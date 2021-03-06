############################################################
# joLooseMatrixInplace #####################################
############################################################

export joLooseMatrixInplace, joLooseMatrixInplaceException

# type definition
"""
joLooseMatrixInplace type

# TYPE PARAMETERS
- DDT::DataType : domain DataType
- RDT::DataType : range DataType

# FIELDS
- name::String : given name
- m::Integer : # of rows
- n::Integer : # of columns
- fop::Function : forward matrix
- fop_T::Function : transpose matrix
- fop_CT::Function : conj transpose matrix
- iop::Nullable{Function} : inverse for fop
- iop_T::Nullable{Function} : inverse for fop_T
- iop_CT::Nullable{Function} : inverse for fop_CT

"""
struct joLooseMatrixInplace{DDT<:Number,RDT<:Number} <: joAbstractLinearOperatorInplace{DDT,RDT}
    name::String
    m::Integer
    n::Integer
    fop::Function    # forward
    fop_T::Function  # transpose
    fop_CT::Function # conj transpose
    iop::Nullable{Function}
    iop_T::Nullable{Function}
    iop_CT::Nullable{Function}
end

# type exception
type joLooseMatrixInplaceException <: Exception
    msg :: String
end

