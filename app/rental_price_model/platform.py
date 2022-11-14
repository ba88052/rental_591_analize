import os
from datetime import datetime
import pandas as pd



def get_platform_data():
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="app/GCP_data_viewer_key.json"
    client = bq.Client()
    # print(client)
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
    df_return_data = pd.concat(df_li,axis=0)
    df_return_data.drop_duplicates(inplace=True)
    return(df_return_data)