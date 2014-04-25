**Title: Diversity dynamics in Nymphalidae butterflies: Effect of phylogenetic uncertainty on diversification rate shift estimates**

### Authors: Carlos Peña^1,\*^ and Marianne Espeland^2,\*^

### Running title:  Diversity dynamics in Nymphalidae butterflies

*1 Laboratory of Genetics, Department of Biology, University of Turku, Turku, Finland. Email: [mycalesis@gmail.com](mailto:mycalesis@gmail.com)*

*2 Museum of Comparative Zoology and Department of Organismic and Evolutionary Biology, Harvard University, Cambridge, USA. Email: [marianne.espeland@gmail.com](mailto:marianne.espeland@gmail.com)*

**Corresponding author:** [mycalesis@gmail.com](mailto:mycalesis@gmail.com) Telephone: +358 417063065 Fax: +358 2 333 6680 

**Comments:** 5814 words, 7 figures, 2 tables and 25 supplementary material files. 

**Additional Supplementary materials:** [http://dx.doi.org/10.6084/m9.figshare.639208](http://dx.doi.org/10.6084/m9.figshare.639208)

**Pre-peer review:** This manuscript has been peer-reviewed by two anonymous referees using Peerage of Science. The peer-review process can be accessed via [https://www.peerageofscience.org/?link=108491](https://www.peerageofscience.org/?link=108491) using the following credentials: **Username:** 522d928bf3f1d@Journal_Evolutionary_Biology  **Password:** 7iepgwlw



## Abstract
The speciose butterfly family Nymphalidae has been used to study 
evolutionary interactions between plants and insects. Theories of 
insect-hostplant dynamics predict accelerated diversification due to key innovations.
We investigated whether phylogenetic uncertainty affects a commonly used method
(MEDUSA, modelling evolutionary diversity using stepwise AIC) for estimating 
shifts in diversification rates in lineages, by extending the method across a 
random sample of trees from the posterior distribution of a Bayesian run. We 
found that phylogenetic uncertainty greatly affects diversification rate 
estimates. Different trees produced diversification rates ranging from high 
values to almost zero for the same clade, and both significant rate increase 
and decrease in some clades. Only three out of 13 significant shifts found on
the maximum clade credibility tree were consistent across most of the sampled trees.
Among these, we found accelerated diversification for Ithomiini butterflies. 
We used the binary speciation and extinction model (BiSSE) and found that a 
hostplant shift to Solanaceae is correlated with increased diversification 
rates in Ithomiini, congruent with the diffuse cospeciation hypothesis. Our results
show that taking phylogenetic uncertainty into account when estimating 
diversification rate shifts is of great importance, and relying on the maximum
clade credibility tree alone can potentially give erroneous results.

**Keywords:** diversification analysis, MEDUSA, BiSSE, speciation rate, 
insect-hostplant dynamics




## Introduction
Hostplant shifts have been invoked to be responsible for a great part of the 
biodiversity of herbivorous insects [@mitter1988]. The study of the 
evolution of hostplant use has spawned several theories explaining the evolutionary
interactions between plants and insects [reviewed by @nyman2012]. The 
"escape-and-radiate" hypothesis [@ehrlich1964] states that plants and
herbivore butterflies are involved in an evolutionary arms race in which newly 
acquired adaptive characters in plants act as defense against herbivores. This
would allow the plant lineage to escape the herbivorous pressure and diversify.
Eventually, the butterflies would also acquire a character to overcome this 
barrier and radiate onto the available plant resource. An alternative hypothesis
of herbivore diversification is the "oscillation hypothesis" [@janz2011; @nylin2013] or 
"diffuse cospeciation" [@nyman2012] in which range expansions of plants
and insects facilitate allopatric speciation and cross-colonization of insects
onto related plants. This hypothesis predicts near-simultaneous diversification
of plants and insects that feed on them [@nyman2012]. The "resource 
abundance-dependent diversity dynamics" hypothesis states that plant groups that
are common and widely distributed will host a higher diversity of herbivores by
facilitating their speciation over wider geographic distributions. According to
this hypothesis, there should be a time lag between the diversification of 
hostplants and insects that feed on them [@nyman2012]. 

The butterfly family Nymphalidae has been an important taxon for developing 
some of the mentioned hypotheses. Nymphalidae contains around 6000 species 
[@van_nieukerken2011], and is the largest family within the true 
butterflies. The family most likely originated around 94 MYA in the mid 
Cretaceous. Diversification of the group began in the Late Cretaceous and most
major radiations (current subfamilies) appeared shortly after the 
Cretaceous-Paleogene (K-Pg) boundary [@heikkila2012]. Several studies 
have used calibrated phylogenies and diversification models to reconstruct the
evolutionary history of the group to identify patterns of accelerated or 
decelerated diversification of some Nymphalidae clades [@elias2009; 
@fordyce2010; @wahlberg2009; @heikkila2012]. For example, it has
been suggested that climate change in the Oligocene and the subsequent 
diversification of grasses has led to diversification of the subfamily Satyrinae
[@pena2008] due to the abundance of grasses over extensive geographic
areas ("resource abundance-dependent diversity dynamics" hypothesis). 
@fordyce2010 found increased diversification rates in some Nymphalidae lineages
after a major hostplant shift, which appears to be in agreement with @ehrlich1964
"escape-and-radiate" model of diversification. 
 	 	
Although it has been suggested that part of the great diversity of Nymphalidae
butterflies is a result of hostplant-insect dynamics, it is necessary to use 
modern techniques to investigate whether the diversification patterns of 
Nymphalidae are in agreement with the theoretical predictions. It is necessary
to test whether the overall diversification pattern of Nymphalidae is congruent
with events of sudden diversification bursts due to hostplant shift, climatic 
events or shifts to closely related hostplants [@nylin2013; @ferrer2013].

In this study, we used a time calibrated genus-level phylogenetic hypothesis 
for Nymphalidae butterflies [taken from @wahlberg2009] to investigate 
patterns of diversification. We applied MEDUSA [modelling evolutionary diversity
using stepwise AIC, @alfaro2009; @harmon2011], a recently developed
statistical method, to study the diversification pattern of Nymphalidae butterflies.
MEDUSA fits likelihood models of diversification into a time calibrated tree and
tests whether allowing increases or decreases in speciation and extinction rates
within the tree produces better fit of the models. MEDUSA is able to take into 
account species diversity for during model fitting and it is normally applied to
the maximum clade credibility phylogenetic tree.
Particularly, we wanted to study the effects of phylogenetic uncertainty and 
modified the current MEDUSA method to take this into account (Multi-MEDUSA). 
We also tested whether hostplant association dynamics can explain the 
diversification patterns of component Nymphalidae lineages by testing whether 
character states of hostplant use affected the diversification pattern of those
lineages employing the method BiSSE as implemented in the R package
``diversitree`` [@fitzjohn2012].



## Methods

### Data
For analyses, we used the phylogenetic trees from the study of @wahlberg2009 that
were generated using DNA sequence data from 10 gene regions for 398 of the 540
valid genera in Nymphalidae. We employed @wahlberg2009 maximum clade credibility
tree (MCC tree) (Fig. 1) as well as a random sample of 1000 trees from
their BEAST run after burnin. Their original BEAST run was for 40 million
generations. We used a burnin of 25 million generations and took a random sample
of 1000 trees using Burntrees v.0.1.9 <http://www.abc.se/~nylander/> (supp. mat.
5) in order to correct for phylogenetic uncertainty when performing the
diversification analyses.

Species richness data for Nymphalidae genera were compiled from several sources
including the specialist-curated lists on <http://tolweb.org>, @lamas2004 and
curated lists of Global Butterfly Names project
(<http://www.ucl.ac.uk/taxome/gbn/>).
We assigned the species numbers of genera not included in the phylogeny to the
closest related genus that was included in @wahlberg2009 study according to
available phylogenetic studies [@matos2013; @brower2010; @kodandaramaiah2010;
@kodandaramaiah2010a; @ortiz2013; @desilva2010; @freitas2004; @pena2006;
@penz1999; @silva2008; @pena2011; @pena2010], taxonomical classification and
morphological resemblance when no phylogenies were available (supp. mat. 03).

Hostplant data for Nymphalidae species were compiled from several sources
including @ackery1988, HOSTS database (<http://bit.ly/YI7nwW>), @dyer2002,
@beccaloni2008, @janzen2009 and others (supp. mat. 06--07) for a total of 6586
hostplant records, including 428 Nymphalidae genera and 143 plant families and
1070 plant genera. It was not possible to find any hostplant data for 35
butterfly genera.



### Analyses of Diversification
We used the statistical software R version 2.15.1 [@r2013] in 
combination with the APE [@paradis2004], GEIGER [@harmon2008] and
``diversitree`` [@fitzjohn2012] packages along with our own scripts to perform
the analyses (included as supplementary materials). All analyses were run on
the 1000 random trees from @wahlberg2009 as well as on the maximum 
clade credibility tree.



### Detecting diversification shifts on phylogenetic trees
Patterns of diversification in Nymphalidae were analyzed by using MEDUSA 
version 093-4-33 [@harmon2011] on the maximum clade credibility tree from 
@wahlberg2009. MEDUSA fits 
alternative birth-death likelihood models to a phylogenetic tree in order to 
estimate changes in net diversification rates along branches. MEDUSA estimates 
likelihood and AIC scores for the simplest birth-death model, with two parameters
(``b``: speciation and ``d``: extinction). The AIC scores of the two-parameter model 
are then compared with incrementally more complex models until the addition of
parameters do not improve the AIC scores beyond a cutoff value. MEDUSA finds the
likelihood of the models after taking into account branch lengths and number of
species per lineage [@alfaro2009]. To our knowledge, studies using MEDUSA
have so far only run the method on a single tree, usually the
maximum clade credibility tree, which makes the assumption that this tree is correct.
We wanted to study the effects of phylogenetic uncertainty on estimation of 
diversification rate shifts and therefore run 
MEDUSA across 1000 random genus-level trees from the posterior distribution
(Multi-MEDUSA, supp. mat. 06) and summarize the estimated changes in 
diversification rates for nodes across all trees. Patterns of change in 
diversification rates are significant if they are found at the same node in at
least 95% of the trees. We also expected to find similar values of net diversification
(``r = b - d``) and relative extinction rate ($\varepsilon$ ``= d/b``) values 
across the 1000 trees for the nodes where changes in diversification tempo 
occurs. We used the AICc threshold of 7.8 units, as estimated by MEDUSA,
as the limit for a significantly better fit to
select among increasingly complex alternative models. 
We let MEDUSA estimate up to 25 diversification rate shifts in our trees as
the maximum number of shifts found in all trees was only 21.


### Effect of the quality of posterior distribution of trees on MEDUSA and Multi-MEDUSA
We tested the effect of topology uncertainty and width of confidence intervals
of ages on the number of diversification splits inferred by the MEDUSA and
Multi-MEDUSA approaches.
We created a thousand sets of 1000 trees with increasinly better support for the 
topology by replacing each of the trees in the posterior distribution with our 
MCC tree.
The degree of topology uncertainty for each 
set was measured as the ratio of nodes with high posterior probability (> 0.95) on
the MCC tree of each set of thousand trees.
Multi-MEDUSA was then run on all the sets of trees, and we counted the number of consistently
recovered diversification splits inferred across more than 95% of the trees.

To test for an effect of age confidence interval widths of node ages, we
created a thousand sets of 1000 trees with narrowing confidence intervals
on the estimated ages for all the nodes.
This was achieved by running a BEAST analysis with a fixed topology
(our MCC tree), but allowing varying branch lengths. We randomly selected
1000 trees from the posterior distribution of trees after burning (supp. mat. 07)
and replaced each of the trees with the MCC tree (supp. mat. 08) to create a thousand
sets of 1000 trees.
The relationship between width of age confidence intervals
and the number diversification splits inferred across more than 95% of the
posterior distribution of trees was plotted.




### Estimation of trait-dependent speciation rates
As the MEDUSA and Multi-MEDUSA approaches estimated an increase in 
diversification in the clade Ithomiini, we tested whether this pattern 
can be explained by hostplant use and performed analyses with the
"binary state speciation and extinction" 
[BiSSE; @maddison2007] Bayesian approach as implemented in the
R package ``diversitree`` [@fitzjohn2012]. MuSSE [@fitzjohn2012] is designed to
examine the joint effects of two or more traits on speciation. Because most of
Nymphalidae butterflies are restricted to use one plant family as hostplant, 
the character states can be coded as presence/absence, for which the BiSSE 
analysis is better suited. BiSSE was designed to test whether a binary character
state has had any effect on increased diversification rate for a clade 
[@maddison2007]. We used our compiled data of hostplant use to produce a
binary dataset for the character "feeding on the plant family Solanaceae" with
two states (absence = 0; presence = 1) (supp. mat. 09), which is the main
hostplants of the diverse Ithomiini butterflies and closest relatives
[@willmott2006]. Other hostplant shifts were not tested for effect on 
diversification rates due to the low support for diversification shifts
found in the MEDUSA analyses.
We analyzed the data using BiSSE employing the Markov 
Chain Monte Carlo algorithm on the maximum clade credibility tree, taking into
account missing taxa by using the parameter "sampling factor" (``sampling.f``)
in ``diversitree``.
We also used constrained analyses forcing no effect of hostplant use on
diversification and likelihood ratio tests to find out whether the hypothesis 
of effect on diversification has a significantly better likelihood than the 
null hypothesis (no effect). The analyses were run across a sample of 250 trees from the 
posterior distribution.
The records of *Vanessa* and *Hypanartia* feeding on Solanaceae 
[@scott1986; @dyer2002] might be incorrect as it is unlikely that these
species can be feeding on this
plant family. We tested whether coding these two genera as not feeding on 
Solanaceae affected our results.

## Results


### Detecting diversification shifts on the maximum clade credibility tree
The MEDUSA analysis on the MCC tree in combination with richness data estimated
18 changes in the tempo of diversification in Nymphalidae history (Fig. 1; 
Table 1). The estimated corrected threshold of AICc scores for 
selecting the optimal model was estimated as 7.8 units. In all MEDUSA analyses, 
the maximum number of inferred diversification splits in all trees was
XXXXXXXXXXXXXXXXXXXXX. Thus
a ``model.limit`` of 25 splits was adequate. The background 
diversification rate for Nymphalidae was estimated as ``r = 0.092`` lineages per 
Million of years and the AICc score for the best fit model was ``5090.5`` 
(Table 1).
MEDUSA also estimated that the basic constant birth--death model was not a
better explanation for our data (AICc ``= 5449.3``).

Some of the 18 changes in diversification correspond to rate 
increases in very species-rich genera: *Ypthima* (``r = 0.311``), *Charaxes* 
(``r = 0.291``), *Callicore* + *Diaethria* (``r = 0.220``), *Pedaliodes* 
(``r = 0.196``) and *Taenaris* (``r = 0.234``). We found rate increases for other
clades as well such as: Lethina + Mycalesina (``r = 0.191``), Oleriina + Ithomiina +
Napeogenina + Dircennina + Godyridina (``r = 0.187``), Satyrini (``r = 0.116``),
Phyciodina in part (``r = 0.241``) and Satyrina (``r = 0.221``), *Coenonympha*
(``r = 0.209``), *Caeruleuptychia* + *Magneuptychia* (``r = 0.312``) and
*Taenaris* (``r = 0.312``).
We also found decreases in diversification rates for Limenitidinae + Heliconiinae
(``r = 0.0541``), part of Danaini (``r = 0.0423``), Pseudergolinae (``r =
0.024``) and Coenonymphina (``r = 0.065``) (Table 1).

### Phylogenetic uncertainty in the Multi-MEDUSA approach
We found that the analyses by MEDUSA on the 1000 trees did not estimate the
same diversification shifts as in the MCC tree (the background diversification
and all shifts found by MEDUSA on the 1000 trees are provided in supp. mat. 11).
In order to obtain the diversification shifts that were estimated in most of
the 1000 trees, we plotted the diversification shifts versus number of trees
containing that particular diversification shift (Fig. 3, supp. mat. 12--13) as
estimated by MEDUSA.
There were three diversification shifts found in more than 95% of the trees:
(i) diversification rate increase in the genus *Charaxes*; (ii) rate increase
in Ithomiini subtribes Oleriina + Ithomiina + Napeogenina + Dircennina +
Godyridina, and (iii) slowed diversification in part of Danaini (Fig. 3).

We obtained mean and standard deviation statistics for the diversification 
values found on the shifts on the 1000 trees (supp. mat. 11), and found that 
some of the changes in diversification rate values had great variation across
the posterior distribution of trees. A boxplot of the diversification rate 
values estimated for the clades that appear in the MCC tree shows that some shifts
are estimated as increased or slowed diversification pace depending on the tree
used for analysis (Fig. 4). This variation is especially wide for the clade
formed by the genera *Magneuptychia* and *Caeruleuptychia* because MEDUSA 
estimated diversification values from three times the background
diversification rate (``r = 0.2755``) to almost zero (``r = 2.04e-07``). The 
diversification rates estimates for the root (background diversification rate)
and the clades (*Tirumala* + *Danaus* + *Amauris* + *Parantica* + *Ideopsis* +
*Euploea* + *Idea*) and (Oleriina + Ithomiina + Napeogenina + Dircennina +
Godyridina) are relatively consistent across the 1000 trees (Fig. 4). It is
also evident that not all the diversification shifts estimated on the MCC tree
are consistently recovered in most of the 1000 trees. Some of the splits in the
MCC tree are recovered in very few trees, for example the split for the clade
(Euptychiina + Pronophilina + Satyrina + Maniolina) is present in only in 18%
of the trees (see supp. mat. 12--13). 

### MEDUSA performance due to phylogenetic uncertainty
We found that most of the diversification splits were consistently recovered
across more than 95% of the trees from the posterior distribution when
there was a high ratio of nodes with high posterior probability 
(Fig. 5; supp. mat. 14--15).
For our data, it would be necessary to obtain a set of trees
from the Bayesian run with almost 99% of the nodes with posterior 
probability higher than 0.95 (almost no phylogenetic uncertainty) in order
to obtain most of the diversification splits from the MCC tree on the posterior
distribution of trees. For example the MCC tree of the set of trees number 949 
had 99.75% of the nodes with posterior probability > 0.95, however it was
possible to recover only 12 diversification shifts (out of a total of 14)
across more than 95% of the trees (supp. mat. 14--15).

Fig. 6 shows that also the width of confidence intervals on the estimated
ages of diversification is correlated with the number of 
diversification splits that are consistently recovered across the posterior
distribution of trees. Very narrow confidence intervals are needed in
order to recover all 14 diversification splits across more than 95% of 
trees from the posterior distribution (supp. mat. 16).


### Estimation of trait-dependent speciation rates
The MEDUSA analyses taking into account phylogenetic uncertainty estimated
a diversification rate increase in part of the clade Ithomiini across more
than 95% of the trees.
Our BiSSE analysis found a positive effect of the 
character state "feeding on Solanaceae" on the diversification rate on part
of Ithomiini (Oleriina + Ithomiina + Napeogenina + Dircennina + Godyridina) 
(Fig. 7). The Markov Chain Monte Carlo algorithm was run for 10000
generations discarding the first 7500 as burnin. 
The estimated mean diversification rate for taxa that do not feed on 
Solanaceae was ``r = 0.11`` while the diversification rate for the Solanaceae
feeders was ``r = 0.16`` (see Fig. S3 for a boxplot of speciation and
extinction values for the 95% credibility intervals).
The same analysis considering *Vanessa* and *Hypanartia* as non-Solanaceae
feeders due to dubious records produced the same pattern and diversification
rates (Fig. S4). Therefore, the rest of the analyses were performed assuming
these two genera as Solanaceae feeders.
We constrained the BiSSE likelihood model to force equal rates of speciation
for both character states in order to test
whether the model of different speciation rates is a significantly better
explanation for the data. A likelihood ratio test found that the model for
increased diversification rate for nymphalids feeding on Solanaceae is a
significantly better explanation than this character state having no effect
on diversification (``p < 0.001``) (Table 2; character states available in
supp. mat. 09, code in supp. mat. 17, and mcmc run in supp. mat. 18). We
combined the post-burnin mcmc generations from running BiSSE on 250 trees from
the posterior distribution and found the same pattern as the BiSSE analysis on
the maximum clade credibility tree (combined mcmc run in supp. mat. 19;
profiles plot of speciation rates in Fig. S5; boxplot of 95% credibility
intervals in Fig. S6).
A BiSSE analysis to test whether the trait "feeding on Apocynaceae" had any
effect on increased diversification rates found similar speciation rates for
lineages feeding on Apocynaceae and other plants (Fig. S7). It has been shown
that BiSSE performs poorly under certain conditions [@davis2013]. 
However, our data has adequate number of taxa under analysis (more than 300
tips), adequate speciation bias (between 1.5x and 2.0x), character state bias 
(around 8x) and extinction bias (around 4x) for the analysis of Solanaceae
hostplants. Thus, BiSSE is expected to produce robust results [@davis2013].

## Discussion
### Effects of phylogenetic uncertainty on the performance of MEDUSA 
The MEDUSA method has been used to infer changes in diversification rates 
along a phylogenetic tree. Since its publication [@alfaro2009] the
results of using MEDUSA on a single tree, the maximum clade credibility tree,
have been used for generation of hypotheses and discussion [e.g. 
@litman2011; @heikkila2012; @ryberg2012].
However, we found that MEDUSA estimated different diversification
shifts and different rates of diversification for certain lineages
when phylogenetic uncertainty was taken into account by using MEDUSA
on a random sample of trees from the posterior distribution of a
Bayesian run. We found that some diversification splits, estimated
on the Nymphalidae maximum clade credibility tree, were found in a very small
percentage of the 1000 randomly sampled trees from the posterior
distribution (Fig. 3). We also found that, even though MEDUSA could
estimate the same diversification splits on two or more trees, the 
estimated diversification rates could vary widely (Fig. 4). For example,
in our Nymphalidae trees, we found that the split for *Magneuptychia* and 
*Caeruleuptychia* had a variation from ``r = 0.2755``, higher than the 
background diversification rate, to almost zero. This means that observed
patterns and conclusions can be completely contradictory depending on tree
choice.

In this study, the effect of phylogenetic uncertainty on the inferred 
diversification splits by MEDUSA is amplified because some Nymphalidae taxa 
appear to be strongly affected by long-branch attraction artifacts
[@pena2011]. Thus, the Bayesian runs are expected to recover alternative
topologies on the posterior distribution of trees, resulting in low support
and posterior probability values for the nodes. For example, posterior
probability values for clades in Satyrini are very low [``0.5 to 0.6``;
@wahlberg2009]. As a result, MEDUSA inferred a diversification
rate increase for part of Satyrini in the maximum clade credibility tree, but this
was recovered only in 17% of the trees from the posterior distribution.

We run Multi-MEDUSA on sets of thousand trees that gradually decrease in
phylogenetic uncertainty (degree of conflicting topology and width of
confidence intervals). 
It appears that the number of nodes with high posterior probability 
and width of confidence intervals for the estimated ages of diversification
on the MCC tree greatly affect the number of diversification splits from the MCC
tree that are consistently found on most trees from the posterior distribution.
In order to recover most diversification splits, it is necessary to 
obtain a set of trees from a BEAST run with almost no phylogenetic 
uncertainty, i.e. very narrow confidence intervals and almost no conflicting 
topologies so that most of the nodes are recovered with high posterior
probability (Fig. 5--6).

If there is strong phylogenetic signal for increases or decreases in
diversification rates for a node, it is expected that these splits would be
inferred by MEDUSA in most of the posterior distribution of trees. However,
weak phylogenetic signal for some nodes can cause some clades to be
absent in some trees and MEDUSA will be unable to estimate any
diversification shift (due to a non-existent node). This is the 
reason why MEDUSA estimated diversification rate splits in more than
95% of the posterior distribution of trees for only three splits: 
the genus *Charaxes*, part of Danaini and part of Ithomiini (Fig. 3),
while estimating splits for other lineages in only a fraction of the
posterior distribution of trees.

The clade Ithomiini and the non-basal danaids are well supported by high
posterior probability values in @wahlberg2009. Therefore our MEDUSA analyses
recovered an increase in diversification rate in more than 95% of the posterior
distribution of trees (Fig. 3).

### Hostplant use and diversification in Nymphalidae
#### Ithomiini
Keith Brown suggested that feeding on Solanaceae was an important event in the
diversification of Ithomiini butterflies [@brown1987]. Ithomiini butterflies
are exclusively Neotropical and most species feed on Solanaceae hostplants during
larval stage [supp. mat. 04; @willmott2006]. Optimizations of the
evolution of hostplant use on phylogenies evidence a probable shift from
Apocynaceae to Solanaceae in the ancestor of the tribe [@brower2006; @willmott2006].
@fordyce2010
found that the Gamma statistics, a LTT plot of an Ithomiini phylogeny and the fit
of the density-dependent model of diversification are consistent with a burst of
diversification in Ithomiini following the shift from Apocynaceae to Solanaceae.

We investigated whether the strong signal for an increase in 
diversification rate for Ithomiini (found by MEDUSA) can be explained due to the
use of Solanaceae plants as hosts during larval stage. For this, we used a Bayesian
approach [BiSSE; @fitzjohn2009] to test whether the trait "feeding on 
Solanaceae" had any effect on the diversification of the group. 

Our BiSSE analysis, extended to take into account missing taxa and phylogenetic 
uncertainty, shows a significantly
higher net diversification rate for Ithomiini taxa, which can be attributed to the
trait "feeding on Solanaceae hostplants" (Fig. 7). This is in agreement with the
findings of @fordyce2010 using other statistical methods. Due to the fact that
Ithomiini are virtually the only nymphalids using Solanaceae as hostplants, it is
possible that the trait responsible for a higher diversification of Ithomiini might
not be the hostplant character. 
As noted by @maddison2007, the responsible trait might be a 
codistributed character such as a trait related to the ability to digest secondary
metabolites.

Solanaceae plants contain chemical compounds and it has been suggested that the high
diversity of Ithomiini is consistent with the "escape-and-radiate scenario" due to
a shift onto Solanaceae [@fordyce2010] and radiation scenarios among chemically
different lineages of Solanaceae plants [@brown1987; @willmott2006].
According to this theory, the shift from Apocynaceae to Solanaceae allowed Ithomiini
to invade newly available resources due to a possible key innovation that allowed
them cope with secondary metabolites of the new hosts. Additional studies are needed
to identify the actual enzymes that Ithomiini species might be using for
detoxification of ingested food as they have been found in other butterfly groups 
[for example Pieridae larvae feeding on Brassicales hosts; @wheat2007].

The increase in diversification inferred by MEDUSA ocurred after the probable
shift from Apocynaceae to Solanaceae, as the Solanaceae feeders in the subtribes
Melinaeina and Mechanitina are not included in the diversification shift (shift number
6 in Fig. 2). The apparent conflicting results from MEDUSA and BiSSE can be explained
by the low species-richness of the subtribes Melinaeina and Mechanitina compared to the
other subtribes included in the shift (52 versus 272 species). It can be that MEDUSA
is more conservative than BiSSE and is not including Melinaeina and Mechanitina
in the shift due to low species numbers.

Although the Solanaceae genera used by the Ithomiini clades are well known 
[@willmott2006], we do not have any understanding on the physiological routes involved
in the detoxification of Solanaceae compounds by the several lineages of Ithomiini.
We can speculate that older lineages exploiting a novel toxic resource [as the subtribes
Melinaeina and Mechanitina; @willmott2006; @wahlberg2009] might not be too efficient
in metabolizing plant toxins and that younger lineages are able to deal with toxins
more efficiently, so that host switching events within Solanaceae are possible, which can
lead to higher diversification.
Studies in *Papilio* species have reported that detoxification enzymes can become more
efficient in metabolizing toxins than ancestral configurations of the proteins, providing 
more opportunities for hostplant switch [@li2003].
This might be the reason why the basal Ithomiini subtribes Melinaeina and Mechanitina
are so species-poor and restricted to few Solanaceae hosts [@willmott2006], while
recent subtribes are species-rich and have expanded their host range into several
Solanaceae lineages [@willmott2006].
It might be that the switch to feeding in Solanaceae was an important event in the 
evolutionary history of Ithomiini, but the actual radiation occurred after critical
physiological changes (a probable key innovation) allowed efficient detoxification of 
Solanaceae toxins.

The diffuse cospeciation hypothesis predicts almost identical ages of insects and 
their hostplants, while the "resource abundance-dependent diversity" and the
"escape-and-radiate" hypotheses state that insects diversify after their hostplants
[@ehrlich1964; @janz2011; @nyman2012]. @wheat2007 found 
strong evidence for a model of speciation congruent with Ehrlich and Raven's
hypothesis in Pieridae butterflies due to, in addition to the identification of a
key innovation, a burst of diversification in glucosinolate-feeding taxa shortly
afterwards (with a lag of ~10 MY). According to a recent dated phylogeny of the 
Angiosperms [@bell2010], the family Solanaceae split from its sister group
about 59 (49-68) MYA and diversification started (crown group age) around 37 (29-47) 
MYA. @wahlberg2009 give the corresponding ages for Ithomiini as 45 
(39-53) and 37 (32-43) MYA, respectively. Thus, current evidence shows that
Solanaceae and Ithomiini might have diversified around the same time, during 
the Late Eocene and Oligocene, and this is congruent with the diffuse 
cospeciation hypothesis.

The uplift of the Andes was a major tectonic event that underwent higher activity
during the Oligocene [@somoza1998]. This caused climatic changes in the region
that affected the flora and fauna of the time, which coincides with the
diversification of modern montane plant and animal taxa [@hoorn2010] including
Ithomiini butterflies and Solanaceae hostplants. Moreover, all Solanaceae clades
currently present in New World originated in South America [@olmstead2013] as well
as Ithomiini butterflies [@wahlberg2009]. This suggests a process of "diffuse
cospeciation" of Ithomiini and hostplants.


#### Danaini
Our Multi-MEDUSA approach gave a significant slowdown in diversification rate in 
the subtribe Danaina of the Danini. Both Danaina and the sister clade Euploeina 
feed mainly on Apocynaceae and thus a hostplant shift should not be responsible 
for the observed slowdown of diversification in the Danaina. As expected, our BiSSE
analysis of Apocynaceae feeders shows that there is no effect of feeding on this
plant family on the diversification rates of Nymphalidae lineages. Many of the
Danaina are large, strong fliers, highly migratory and involved in mimicry rings.
Among them is for example the monarch (*Danaus plexippus*), probably the most well
known of all migratory butterflies. The causes for a lower diversification rate
in the Danaina remains to be investigated, but their great dispersal power might
be involved in preventing allopatric speciation. It has been found in highly vagile
species in the nymphalid genus *Vanessa* that dispersal has homogenized populations
due to gene flow, as old and vagile species seem to be genetically homogeneous 
while younger widespread species show higher genetic differentiation in their
populations  [@wahlberg2011].

#### *Charaxes*
The genus *Charaxes* contain 193 species distributed in the Old World with highest
diversity in the Afrotropical region. These butterflies are also very strong fliers,
but contrary to Danaina, which are specialized Apocynaceae feeders,
*Charaxes* are known to feed on at least 28 plant families in 18 orders 
[@ackery1988] and some species appear to be polyphagous [@muller2010].
@aduse2009 showed that most of the diversification of the
genus occurred from the late Oligocene to the Miocene when there were 
drastic global climatic fluctuations, indicating that the diversity mainly
is driven by climate change. @muller2010 found that climatic 
changes during the Pliocene, Pleistocene as well as dispersal and vicariance
might have been responsible for the high diversification of the genus. 

#### Satyrini
The diverse tribe Satyrini radiated simultaneously with the radiation of their main 
hostplant, grasses, during the climatic cooling in the Oligocene
[@pena2008]. Thus, it is somewhat surprising that part of Satyrini
(the subtribes Euptychiina, Satyrina and Pronophilina) were found to have
accelerated diversification in only 17% of the trees from the posterior distribution.
Although this can be attributed to low phylogenetic signal [posterior probability
value = 0.6 for this clade in @wahlberg2009], the clade Satyrini is
very robust [posterior probability value = 1.0 for this clade in @wahlberg2009]
and MEDUSA failed to identify any significant accelerated diversification rate
for Satyrini. It appears that the radiation of Satyrini as a whole was not
remarkably fast and therefore not picked up by MEDUSA.

The origin of the tribe Satyrini is not completely clear (originated either in the
Neotropical or Eastern Palaearctic, Oriental and/or Indo-Australian regions
[@pena2011] and their radiation involved colonizing almost all
continents starting from their place of origin. For butterflies, a 
prerequisite for colonizing new areas is that suitable hostplants are 
already present. Therefore, it should be expected that the diversification
of Satyrinae occurred in a stepwise manner, with pulses or bursts of
diversification for certain lineages but unlikely for the tribe Satyrini 
as a whole.

We found that even though MEDUSA estimated several diversification shifts in the 
maximum clade credibility tree of Nymphalidae, only a few of these splits were found in 
more than 95% of the trees from the posterior distribution. In the literature, it
is common practice that conclusions are based on the splits estimated on the maximum
clade credibility tree. However, by using a Multi-MEDUSA approach, we found that some of
this splits might be greatly affected by phylogenetic uncertainty. Moreover, some of
these splits can be recovered either as increases or decreases in diversification
rate depending on the tree from the posterior distribution that was used for analysis.
This means that contradictory conclusions would be made if only the maximum
clade credibility tree was used for analysis. MEDUSA appears to be sensitive to the
number of nodes with high posterior probability and width of age confidence intervals.
For our data, it would be necessary to obtain a posterior distribution of trees
with no conflicting topology, and very similar estimated ages for nodes in order to
consistently recover most of the diversification splits on the posterior
distribution of trees that were inferred by MEDUSA on the MCC tree.

Our Multi-MEDUSA approach to perform analyses on the posterior distribution of trees
found strong support for an increase in diversification rate in the tribe Ithomiini
and the genus *Charaxes*, and for a decrease in diversification rate in the subtribe
Danaina. Due to phylogenetic uncertainty, we did not obtain strong support for other
diversification splits in Nymphalidae. 
Our BiSSE analysis corroborated other studies in that the trait "feeding on Solanaceae",
or a codistributed character, was important in the diversification of Ithomiini 
butterflies. However, by applying MEDUSA we found that a critical character in the 
radiation of the group might have appeared after the shift from Apocynaceae to 
Solanaceae.
We also found that the trait "feeding on Apocynaceae" is not 
responsible for the slowdown of diversification in Danaina. Ithomiini and Solanaceae 
diversified near simultaneously, which is in agreement with the diffuse co-speciation
hypothesis [@janz2011; @nyman2012]. 

## Acknowledgments
We are thankful to Mark Cornwall for help with the script to extend MEDUSA to include
phylogenetic uncertainty, Niklas Wahlberg for commenting on the manuscript and giving
us the posterior distribution of trees, Luke Harmon for commenting on the manuscript
and anonymous reviewers for their comments, which greatly improved the manuscript, 
Jessica Slove Davidson and Niklas Janz for access to their hostplant data. The study
was supported by a Kone Foundation grant (awarded to Niklas Wahlberg), Finland
(C. Peña) and the Research Council of Norway (grant no. 204308 to M. Espeland).
We acknowledge CSC--IT Center for Science Ltd. (Finland) for the allocation of 
computational resources.


## Figure legends

Figure 1. Results of the MEDUSA analysis run on the maximum clade credibility
tree. Rate shifts were estimated for the following nodes (besides the background
rate): 2) Limenitidinae + Heliconiinae, 3) *Ypthima*, 4) *Charaxes*, 5)
Mycalesina + Lethina, 6) Ithomiini in part, 7) Satyrini in part, 8)
Phyciodina in part, 9) Danaini in part, 10) *Caeruleuptychia* +
*Magneuptychia*, 11) Satyrina, 12) *Callicore* + *Diaethria*, 13)
*Pedaliodes*, 14) *Taenaris*.

Figure 2. Results of the MultiMEDUSA analysis on 1000 random trees from the
posterior distribution of the Nymphalidae phylogeny. Bars show the number of trees
where MEDUSA found significant increases or decreases in diversification rates for
tips or clades in Nymphalidae.

Figure 4. Boxplot of the range of diversification values for tips or clades
estimated by MEDUSA on the 1000 random trees from the posterior distribution of
the Nymphalidae phylogeny. The tips or clades shown are those present on the
maximum clade credibility tree.

Figure 5. Correlation between percentage on nodes with posterior probability
``> 0.95`` and number of diversification splits consistently recovered in 
Multi-MEDUSA analyses.

Figure 6. Correlation between width of confidence intervals for nodes and number
of diversification splits consistently recovered in Multi-MEDUSA analyses.

Figure 7. BiSSE analysis of diversification of nymphalids due to feeding on
Solanaceae hostplants. Speciation and diversification rates are significantly
higher in Solanaceae feeders ($lambda$1, r1).

**Table 1.** Significant diversification rate shifts found in the MEDUSA analysis
of the Nymphalid maximum clade credibility tree. Split.Node = node number, r =
net diversification rate, LnLik.part = log likelihood value.

Table 2. Likelihood ratio test between the model of increased diversification of
nymphalids feeding on Solanaceae against a model forcing equal speciation rates
(no effect on diversification).


# Supp. mat.
**``supp_mat_01_run_medusa_on_mct.R``**: Run MEDUSA on MCC tree from
@wahlberg2009.

**``supp_mat_02_genus.nex``**: MCC Nymphalidae tree from @wahlberg2009.

**``supp_mat_03_richness.nex``**: Species richness for lineages in Nymphalidae.

**``supp_mat_04_run_multimedusa.R``**: Run MultiMEDUSA on 1000
random trees from @wahlberg2009.

**``supp_mat_05_1000_random_trees_no_outgroups.nex``**: 1000 random trees from
@wahlberg2009.

**``supp_mat_06_host_plant_data.csv``**: Hostplants of Nymphalidae butterflies
recorded from the literature.

**``supp_mat_07_host_plant_data_references.csv``**: References for hostplants
data.

Figure S2. Boxplot of the 95% confidence intervals for estimated speciation and
extinction rates on an enforced strict higher level phylogeny of our MCC tree by
collapsing all clades younger than the cutoff value at 24 MYA (see figure S1).
Estimated rates using the method in @stadler2013.

Figure S3. Boxplot of speciation and extinction values for the 95% credibility
intervals of values estimated by BiSSE analysis of diversification due to 
feeding on Solanaceae plants.

Figure S4. BiSSE analysis of diversification of nymphalids due to feeding on
Solanaceae hostplants assuming *Vanessa* and *Hypanartia* as non-Solanaceae
feeders. The same pattern is recovered, speciation and diversification rates
are significantly higher for Solanaceae feeders ($lambda$1, r1).

Figure S5. Diversification rates of nymphalids feeding on Solanaceae plants
as estimated by combining post-burnin runs of BiSSE on the 1000 trees from 
the posterior distribution.

Figure S6. Boxplot of speciation and extinction values for the 95% credibility
intervals of values estimated by BiSSE analysis of diversification due to 
feeding on Solanaceae plants on the combined post-burnin runs on 1000 trees
from the posterior distribution.

Figure S7. BiSSE analysis of diversification of nymphalids due to feeding on
Apocynaceae hostplants. Speciation and diversification rates are similar.


## References

