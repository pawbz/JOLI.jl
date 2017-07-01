############################################################
## joLinearOperator - extra functions
# commons methods class for jo[Abstract]LinearOperator

# elements(jo)
elements{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) = A*eye(DDT,A.n)

# hasinverse(jo)
hasinverse{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT}) = !isnull(A.iop)

# issquare(jo)
issquare{DDT,RDT}(A :: joAbstractLinearOperator{DDT,RDT}) = (A.m == A.n)

# iscomplex(jo)
iscomplex{DDT,RDT}(A :: joAbstractLinearOperator{DDT,RDT}) = !(DDT<:Real && RDT<:Real)

# islinear(jo)
function islinear{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT},samples=3;tol::Float64=0.,verbose::Bool=false)
    Test=true
    TEST=Array{Bool,1}(0)
    MYTOL=Array{Float64,1}(0)
    DIF=Array{Float64,1}(0)
    RER=Array{Float64,1}(0)
    RTO=Array{Float64,1}(0)
    for s=1:samples
        x= DDT<:Real ? jo_convert(DDT,randn(A.n)) : jo_convert(DDT,complex.(randn(A.n),randn(A.n)))
        y= DDT<:Real ? jo_convert(DDT,randn(A.n)) : jo_convert(DDT,complex.(randn(A.n),randn(A.n)))
        Axy=A*(x+y)
        AxAy=(A*x+A*y)
        dif=vecnorm(Axy-AxAy); push!(DIF,dif)
        rer=abs(dif/vecnorm(Axy)); push!(RER,rer)
        rto=abs(vecnorm(AxAy)/vecnorm(Axy)); push!(RTO,rto)
        mytol=(tol>0 ? tol : sqrt(max(eps(vecnorm(Axy)),eps(vecnorm(AxAy))))); push!(MYTOL,mytol)
        test=(dif < mytol); push!(TEST,test); Test=Test&&test
        result = test ? "passed" : "failed"
        if verbose println("Linear test [$s] $result with tol=$mytol: \n diff=   $dif \n relerr= $rer \n ratio=  $rto") end
    end
    return Test,TEST,MYTOL,DIF,RER,RTO
end

# isadjoint(jo)
function isadjoint{DDT,RDT}(A::joAbstractLinearOperator{DDT,RDT},samples=3;tol::Float64=0.,normfactor::Real=1.,userange::Bool=false,verbose::Bool=false)
    Test=true
    TEST=Array{Bool,1}(0)
    MYTOL=Array{Float64,1}(0)
    DIF=Array{Float64,1}(0)
    RER=Array{Float64,1}(0)
    RTO=Array{Float64,1}(0)
    for s=1:samples
        if userange
            x= RDT<:Real ? jo_convert(RDT,randn(A.m)) : jo_convert(RDT,complex.(randn(A.m),randn(A.m)))
            y= RDT<:Real ? jo_convert(RDT,randn(A.m)) : jo_convert(RDT,complex.(randn(A.m),randn(A.m)))
            x=A'*x
        else
            x= DDT<:Real ? jo_convert(DDT,randn(A.n)) : jo_convert(DDT,complex.(randn(A.n),randn(A.n)))
            y= DDT<:Real ? jo_convert(DDT,randn(A.n)) : jo_convert(DDT,complex.(randn(A.n),randn(A.n)))
            y=A*y
        end
        nfr=convert(RDT,normfactor)
        nfd=convert(DDT,normfactor)
        Axy=dot((A*x)/nfr,y)
        xAty=dot(x,(A'*y)*nfd)
        dif=abs(xAty-Axy); push!(DIF,dif)
        rer=abs(dif/Axy); push!(RER,rer)
        rto=abs(xAty/Axy); push!(RTO,rto)
        mytol=(tol>0 ? tol : sqrt(max(eps(abs(Axy)),eps(abs(xAty))))); push!(MYTOL,mytol)
        test=(dif < mytol); push!(TEST,test); Test=Test&&test
        result = test ? "passed" : "failed"
        if verbose println("Adjoint test [$s] $result with tol=$mytol: \n diff=   $dif \n relerr= $rer \n ratio=  $rto") end
    end
    return Test,TEST,MYTOL,DIF,RER,RTO
end

