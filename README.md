HW3- MapReduce Instructions :

Python 3 is required. You don't need to download mincemeat. If you download mincemeat from the website and use that instead, you might find syntax errors :

e.g., example.py contains print result, which you can change to print(result) 
e.g., mincemeat.py contains import cPickle as pickle, which you can change to import pickle

To start the server :
% cd /Workspace/PythonMapReduce/src
% python coursera_hw3.py

To start the client :
% python mincemeat.py -p changeme localhost

Note that the output will be printed to the terminal. To print output to a file, start the server with :
% python coursera_hw3.py > file.txt


Misc : 

hw3/res/hw3_instr.txt are the instructions for hw3
hw3/res/hw3_qn.txt are the questions for hw3, with my answer provided
hw3/res/hw3_out.txt is the output file produced by the map reduce operation
