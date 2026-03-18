%* Set up some macro parameters ;

%let inputTable = SASHELP.HEART;
%let histX = AgeAtStart;
%let histGroup = Sex;

%* First, a simple graphic ;

PROC R;
submit;

# Set things up and move values from SAS into R
library(ggplot2)
df= sd2df(symget("inputTable"))  # Move dataset to R dataframe
histV =  sym(symget("histX"))    # Apply macro variable to R var, stripping off quotes
histG =  symget("histGroup")     # This will leave a quote envelope

# Make a Plot Object 
# Note that if you did not remove quote envelope, you will have to here
# Also note on the fill, we are doing it all in one step

plt = ggplot(df, aes(x=!!histV, color=!!sym(histG), fill=!!sym(symget("histGroup")))) +
  geom_histogram(position="identity", alpha=0.5, bins = 20) + 
  labs (title = paste("Histogram of",histV,"by",histG))


rplot(plt)  # send the plot to the results pane

endsubmit;
RUN;


%* Now Some data manipulations;

proc R;
submit;

# Set up libraries and read in data
library(dplyr)  
library(ggplot2)

df= sd2df(symget("inputTable"))         # Move data to dataframe
print(head(df))                         # Print will output to log
show(df,paste("Dataset",symget("inputTable")),count=11)  # Show will output to Results window

dead <- df %>% filter(Status == "Dead")  # Make a new dataframe with a filter
df2sd(dead,"Dead")                       # Move dataframe to SAS dataset
symput("numDead",nrow(dead) )            # Put the number of rows into a SAS macro variable

submit("%put &=numDead;")                # Execute SAS Code on exit
hello = sasfnc("propcase","HELLo WORld") # Execute a SAS function
print(hello)


endsubmit;
RUN;
