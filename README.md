# All-relevant feature selection with Boruta, Shiny and R
Boruta is one of the most popular methods for all-relevant feature selection. It's great for data exploration because it tries to find all variables that could have some relationship with target. Another popular approach, minimum optimal feature selection, selects only the minimal subset of features. 
* More info about Boruta: [https://www.mimuw.edu.pl/~ajank/papers/Kursa2010.pdf](https://www.mimuw.edu.pl/~ajank/papers/Kursa2010.pdf)
* Boruta on CRAN: [https://cran.r-project.org/web/packages/Boruta/](https://cran.r-project.org/web/packages/Boruta/)
* Boruta.py: [https://github.com/scikit-learn-contrib/boruta_py](https://github.com/scikit-learn-contrib/boruta_py)
* See also MUVR: [https://gitlab.com/CarlBrunius/MUVR](https://gitlab.com/CarlBrunius/MUVR)

![Boruta results](https://raw.githubusercontent.com/statsim/select-shiny/master/images/boruta.png "Boruta all-relevant feature selection results")

### Open on shinyapps
[https://statsim.shinyapps.io/select/](https://statsim.shinyapps.io/select/)
We are currently on a free tier. The app can be offline if there's no hours left

### Run select with R from remote repository
`R -e "shiny::runGitHub('select-shiny', 'statsim')"` (needs R and shiny installed)

If everything is ok, you'll see something like this:

```
Downloading https://github.com/statsim/select-shiny/archive/master.tar.gz
...
Listening on http://127.0.0.1:5352
```

Then just open the link in the browser

### Run locally
Clone the repository with `git clone` then `R -e "shiny::runApp('select-shiny')"`

### Alternatives
Web version based on JavaScript port of Boruta:
* [https://statsim.com/select](https://statsim.com/select)
There's another shiny app that also uses Boruta under the hood and supports bigger files:
* [https://shiny.gramener.com/varselect/](https://shiny.gramener.com/varselect/)
