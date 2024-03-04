#import "./lib.typ" : *
= Example 1:

#let df = dataframe(
                    Year:(2021,2022,2023),
                    Fruits:(10,20,30),
                    Vegetables:(11,15,35)
                    )
Stocks:
#tbl(df)
#plot(df, x:"Year", x-tick-step:1, 
                  style:(
                      "Fruits":(color:red,hypograph:true),
                      "Vegetables":(color:green, thickness:2pt)
                      )
        )


#let adf =(
  (Year:2021, Fruits:10, Vegetables: 11),
  (Year:2022, Fruits:20, Vegetables: 15),
  (Year:2023, Fruits:30, Vegetables: 35),
)
#let df = dataframe(adf)
#tbl(df)

= Example 2
#let df = add-cols(df, Milk:(19,5,15))
#tbl(df)

= Example 3

#let df2 = add-rows(df, Year:2024, Fruits:25, Vegetables:20, Milk:10)
#tbl(df2)

#let df3 = add-rows(df, Year:(2024,2025), Fruits:(25,30), Vegetables:(20,10), Milk:(10,5))
#pagebreak()
#columns(2)[
  #tbl(df2)
  #colbreak()
  #tbl(df3)]

= Example 4

#let df2 = add-rows(df, Year:2024, Fruits:25, Vegetables:20)
#let df3 = add-rows(df, Year:2024, Fruits:25, Vegetables:20, missing:"/")
#columns(2)[
  #tbl(df2)
  #colbreak()
  #tbl(df3)]

= Example 5

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
#tbl(concat(df,df2))
#colbreak()
#tbl(concat(df,df3))
]

= Example 6
#tbl(slice(df, row-start:1, col-start:1))


#df

#tbl(select(df, rows:r=>r.Year > 2022))
#tbl(select(df, cols:r=>r!="Fruits"))
#tbl(select(df, cols:("Fruits","Vegetables"), rows:r=>r.Year > 2021))


= Example 7


#let df = dataframe(
                    Fruits:(10,20,30),
                    Vegetables:(11,15,35)
                    )
#columns(2)[
  `df = dataframe(
        Fruits:(10,20,30),
        Vegetables:(11,15,35)
        )`
#tbl(df)
`add(df,dataframe(x:(1,2,3)))`
#tbl(add(df,dataframe(x:(1,2,3))))
#colbreak()
#v(3.5em)
`add(df,1)`
#tbl(add(df,1))
`add(df, dataframe(x:(1,2,3),y:(4,5,6)))`
#tbl(add(df, dataframe(x:(1,2,3),y:(4,5,6))))
]

= Example 8
#table(columns:(8cm,auto),
    align: bottom,stroke: none,
[#let df = dataframe(
                    Fruits:(10,20,30),
                    Vegetables:(11,15,35)
                    )
`
df = dataframe(
          Fruits:(10,20,30),
          Vegetables:(11,15,35)
          )`

],[`cumsum(df)`],
[

#tbl(df)
],[
#tbl(cumsum(df))
])

#let df = dataframe(
                    Year:(2021,2022,2023),
                    Fruits:(10,20,30),
                    Vegetables:(11,15,35)
                    )
#pagebreak()
= Example 9
#table(columns:(7cm,auto),
    align: bottom,stroke: none,
[
`
df = dataframe(
          Year:(2021,2022,2023),
          Fruits:(10,20,30),
          Vegetables:(11,15,35)
          )`

],[`sum(df)`\ #sum(df)],
[

#tbl(df)
],[
`add-rows(df, 
    mean(select(df,cols:r=>r!="Year")))`

#tbl(add-rows(df,mean(select(df,cols:r=>r!="Year"))))
])

= Example 10

#let df = slice(dataframe-from-csv(csv("data/AAPL.csv")),row-end:5)
#tbl(df)

= Example 11

#tbl(df, transpose:true)

= Example 12


#let df = dataframe(
                    Year:(2021,2022,2023),
                    Fruits:(10,20,30),
                    Vegetables:(11,15,35)
                    )
#to-array(df)
#import "@preview/tablex:0.0.8":*
#tablex(
  ..tabut-cells(df,
  (
    (header: "Year", func:r=>r.Year),
    (header:"Fruits", func:r=>r.Fruits)
  ),
  headers:true
))

= Example 13

#let df = dataframe-from-csv(csv("data/AAPL.csv"))

#plot(df, x:"Date",
          y:("High","Low","Close"),
          x-tick-step:duration(days:5),
          x-tick-rotate:-45deg, x-tick-anchor:"west",
          style:(
            "Close": (color:red, thickness:1pt, mark:"o", line:"spline"),
            "Low":(color:red.lighten(45%),
            hypograph:true, thickness:2pt),
            "High":(color:green.lighten(45%),epigraph:true, thickness:2pt)

          ))
#let df = dataframe(x:("A","B","C"), y:(1,2,5))
#plot(df, x:"x")