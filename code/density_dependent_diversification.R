library(laser)

data(warblers) 

# constant rate
bd_ML(warblers, tdmodel=0)
# Maximum likelihood parameter estimates: lambda0: 0.280727, mu0: 0.000000, lambda1: 0.000000, mu1: 0.000000:  
# Maximum loglikelihood: -54.488919 


# linear dependence in speciation rate as default ddmodel == 1
dd_ML(warblers)

# Maximum likelihood parameter estimates: lambda: 1.081300, mu: 0.000000, K: 27.335160 
# Maximum loglikelihood: -43.287853 


# linear dependence in speciation and extinction rates ddmodel == 5
dd_ML(warblers, ddmodel=5)
# Maximum likelihood parameter estimates: lambda: 0.875239, mu: 0.000000, K: 28.161940, r: 0.000000 
# Maximum loglikelihood: -43.645198 


# linear dependence in extinction rates ddmodel == 3
dd_ML(warblers, ddmodel=3)


# for our data try function 
dd_KI_ML()