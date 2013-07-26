# Nymphalidae diversification paper

Software in ``code`` folder taken from:

* [turboMEDUSA](https://github.com/josephwb/turboMEDUSA)
* [phyloch](http://www.christophheibl.de/Rpackages.html)
* [auteur v0.12.1010](http://cran.r-project.org/src/contrib/Archive/auteur/)

## Reproducing the analyses
You can easily reproduce the analyses by using [GNU make](http://www.gnu.org/software/make/).
Install ``make`` in your computer and run the analysis with ``make command``. For example:

```bash
# Run MEDUSA analysis on our MCT
make medusa_run
```

The code and data will be read from their respective folders.
The output data and plots will be saved into the folder ``output``.
