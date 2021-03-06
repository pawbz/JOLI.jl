############################################################
# joLinearFunctionInplace ##################################
############################################################

export joLinearFunctionInplace, joLinearFunctionInplaceException

# type definition
"""
joLinearFunctionInplace type

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
- iop::Nullable{Function} : inverse for fop
- iop_T::Nullable{Function} : inverse for fop_T
- iop_CT::Nullable{Function} : inverse for fop_CT

"""
struct joLinearFunctionInplace{DDT<:Number,RDT<:Number} <: joAbstractLinearOperatorInplace{DDT,RDT}
    name::String
    m::Integer
    n::Integer
    fop::Function              # forward
    fop_T::Nullable{Function}  # transpose
    fop_CT::Nullable{Function} # conj transpose
    iop::Nullable{Function}
    iop_T::Nullable{Function}
    iop_CT::Nullable{Function}
end

# type exceptions
type joLinearFunctionInplaceException <: Exception
    msg :: String
end

