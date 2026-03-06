
%* Specify the location you want the ouptut HTML File with name;
%let HTML_OUT = /bigdisk/lax/computeece/warehouse/jimbox/Packages.html;

PROC R;
SUBMIT;


library(gt)

ver = R.version.string
location = R.home()
pkg = as.data.frame(installed.packages()[,c(1,3)])
html = symget("HTML_OUT")


# Make an HTML File with the report

pkg_list = pkg %>%
  gt() %>%
  tab_header(
    title = paste("R Version: ",ver),
    subtitle = paste("R Location: ",location)
  ) %>%
  fmt_number(
    columns = where(is.numeric),
    decimals = 2
  ) %>%
  tab_options(
    table.font.size = px(14),
    row.striping.background_color = "rgba(0,0,0,0.03)"
  )


  gtsave(pkg_list,html)

### Move details to SAS to make a different report

df2sd(pkg, "Packages", "work")
symput("version",ver ) 
symput("location",location ) 

ENDSUBMIT;
RUN;

/* Make a quick report in results tab */

TITLE "Package Listing from &version";
TITLE2 "R Location: &location";
PROC SQL;
  Select Package, version
  from packages
  order by upcase(Package);
quit;
TITLE;
TITLE2;
