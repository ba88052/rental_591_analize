import os
import flask
import json
import dash
import pandas as pd
from datetime import datetime
from datetime import timedelta
from flask_cors import CORS
import plotly.graph_objs as go 
import dash_core_components as dcc 
import dash_html_components as html
from google.cloud import bigquery as bq
from dash.dependencies import Input, Output 
from flask import Flask, render_template, request
import app.spider_591.spider_591 as spider_591
import app.rental_price_model.rental_price_model as rental_price_model
from app.rental_price_model.clean_data import get_mean_price, get_count_number


app = Flask(__name__, template_folder = "templates")
app.config.from_object("app.config.DevelopmentConfig")
app.config['SECRET_KEY'] = 'my_key'
CORS(app)
#----------------------------------------------------------------#
#Spider
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
#Model
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

@app.route("/model_web", methods=["GET", "POST"])
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
            df_for_test = pd.DataFrame(data, index = [0])
            df_for_test.drop(["model"], axis = 1, inplace = True)
            if data["model"] == "XGB":
                ans = price_model.XGB_predict(df_for_test)
            elif data["model"] == "keras":
                ans = price_model.keras_predict(df_for_test)
            # print(ans)
            return render_template('model_web.html', ans = str(ans))
    return render_template('model_web.html', ans = "")

#-----------------------------------------------------#
#Data Platform
os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="app/GCP_data_viewer_key.json"
client = bq.Client()
print(client)

df_li = []
for i in range(0,8):
    today = (datetime.today() - timedelta(i)).strftime("%Y-%m-%d")
    table_name = f"{today}_RENTAL"
    try:
        sql = f"""
            SELECT *
            FROM `rental591analize.spider_591_rental_SET.{table_name}`
        """
        df = client.query(sql).to_dataframe()
        df["date"] = today
    except:
        continue
    df_li.append(df)
df_predict = pd.concat(df_li,axis=0)
df_predict.drop_duplicates(inplace=True)
# print(df_predict.head(3))
target_list = ["平均價格", "個數統計"]
parameter_list = [ "section", "kind", "shape", "role", "date", "street"]
app_dash = dash.Dash(__name__, server = app, url_base_pathname = "/dash/")
mean_price = get_mean_price(df_predict, ["section"])

app_dash.layout = html.Div([
    html.Div([
        html.H1(children="台中租屋資訊數據儀表板",),

        html.P(
            children="選擇要做的分析",
        ),
        dcc.Dropdown(
                    id='function',
                    options=target_list,
                    placeholder='選擇要做的分析',
                    searchable=False,
                    value="平均價格"
                ),
        html.P(
            children="選擇參數",
        ),
        dcc.Dropdown(
                    id='parameter_1',
                    options=parameter_list,
                    placeholder='組別參數1',
                    searchable=False,
                    value="section"
                ), 
        html.P(
            children="選擇使用的圖",
        ),
        dcc.Dropdown(
                    id='figure_type',
                    options=["line", "bar"],
                    placeholder='選擇使用的圖',
                    searchable=False,
                    value="line"
                ),
        dcc.Graph(
                    id='rental_figure',
                    figure= {
                    "data": [go.Line(x = mean_price["section"], y = mean_price["price"])],
                        "layout": {"title": "Average Price of Avocados"}}
                )])
])

@app_dash.callback(Output('rental_figure', 'figure'),
            [Input('function', 'value'),
            Input('parameter_1', 'value'),
            Input('figure_type', 'value')])
def get_rental_figure(function_name, parameter_1, figure_type):
    if function_name == "平均價格":
        df_figure = get_mean_price(df_predict, [parameter_1])
        x = df_figure[parameter_1]
        y = df_figure["price"]
    else:
        df_figure = get_count_number(df_predict, [parameter_1])
        x = df_figure[parameter_1]
        y = df_figure["post_id"]
    if figure_type == "bar":
        return{
            "data":[go.Bar(x = x, y = y )]
        }
    else:
        return{
            "data":[go.Line(x = x, y = y )]
        }

@app.route("/data_platform", methods=["GET"])
def data_platform():
    return flask.redirect("/dash")


# if __name__ == "__main__":
#     app.run(port=8081)