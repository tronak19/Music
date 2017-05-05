# Interpretation of Music Scoresheet to Generate Audio File<br />
Image Processing & Music Domain<br/>

The system takes a digital music scoresheet image as input and and generates an audio file of the symphony represented by the scoresheet image as output. An artificial neural network based on boosting approach is engineered for training the system and for recognition of segmented music notes

Project is being developed on MATLAB platform.

## Process Flow:<br/>
* Preprocessing - Binarization<br/>
* Segmentation - Hierarchical Decomposition<br/>
* Training & Recognition - Artificial Neural Network (SVD, PCA, Classification Tree)<br/>
* Playback - MIDI<br/>

## Intermediate Outputs
Note Segmentation<br/>
Step 1:<br/>
![step1](https://raw.githubusercontent.com/tronak19/Music/master/Output/Symbol_8.png)

Step 2:<br/>
![step2](https://raw.githubusercontent.com/tronak19/Music/master/Wipe/Symbol_7.png)

Step 3:<br/>
![step3](https://raw.githubusercontent.com/tronak19/Music/master/Other/boundary.png)