import numpy as np
import pandas as pd
from flask import Flask, jsonify, render_template, request
from flask_cors import CORS
import json
import app.spider_591.spider_591 as spider_591
import app.rental_price_model.rental_price_model as rental_price_model

from flask import Flask, render_template, session, redirect, url_for
from flask_wtf import FlaskForm
from wtforms import (StringField, BooleanField, DateTimeField,
RadioField, SelectField, TextField,
TextAreaField,SubmitField)
from wtforms.validators import DataRequired


app = Flask(__name__)
app.config.from_object("app.config.DevelopmentConfig")
CORS(app)


#----------------------------------------------------------------#
@app.route("/spider_591_test", methods=["GET"])
def spider_test():
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

@app.route("/spider_591_api", methods=["POST"])
def get_spider():
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

#----------------------------------------------------------------#
@app.route("/model_api", methods=["POST"])
def model_predict():
    price_model = rental_price_model.Rental_price_model()
    # 篩選條件
    rental_data = request.get_json()
    rental_data = dict(rental_data)
    df_for_test = pd.DataFrame(rental_data, index = [0])
    df_for_test.drop(["model"], axis = 1, inplace = True)
    # print(df_for_test.info())
    if rental_data["model"] == "XGB":
        ans = price_model.XGB_predict(df_for_test)
    elif rental_data["model"] == "keras":
        ans = price_model.keras_predict(df_for_test)
    print(ans)
    return(str(ans))

@app.route("/weekly_model_training", methods=["GET"])
def weekly_model_training():
    rental_price_model.Rental_price_model().weekly_model_training()
    # 篩選條件
    return("Weekly model training is done.")


#---------------------------------------------------------#
class model_web_form(FlaskForm):
    model = StringField('要使用的模型', validators=[DataRequired()])
    area = BooleanField('坪數')
    bedroom = RadioField('臥室數量', choices=[('M','男生'),('F','女生')])
    livingroom = SelectField('客廳數量', choices=[('sports','運動'),('travel','旅遊'),('movie','電影')])
    bathroom= TextAreaField('浴廁數量')
    section = BooleanField('區域')
    kind = BooleanField('房間類型')
    shape = BooleanField('大樓or房屋類型')
    role = BooleanField('由誰販售')
    girl_cant_live = BooleanField('特殊規定-禁止女生住宿')
    boy_cant_live = BooleanField('特殊規定-禁止男生住宿')
    pet_cant_live = BooleanField('特殊規定-禁養寵物')
    cant_cooking = BooleanField('特殊規定-不可開伙')
    submit = SubmitField("確認")

@app.route("/model_web", methods=["GET"])
def model_web():
    form = model_web_form()
    if form.validate_on_submit():
        session['name'] = form.name.data
        session['agreed'] = form.agreed.data
        session['gender'] = form.gender.data
        session['hobby'] = form.hobby.data
        session['others'] = form.others.data
        return redirect(url_for('thankyou'))
    return render_template('home.html', form=form)




    price_model = rental_price_model.Rental_price_model()
    # 篩選條件
    rental_data = request.get_json()
    rental_data = dict(rental_data)
    df_for_test = pd.DataFrame(rental_data, index = [0])
    df_for_test.drop(["model"], axis = 1, inplace = True)
    # print(df_for_test.info())
    if rental_data["model"] == "XGB":
        ans = price_model.XGB_predict(df_for_test)
    elif rental_data["model"] == "keras":
        ans = price_model.keras_predict(df_for_test)
    print(ans)
    return("順利預測 " + str(ans))





# if __name__ == "__main__":
#     app.run(port=8081)