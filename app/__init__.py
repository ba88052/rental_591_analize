import os
import flask
import json
import pandas as pd
from flask_cors import CORS
from flask import Flask, render_template, request
import app.spider_591.spider_591 as spider_591
import app.rental_price_model.rental_price_model as rental_price_model


app = Flask(__name__, template_folder = "templates")
app.config.from_object("app.config.DevelopmentConfig")
app.config['SECRET_KEY'] = 'my_key'
CORS(app)

#-----------------------------------------------------------------#
#首頁
@app.route("/")
def index():
    return "Hello!! Welcome to rental_591_analize"
#-----------------------------------------------------------------#
#Spider
@app.route("/spider-591/test", methods=["GET"])
def spider_test():
    rental_591_spider = spider_591.Rantal_591_Spider()
    with open ("app/spider_591/test.txt", "r") as test:
        rental_params = json.loads(test.read())
    print("測試：搜尋591租屋網中...")
    total_count = rental_591_spider.get_total_count(rental_params)
    print('測試：搜尋結果房屋總數：', total_count)
    total_count, houses = rental_591_spider.search(rental_params)
    print("測試：回傳第一頁內容")
    df_return = rental_591_spider.get_df_return_data(houses)
    js_return = df_return.to_json()
    print("測試：成功")
    return(js_return)
@app.route("/spider-591", methods=["POST"])
def get_spider():
    rental_591_spider = spider_591.Rantal_591_Spider()
    # 篩選條件
    rental_params = request.get_json()
    # print(rental_params)
    print("搜尋591租屋網中...")
    total_count = rental_591_spider.get_total_count(rental_params)
    print('搜尋結果房屋總數：', total_count)
    total_page = total_count//30 + 1
    df_return_list = []
    for first_page in range(1,total_page+1, 10):
        last_page = first_page+10
        total_count, houses = rental_591_spider.search(rental_params, first_page = first_page, last_page = last_page)
        print(f"爬取{first_page}~{last_page-1}頁租屋資料")
        # print("houses:", houses[0]["post_id"])
        df_return_data = rental_591_spider.get_df_return_data(houses)
        df_return_list.append(df_return_data)
    df_return = pd.concat(df_return_list, axis = 0)
    js_return = df_return.to_json()
    print("爬蟲成功")
    return(js_return)
@app.route("/spider-591/daily", methods=["GET"])
def daily_spider():
    spider_591.Rantal_591_Spider().daily_spider_to_GCP()
    # 篩選條件
    return("Today spider_591 is done.")

#-----------------------------------------------------------------#
#Model
@app.route("/model", methods=["POST"])
def model_predict():
    price_model = rental_price_model.Rental_price_model()
    # 篩選條件
    rental_data = request.get_json()
    rental_data = dict(rental_data)
    df_for_predict = pd.DataFrame(rental_data, index = [0])
    df_for_predict.drop(["model"], axis = 1, inplace = True)
    # print(df_for_test.info())
    if rental_data["model"] == "XGB":
        ans = price_model.XGB_predict(df_for_predict)[0]
    elif rental_data["model"] == "keras":
        ans = price_model.keras_predict(df_for_predict)[0][0]
    print(ans)
    return(str(ans))

@app.route("/model/weekly-training", methods=["GET"])
def weekly_model_training():
    rental_price_model.Rental_price_model().weekly_model_training()
    # 篩選條件
    return("Weekly model training is done.")

@app.route("/model/web", methods=["GET", "POST"])
def model_web():
    if request.method == "POST":
        if request.values["send"] == "submit":
            # print(request.values)
            price_model = rental_price_model.Rental_price_model()
            data = {}
            features = ["model", "area", "bedroom", "livingroom",
                        "bathroom", "section", "kind", "shape",
                        "role", "girl_cant_live", "boy_cant_live",
                        "pet_cant_live", "cant_cooking"]
            for feature in features:
                try:
                    data[feature] = request.values[feature]
                except:
                    data[feature] = 0
            df_for_predict = pd.DataFrame(data, index = [0])
            df_for_predict.drop(["model"], axis = 1, inplace = True)
            print(df_for_predict)
            if data["model"] == "XGB":
                ans = price_model.XGB_predict(df_for_predict)[0]
            elif data["model"] == "keras":
                ans = price_model.keras_predict(df_for_predict)[0][0]
            # print(ans)
            return render_template('model_web.html', ans = str(ans))
    return render_template('model_web.html', ans = "")

#-----------------------------------------------------------------#
#Data Platform
@app.route("/platform", methods=["GET"])
def data_platform():
    return flask.redirect("/dash")