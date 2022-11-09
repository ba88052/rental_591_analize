import numpy as np
import pandas as pd
from flask import Flask, jsonify, render_template, request
from flask_cors import CORS
import json
import app.spider_591.spider_591 as spider_591


app = Flask(__name__)
app.config.from_object("app.config.DevelopmentConfig")
CORS(app)

@app.route("/test", methods=["GET"])
def get_test():
    rental_591_spider = spider_591.Rantal_591_Spider()
    with open ("app/test.txt", "r") as test:
        rental_params = json.loads(test.read())
    print("測試：搜尋591租屋網中...")
    total_count = rental_591_spider.get_total_count(rental_params)
    print('搜尋結果房屋總數：', total_count)
    all_rental = {}
    total_count, houses = rental_591_spider.search(rental_params)
    print("回傳第一頁內容")
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
    df = pd.DataFrame.from_dict(all_rental, orient = "index", columns = columns)
    js = df.to_json()
    return(js)

@app.route("/spider_591", methods=["POST"])
def post_input():
    rental_591_spider = spider_591.Rantal_591_Spider()
    # 篩選條件
    rental_params = request.get_json()
    # print(rental_params)
    print("搜尋591租屋網中...")
    total_count = rental_591_spider.get_total_count(rental_params)
    print('搜尋結果房屋總數：', total_count)
    total_page = total_count//30 + 1
    all_rental = {}
    for first_page in range(1,total_page+1, 10):
        last_page = first_page+10
        total_count, houses = rental_591_spider.search(rental_params, first_page = first_page, last_page = last_page)
        print(f"爬取{first_page}~{last_page-1}頁租屋資料")
        # print("houses:", houses[0]["post_id"])
        infor = ["post_id","title", "kind_name", "community", "area", "section_name"]
        columns = ["post_id", "title", "kind", "community", "area", "section", "shape", "layout", 
                    "address","inName", "role", "phone", "phone_extension","mobile", 
                    "mobile_extension", "rule", "remark","price"]
        try:
            header = rental_591_spider.get_header(houses[0]["post_id"])
        except:
            header = header
        for i in houses:
            rental_post_id = i["post_id"]
            try:
                all_rental[rental_post_id] = [i[inf] for inf in infor]+(
                    rental_591_spider.get_detail_we_need(i["post_id"], 
                    spider = rental_591_spider, headers = header))
            except:
                print(f"ERROR in rental post_id={rental_post_id}")
    df = pd.DataFrame.from_dict(all_rental, orient = "index", columns = columns)
    js = df.to_json()
    return(js)

@app.route("/daily_spider", methods=["GET"])
def daily_spider():
    spider_591.Rantal_591_Spider().daily_spider_to_GCP()
    # 篩選條件
    return("Today spider_591 is done.")

# if __name__ == "__main__":
#     app.run(port=8081)