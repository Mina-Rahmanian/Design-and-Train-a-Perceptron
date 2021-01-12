# Design and train a Perceptron (using iris data) <br />  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (C#, Matlab, Python)
<br />


Useful bits of knowledge before start:
+ First of all, please read The Artificial Neural Networks book in second edition from this link ["Elements of Artificial Neural Networks" ](https://www.academia.edu/23714658/Elements_of_Artificial_Neural_Networks). 
+ There are absolutely free resources for Deep Learning (online book) in [here](http://neuralnetworksanddeeplearning.com/chap1.html).
+  Also if you want to work Convolutional network you can read this link [Convolutional network](https://ujjwalkarn.me/2016/08/11/intuitive-explanation-convnets/) too. 
<br /><br /><br />


## Data Description

+ Iris data is one of the most popular datasets in machine learning tasks. Iris is a flowering plant with 260-300 different species.
+ Iris data contains the measurements of 3 different species of Iris: Setosa, Versicolour and Virginia.
+ The plot below shows the relation between Petal width and length.
+ The data is provided in two files here: [ iris_train.txt](https://github.com/Mina-Rahmanian/Design-and-Train-a-Perceptron/blob/main/iris_train.txt) and [iris_test.txt](https://github.com/Mina-Rahmanian/Design-and-Train-a-Perceptron/blob/main/iris_test.txt).
   - Each line in the files represents a separate data point where each data point includes the following comma separated values: <br />
        + Sepal length (cm), Sepal width (cm), Petal length (cm), Petal width (cm), class label
        + Example: 5.1,3.5,1.4,0.2,Iris-setosa
   - Iris_train.txt contains 40 data points for each class. We should Use this to train our perceptron.
   - Iris_test.txt contains 10 data points for each class. Use this to test that our perceptron works correctly.<br /><br />
   
<p align="center">
<img width="520" height="450" alt="iris" src="https://user-images.githubusercontent.com/71558720/104261895-7a410680-5454-11eb-96ca-e9b18a215a84.PNG"><br /><br />
<p align="center">

----------------------------------------

# Solution

1) one coded in C#, depicts a structure of the following figure. First-class is separated by designing the first set of weights such that the first class is split from the other two. Then, types 2 and 3 are separated in another perceptron by designing appropriate weights. In this platform, the weighting factors are computed sequentially. The code is ---------

<p align="center">
<img width="700" height="450" alt="f1" src="https://user-images.githubusercontent.com/71558720/104262571-dd7f6880-5455-11eb-9b6e-42005327ddd2.PNG">


----------------------------------------------------
2) In the second case, we calculate the weights in parallel and simultaneously using the error correction and pocket algorithm. Here three perceptrons are deployed to do the task. The code is written in Matlab and is attached with the comments included. The chosen growth rate is 0.01 and initial weighting factors are selected randomly.

<p align="center">
<img width="500" height="350" alt="f2" src="https://user-images.githubusercontent.com/71558720/104262573-deb09580-5455-11eb-9a8b-26a2b3893445.PNG">












