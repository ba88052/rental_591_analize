import time
import random
import requests
from bs4 import BeautifulSoup
import re
import pandas as pd
from google.cloud import bigquery as bq
from datetime import datetime
import os

class Rantal_591_Spider():
    def __init__(self):
        self.headers = {
            'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36 Edg/88.0.705.68',
        }

    # filter_params: 篩選參數
    def search(self, filter_params=None, testing = True):  
        test_page = 30  
        total_count = 0
        house_list = []
        page = 0

        #取得X-CSRF-TOKEN
        s = requests.Session()
        url = 'https://rent.591.com.tw/'
        r = s.get(url, headers=self.headers)
        soup = BeautifulSoup(r.text, 'html.parser')
        token_item = soup.select_one('meta[name="csrf-token"]')
        headers = self.headers.copy()
        headers['X-CSRF-TOKEN'] = token_item.get('content')

        #搜尋租屋資訊
        url = 'https://rent.591.com.tw/home/search/rsList'
        params = 'is_format_data=1&is_new_list=1&type=1'
        if filter_params:
            params += ''.join([f'&{key}={value}' for key, value, in filter_params.items()])
        else:
            params += '&region=1&kind=0'
        #在cookie設定地區縣市，避免某些條件無法取得資料
        s.cookies.set('urlJumpIp', filter_params.get('region', '1') if filter_params else '1', domain='.591.com.tw')
        
        r = s.get(url, params=params, headers=headers)
        total_count = int(r.json()['records'].replace(",",""))
        if testing:
            total_page = 1
        else:
            total_page = total_count//30+1
        # print(total_count)

        while page < total_page:
            params += f'&firstRow={page*30}'
            r = s.get(url, params=params, headers=headers)
            if r.status_code != requests.codes.ok:
                print('請求失敗', r.status_code)
                break
            page += 1

            data = r.json()
            # total_count = data['records']
            house_list.extend(data['data']['data'])
            # 隨機delay一段時間，避免過度頻繁被擋
            time.sleep(random.uniform(2, 5))

        return total_count, house_list

    def get_house_detail(self, house_id):
        """ 房屋詳情
        house_id: 房屋ID
        """
        # 紀錄 Cookie 取得 X-CSRF-TOKEN, deviceid
        s = requests.Session()
        url = f'https://rent.591.com.tw/home/{house_id}'
        r = s.get(url, headers=self.headers)
        soup = BeautifulSoup(r.text, 'html.parser')
        token_item = soup.select_one('meta[name="csrf-token"]')

        headers = self.headers.copy()
        headers['X-CSRF-TOKEN'] = token_item.get('content')
        headers['deviceid'] = s.cookies.get_dict()['T591_TOKEN']
        # headers['token'] = s.cookies.get_dict()['PHPSESSID']
        headers['device'] = 'pc'

        url = f'https://bff.591.com.tw/v1/house/rent/detail?id={house_id}'
        r = s.get(url, headers=headers)
        if r.status_code != requests.codes.ok:
            print('請求失敗', r.status_code)
            return
        house_detail = r.json()['data']
        return house_detail
    
    def get_detail_we_need(self, house_id, spider):
        information = []
        rental = spider.get_house_detail(house_id)
        information.append(rental["info"][3]["value"])
        information.append(rental["favData"]["layout"])
        information.append(rental["favData"]["address"])
        information.append(rental["linkInfo"]["imName"])
        information.append(rental["linkInfo"]["roleName"])
        if rental["linkInfo"]["phone"]:
            information.append(rental["linkInfo"]["phone"])
            information.append(0)
        else:
            information.append(0)
            information.append(rental["linkInfo"]["mobile"])
        information.append(rental["service"]["rule"])       
        remark = rental["remark"]["content"]
        garbage_word = re.findall(r'(<.+?>)', remark)
        for garbage in garbage_word:
            remark = remark.replace(garbage, "")
        information.append(remark)
        information.append(rental["favData"]["price"])
        return information


if __name__ == "__main__":
    #每日591爬蟲任務
    #與Bigquery建立連線並確認金鑰沒問題
    #應顯示 <google.cloud.bigquery.client.Client object at xxxxxxxxxxxx>
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="./GCP_key.json"
    client = bq.Client()
    print(client)

    today = datetime.now().strftime("%Y-%m-%d")
    #爬取資料
    rental_591_spider = Rantal_591_Spider()
        
    filter_params = {
        # 篩選條件
        'showMore': '1', #(套用更多搜尋方式)默認開啟
        'searchtype': '1', #(搜索型態)1-鄉鎮, 2-商圈, 3-學校, 4-捷運
        'region': '8',  # (城市) 台中
        'section':"104", #(區域) 西屯區 ##詳閱文件
        # 'multiPrice': '0_5000,5000_10000',  # (租金)0_5000, 5000_10000, 10000_20000, 20000_30000, 30000_40000, 40000_ 
        # 'rentprice': '3000,6000',  #(自訂租金範圍)
        # 'kind': '2', #(類型)0-不限, 1-整層住房, 2-獨立套房, 3-分租套房, 4-雅房, 8-車位, 24-其他, 
        # 'shape': '3',  #(型態)1-公寓, 2-電梯大樓, 3-透天厝, 4-別墅
        # 'multiNotice': 'all_sex',  # (須知)all_sex, boy, girl, not_cover
        # 'multiRoom': '2,3',  #(格局)1-一房, 2-二房, 3-三房, 4-四房以上
        # 'multiArea': '10_20,20_30,30_40', #(坪數)0_10, 10_20, 20_30, 30_40, 40_50, 50_
        # 'area': '20,50',  # (自訂坪數範圍)
        # 'multiFloor': '2_6',  #(樓層)0_1, 2_6, 6_12, 12_
        # 'option': 'cold,washer,bed',  #(設備)
    }
    total_count, houses = rental_591_spider.search(filter_params)
    print('搜尋結果房屋總數：', total_count)

    all_rental = {}
    infor = ["title", "kind_name", "community", "area", "section_name"]
    columns = ["title", "kind", "community", "area", "section", "shape", "layout", "address","inName", "role", "phone", "mobile", "rule", "remark","price"]

    for i in houses:
        all_rental[i["post_id"]] = [i[inf] for inf in infor]+(rental_591_spider.get_detail_we_need(i["post_id"], spider = rental_591_spider))
    rental_df = pd.DataFrame.from_dict(all_rental, orient = "index", columns = columns)
    
    #把df丟進bigquery
    dataset_id = "spider_591_rental_SET"#設定 Dataset 名稱，可以修改
    try:
        dataset = bq.Dataset(f"{client.project}.{dataset_id}")
        dataset.location = "asia-east1"     #設定資料位置，如不設定預設是 US
        # dataset.default_table_expiration_ms = 30 * 24 * 60 * 60 * 1000    #設定資料過期時間，這邊設定 30 天過期
        dataset.description = 'create_spider_591_rental_dataset location at asia-east1'    #設定 dataset 描述
        dataset = client.create_dataset(dataset) # Make an API request.
        print(f"Created dataset {client.project}.{dataset.dataset_id}")
    except:
        print(f"{dataset_id} Dataset Already Exist")

    dataset_id = "spider_591_rental_SET"
    dataset_ref = client.dataset(dataset_id)
    table_id = f"{today}_TEST_TABLE" 
    table_ref = dataset_ref.table(table_id)
    job = client.load_table_from_dataframe(rental_df, table_ref, location="asia-east1")
    job.result()  # Waits for table load to complete.
    assert job.state == "DONE"
    print("Today spider_591 is done.")