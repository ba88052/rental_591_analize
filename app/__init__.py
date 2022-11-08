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
        total_count, houses = rental_591_spider.search(rental_params)
        print('搜尋結果房屋總數：', total_count)
    all_rental = {}
    infor = ["title", "kind_name", "community", "area", "section_name"]
    columns = ["title", "kind", "community", "area", "section", "shape", "layout", "address","inName", "role", "phone", "phone_extension","mobile", "mobile_extension", "rule", "remark","price"]
    for i in houses:
        all_rental[i["post_id"]] = [i[inf] for inf in infor]+(rental_591_spider.get_detail_we_need(i["post_id"], spider = rental_591_spider))
    df = pd.DataFrame.from_dict(all_rental, orient = "index", columns = columns)
    js = df.to_json()
    return(js)

@app.route("/spider_591", methods=["POST"])
def post_input():
    rental_591_spider = spider_591.Rantal_591_Spider()
    # 篩選條件
    rental_params = request.get_json()
    total_count, houses = rental_591_spider.search(rental_params)
    print('搜尋結果房屋總數：', total_count)
    all_rental = {}
    infor = ["title", "kind_name", "community", "area", "section_name"]
    columns = ["title", "kind", "community", "area", "section", "shape", "layout", "address","inName", "role", "phone", "phone_extension","mobile", "mobile_extension", "rule", "remark","price"]
    for i in houses:
        all_rental[i["post_id"]] = [i[inf] for inf in infor]+(rental_591_spider.get_detail_we_need(i["post_id"], spider = rental_591_spider))
    df = pd.DataFrame.from_dict(all_rental, orient = "index", columns = columns)
    js = df.to_json()
    return(js)

@app.route("/daily_spider", methods=["GET"])
def daily_spider():
    spider_591.Rantal_591_Spider().daily_spider_to_GCP(test = True)
    # 篩選條件
    return("Today spider_591 is done.")

# if __name__ == "__main__":
#     app.run(port=8081)