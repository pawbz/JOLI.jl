############################################################
## joLooseLinearFunction - overloaded Base functions

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
conj{DDT,RDT}(A::joLooseLinearFunction{DDT,RDT}) =
    joLooseLinearFunction{DDT,RDT}("conj("*A.name*")",A.m,A.n,
        get(A.fop_C),
        A.fop_CT,
        A.fop_T,
        A.fop,
        A.fMVok,
        A.iop_C,
        A.iop_CT,
        A.iop_T,
        A.iop,
        A.iMVok
        )

# transpose(jo)
transpose{DDT,RDT}(A::joLooseLinearFunction{DDT,RDT}) =
    joLooseLinearFunction{RDT,DDT}(""*A.name*".'",A.n,A.m,
        get(A.fop_T),
        A.fop,
        A.fop_C,
        A.fop_CT,
        A.fMVok,
        A.iop_T,
        A.iop,
        A.iop_C,
        A.iop_CT,
        A.iMVok
        )

# ctranspose(jo)
ctranspose{DDT,RDT}(A::joLooseLinearFunction{DDT,RDT}) =
    joLooseLinearFunction{RDT,DDT}(""*A.name*"'",A.n,A.m,
        get(A.fop_CT),
        A.fop_C,
        A.fop,
        A.fop_T,
        A.fMVok,
        A.iop_CT,
        A.iop_C,
        A.iop,
        A.iop_T,
        A.iMVok
        )

# isreal(jo)

# issymmetric(jo)

# ishermitian(jo)

############################################################
## overloaded Base *(...jo...)

# *(jo,jo)

# *(jo,mvec)
function *{ADDT,ARDT,mvDT<:Number}(A::joLooseLinearFunction{ADDT,ARDT},mv::AbstractMatrix{mvDT})
    A.n == size(mv,1) || throw(joLooseLinearFunction("shape mismatch"))
    if A.fMVok
        MV=A.fop(mv)
    else
        MV=Matrix{ARDT}(A.m,size(mv,2))
        for i=1:size(mv,2)
            V=A.fop(mv[:,i])
            MV[:,i]=V
        end
    end
    return MV
end

# *(mvec,jo)

# *(jo,vec)
function *{ADDT,ARDT,vDT<:Number}(A::joLooseLinearFunction{ADDT,ARDT},v::AbstractVector{vDT})
    A.n == size(v,1) || throw(joLooseLinearFunctionException("shape mismatch"))
    V=A.fop(v)
    return V
end

# *(vec,jo)

# *(num,jo)

# *(jo,num)

############################################################
## overloaded Base \(...jo...)

# \(jo,jo)

# \(jo,mvec)
function \{ADDT,ARDT,mvDT<:Number}(A::joLooseLinearFunction{ADDT,ARDT},mv::AbstractMatrix{mvDT})
    A.m == size(mv,1) || throw(joLooseLinearFunctionException("shape mismatch"))
    if hasinverse(A)
        if A.iMVok
            MV = get(A.iop)(mv)
        else
            MV=Matrix{ADDT}(A.n,size(mv,2))
            for i=1:size(mv,2)
                V=get(A.iop)(mv[:,i])
                MV[:,i]=V
            end
        end
    elseif issquare(A)
        MV=Matrix{ADDT}(A.n,size(mv,2))
        for i=1:size(mv,2)
            V=jo_convert(ADDT,jo_iterative_solver4square(A,mv[:,i]))
            MV[:,i]=V
        end
    elseif (istall(A) && !isnull(jo_iterative_solver4tall))
        MV=Matrix{ADDT}(A.n,size(mv,2))
        for i=1:size(mv,2)
            V=jo_convert(ADDT,jo_iterative_solver4tall(A,mv[:,i]))
            MV[:,i]=V
        end
    elseif (iswide(A) && !isnull(jo_iterative_solver4wide))
        MV=Matrix{ADDT}(A.n,size(mv,2))
        for i=1:size(mv,2)
            V=jo_convert(ADDT,jo_iterative_solver4wide(A,mv[:,i]))
            MV[:,i]=V
        end
    else
        throw(joLooseLinearFunctionException("\(jo,MultiVector) not supplied"))
    end
    return MV
end

# \(mvec,jo)

# \(jo,vec)
function \{ADDT,ARDT,vDT<:Number}(A::joLooseLinearFunction{ADDT,ARDT},v::AbstractVector{vDT})
    A.m == size(v,1) || throw(joLooseLinearFunctionException("shape mismatch"))
    if hasinverse(A)
        V=get(A.iop)(v)
    elseif issquare(A)
        V=jo_convert(ADDT,jo_iterative_solver4square(A,v))
    elseif (istall(A) && !isnull(jo_iterative_solver4tall))
        V=jo_convert(ADDT,jo_iterative_solver4tall(A,v))
    elseif (iswide(A) && !isnull(jo_iterative_solver4wide))
        V=jo_convert(ADDT,jo_iterative_solver4wide(A,v))
    else
        throw(joLooseLinearFunctionException("\(jo,Vector) not supplied"))
    end
    return V
end

# \(vec,jo)

# \(num,jo)

# \(jo,num)

############################################################
## overloaded Base +(...jo...)

# +(jo)

# +(jo,jo)

# +(jo,mvec)

# +(mvec,jo)

# +(jo,vec)

# +(vec,jo)

# +(jo,num)

# +(num,jo)

############################################################
## overloaded Base -(...jo...)

# -(jo)
-{DDT,RDT}(A::joLooseLinearFunction{DDT,RDT}) =
    joLooseLinearFunction{DDT,RDT}("(-"*A.name*")",A.m,A.n,
        v1->-A.fop(v1),
        v2->-get(A.fop_T)(v2),
        v3->-get(A.fop_CT)(v3),
        v4->-get(A.fop_C)(v4),
        A.fMVok,
        v5->-get(A.iop)(v5),
        v6->-get(A.iop_T)(v6),
        v7->-get(A.iop_CT)(v7),
        v8->-get(A.iop_C)(v8),
        A.iMVok
        )

# -(jo,jo)

# -(jo,mvec)

# -(mvec,jo)

# -(jo,vec)

# -(vec,jo)

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

# A_mul_B!(...,jo,...)
A_mul_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractVector{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractVector{XDT}) = y[:] = A * x
A_mul_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractMatrix{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractMatrix{XDT}) = y[:,:] = A * x

# At_mul_B!(...,jo,...)
At_mul_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractVector{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractVector{XDT}) = y[:] = A.' * x
At_mul_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractMatrix{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractMatrix{XDT}) = y[:,:] = A.' * x

# Ac_mul_B!(...,jo,...)
Ac_mul_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractVector{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractVector{XDT}) = y[:] = A' * x
Ac_mul_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractMatrix{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractMatrix{XDT}) = y[:,:] = A' * x

# A_ldiv_B!(...,jo,...)
A_ldiv_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractVector{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractVector{XDT}) = y[:] = A \ x
A_ldiv_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractMatrix{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractMatrix{XDT}) = y[:,:] = A \ x

# At_ldiv_B!(...,jo,...)
At_ldiv_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractVector{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractVector{XDT}) = y[:] = A.' \ x
At_ldiv_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractMatrix{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractMatrix{XDT}) = y[:,:] = A.' \ x

# Ac_ldiv_B!(...,jo,...)
Ac_ldiv_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractVector{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractVector{XDT}) = y[:] = A' \ x
Ac_ldiv_B!{DDT,RDT,YDT<:Number,XDT<:Number}(y::AbstractMatrix{YDT},A::joLooseLinearFunction{DDT,RDT},x::AbstractMatrix{XDT}) = y[:,:] = A' \ x

