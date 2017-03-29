############################################################
# joLinearFunction #########################################
############################################################

export joLinearFunction, joLinearFunctionAll, joLinearFunctionT, joLinearFunctionCT,
       joLinearFunctionFwdT, joLinearFunctionFwdCT, joLinearFunctionException

############################################################
## type definition

"""
joLinearFunction type

# TYPE PARAMETERS
- DDT::DataType : domain DataType
- RDT::DataType : range DataType

# FIELDS
- name::String : given name
- m::Integer : # of rows
- n::Integer : # of columns
- fop::Function : forward function
- fop_T::Nullable{Function} : transpose function
- fop_CT::Nullable{Function} : conj transpose function
- fop_C::Nullable{Function} : conj function
- iop::Nullable{Function} : inverse for fop
- iop_T::Nullable{Function} : inverse for fop_T
- iop_CT::Nullable{Function} : inverse for fop_CT
- iop_C::Nullable{Function} : inverse for fop_C

"""
immutable joLinearFunction{DDT<:Number,RDT<:Number} <: joAbstractLinearOperator{DDT,RDT}
    name::String
    m::Integer
    n::Integer
    fop::Function              # forward
    fop_T::Nullable{Function}  # transpose
    fop_CT::Nullable{Function} # conj transpose
    fop_C::Nullable{Function}  # conj
    iop::Nullable{Function}
    iop_T::Nullable{Function}
    iop_CT::Nullable{Function}
    iop_C::Nullable{Function}
end

############################################################
## type exceptions

type joLinearFunctionException <: Exception
    msg :: String
end

############################################################
# includes

include("joLinearFunction/constructors.jl")
include("joLinearFunction/base_functions.jl")
include("joLinearFunction/extra_functions.jl")
