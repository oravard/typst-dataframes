 # DataFrames

 This packages deals with data frames which are objects that are similar to pandas dataframes in python or DataFrames in Julia.
 
 A dataframe is a two dimentionnal array. Many operations can be done between columns, rows and it can be displayed as a table or as a graphic plot.

 ## Simple use case

 A dataframe is created given his array for each column. Displing the dataframe can be done using `plot` or `table` function:
 ```typst
 #import "@preview/dataframes:0.1.0": *
 
#let df = dataframe(
                    Year:(2021,2022,2023),
                    Fruits:(10,20,30),
                    Vegetables:(11,15,35)
                    )
Stocks:
#table(df)
#plot(df, x:"Year", x-tick-step:1)
 ```
