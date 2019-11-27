# README

“[The world’s largest selfie](https://www.gsmarena.com/nokia_lumia_730_captures_worlds_largest_selfie-news-10285.php)” captured by the 5MP camera of the Lumia 730 cellphone is widely used to evaluated the performance of unconstrained face detection algorithms. But by now, there is no any related benchmark about it. In order to facilitate the comparation among different methods on this picture, we annotated it with the labelling tool named [labelImg](https://pypi.org/project/labelImg/). 

| Author<br /><br /><br /> | Xu, Guangzhu;<br /> Qu, Jinshan; <br />Wan, Qiubo;<br /> Zhu, Zequn | R.N.J. Veldhuis;<br />L.J. Spreeuwers<br /> |
| ------------------------ | ------------------------------------------------------------ | ------------------------------------------- |
| Email<br /><br />        | xgz@ctgu.edu.cn                                              | r.n.j.veldhuis@utwente.nl                   |
| Affiliation              | China Three Gorges University                                | Twente University, the Netherlands          |

![selfie](D:\Git-rigan\selfieBenchmark\SelfieImg\selfie-benchmark.jpg)

### The repository includes:

1. selfie.jpg
2. Benchmark
3. evaluation scripts

## About the benchmark

Altogether, 856 faces are labelled. They are divided into three categories: 

clearface: 336 images (indicated with blue bounding boxes)
dimface:  398 images (indicated with green bounding boxes) 
guessface: 122 images (inidcated with red bounding boxes)

We use the Yolo format in the annotation file, and the format of annotation information is: classes x y w h, x/y is the coordinate of the center point, w/h is the width and height of the bouding box.

We also wrote a script to evaluate the detection performance on the selfie. This script was extracted from the WIDER FACE evaluation script and we have modified it. We will draw a curve to show the detection performance of your model on the selfie.

## How to use it

Download our project, test your model with the selfie picture, and place your test results in the project root directory. You need to specify the path of the file to be evaluated and the algorithm name in the file selfie_eval.m.

The format of your test results should be :
Image name
Number of detected
x1 y1 w h
…
…
…
There is an example for testing, which is the sample.txt.
Execute selfie_eval. m and you will get the result, your results will be saved below Selfie/figure as a pdf file.

### Citation

Please use this bibtex to cite this repository:

{

Title={ Benchmark of the world's largest selfie},
Author = { Xu GuangZhu, Qu JinShan,Wan QiuBo, Lei BangJun, R.N.J. Veldhuis, L.J. Spreeuwers},
Year = { 2019 },
Affiliation={ College of Computer and Technology Information, China Three Gorges University, P.R. China;
                   Faculty of Electrical Engineering, Mathematics & Computer Science, University of Twente, the Netherlands}
Publisher={ Github },

}

 

