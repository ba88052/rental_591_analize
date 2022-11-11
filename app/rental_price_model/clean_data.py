import re
import numpy as np
import pandas as pd
import re

def address_street(address):
    address = str(address)
    try:
        return(re.search(r"(?:區)(\D+)(?:\d?)", address).group(1))
    except:
        return(np.nan)
def get_street(df_for_clean):
    df_street = pd.DataFrame()
    df_street["street"] = df_for_clean["address"].apply(address_street)
    return df_street
def get_shape(df_for_clean):  
    df_for_clean = df_for_clean.rename(columns = {"shape":"shape_change"})
    shape_list = ['一年', '半年', '三個月', '住宅大樓', '公寓', '別墅', '華廈', '透天厝', '電梯大樓']
    df_shape =pd.DataFrame(columns = shape_list, index = df_for_clean.index)
    df_shape.fillna(0, inplace = True)
    for i,l in zip(df_for_clean.index, df_for_clean.shape_change):
        if l in shape_list:
            df_shape.loc[i, l] = 1
    return df_shape
def get_role(df_for_clean):    
    role_list = ['代理人', '仲介', '屋主']
    df_role =pd.DataFrame(columns = role_list, index = df_for_clean.index)
    df_role.fillna(0, inplace = True)
    for i,l in zip(df_for_clean.index, df_for_clean.role):
        df_role.loc[i, l] = 1
    return df_role
def get_kind(df_for_clean):    
    kind_list = ['其他', '分租套房', '整層住家', '獨立套房', '車位', '雅房']
    df_kind =pd.DataFrame(columns = kind_list, index = df_for_clean.index)
    df_kind.fillna(0, inplace = True)
    for i,l in zip(df_for_clean.index, df_for_clean.kind):
        df_kind.loc[i, l] = 1
    return df_kind
def get_section(df_for_clean):
    section_list = ['西屯區','北區','北屯區','西區', '南區','南屯區','東區','大里區','龍井區','太平區',
                    '沙鹿區','中區','大雅區','豐原區','霧峰區','潭子區','后里區','清水區','梧棲區','烏日區',
                    '大甲區','大肚區','神岡區','外埔區','東勢區','新社區','大安區','石岡區','和平區']
    df_section =pd.DataFrame(columns = section_list, index = df_for_clean.index)
    df_section.fillna(0, inplace = True)
    for i,l in zip(df_for_clean.index, df_for_clean.section):
        df_section.loc[i, l] = 1
    return df_section
def get_layout_spilt(df_for_clean):
    bedroom_list = []
    livingroom_list = []
    bathroom_list = []
    for i, l in zip(df_for_clean["layout"], df_for_clean["shape"]):
        try:
            bedroom_list.append(re.search(r"(\d+)房+", i).group(1))
        except:
            if l in ['住宅大樓', '公寓', '別墅', '華廈', '透天厝', '電梯大樓']:
                bedroom_list.append(1)
            else:
                bedroom_list.append(0)
        try:
            livingroom_list.append(re.search(r"(\d+)廳+", i).group(1))
        except:
            livingroom_list.append(0)
        try:
            bathroom_list.append(re.search(r"(\d+)衛+", i).group(1))
        except:
            bathroom_list.append(0)
    df_layout = pd.DataFrame()
    df_layout["bedroom"] = bedroom_list
    df_layout["livingroom"] = livingroom_list
    df_layout["bathroom"] = bathroom_list
    return df_layout

def get_rule_spilt(df_for_clean):
    girl_cant_live_list = []
    boy_cant_live_list = []
    pet_cant_live_list = []
    cant_cooking_list = []
    # boy_cant_live
    for i in df_for_clean["rule"]:
        i = str(i)
        if i:
            if "限男" in i:
                girl_cant_live_list.append(1)
            else:
                girl_cant_live_list.append(0)

            if "限女" in i:
                boy_cant_live_list.append(1)
            else:
                boy_cant_live_list.append(0)

            if "不可養寵物" in i:
                pet_cant_live_list.append(1)
            else:
                pet_cant_live_list.append(0)

            if "不可開伙" in i:
                cant_cooking_list.append(1)
            else:
                cant_cooking_list.append(0)
        else:
            girl_cant_live_list.append(0)
            boy_cant_live_list.append(0)
            pet_cant_live_list.append(0)
            cant_cooking_list.append(0)
    df_rule = pd.DataFrame()
    df_rule["girl_cant_live"] = girl_cant_live_list
    df_rule["boy_cant_live"] = boy_cant_live_list
    df_rule["pet_cant_live"] = pet_cant_live_list
    df_rule["cant_cooking"] = cant_cooking_list
    return df_rule

def get_clean_df(df_for_clean):
    df_clean = df_for_clean.copy()
    try:
        df_clean.drop(["Unnamed: 0"], axis = 1, inplace = True)
    except:
        None
    df_clean.drop(df_clean[df_clean["price"].isnull()].index, inplace = True)
    df_clean = pd.concat([df_clean, get_street(df_clean),
                        get_layout_spilt(df_clean), get_rule_spilt(df_clean), 
                        get_section(df_clean), get_kind(df_clean), 
                        get_shape(df_clean), get_role(df_clean)], axis = 1)
    df_clean.drop(["section", "inName", "phone", "mobile", 
                "phone_extension", "mobile_extension", 
                "community", "layout", "address", 
                "rule", "shape", "role", "kind"], axis = 1, inplace = True)
    return df_clean
def get_predict_df(df_for_clean):
    df_clean = df_for_clean.copy()
    try:
        df_clean.drop(["Unnamed: 0"], axis = 1, inplace = True)
    except:
        None
    df_clean = pd.concat([df_clean, get_section(df_clean), get_kind(df_clean), 
                        get_shape(df_clean), get_role(df_clean)], axis = 1)
    df_clean.drop(["section", "shape", "role", "kind"], axis = 1, inplace = True)
    df_clean = df_clean.astype("float")
    return df_clean