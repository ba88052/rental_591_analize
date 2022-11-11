import numpy as np
import xgboost as xgb
import pandas as pd
import tensorflow as tf
from tensorflow import keras
from google.cloud import bigquery as bq
import os
from datetime import timedelta
from datetime import datetime
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
from sklearn.metrics import mean_squared_error as mse
from sklearn.metrics import mean_absolute_error as mae
from sklearn.metrics import mean_absolute_percentage_error as mape

if __name__ == "__main__":
    from clean_data import get_clean_df, get_predict_df
else:
    from app.rental_price_model.clean_data import get_clean_df, get_predict_df

class Rental_price_model():
    def __init__(self):
        pass
    def XGB_predict(self, data_predict):
        df_predict = get_predict_df(data_predict)
        xgb_data_predict = xgb.DMatrix(df_predict)
        xgb_model = xgb.Booster()
        if __name__ == "__main__":
            xgb_model.load_model("model/xgb_model.json")
        else:
            xgb_model.load_model("app/rental_price_model/model/xgb_model.json")
        return(xgb_model.predict(xgb_data_predict))
    def keras_predict(self, data_predict):
        df_predict = get_predict_df(data_predict)
        if __name__ == "__main__":
            keras_model = tf.keras.models.load_model('model/tensorflow_model')
        else:
            keras_model = tf.keras.models.load_model('app/rental_price_model/model/tensorflow_model')
        return(keras_model.predict(df_predict))
#___________________________________________________________________________________#
    def get_training_data(self, df_train):
        df_train = get_clean_df(df_train)
        df_train = df_train.drop(["street", "title", "remark", "post_id", "__index_level_0__"], axis = 1)
        df_train.to_csv("after_clean.csv")
        df_train = df_train.astype("float")
        scaler = preprocessing.MinMaxScaler(feature_range = (0, 1))
        df_scaler = df_train.copy()
        df_scaler[list(df_scaler.columns)] = scaler.fit_transform(df_scaler[list(df_scaler.columns)])
        X_train, X_test, y_train, y_test = train_test_split(df_scaler.drop("price", axis = 1), df_train.price, test_size=0.3)
        return (X_train, X_test, y_train, y_test)
    def XGB_training(self, data_train):
        X_train, X_test, y_train, y_test = data_train
        params = {}
        dtrain = xgb.DMatrix(X_train, y_train)
        num_rounds = 100 
        plst = params.items()
        xgb_model = xgb.train(plst, dtrain, num_rounds)
        dtest = xgb.DMatrix(X_test)
        y_pre = xgb_model.predict(dtest)
        if __name__ == "__main__":
            xgb_model.save_model("model/xgb_model.json")
        else:
            xgb_model.save_model('app/rental_price_model/model/xgb_model.json')
        print("XGB模型儲存完成")
        score_title = ["XGB_mean_absolute_error", "XGB_mean_squared_error", "XGB_mean_absolute_percentage_error"]
        scores = []
        scores.append(mse(y_pre, y_test))
        scores.append(mae(y_pre, y_test))
        scores.append(mape(y_pre, y_test))
        for title, score in zip(score_title, scores):
            print(f"{title}:{score}")
        return(scores)
    def keras_training(self, data_train):
        X_train, X_test, y_train, y_test = data_train
        model = keras.Sequential([
                keras.layers.Dense(32, name="hidden1"),
                keras.layers.Dense(32, name="hidden2"),
                keras.layers.Dense(1, name="output"),
            ])
        model.compile(loss="mae", optimizer="sgd")
        model.fit(X_train, y_train, epochs=100, batch_size=16)
        y_pre = model.predict(X_test)
        if __name__ == "__main__":
            model.save('model/tensorflow_model')
        else:
            model.save('app/rental_price_model/model/tensorflow_model')
        print("keras模型儲存完成")
        score_title = ["keras_mean_absolute_error", "keras_mean_squared_error", "keras_mean_absolute_percentage_error"]
        scores = []
        scores.append(mse(y_pre, y_test))
        scores.append(mae(y_pre, y_test))
        scores.append(mape(y_pre, y_test))
        for title, score in zip(score_title, scores):
            print(f"{title}:{score}")
        return(scores) 
 
    def weekly_model_training(self):
        if __name__ == "__main__":
            os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="GCP_key.json"
        else:
            os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="app/rental_price_model/GCP_key.json"
        client = bq.Client()
        print("連接GCP")
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
            except:
                continue
            df_li.append(df)
        df_predict = pd.concat(df_li, axis=0)
        df_predict.drop_duplicates(inplace=True)
        print("取得Bigquery資料")
        # df_predict.to_csv("before_clean_csv")
        df_clean = Rental_price_model.get_training_data(self, df_predict.reset_index(drop=True))
        print("訓練XGB模型")
        Rental_price_model.XGB_training(self, df_clean)
        print("訓練keras模型")
        Rental_price_model.keras_training(self, df_clean)
        print("每週訓練完成")

if __name__ == "__main__":
    rpc = Rental_price_model()
    rpc.weekly_model_training()
