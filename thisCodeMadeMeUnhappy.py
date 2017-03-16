#!/usr/local/bin/python2
# -*- coding: utf-8 -*-
#2017-03-05
#我很不喜欢这段代码帮不靠谱的人做不靠谱的事情真的不开心
#以此为戒希望自己开心一点

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn import datasets, linear_model
from pylab import *
mpl.rcParams['font.sans-serif'] = ['Arial Unicode MS']
mpl.rcParams['axes.unicode_minus'] = False


def getData(filename, col):
    data = pd.read_csv(filename)
    X = []
    ret = []
    for c in col:
        X = []
        for cell in data[c]:
            if cell.find(",") >= 0:
                ls = cell.split(',')
                X.append(float(ls[0]) * 1000 + float(ls[1]))
            else:
                X.append(float(cell))
        ret.append(X)
    return ret


def addData(filename, col, ls):
    data = pd.read_csv(filename)
    for c in col:
        x = []
        for cell in data[c]:
            x.append(cell)
        ls.append(x)


def getRegression(X, Y, prediction, init):
    '''X 是状态变量和输入组成的状态变量组
       Y 是状态变量的导数，即状态变量每年的增加值
       prediction 是用来用预测状态的13年的输入变量
       init 是初始的状态'''
    dimension = 3
    regr = [linear_model.LinearRegression() for i in range(dimension)]
    #估计每一维的参数a_ij,b_{ij}
    for i in range(dimension):
        regr[i].fit(X, Y[i])
    out = []
    increase = np.array([0.0 for i in range(dimension)])
    for data in prediction:
        init += increase  #状态变量累加
        ls = np.concatenate((init, data))
        for i in range(dimension):
            increase[i] = regr[i].predict(ls)[0]
        out.append(copy.copy(init))  #out用来记录每年的累计变量
    para = {}
    para['intercept'] = regr[0].intercept_  #截距
    para['cofficient'] = regr[1].coef_  #系数
    para['out'] = out
    para['redi'] = regr[0].residues_  #残差
    return para


def getAvage(ls):
    "产生未来3年的输入变量"
    for i in range(3):
        x = []
        x.append(ls[-1][0] * 1.13)
#        x.append(ls[-1][1] * 1.154)
        x.append(ls[-1][1] * 1.004)
        x.append(ls[-1][2] * 1.04)
        x.append(ls[-1][3] * 1.038)
        ls = np.vstack((ls, x))

    return ls


if __name__ == "__main__":
    dimension = 3
    var_x = []
    addData("data1.csv", [r"吞吐量", r"吞吐能力", r"固定资产投资"], var_x)
    var = getData("data.csv", ["GDP", "3", "2"])
    addData("data.csv", ["employee"], var)
    var_x.extend(var)
    # 读入的吞吐量,吞吐能力为亿吨，将其换算为万吨
    for i in range(len(var_x[0])):
        var_x[0][i] *= 10000
    for i in range(len(var_x[1])):
        var_x[1][i] *= 10000
    sca = copy.copy(var_x[0])
    package = var_x[0:dimension]

    #计算第二产业和第三产业占GDP的比重
    var_x = np.array(var_x)
    var_x[4] /= var_x[3]
    var_x[5] /= var_x[3]
    ret = var_x[dimension:]
    ret = np.array(ret).T
    var_x = np.array(var_x).T

    #计算每一年状态变量的增加值，np.diff()是计算数组相邻元素差值的函数
    for i in range(dimension):
        package[i] = np.diff(package[i])
    ret = getAvage(ret)

    #拟合曲线并预测数值
    init = var_x[0,0:dimension]
    var_copy = copy.copy(var_x)
    package_copy = copy.copy(package)
    ret_copy = copy.copy(ret)
    init_copy =copy.copy(init)
    out = getRegression(var_x[0:9], package[0:9], ret, init)
    for i in range(13):
        tmp = ret_copy[i][1] * 0.1
        ret_copy[i][1] += tmp
#        ret_copy[i][2] += tmp
    newout = getRegression(var_copy[0:9], package_copy[0:9], ret_copy, init_copy)

    #绘图并保存数据
    plt.figure()
    plt.title(u"实际吞吐量与模拟吞吐量比较")
    axis_x = range(2006, 2019)  #仿真年份2006-2019
    var_y = np.array(out["out"])[:, 0]
    plt.plot(axis_x, var_y)
    var_new =  np.array(newout["out"])[:,0]
    plt.plot(axis_x, var_new)
    plt.scatter(axis_x[0:10], sca)
    np.save("产业结构原始.npy", var_y)
    np.save("增大第二.npy", var_new)
    plt.show()
