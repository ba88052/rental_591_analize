import os
from datetime import datetime, timedelta
import dash
from dash import dcc
from dash import html
import pandas as pd
import plotly.graph_objs as go
from dash.dependencies import Input, Output
from google.cloud import bigquery as bq
from app.rental_price_model.clean_data import get_count_number, get_mean_price
from app import app


os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="app/GCP_data_viewer_key.json"
client = bq.Client()
print(client)

df_li = []
for i in range(0,15):
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
df_platform = pd.concat(df_li,axis=0)
df_platform.drop_duplicates(inplace=True)
# print(df_predict.head(3))
target_list = ["平均價格", "個數統計"]
X_axis_list = [ "section", "kind", "shape", "role", "date", "street"]
parameter_list = ["all", "section", "kind", "shape", "role", "date", "street"]
app_dash = dash.Dash(__name__, server = app, url_base_pathname = "/dash/")
mean_price = get_mean_price(df_platform, ["section"])

app_dash.layout = html.Div([
        html.Div(html.H1(children="台中租屋資訊數據儀表板")),
        html.Div(
            [
                html.Div(
                    [
                        html.Div(children="Y軸"),
                        dcc.Dropdown(
                            id='y_axis',
                            options=target_list,
                            searchable=False,
                            value="平均價格"
                        ),
                    ],style={"width": "45%"},
                ),

                html.Div(
                    [
                        html.Div(children="X軸"),
                        dcc.Dropdown(
                            id='X_axis',
                            options=X_axis_list,
                            searchable=False,
                            value="section"
                        ),
                    ],style={"width": "45%"},
                ),
            ],style={"width": "90%", "display":"flex", "justify-content":"space-between"},
        ),
        html.Div(),
        html.Div(
            [
                html.Div(
                    [
                        html.Div(children="篩選項目"),
                        dcc.Dropdown(
                            id='parameter',
                            options=parameter_list,
                            searchable=False,
                            value="all"
                        ),
                    ],style={"width": "45%"},
                ),

                html.Div(
                    [
                        html.Div(children="篩選項目等於"),
                        dcc.Dropdown(
                            id='parameter_value',
                            placeholder="請先選擇篩選項目", 
                            value="all"
                        ),
                    ],style={"width": "45%"},
                ),
            ],style={"width": "90%", "display":"flex", "justify-content":"space-between", "margin-top":"0.5rem"},
        ),
        html.Div(),
        html.Div(
            [
                html.Div(
                    [
                        html.Div(children="選擇使用的圖"),
                        dcc.Dropdown(
                            id='figure_type',
                            options=["line", "bar"],
                            searchable=False,
                            value="line"
                        ),
                    ],style={"width": "45%"},
                ),],style={"width": "90%", "display":"flex", "justify-content":"space-between", "margin-top":"0.5rem"},
        ),
        html.Div(
        [
            dcc.Graph(
                id='rental_figure',
                figure= {
                    "data": [go.Line(x = mean_price["section"], y = mean_price["price"])],
                    "layout": {"title": "Average Price of Avocados"}
                    }
            )
        ],style={"width": "100%"},
        ),
    ],style={"width": "95%"},
)
@app_dash.callback(Output('rental_figure', 'figure'),
            [Input('y_axis', 'value'),
            Input('X_axis', 'value'),
            Input('parameter', 'value'),
            Input('parameter_value', 'value'),
            Input('figure_type', 'value')])
def get_rental_figure(y_axis, X_axis, parameter, parameter_value,figure_type):
    if y_axis == "平均價格":
        if parameter == "all":
            df_figure = get_mean_price(df_platform, [X_axis])
            x = df_figure[X_axis]
            y = df_figure["price"]
        else:
            df_figure = get_mean_price(df_platform[df_platform[parameter] == parameter_value], [X_axis])
            x = df_figure[X_axis]
            y = df_figure["price"]
    else:
        if parameter == "all":
            df_figure = get_count_number(df_platform, [X_axis])
            x = df_figure[X_axis]
            y = df_figure["post_id"]
        else:
            df_figure = get_count_number(df_platform[df_platform[parameter] == parameter_value], [X_axis])
            x = df_figure[X_axis]
            y = df_figure["post_id"]
    if figure_type == "bar":
        return{
            "data":[go.Bar(x = x, y = y )]
        }
    else:
        return{
            "data":[go.Line(x = x, y = y )]
        }
@app_dash.callback(Output('parameter_value', 'options'),
            Input('parameter', 'value'))
def get_parameter_value_list(parameter):
    if parameter == "all":
        return([])
    else:
        return(list(set(df_platform[parameter])))

app.run(host="0.0.0.0", port=8081)