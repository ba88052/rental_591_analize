import time
import random
import requests
from bs4 import BeautifulSoup
import re
import pandas as pd


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