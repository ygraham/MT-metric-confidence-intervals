# MT-metric-confidence-intervals

#### Code for Computing Confidence Intervals 
#### used for Evaluating Machine Translation Metrics
#### by Correlation with Human Judgment

***
NAACL Paper ([bibtex](https://www.computing.dcu.ie/~ygraham/naacl16)):

Yvette Graham and Qun Liu, 2016  
Achieving Accurate Conclusions in Evaluation of Automatic Machine Translation Metrics  
In Proceedings of the 15th Annual Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies  
San Diego, CA.   
***

Example input files for WMT'15 data are in the following directory:

    ./wmt15-data


For example, for cs-en the code expects two files:

    ./wmt15-data/hum-sys.cs-en.scores.csv (human assessment and metric scores for MT systems)
    
    ./wmt15-data/wmt-r.cs-en.csv (pre-computed correlations to order the metrics from best to worst)


To run the code to compute confidence intervals for a given language pair:

    R --no-save --args cs-en < diff-dep-r-ci.R

This creates a matrix of difference in dependent correlation confidence intervals 
for every pair of metrics with respect to their correlation with human assessment.
Confidence intervals will be produced, for example, in the following file:

    ./wmt15-data/diff-dep/r-ci.cs-en.csv
    

Any questions, feel free to email me: graham.yvette@gmail.com

wmt-15 conclusions based on confidence intervals can be found here:

    ./wmt15-conc/r-conc-binary.cs-en.pdf
    ./wmt15-conc/r-conc-binary.de-en.pdf
    ./wmt15-conc/r-conc-binary.fi-en.pdf
    ./wmt15-conc/r-conc-binary.fr-en.pdf
    ./wmt15-conc/r-conc-binary.ru-en.pdf
    ./wmt15-conc/r-conc-binary.en-cs.pdf
    ./wmt15-conc/r-conc-binary.en-de.pdf
    ./wmt15-conc/r-conc-binary.en-fi.pdf
    ./wmt15-conc/r-conc-binary.en-fr.pdf
    ./wmt15-conc/r-conc-binary.en-ru.pdf




