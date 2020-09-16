# %% [markdown]
# LinearRegreesion Construction

# %%
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# %%
class LinearRegression:
    def fit(self, X, y, intercept = False):
        if intercept == False:
            ones = np.ones(len(X)).reshape(len(X),1)
            X = np.concatenate((ones, X), axis = 1)
        self.X = np.array(X)
        self.y = np.array(y)
        self.N, self.D = self.X.shape

        XtX = np.dot(self.X.T, self.X)
        XtX_inverse = np.linalg.inv(XtX)
        Xty = np.dot(self.X.T, self.y)
        self.beta_hats = np.dot(XtX_inverse, Xty)
        self.y_hat = np.dot(self.X, self.beta_hats)
        self.L = .5 * np.sum((self.y - self.y_hat) ** 2)

    def predict(self, X_test, intercept = True):
        self.y_test_hat = np.dot(X_test, self.beta_hats)
# %%
from sklearn import datasets
boston = datasets.load_boston()
X = boston["data"]
y = boston["target"]
# %%
model = LinearRegression()
model.fit(X, y, intercept=False)

# %%
sns.set_style(None, {"font.sans-serif":["SimHei", "Arial"]})
# sns.set_style(None, {"font.sans-serif":["SimSun", "Arial"]})
fig, ax = plt.subplots()
sns.scatterplot(model.y, model.y_hat)
ax.set_xlabel(r"$y$", size = 16)
ax.set_ylabel(r"$\hat{y}$", size = 16, rotation = 0, labelpad = 15)
ax.set_title(r"$y$ vs. $\hat{y}$", size = 16, pad = 10)
sns.despine()
