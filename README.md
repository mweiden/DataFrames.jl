DataFrames.jl
=========

Package for working with tabular data in Julia using `DataFrame`'s.

# Installation

DataFrames.jl is now an installable package. 

To install DataFrames.jl, use the following:

```julia
Pkg.add("DataFrames")
```

DataFrames.jl has one main module named `DataFrames`. You can load it as:

```julia
using DataFrames
```

# Features

* `DataFrame` for efficient tabular storage of two-dimensional data
* Minimized data copying
* Default columns can handle missing values (NA's) of any type
* `PooledDataFrame` for efficient storage of factor-like arrays for
  characters, integers, and other types
* Flexible indexing
* `SubDataFrame` for efficient subset referencing without copies
* Grouping operations inspired by [plyr](http://plyr.had.co.nz/),
  [pandas](http://pandas.pydata.org/), and
  [data.table](http://cran.r-project.org/web/packages/data.table/index.html)
* Basic `merge` functionality
* `stack` and `unstack` for long/wide conversions
* Pipelining support (`|>`) for many operations
* Several typical R-style functions, including `head`, `tail`, `describe`,
  `unique`, `duplicated`, `with`, `within`, and more
* Formula and design matrix implementation

# Demos

Here's a minimal demo showing some grouping operations:

```julia

julia> using DataFrames

julia> d = DataFrame(quote     # expressions are one way to create a DataFrame
           x = randn(10)
           y = randn(10)
           i = rand(1:3,10)
           j = rand(1:3,10)
       end);

julia> dump(d)    # dump() is like R's str()
DataFrame  10 observations of 4 variables
  x: DataArray{Float64,1}(10) [-0.22496343871037897,-0.4033933555989207,0.6027847717547058,0.06671669747901597]
  y: DataArray{Float64,1}(10) [0.21904975091285417,-1.3275512477731726,2.266353546459277,-0.19840910239041679]
  i: DataArray{Int64,1}(10) [2,1,3,1]
  j: DataArray{Int64,1}(10) [3,2,1,2]

julia> head(d)
6x4 DataFrame:
                x         y i j
[1,]    -0.224963   0.21905 2 3
[2,]    -0.403393  -1.32755 1 2
[3,]     0.602785   2.26635 3 1
[4,]    0.0667167 -0.198409 1 2
[5,]      1.68303  -1.11183 1 3
[6,]     0.346034   1.68227 2 1

julia> d[1:3, ["x","y"]]     # indexing is similar to R's
3x2 DataFrame
                x        y
[1,]    -0.224963  0.21905
[2,]    -0.403393 -1.32755
[3,]     0.602785  2.26635

julia> # Group on column i, and pipe (|>) that result to an expression
julia> # that creates the column x_sum.
julia> groupby(d, "i") |> :(x_sum = sum(x))
3x2 DataFrame
        i    x_sum
[1,]    1  2.06822
[2,]    2 -1.80867
[3,]    3 0.319517

julia> groupby(d, "i") |> :sum   # Another way to operate on a grouping
3x4 DataFrame
        i    x_sum    y_sum j_sum
[1,]    1  2.06822 -2.73985     8
[2,]    2 -1.80867  1.83489     7
[3,]    3 0.319517  1.03072     2
```

See [demo/workflow_demo.jl](https://github.com/HarlanH/DataFrames.jl/blob/master/demo/workflow_demo.jl) for a basic demo of the parts of a Julian data workflow.

See [demo/design_demo.jl](https://github.com/HarlanH/DataFrames.jl/blob/master/demo/design_demo.jl) for a more in-depth demo of DataFrame and related types and
library.

# Reading data from CSV files

We have a `readtable` function for this, which takes in a filename as a string and allows the following options to be set as keyword arguments:

* `header::Bool` -- Use the information from the file's header line to determine column names. Defaults to `true`.
* `separator::Char` -- Assume that fields are split by the `separator` character. If not specified, it will be guessed from the filename: `.csv` defaults to `','`, `.tsv` defaults to `'\t'`, `.wsv` defaults to `' '`.
* `quotemark::Char` -- Assume that fields contained inside of two `quotemark` characters are quoted, which disables processing of separators and linebreaks. Defaults to `'"'`.
* `decimal::Char` -- Assume that the decimal place in numbers is written using the `decimal` character. Defaults to `','`.
* `nastrings::Vector{ASCIIString}` -- Translate any of the strings into this vector into an `NA`. Defaults to `["", "NA"]`.
* `truestrings::Vector{ASCIIString}` -- Translate any of the strings into this vector into a Boolean `true`. Defaults to `["T", "t", "TRUE", "true"]`.
* `falsestrings::Vector{ASCIIString}` -- Translate any of the strings into this vector into a Boolean `true`. Defaults to `["F", "f", "FALSE", "false"]`.
* `makefactors::Bool` -- Convert string columns into `PooledDataVector`'s for use as factors. Defaults to `false`.
* `nrows::Int` -- Read only `nrows` from the file. Defaults to `-1`, which indicates that the entire file should be read.
* `colnames::Vector{UTF8String}` -- Use the values in this array as the names for all columns instead of or in lieu of the names in the file's header. Defaults to `[]`, which indicates that the header should be used if present or that numeric names should be invented if there is no header.
* `cleannames::Bool` -- Call `cleancolnames!` on the resulting DataFrame to ensure that all column names are valid identifers in Julia.
* `coltypes::Vector{Any}` -- Specify the types of all columns. Defaults to `{}`.
* `allowcomments::Bool` -- Ignore all text inside comments. Defaults to `false`.
* `commentmark::Char` -- Specify the character that starts comments. Defaults to `'#'`.
* `ignorepadding::Bool` -- Ignore all whitespace on left and right sides of a field. Defaults to `true`.
* `skipstart::Int` -- Specify the number of initial rows to skip. Defaults to `0`.
* `skiprows::Vector{Int}` -- Specify the indices of lines in the input to ignore. Defaults to `[]`.
* `skipblanks::Bool` -- Skip any blank lines in input. Defaults to `true`.
* `encoding::Symbol` -- Specify the file's encoding as either `:utf8` or `:latin1`. Defaults to `:utf8`.

# Documentation

* [Library-style function reference](https://github.com/HarlanH/DataFrames.jl/blob/master/spec/FunctionReference.md)
* [Background and motivation](https://github.com/HarlanH/DataFrames.jl/blob/master/spec/Motivation.md)


# Development work

The [Issues](https://github.com/HarlanH/DataFrames.jl/issues) highlight a
number of issues and ideas for enhancements. Here are some particular
enhancements under way or under discussion:

* _Data Streams:_
[issue 34](https://github.com/HarlanH/DataFrames.jl/issues/34), [doc](https://github.com/HarlanH/DataFrames.jl/blob/master/doc/sections/09_datastreams.md)

* _Distributed DataFrames:_ [issue 26](https://github.com/HarlanH/DataFrames.jl/issues/26)

* _Fast vector indexing:_
  [issue 24](https://github.com/HarlanH/DataFrames.jl/issues/24), [commit](https://github.com/HarlanH/DataFrames.jl/commit/268faa1c3b9fa2aa3e0c1199d626fe5a83ad1604)

* _Bitstypes with NA support:_ [issue 45](https://github.com/HarlanH/DataFrames.jl/issues/45), [doc](https://github.com/tshort/DataFrames.jl/blob/bitstypeNA/spec/MissingValues.md)

# Possible changes to Julia

DataFrames fit well with Julia's syntax, but some features would
improve the user experience, including keyword function arguments
[(Julia issue 485)](https://github.com/JuliaLang/julia/issues/485),
`"~"` for easier expression syntax, and overloading `"."` for easier
column access (df.colA). See
[here](https://github.com/HarlanH/DataFrames.jl/blob/master/spec/JuliaChanges.md)
for a bit more information.

# Current status

Please consider this a development preview. Many things work, but
expect some rough edges. We hope that this can become a standard Julia
package.
