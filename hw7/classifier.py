# Description: Read data, build naive Bayesian classifier and classify first few instances
# Category:    modelling
# Uses:        voting.tab
# Referenced:  c_basics.htm

import orange
data = orange.ExampleTable("genestrain.tab")
predictionData = orange.ExampleTable("genesblind.tab")
classifier = orange.BayesLearner(data)
for i in predictionData:
    c = classifier(i)
    print "%s" % (c)
