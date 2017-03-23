This example assumes an experiment in which we take 8 seeds from each of a certain 100 plants with a various number of leaves (unknown), thus its dataset contains 
1) ID of each plant and 2) the number of survived seeds in 100 rows. 
From the viewpoint of hierarchical Bayesian modeling, unknown number of leaves of each plant can be random effects*2.

Hierarchical Bayesian models assume various kinds of individual biases (random effects).
It can be regarded as an "absorber" that can absorb fluctuations given by such random effects.
