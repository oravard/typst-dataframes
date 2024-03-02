 # DataFrames

 This packages deals with data frames which are objects that are similar to pandas dataframes in python or DataFrames in Julia.
 
 A dataframe is a two dimentionnal array. Many operations can be done between columns, rows and it can be displayed as a table or as a graphic plot.

 ## Simple use case

 A dataframe is created given its array for each column. Displaying the dataframe can be done using `plot` or `table` functions:
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
![Example 1](https://raw.githubusercontent.com/oravard/typst-dataframes/main/img/example-01.png)

## Dataframe creation

The simple way to create a dataframe is to provide arrays with their corresponding column names to the constructor like in the preceding paragraph. 

But, you can provide each lines of your dataframe as an array. This means that you have to specify the column names for each line. The following example is equivalent to the preceding one.
```typst
#let adf =(
  (Year:2021, Fruits:10, Vegetables: 11),
  (Year:2022, Fruits:20, Vegetables: 15),
  (Year:2023, Fruits:30, Vegetables: 35),
)
#let df = dataframe(adf)

//is equivalent to

#let df =  = dataframe(
                    Year:(2021,2022,2023),
                    Fruits:(10,20,30),
                    Vegetables:(11,15,35)
                    )
```
The specification of a dataframe is that the number of elements for each column must be the same. If this is not the case, an error is raised.
For the following explainations, we will use `df` as the dataframe which is defined in this paragraph.

## Rows and columns
Columns are accessed using dot following by the column name (ex: `df.Year` returns the column "Year" of the dataframe). Rows can be selected using the `row` function (ex: `row(df,i)` returns the ith row of df). Selecting a set of rows and columns can be done using `slice` or `select` functions.

Rows and columns can be added with `add-cols` and `add-rows` functions or by concatenation of two dataframes using `concat`.

### nb-rows
The function `nb-rows` returns the number of rows of a dataframe:
```typst
#let nb = nb-rows(df)
#nb
```
displays:

```
3
```

### nb-cols
The function `nb-cols` returns the number of columns of a dataframe.
```typst
#let nb = nb-rows(df)
#nb
```
displays:

```
3
```

### size

The function `size` returns an array of (nb-rows,nb-cols).

```typst
#let nb = size(df)
#nb
```
displays:

```
(3,3)
```

### add-cols

The function `add-colls` add columns to the dataframe. Columns are provided with their column name as named arguments.

```typst
#let df = add-cols(df, Milk:(19,5,15))
#table(df)
```
displays:

![Example 2](https://raw.githubusercontent.com/oravard/typst-dataframes/main/img/example-02.png)

a shortcut `hcat` to `add-cols` is provided for people who are more confortable with Python or Julia terminology.

### add-rows

The function `add-rows` add rows to the dataframe. Rows are provided as named arguments. Each argument could be a scalar or an array. The only rule is that the final number of elements for each columns is the same.

```typst
#let df2 = add-rows(df, 
                    Year:2024, 
                    Fruits:25, 
                    Vegetables:20, 
                    Milk:10)
#table(df2)

#let df3 = add-rows(df, 
                    Year:(2024,2025), 
                    Fruits:(25,30), 
                    Vegetables:(20,10), 
                    Milk:(10,5))

#columns(2)[
  #table(df2)
  #colbreak()
  #table(df3)]
```
displays:

![Example 3](https://raw.githubusercontent.com/oravard/typst-dataframes/main/img/example-03.png)

If the arguments of function `add-rows` do not provides each columns, the missing elements are replaced with the `missing` value:
```typst

#let df2 = add-rows(df, Year:2024, Fruits:25, Vegetables:20)
#let df3 = add-rows(df, Year:2024, Fruits:25, Vegetables:20, missing:"/")
#columns(2)[
  #table(df2)
  #colbreak()
  #table(df3)]
```
displays:

![Example 4](https://raw.githubusercontent.com/oravard/typst-dataframes/main/img/example-04.png)

Be carreful using the `missing` argument which default is `none`. Future numerical operations using rows / cols will raise an error. Provide a numerical value for the `missing` argument if you want to do future numerical operations between rows / cols.


a shortcut `vcat` to `add-rows` is provided for people who are more confortable with Python or Julia terminology.

### concatenation

The concatenation of two dataframes can be done using the `concat` function. The `concat` function takes two dataframes as arguments. The result is a dataframe using the following rules:

- if the column names of the two dataframes are the same, the second dataframe is added to the first as new rows.
- if all column names of the second dataframe are different of the first dataframe column names, the second dataframe is added to the first as new columns. It implies that the number of rows of the two dataframes are the same.

```typst
#let df = dataframe(
                    Year:(2021,2022,2023),
                    Fruits:(10,20,30),
                    Vegetables:(11,15,35)
                    )
#let df2 = dataframe(
                    Year:2024,
                    Fruits:25,
                    Vegetables:20
          )
#let df3 = dataframe(Milk:(19,5,15))
#columns(2)[
#table(concat(df,df2))
#colbreak()
#table(concat(df,df3))
```
displays:

![Example 5](https://raw.githubusercontent.com/oravard/typst-dataframes/main/img/example-05.png)

The dataframe `df2` is equivalent to adding row to `df` while `df3` is equivalent to adding column to `df`.

### slice

The `slice` function allows to select rows and cols of a dataframe returning a new dataframe. The arguments of the `slice` function are:

- `row-start`: the first row to return (default:0)
- `row-end`: the last row to return (default: none -> the last)
- `row-count`: the number of rows to return (default: -1 -> row-end - row-start)
- `col-start`: the first col to return (default:0)
- `row-end`: the last col to return (default: none -> the last)
- `row-count`: the number of cols to return (default: -1 -> col-end - col-start)
Example :

```typst
#table(slice(df, row-start:1, col-start:1))
```
displays:


![Example 6](https://raw.githubusercontent.com/oravard/typst-dataframes/main/img/example-06.png)

### select 

The select function allows to select rows or columns.
- rows are selected given their name or a filter function 
- cols are selected given a filter function

The arguments of the `select` function are:
- `rows` : (default:`auto`) a filter function which return `true` for all desired rows. 
- `cols`: (default:`auto`) an array of col names or a function which returns `true` for the desired cols.

Example:

```typst
#let df2 = select(df, rows:r=>r.Year > 2022)
#let df3 = select(df, cols:r=>r!="Fruits")
#table(select(df, cols:("Fruits","Vegetables"),
                  rows:r=>r.Year > 2022))
```

### sorted

The `sorted` function allows to sort a dataframe. The arguments are:
- `col`: the column name for sorting (ascending)
- `rev`: (default:`false`) `true` for reverse mode (descending)
Example:
```typst
sorted(df,"Year",rev:true)
```
## Numerical operations
Many operations can be done on dataframes. We have four kind of operations: unary, two elements, cumulative and folding.

### Unary operations

An unary operation make the same operation on all elements of a dataframe. Here is the list of available unary operations:

| Function name | Description |
|---------------|-------------|
| `abs`   | returns the absolute value (ex: `abs(df)`)|
| `ceil`  | returns the nearest greter integer|
| `floor` | returns the nearest smaller integer|
| `round` | returns the rounding value. You can use the named argument `digits` (ex: `round(df,digits:2)`) |
| `exp`   | returns exponential value |
| `log`   | returns the logarithmic value |
| `sin`   | returns sinus |
| `cos`   | returns cosinus |

### Two elements operations

For example, some elements can be added to a dataframe using the `add(df,other)` function. We consider four cases for this kind of operation :

- if `other` is a scalar: `other` is added to all efements of `df`
- if `other` is a dataframe: 
    - if `other` number cols is 1, then each col of `df` is added term by term with `other`
    - if `other` number cols is equal to `df` number cols, each col of `df` is added term by term to the col of `other` with the same index
    - if `other` column names are equal to `df` column names, each col of `df` is added term by term to the col of `other` which have the same name.

Example:

![Example 7](https://raw.githubusercontent.com/oravard/typst-dataframes/main/img/example-07.png)

These rules applies to all the following two elements functions:

| Function  | Description  |
|-----------|--------------|
|`add`      | Addition `add(df,other)`    |
|`substract`| Substraction `substract(df,other)`|
|`mult`     | Multiplication `mult(df,other)` |
|`div`      | Division `div(df,other)` |

### Cumulative operations
