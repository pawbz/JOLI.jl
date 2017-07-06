############################################################
## joMatrix - overloaded Base functions
# un-implemented methods are defined in joLinearOperator/base_functions.jl

# eltype(jo)

# deltype(jo)

# reltype(jo)

# show(jo)

# showall(jo)

# display(jo)

# size(jo)

# size(jo,1/2)

# length(jo)

# full(jo)

# norm(jo)

# vecnorm(jo)

# real(jo)

# imag(jo)

# conj(jo)
conj{DDT,RDT}(A::joMatrix{DDT,RDT}) =
    joMatrix{DDT,RDT}("conj("*A.name*")",A.m,A.n,
        A.fop_C,
        A.fop_CT,
        A.fop_T,
        A.fop,
        A.iop_C,
        A.iop_CT,
        A.iop_T,
        A.iop
        )

# transpose(jo)
transpose{DDT,RDT}(A::joMatrix{DDT,RDT}) =
    joMatrix{RDT,DDT}(""*A.name*".'",A.n,A.m,
        A.fop_T,
        A.fop,
        A.fop_C,
        A.fop_CT,
        A.iop_T,
        A.iop,
        A.iop_C,
        A.iop_CT
        )

# ctranspose(jo)
ctranspose{DDT,RDT}(A::joMatrix{DDT,RDT}) =
    joMatrix{RDT,DDT}(""*A.name*"'",A.n,A.m,
        A.fop_CT,
        A.fop_C,
        A.fop,
        A.fop_T,
        A.iop_CT,
        A.iop_C,
        A.iop,
        A.iop_T
        )

# isreal(jo)

# issymmetric(jo)

# ishermitian(jo)

############################################################
## overloaded Base *(...jo...)

# *(jo,jo)

# *(jo,mvec)
function *{ADDT,ARDT,mvDT<:Number}(A::joMatrix{ADDT,ARDT},mv::AbstractMatrix{mvDT})
    A.n == size(mv,1) || throw(joMatrixException("shape mismatch"))
    jo_check_type_match(ADDT,mvDT,join(["DDT for *(jo,mvec):",A.name,typeof(A),mvDT]," / "))
    MV = A.fop(mv)
    jo_check_type_match(ARDT,eltype(MV),join(["RDT from *(jo,mvec):",A.name,typeof(A),eltype(MV)]," / "))
    return MV
end

# *(jo,vec)
function *{ADDT,ARDT,vDT<:Number}(A::joMatrix{ADDT,ARDT},v::AbstractVector{vDT})
    A.n == size(v,1) || throw(joMatrixException("shape mismatch"))
    jo_check_type_match(ADDT,vDT,join(["DDT for *(jo,vec):",A.name,typeof(A),vDT]," / "))
    V=A.fop(v)
    jo_check_type_match(ARDT,eltype(V),join(["RDT from *(jo,vec):",A.name,typeof(A),eltype(V)]," / "))
    return V
end

# *(num,jo)

# *(jo,num)

############################################################
## overloaded Base \(...jo...)

# \(jo,mvec)
function \{ADDT,ARDT,mvDT<:Number}(A::joMatrix{ADDT,ARDT},mv::AbstractMatrix{mvDT})
    A.m == size(mv,1) || throw(joMatrixException("shape mismatch"))
    jo_check_type_match(ARDT,mvDT,join(["RDT for *(jo,mvec):",A.name,typeof(A),mvDT]," / "))
    if hasinverse(A)
        MV=get(A.iop)(mv)
        jo_check_type_match(ADDT,eltype(MV),join(["DDT from *(jo,mvec):",A.name,typeof(A),eltype(MV)]," / "))
    else
        throw(joMatrixException("\(jo,Vector) not supplied"))
    end
    return MV
end

# \(jo,vec)
function \{ADDT,ARDT,vDT<:Number}(A::joMatrix{ADDT,ARDT},v::AbstractVector{vDT})
    A.m == size(v,1) || throw(joMatrixException("shape mismatch"))
    jo_check_type_match(ARDT,vDT,join(["RDT for *(jo,vec):",A.name,typeof(A),vDT]," / "))
    if hasinverse(A)
        V=get(A.iop)(v)
        jo_check_type_match(ADDT,eltype(V),join(["DDT from *(jo,vec):",A.name,typeof(A),eltype(V)]," / "))
    else
        throw(joMatrixException("\(jo,Vector) not supplied"))
    end
    return V
end

# \(jo,num)

############################################################
## overloaded Base +(...jo...)

# +(jo)

# +(jo,jo)

# +(jo,num)

# +(num,jo)

############################################################
## overloaded Base -(...jo...)

# -(jo)
-{DDT,RDT}(A::joMatrix{DDT,RDT}) =
    joMatrix{DDT,RDT}("(-"*A.name*")",A.m,A.n,
        v1->-A.fop(v1),
        v2->-A.fop_T(v2),
        v3->-A.fop_CT(v3),
        v4->-A.fop_C(v4),
        v5->-get(A.iop)(v5),
        v6->-get(A.iop_T)(v6),
        v7->-get(A.iop_CT)(v7),
        v8->-get(A.iop_C)(v8)
        )

# -(jo,jo)

# -(jo,num)

# -(num,jo)

############################################################
## overloaded Base .*(...jo...)

############################################################
## overloaded Base .\(...jo...)

############################################################
## overloaded Base .+(...jo...)

############################################################
## overloaded Base .-(...jo...)

############################################################
## overloaded Base block methods

# hcat(...jo...)

# vcat(...jo...)

# hvcat(...jo...)

############################################################
## overloaded Base.LinAlg functions

# A_mul_B!(vec,jo,vec)

# At_mul_B!(vec,jo,vec)

# Ac_mul_B!(vec,jo,vec)

