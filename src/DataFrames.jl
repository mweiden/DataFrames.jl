# Note that the two calls to using Stats in this file are
# strictly required: one pulls the names into DataFrames
# for easy access within the module, whereas the other call
# pushes those names into Main.
using Stats

module DataFrames

##############################################################################
##
## Dependencies
##
##############################################################################

using Base.Intrinsics
using GZip
using Stats

##############################################################################
##
## Global constants
##
##############################################################################

const DEFAULT_COLUMN_TYPE = Float64
const DEFAULT_POOLED_REF_TYPE = Uint32

##############################################################################
##
## Extend methods in Base by default
##
##############################################################################

importall Base
importall Stats
import Base.Sort.Algorithm, Base.Sort.By, Base.Sort.Forward
import Base.Sort.Ordering, Base.Sort.Perm, Base.Sort.lt
import Base.Sort.sort, Base.Sort.sort!, Base.Sort.sortby, Base.Sort.sortby!

##############################################################################
##
## Exported methods and types
##
##############################################################################

export # reconcile_groups,
       @DataFrame,
       @transform,
       AbstractDataArray,
       AbstractDataFrame,
       AbstractDataVector,
       AbstractIndex,
       anyna,
       allna,
       array,
       based_on,
       by,
       cbind,
       clean_colnames!,
       colffts,
       colmaxs,
       colmeans,
       colmedians,
       colmins,
       colnames!,
       colnames,
       colnorms,
       colprods,
       colranges,
       colstds,
       colsums,
       coltypes,
       colvars,
       colwise,
       combine,
       compact,
       complete_cases,
       complete_cases!,
       cut,
       DataArray,
       databool,
       datadiagm,
       dataeye,
       datafalses,
       datafloat,
       DataFrame,
       dataint,
       DataMatrix,
       dataones,
       DataStream,
       datatrues,
       DataVector,
       datazeros,
       describe,
       dict,
       drop_duplicates!,
       duplicated,
       each_failNA,
       each_removeNA,
       each_replaceNA,
       EachCol,
       EachRow,
       failNA,
       findat,
       flipud!,
       flipud,
       Formula,
       get_groups,
       get_indices,
       gl,
       GroupApplied,
       groupby,
       GroupedDataFrame,
       head,
       Index,
       index,
       index_to_level,
       IndexedVector,
       Indexer,
       interaction_design_matrix,
       is_group,
       isna,
       letters,
       LETTERS,
       level_to_index,
       levels,
       load_df,
       matrix,
       merge,
       model_frame,
       model_matrix,
       model_response,
       ModelFrame,
       ModelMatrix,
       NA,
       NAException,
       nafilter,
       naFilter,
       NamedArray,
       names!,
       nareplace,
       naReplace,
       nas,
       NAtype,
       ncol,
       nrow,
       padNA,
       paste,
       pdatafalses,
       pdataones,
       pdatatrues,
       pdatazeros,
       percent_change,
       PooledDataVecs, # The capitalization and/or name for this is a bit inconsistent (merge_pools, maybe?). Do we want to export?
       PooledDataArray,
       PooledDataMatrix,
       PooledDataVector,
       printtable,
       range,
       rbind,
       read_minibatch,
       readtable,
       reldiff,
       removeNA,
       rename_group!,
       reorder,
       rep,
       replace!,
       rename!,
       rename,
       replaceNA,
       rowffts,
       rowmaxs,
       rowmeans,
       rowmedians,
       rowmins,
       rownorms,
       rowprods,
       rowranges,
       rowstds,
       rowsums,
       rowvars,
       save,
       set_group,
       set_groups,
       set_levels,
       set_levels!,
       SimpleIndex,
       stack,
       SubDataFrame,
       subset,
       table,
       tail,
       unique,
       unstack,
       vector,
       with,
       within!,
       within,
       without,
       writetable,
       xtab,
       xtabs,
       stack_df,
       StackedVector,
       RepeatedVector,
       EachRepeatedVector,
       melt,
       melt_df,
       pivot_table,
       RComplex,     # Vector{Complex128}
       RInteger,     # Vector{Int32} plus BitVector of NA indicators
       RLogical,     # BitVector of values and BitVector of NA indicators
       RNumeric,     # Vector{Float64}
       RList,        # Vector{Any}
       RString,      # Vector{ASCIIString}
       RSymbol,      # Symbol stored as an String b/c of embedded '.'

       class,                              # in the S3 sense of "class"
       inherits,
       read_rda,
       vecbind

##############################################################################
##
## Deprecations
##
##############################################################################

Base.@deprecate read_table readtable
Base.@deprecate print_table printtable
Base.@deprecate write_table writetable

##############################################################################
##
## Load files
##
##############################################################################

include("utils.jl")
include("natype.jl")
include("dataarray.jl")
include("pooleddataarray.jl")
include("datavector.jl")
include("datamatrix.jl")
include("index.jl")
include("namedarray.jl")
include("dataframe.jl")
include("merge.jl")
include("grouping.jl")
include("reshape.jl")
include("formula.jl")
include("io.jl")
include("datastream.jl")
include("linalg.jl")
include("operators.jl")
include("statistics.jl")
include("predicates.jl")
include("indexing.jl")
include("extras.jl")
include("RDA.jl")

# TODO: Remove these definitions
nafilter(x...) = error("Function removed. Please use removeNA")
nareplace(x...) = error("Function removed. Please use replaceNA")
naFilter(x...) = error("Function removed. Please use each_removeNA")
naReplace(x...) = error("Function removed. Please use each_replaceNA")

end # module DataFrames
