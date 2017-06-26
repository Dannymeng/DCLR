#!/usr/bin/python
# -*- coding: utf-8 -*-


import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline

if __name__ == "__main__":

    path1 = 'drugpairfeature.txt'
    data = np.loadtxt(path1, dtype=np.float)
    [pair, x] = np.split(data, (2,), axis=1)

    path2 = 'output.txt'
    y = np.loadtxt(path2, dtype=np.float)

    [x_train, x_test, y_train, y_test] = train_test_split(x, y, train_size=0.7, random_state=1)

    # model = LogisticRegressionCV(Cs=10, fit_intercept=True, cv=5)
    model = LogisticRegression()

    nrow, ncol = y.shape
    pred = np.zeros((nrow, ncol))

    for f in range(ncol):
        y_train_temp = y_train[:, f]
        y_test_temp = y_test[:, f]
        model.fit(x_train, y_train_temp)

        y_hat = model.predict(x_test)
        # print(u'The accuracy of model：%.2f%%' % (100 * np.mean(y_hat == y_test_temp.ravel())))
        # pred[:, f] = model.predict_log_proba(x)[:, 1]
        pred[:, f] = model.predict_proba(x)[:, 1]
