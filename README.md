# All-relevant feature selection with Boruta and R

More info about Boruta: [https://www.mimuw.edu.pl/~ajank/papers/Kursa2010.pdf](https://www.mimuw.edu.pl/~ajank/papers/Kursa2010.pdf)

### Open on shinyapps
[https://statsim.shinyapps.io/select/](https://statsim.shinyapps.io/select/)
We are currently on a free tier. The app can be offline if there's no hours left.


### Run select with R from remote repository
`R -e "shiny::runGitHub('select', 'statsim')"` (needs R and shiny installed)

If everything is ok, you'll see something like this:

```
Downloading https://github.com/statsim/select/archive/master.tar.gz
...
Listening on http://127.0.0.1:5352
```

Then just open the link in the browser

### Run locally
Clone the repository with `git clone` then `R -e "shiny::runApp('select')"`
