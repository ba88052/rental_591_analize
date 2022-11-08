import time
import random
import requests
from bs4 import BeautifulSoup
import json
import re
import pandas as pd
from google.cloud import bigquery as bq
import pandas_gbq
from datetime import datetime
import os

class Rantal_591_Spider():
    def __init__(self):
        self.headers = {
            'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36 Edg/88.0.705.68',
        }

    def get_total_count(self, filter_params=None):
        total_count = 0
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
        return total_count

    # filter_params: 篩選參數
    def search(self, filter_params=None, first_page = 0, last_page = 2):
        total_count = 0
        house_list = []

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

        while first_page < last_page:
            params += f'&firstRow={first_page*30}'
            r = s.get(url, params=params, headers=headers)
            if r.status_code != requests.codes.ok:
                print('請求失敗', r.status_code)
                break
            first_page += 1

            data = r.json()
            # total_count = data['records']
            house_list.extend(data['data']['data'])
            # 隨機delay一段時間，避免過度頻繁被擋
            time.sleep(random.uniform(2, 5))

        return total_count, house_list

    def get_header(self, house_id):
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
        return headers

    def get_house_detail(self, house_id, headers):
        """ 房屋詳情
        house_id: 房屋ID
        """
        s = requests.Session()
        url = f'https://rent.591.com.tw/home/{house_id}'
        r = s.get(url, headers=self.headers)
        soup = BeautifulSoup(r.text, 'html.parser')
        url = f'https://bff.591.com.tw/v1/house/rent/detail?id={house_id}'
        r = s.get(url, headers=headers)
        if r.status_code != requests.codes.ok:
            print('請求失敗', r.status_code)
            return
        house_detail = r.json()['data']
        return house_detail
    
    def get_detail_we_need(self, house_id, spider, headers):
        information = []
        rental = spider.get_house_detail(house_id, headers)
        information.append(rental["info"][3]["value"])
        information.append(rental["favData"]["layout"])
        information.append(rental["favData"]["address"])
        information.append(rental["linkInfo"]["imName"])
        information.append(rental["linkInfo"]["roleName"])
        phone  = rental["linkInfo"]["phone"]
        phone = re.sub("-", "", phone)
        mobile = rental["linkInfo"]["mobile"]
        mobile = re.sub("-", "", mobile)
        if phone:
            try:
                information.append(phone)
                information.append(None)
            except:
                information.append(phone.split(",")[0])
                information.append(phone.split(",")[1])
        else:
            information.append(None)
            information.append(None)
        if mobile:
            try:
                information.append(mobile)
                information.append(None)
            except:
                information.append(mobile.split(",")[0])
                information.append(mobile.split(",")[1])
        else:
            information.append(None)
            information.append(None)
        information.append(rental["service"]["rule"])       
        remark = rental["remark"]["content"]
        garbage_word = re.findall(r'(<.+?>)', remark)
        for garbage in garbage_word:
            remark = remark.replace(garbage, "")
        information.append(remark)
        information.append(rental["favData"]["price"])
        return information


    def daily_spider_to_GCP(self, test=False):
        #每日591爬蟲任務
        #與Bigquery建立連線並確認金鑰沒問題
        os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="app/spider_591/GCP_key.json"
        client = bq.Client()
        print(client)
        #應顯示 <google.cloud.bigquery.client.Client object at xxxxxxxxxxxx>

        today = datetime.now().strftime("%Y-%m-%d")

        #爬取資料
        rental_591_spider = Rantal_591_Spider()
        with open ("app/spider_591/daily_spider_params.txt", "r") as params:
            filter_params  = json.loads(params.read())
        print("搜尋591租屋網中...")
        total_count = rental_591_spider.get_total_count(filter_params)
        print('搜尋結果房屋總數：', total_count)
        total_page = total_count//30 + 1

        for first_page in range(1,total_page+1, 10):
            last_page = first_page+10
            total_count, houses = rental_591_spider.search(filter_params, first_page = first_page, last_page = last_page)
            print(f"爬取{first_page}~{last_page-1}頁租屋資料")
            all_rental = {}
            infor = ["post_id","title", "kind_name", "community", "area", "section_name"]
            columns = ["post_id", "title", "kind", "community", "area", "section", "shape", "layout", 
                        "address","inName", "role", "phone", "phone_extension","mobile", 
                        "mobile_extension", "rule", "remark","price"]
            header = rental_591_spider.get_header(houses[0]["post_id"])
            for i in houses:
                rental_post_id = i["post_id"]
                try:
                    all_rental[rental_post_id] = [i[inf] for inf in infor]+(
                        rental_591_spider.get_detail_we_need(i["post_id"], 
                        spider = rental_591_spider, headers = header))
                except:
                    print(f"ERROR in rental post_id={rental_post_id}")
            rental_df = pd.DataFrame.from_dict(all_rental, orient = "index", columns = columns)    
            # rental_df.to_csv("./check.csv")
            #把df丟進bigquery
            print(f"把{first_page}~{last_page-1}頁資料上傳bigquery...")
            dataset_id = "spider_591_rental_SET"#設定 Dataset 名稱，可以修改
            dataset = bq.Dataset(f"{client.project}.{dataset_id}")
            dataset.location = "asia-east1"     #設定資料位置，如不設定預設是 US
            # dataset.default_table_expiration_ms = 30 * 24 * 60 * 60 * 1000    #設定資料過期時間，這邊設定 30 天過期
            dataset.description = 'create_spider_591_rental_dataset location at asia-east1'    #設定 dataset 描述
            try:
                dataset = client.create_dataset(dataset) # Make an API request.
                print(f"Created dataset {client.project}.{dataset.dataset_id}")
            except:
                print(f"{dataset_id} Dataset Already Exist")
            table_name = f"{today}_RENTAL"
            table_id = f"{dataset_id}.{table_name}" 
            job = client.load_table_from_dataframe(rental_df, table_id, location="asia-east1")
            job.result()  # Waits for table load to complete.
            assert job.state == "DONE"
            print("Today spider_591 is done.")

            # pandas_gbq.to_gbq(rental_df, table_id, project_id = "rental591analize", if_exists = "append")
            print(f"{first_page}~{last_page-1}資料上傳成功")
        print("Today spider_591 is done.")

if __name__ == "__main__":
    rental_591_spider = Rantal_591_Spider()
    rental_591_spider.daily_spider_to_GCP()