# PROC R Examples in SAS
## Overview

A practical starter repository that contains examples utilizing PROC R

| Name | Description | link |
| :--- | :--- | :-: |
| R_Info.sas | Runs code to capture the version, location, and package listing for the R environment (requires gt package; you may need to delete that section). | [link](https://github.com/jwbox/PROC-R/blob/main/R_Info.sas) |
| ProcR_Overview.sas | Demonstrates all of the PROC R-specific stuff, from moving datasets to macro variables, SAS functions, and code execution. | [link](https://github.com/jwbox/PROC-R/blob/main/ProcR_Overview.sas) |
| Scatter.step | Is a custom step that makes a ggplot scatterplot from a SAS dataset. | [link](https://github.com/jwbox/PROC-R/blob/main/Scatter.step) |

### Prerequisites

An active SAS Viya license and environment

### Installation

Clone the repository into the root of your workspace:

`git clone https://github.com/jwbox/PROC-R.git`

## License & Data

SAS provides more than 200 data sets in the Sashelp library. These data sets are available for you to use for examples and for testing code. For example, the following step uses the Sashelp.LeuTrain data set:

```sas
title 'Leukemia Training Data';
proc contents data=sashelp.LeuTrain varnum;
   ods select position;
run;
```

You do not need to provide a DATA step to use Sashelp data sets.

The following steps list all the data sets that are available in Sashelp:

```sas
ods select none;
proc contents data=sashelp._all_;
   ods output members=m;
run;
ods select all;

proc print;
   where memtype = 'DATA';
run;
```

## Contact

- Jim Box (jim.box@sas.com)
- Lleyton Seymour (lleyton.seymour@sas.com)


## Change Log

- Version 1.0.0 (27MAR2026)
  - Initial release on GitHub
