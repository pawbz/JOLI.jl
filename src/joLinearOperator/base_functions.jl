############################################################
## joLinearOperator - overloaded Base functions
# commons methods class for jo[Abstract]LinearOperator

# eltype(jo)
eltype{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) = promote_type(DDT,RDT)

# deltype(jo)
deltype{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) = DDT

# reltype(jo)
reltype{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) = RDT

# show(jo)
show(A::joAbstractLinearOperator) = println((typeof(A),A.name,A.m,A.n))

# showall(jo)
showall(A::joAbstractLinearOperator) = println((typeof(A),A.name,A.m,A.n))

# display(jo)
display(A::joAbstractLinearOperator) = showall(A)

# size(jo)
size(A::joAbstractLinearOperator) = A.m,A.n

# size(jo,1/2)
function size(A::joAbstractLinearOperator,ind::Integer)
    if ind==1
		return A.m
	elseif ind==2
		return A.n
	else
		throw(joAbstractLinearOperatorException("invalid index"))
	end
end

# length(jo)
length(A::joAbstractLinearOperator) = A.m*A.n

# full(jo)
full{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) = A*eye(DDT,A.n)

# norm(jo)
norm(A::joAbstractLinearOperator,p::Real=2) = norm(elements(A),p)

# vecnorm(jo)
vecnorm(A::joAbstractLinearOperator,p::Real=2) = vecnorm(elements(A),p)

# real(jo)
#real{DDT<:Real,RDT<:Real}(A::joAbstractLinearOperator{DDT,RDT}) = A
function real{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT})
    throw(joAbstractLinearOperatorException("real(jo) not implemented"))
end
joReal{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) = real(A)

# imag(jo)
#imag{DDT<:Real,RDT<:Real}(A::joAbstractLinearOperator{DDT,RDT}) = joZeros(A.m,A.n,DDT,RDT)
function imag{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT})
    throw(joAbstractLinearOperatorException("imag(jo) not implemented"))
end
joImag{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) = imag(A)

# conj(jo)
conj{DDT,RDT}(A::joLinearOperator{DDT,RDT}) =
    joLinearOperator{DDT,RDT}("conj("*A.name*")",A.m,A.n,
        get(A.fop_C),
        A.fop_CT,
        A.fop_T,
        A.fop,
        A.iop_C,
        A.iop_CT,
        A.iop_T,
        A.iop
        )
joConj(A::joAbstractLinearOperator) = conj(A)

# transpose(jo)
transpose{DDT,RDT}(A::joLinearOperator{DDT,RDT}) =
    joLinearOperator{RDT,DDT}(""*A.name*".'",A.n,A.m,
        get(A.fop_T),
        A.fop,
        A.fop_C,
        A.fop_CT,
        A.iop_T,
        A.iop,
        A.iop_C,
        A.iop_CT
        )

# ctranspose(jo)
ctranspose{DDT,RDT}(A::joLinearOperator{DDT,RDT}) =
    joLinearOperator{RDT,DDT}(""*A.name*"'",A.n,A.m,
        get(A.fop_CT),
        A.fop_C,
        A.fop,
        A.fop_T,
        A.iop_CT,
        A.iop_C,
        A.iop,
        A.iop_T
        )

# isreal(jo)
isreal{DDT,RDT}(A :: joAbstractLinearOperator{DDT,RDT}) = (DDT<:Real && RDT<:Real)

# issymmetric(jo)
issymmetric{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) =
    (A.m == A.n && (vecnorm(elements(A)-elements(A.')) < joTol))

# ishermitian(jo)
ishermitian{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) =
    (A.m == A.n && (vecnorm(elements(A)-elements(A')) < joTol))

############################################################
## overloaded Base *(...jo...)

# *(jo,jo)
function *{ARDT,BDDT,CDT}(A::joAbstractLinearOperator{CDT,ARDT},B::joAbstractLinearOperator{BDDT,CDT})
    size(A,2) == size(B,1) || throw(joAbstractLinearOperatorException("shape mismatch"))
    return joLinearOperator{BDDT,ARDT}("("*A.name*"*"*B.name*")",size(A,1),size(B,2),
        v1->A*(B*v1),
        v2->B.'*(A.'*v2),
        v3->B'*(A'*v3),
        v4->conj(A)*(conj(B)*v4),
        @joNF, @joNF, @joNF, @joNF
        )
end

# *(jo,mvec)
function *{ADDT,ARDT,mvDT<:Number}(A::joLinearOperator{ADDT,ARDT},mv::AbstractMatrix{mvDT})
    A.n == size(mv,1) || throw(joLinearOperatorException("shape mismatch"))
    jo_check_type_match(ADDT,mvDT,join(["DDT for *(jo,mvec):",A.name,typeof(A),mvDT]," / "))
    MV = A.fop(mv)
    jo_check_type_match(ARDT,eltype(MV),join(["RDT from *(jo,mvec):",A.name,typeof(A),eltype(MV)]," / "))
    return MV
end

# *(jo,vec)
function *{ADDT,ARDT,vDT<:Number}(A::joLinearOperator{ADDT,ARDT},v::AbstractVector{vDT})
    A.n == size(v,1) || throw(joLinearOperatorException("shape mismatch"))
    jo_check_type_match(ADDT,vDT,join(["DDT for *(jo,vec):",A.name,typeof(A),vDT]," / "))
    V=A.fop(v)
    jo_check_type_match(ARDT,eltype(V),join(["RDT from *(jo,vec):",A.name,typeof(A),eltype(V)]," / "))
    return V
end

# *(num,jo)
function *{ADDT,ARDT}(a::Number,A::joAbstractLinearOperator{ADDT,ARDT})
    return joLinearOperator{ADDT,ARDT}("(N*"*A.name*")",A.m,A.n,
        v1->jo_convert(ARDT,a*(A*v1),false),
        v2->jo_convert(ADDT,a*(A.'*v2),false),
        v3->jo_convert(ADDT,conj(a)*(A'*v3),false),
        v4->jo_convert(ARDT,conj(a)*(conj(A)*v4),false),
        @joNF, @joNF, @joNF, @joNF
        )
end
function *{ADDT,ARDT}(a::joNumber{ADDT,ARDT},A::joAbstractLinearOperator{ADDT,ARDT})
    return joLinearOperator{ADDT,ARDT}("(N*"*A.name*")",A.m,A.n,
        v1->jo_convert(ARDT,a.rdt*(A*v1),false),
        v2->jo_convert(ADDT,a.ddt*(A.'*v2),false),
        v3->jo_convert(ADDT,conj(a.ddt)*(A'*v3),false),
        v4->jo_convert(ARDT,conj(a.rdt)*(conj(A)*v4),false),
        @joNF, @joNF, @joNF, @joNF
        )
end

# *(jo,num)
*{ADDT,ARDT}(A::joAbstractLinearOperator{ADDT,ARDT},a::Number) = a*A
*{ADDT,ARDT}(A::joAbstractLinearOperator{ADDT,ARDT},a::joNumber{ADDT,ARDT}) = a*A

############################################################
## overloaded Base \(...jo...)

# \(jo,mvec)
function \{ADDT,ARDT,mvDT<:Number}(A::joLinearOperator{ADDT,ARDT},mv::AbstractMatrix{mvDT})
    A.m == size(mv,1) || throw(joLinearOperatorException("shape mismatch"))
    jo_check_type_match(ARDT,mvDT,join(["RDT for *(jo,mvec):",A.name,typeof(A),mvDT]," / "))
    if hasinverse(A)
        MV=get(A.iop)(mv)
        jo_check_type_match(ADDT,eltype(MV),join(["DDT from *(jo,mvec):",A.name,typeof(A),eltype(MV)]," / "))
    else
        throw(joLinearOperatorException("\(jo,MultiVector) not supplied"))
    end
    return MV
end

# \(jo,vec)
function \{ADDT,ARDT,vDT<:Number}(A::joLinearOperator{ADDT,ARDT},v::AbstractVector{vDT})
    A.m == size(v,1) || throw(joLinearOperatorException("shape mismatch"))
    jo_check_type_match(ARDT,vDT,join(["RDT for *(jo,vec):",A.name,typeof(A),vDT]," / "))
    if hasinverse(A)
        V=get(A.iop)(v)
        jo_check_type_match(ADDT,eltype(V),join(["DDT from *(jo,vec):",A.name,typeof(A),eltype(V)]," / "))
    else
        throw(joLinearOperatorException("\(jo,Vector) not supplied"))
    end
    return V
end

# \(jo,num)
#\{ADDT,ARDT}(A::joAbstractLinearOperator{ADDT,ARDT},a::Number) = inv(a)*A
#\{ADDT,ARDT}(A::joAbstractLinearOperator{ADDT,ARDT},a::joNumber{ADDT,ARDT}) = inv(a)*A

############################################################
## overloaded Base +(...jo...)

# +(jo)
+(A::joAbstractLinearOperator) = A

# +(jo,jo)
function +{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT},B::joAbstractLinearOperator{DDT,RDT})
    size(A) == size(B) || throw(joAbstractLinearOperatorException("shape mismatch"))
    return joLinearOperator{DDT,RDT}("("*A.name*"+"*B.name*")",size(A,1),size(B,2),
        v1->A*v1+B*v1,
        v2->A.'*v2+B.'*v2,
        v3->A'*v3+B'*v3,
        v4->conj(A)*v4+conj(B)*v4,
        @joNF, @joNF, @joNF, @joNF
        )
end

# +(jo,num)
function +{ADDT,ARDT}(A::joAbstractLinearOperator{ADDT,ARDT},b::Number)
    return joLinearOperator{ADDT,ARDT}("("*A.name*"+N)",size(A,1),size(A,2),
        v1->A*v1+joConstants(A.m,A.n,b;DDT=ADDT,RDT=ARDT)*v1,
        v2->A.'*v2+joConstants(A.n,A.m,b;DDT=ARDT,RDT=ADDT)*v2,
        v3->A'*v3+joConstants(A.n,A.m,conj(b);DDT=ARDT,RDT=ADDT)*v3,
        v4->conj(A)*v4+joConstants(A.m,A.n,conj(b);DDT=ADDT,RDT=ARDT)*v4,
        @joNF, @joNF, @joNF, @joNF
        )
end
function +{ADDT,ARDT}(A::joAbstractLinearOperator{ADDT,ARDT},b::joNumber{ADDT,ARDT})
    return joLinearOperator{ADDT,ARDT}("("*A.name*"+N)",size(A,1),size(A,2),
        v1->A*v1+joConstants(A.m,A.n,b.rdt;DDT=ADDT,RDT=ARDT)*v1,
        v2->A.'*v2+joConstants(A.n,A.m,b.ddt;DDT=ARDT,RDT=ADDT)*v2,
        v3->A'*v3+joConstants(A.n,A.m,conj(b.ddt);DDT=ARDT,RDT=ADDT)*v3,
        v4->conj(A)*v4+joConstants(A.m,A.n,conj(b.rdt);DDT=ADDT,RDT=ARDT)*v4,
        @joNF, @joNF, @joNF, @joNF
        )
end

# +(num,jo)
+{ADDT,ARDT}(b::Number,A::joAbstractLinearOperator{ADDT,ARDT}) = A+b
+{ADDT,ARDT}(b::joNumber{ADDT,ARDT},A::joAbstractLinearOperator{ADDT,ARDT}) = A+b

############################################################
## overloaded Base -(...jo...)

# -(jo)
-{DDT,RDT}(A::joLinearOperator{DDT,RDT}) =
    joLinearOperator{DDT,RDT}("(-"*A.name*")",A.m,A.n,
        v1->-A.fop(v1),
        v2->-get(A.fop_T)(v2),
        v3->-get(A.fop_CT)(v3),
        v4->-get(A.fop_C)(v4),
        v5->-get(A.iop)(v5),
        v6->-get(A.iop_T)(v6),
        v7->-get(A.iop_CT)(v7),
        v8->-get(A.iop_C)(v8)
        )

# -(jo,jo)
-(A::joAbstractLinearOperator,B::joAbstractLinearOperator) = A+(-B)

# -(jo,num)
-(A::joAbstractLinearOperator,b::Number) = A+(-b)
-(A::joAbstractLinearOperator,b::joNumber) = A+(-b)

# -(num,jo)
-(b::Number,A::joAbstractLinearOperator) = -A+b
-(b::joNumber,A::joAbstractLinearOperator) = -A+b

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
hcat(ops::joAbstractLinearOperator...) = joDict(ops...)

# vcat(...jo...)
vcat(ops::joAbstractLinearOperator...) = joStack(ops...)

# hvcat(...jo...)
hvcat(rows::Tuple{Vararg{Int}}, ops::joAbstractLinearOperator...) = joBlock(collect(rows),ops...)

############################################################
## overloaded Base.LinAlg functions

# A_mul_B!(vec,jo,vec)
A_mul_B!(y::AbstractVector,A::joAbstractLinearOperator,x::AbstractVector) = y[:] = A * x

# At_mul_B!(vec,jo,vec)
At_mul_B!(y::AbstractVector,A::joAbstractLinearOperator,x::AbstractVector) = y[:] = A.' * x

# Ac_mul_B!(vec,jo,vec)
Ac_mul_B!(y::AbstractVector,A::joAbstractLinearOperator,x::AbstractVector) = y[:] = A' * x

