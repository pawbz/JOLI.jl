############################################################
# joLooseLinearFunction ####################################
############################################################

export joLooseLinearFunction, joLooseLinearFunctionException

# type definition
"""
joLooseLinearFunction type

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
- fMVok : whether fops are rady to handle mvec
- iop::Nullable{Function} : inverse for fop
- iop_T::Nullable{Function} : inverse for fop_T
- iop_CT::Nullable{Function} : inverse for fop_CT
- iop_C::Nullable{Function} : inverse for fop_C
- iMVok::Bool : whether iops are rady to handle mvec

"""
struct joLooseLinearFunction{DDT<:Number,RDT<:Number} <: joAbstractFosterLinearOperator{DDT,RDT}
    name::String
    m::Integer
    n::Integer
    fop::Function              # forward
    fop_T::Nullable{Function}  # transpose
    fop_CT::Nullable{Function} # conj transpose
    fop_C::Nullable{Function}  # conj
    fMVok::Bool                # forward can do mvec
    iop::Nullable{Function}
    iop_T::Nullable{Function}
    iop_CT::Nullable{Function}
    iop_C::Nullable{Function}
    iMVok::Bool
end

# type exceptions
type joLooseLinearFunctionException <: Exception
    msg :: String
end

