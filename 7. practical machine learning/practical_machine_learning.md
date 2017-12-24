---
title: "Practical Machine Learning"
author: "Minki Jo"
date: "Dec. 24th, 2017"
---
### Executive Summary  
Considering dataset's chracracteristic, `Random Forest` model is used. In order to choose number of variables in random forest, `the least out of bag error` is used for the cross validation; as a result, 7 mtry is selected. In order to validate the selected model, 40% of whole data is separated into validation set before applying the model. The results shows that the model has 100% in accuracy, which is out of sample error and the most important variables turns out "yaw_belt"", "roll_belt", "magnet_dumbbell_z" and "pitch_belt". Finally, 20 cases for test set is predicted well. 

### Introduction  
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. 

The goal of this project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set. This reports mainly includes following points:  
- How the model was built  
- How coross validation is used  
- what the expected sample error is  
- what the model decision is reached
- and answer 20 different test cases  

### Library  
```{r echo=TRUE, message=FALSE, warning=FALSE}
library(caret)
library(randomForest)
```

### Data Loading and target variable  
Two csv files are read separately into train and test dataset. Let's see what each dataset's dimension is.   
```{r}
train <- read.csv("pml-training.csv", header =T, sep=",", na.strings=c("NA",""))
test <- read.csv("pml-testing.csv", header =T, sep=",", na.strings=c("NA",""))
dim(train)
dim(test)
train$classe = as.factor(train$classe)
table(train$class)
```
Train set includes 19,622 observations and 160 variables with target variable, classe, while test set consists of 20 cases with 160 variables. All columns between train and test set are the same except that the test data does not have target variable, but it has a variable, problem_id instead. We can also see the target variable that has 5 factors.
 
### Preprocessing  
Before applying train data to machine learning model, the columns from data sets that have missing values should be gotten rid of. Let's find which variables has many missing values that should be removed and make a new train dataset.  
```{r}
na.apply <- sapply(1:dim(train)[2], function(x) {sum(is.na(train[, x]))})
na.apply
```

From the results above, each variable either have no missing value or a lot of missing data (19,216 out of 19,622). Therefore, all columns that have 19,216 missing values should be removed and train data is newly set like below  
```{r}
value.col = which(na.apply == 0)
train <- train[, value.col]
test <- test[, value.col]
dim(train)
dim(test)
```
Now, variables for train and test data is reduced to 60 variables. The first 7 columns should be removed from expalanatory variables because it is unnecessery attributes for the model.

```{r}
train <- train[, 8:60]
test <-  test[, 8:59]
dim(train);  dim(test)
```
Now, the final columns for train has 53 variables, (52 for attributes, 1 for target). Since test data does not have target value, 53th variable(problem_id) should be removed too. Now, data cleaning procedure is done.

### Dataset Partition  
Since we are going to validate out of sample error after applying to model, validation dataset should be formed before application to model. Dataset here used is large ("large"" is usally said when data has more than 500 observations), validation dataset should be separated from train data, whose ratio is its 40%.

```{r}
inTrain = createDataPartition(train$classe, p=0.6, list=FALSE)
tr <- train[inTrain,]
val <- train[inTrain,]
```

###  Application to model  
Since the target variable is qualitative and has more than 2 factors, we should use the models which is not only for **"classfication problem"**", but also **"muti-factor response variable"**. 
For those constraints, tree-based modeling works well. It is widely said that random forest, which is ensemble between tree and bootstrap, has higher performance than model using pruned tree, **random forest is used for this report**. 

### Cross Validation  
In order to choose number of variables for bootstrap in random forest, `Out Of Bag Error(OOB Error)` is used for cross validation. For random forest, optimum number of variables is near sqrare root of number of variables, here sqrt(53). Let's try mtry between 6 and 9 in random forest. 

```{r echo=TRUE, message=FALSE, warning=FALSE, paged.print=FALSE}
err.rate <- c()
set.seed(123)
for (i in 6 : 9){
        rf.fit <- randomForest(classe ~., data = tr, mtry =i)
        err.rate <- c(err.rate, mean(rf.fit$err.rate[,1]))
}
err.rate
```
Since OOB Error having mtry between 6 and 10 are pretty close,which is around 0.9%, less variable model(here for 6) is selected. For your information, 500 trees (here in default) is usually good enough for random foreset. So, we do not need to try higher number of trees here. For more detail analysis later, important fucntion is added to activate now.
```{r}
set.seed(123)
rf.fit <- randomForest(classe ~., data = tr, mtry =6, importance =T)
```

### Validaton  
It is time to validate how powerful our selected prediction rate is by using validation set.
```{r}
pred <- predict(rf.fit, newdata = val)
confusionMatrix(pred, val$classe)
```


```{r}
varImpPlot(rf.fit, sort = T, type = 1)
```

The model chosen has accuracy 100, which is very high `The out-of-sample error using validation set. From the important plot above, the the most important variables in order are "yaw_belt"", "roll_belt", "pitch_belt", "magnet_dumbbell_z".

### Prediction  
Now, let's predict 20 cases in test set
```{r}
pred <- predict(rf.fit, newdata=test)
pred
```

