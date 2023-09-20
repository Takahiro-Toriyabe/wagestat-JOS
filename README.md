# wagestat-JOS

This repository provides the codes to replicate Daiji Kawaguchi and Takahiro Toriyabe (2024) "Non-response Bias of Japanese Wage Statistics", Journal of Official Statistics.

## Before running the code...

### Dataset

We are not allowed to share the microdata used in the paper. The application procedure for the usage of the microdata is explained [here](https://www.e-stat.go.jp/microdata/). Access to the administrative tax data of a local government was given through the project "Academic infrastructure development of administrative data from local governments and application for economic analysis" (PI: Ayako Kondo). To see the directory settings for those microdata, please check do-files in `wagestat-JOS/src/do/import/`.

### Program depenency

Our graph scheme is partly based on Daniel Bischof, 2016. "BLINDSCHEMES: Stata module to provide graph schemes sensitive to color vision deficiency," Statistical Software Components S458251, Boston College Department of Economics, revised 07 Aug 2020. You can install this package by `ssc install blindschemes`. After installing it, please copy and paste `wagestat-JOS/src/scheme/scheme-tt_color.scheme` and `wagestat-JOS/src/scheme/scheme-tt_mono.scheme` under your ado-file folder. (You can find your ado-file folder by typing `adopath` on the Stata interactive window.)

## How to run the code

After preparing data and installing the program described above, you can run `wagestat-JOS/src/do/main.do` by specifying `path_root` as the path to `wagestat-JOS`. Then, `wagestat-JOS/src/do/main.do` automatically runs all subsequent codes to clean data and generate figures and tables shown in the paper.

## Contact

If you have any problems in running the code, please create a new issue from [this page](https://github.com/Takahiro-Toriyabe/wagestat-JOS/issues).
