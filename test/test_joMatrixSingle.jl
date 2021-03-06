T=6
tsname="joMatrix - Single"
@testset "$tsname" begin
for t=1:T # start test loop

if t<=2
    (m,n)=(5,5)
else
    (m,n)=(rand(3:7),rand(3:7))
end

if t%2==1
    tname="loop $t for real($m,$n)"
    a=rand(m,n)
    b=rand(m,n)
    vn=rand(n)
    mvn=rand(n,2)
    vm=rand(m)
    mvm=rand(m,2)
else
    tname="loop $t for complex($m,$n)"
    a=rand(Complex{Float64},m,n)
    b=rand(Complex{Float64},m,n)
    vn=rand(Complex{Float64},n)
    mvn=rand(Complex{Float64},n,2)
    vm=rand(Complex{Float64},m)
    mvm=rand(Complex{Float64},m,2)
end
A=joMatrix(a)
B=joMatrix(b)
afac=rand(eltype(a))
Afac=joNumber(afac,A)
mfac=rand(eltype(a))
Mfac=joNumber(mfac,A)

verbose && println("$tsname $tname")
    @testset "$tname A" begin
        @test size(A)==size(a)
        @test length(A)==length(a)
        @test full(A)==a
        @test elements(A)==a
        @test norm(A)==norm(a)
        for i=1:2
            @test norm(A,i)==norm(a,i)
        end
        @test norm(A,Inf)==norm(a,Inf)
        @test vecnorm(A)==vecnorm(a)
        for i=1:2
            @test vecnorm(A,i)==vecnorm(a,i)
        end
        @test vecnorm(A,Inf)==vecnorm(a,Inf)
        @test elements(A')==a'
        @test elements(A.')==a.'
        @test elements(conj(A))==conj(a)
        @test elements(+A)==+a
        @test elements(-A)==-a
        @test norm(A*vn-a*vn)<joTol
        @test norm(A*mvn-a*mvn)<joTol
        @test norm(A'*vm-a'*vm)<joTol
        @test norm(A'*mvm-a'*mvm)<joTol
        @test norm(A.'*vm-a.'*vm)<joTol
        @test norm(A.'*mvm-a.'*mvm)<joTol
        @test norm((A.')'*vn-(a.')'*vn)<joTol
        @test norm((A.')'*mvn-(a.')'*mvn)<joTol
        @test norm((A').'*vn-(a').'*vn)<joTol
        @test norm((A').'*mvn-(a').'*mvn)<joTol
        @test norm(elements(A.'*A)-(a.'*a))<joTol
        @test norm(elements(A*A.')-(a*a.'))<joTol
        @test norm(elements(A'*A)-(a'*a))<joTol
        @test norm(elements(A*A')-(a*a'))<joTol
        @test norm(A\vm-a\vm)<joTol
        @test norm(A\mvm-a\mvm)<joTol
        @test norm(A'\vn-a'\vn)<joTol
        @test norm(A'\mvn-a'\mvn)<joTol
        @test norm(A.'\vn-a.'\vn)<joTol
        @test norm(A.'\mvn-a.'\mvn)<joTol
        @test norm(elements(A+B)-(a+b))<joTol
        @test norm(elements(A-B)-(a-b))<joTol
        @test norm(elements(mfac*A)-(mfac*a))<joTol
        @test norm(elements(mfac*A.')-(mfac*a.'))<joTol
        @test norm(elements(mfac*A')-(mfac*a'))<joTol
        @test norm(elements(mfac*conj(A))-(mfac*conj(a)))<joTol
        @test norm(elements(A*mfac)-(a*mfac))<joTol
        @test norm(elements(A.'*mfac)-(a.'*mfac))<joTol
        @test norm(elements(A'*mfac)-(a'*mfac))<joTol
        @test norm(elements(conj(A)*mfac)-(conj(a)*mfac))<joTol
        @test norm(elements(Mfac*A)-(mfac*a))<joTol
        @test norm(elements(Mfac*A.')-(mfac*a.'))<joTol
        @test norm(elements(Mfac*A')-(mfac*a'))<joTol
        @test norm(elements(Mfac*conj(A))-(mfac*conj(a)))<joTol
        @test norm(elements(A*Mfac)-(a*mfac))<joTol
        @test norm(elements(A.'*Mfac)-(a.'*mfac))<joTol
        @test norm(elements(A'*Mfac)-(a'*mfac))<joTol
        @test norm(elements(conj(A)*Mfac)-(conj(a)*mfac))<joTol
        @test norm(elements(A+afac)-(a+afac))<joTol
        @test norm(elements(A.'+afac)-(a.'+afac))<joTol
        @test norm(elements(A'+afac)-(a'+afac))<joTol
        @test norm(elements(conj(A)+afac)-(conj(a)+afac))<joTol
        @test norm(elements(afac+A)-(afac+a))<joTol
        @test norm(elements(afac+A.')-(afac+a.'))<joTol
        @test norm(elements(afac+A')-(afac+a'))<joTol
        @test norm(elements(afac+conj(A))-(afac+conj(a)))<joTol
        @test norm(elements(A+Afac)-(a+afac))<joTol
        @test norm(elements(A.'+Afac)-(a.'+afac))<joTol
        @test norm(elements(A'+Afac)-(a'+afac))<joTol
        @test norm(elements(conj(A)+Afac)-(conj(a)+afac))<joTol
        @test norm(elements(Afac+A)-(afac+a))<joTol
        @test norm(elements(Afac+A.')-(afac+a.'))<joTol
        @test norm(elements(Afac+A')-(afac+a'))<joTol
        @test norm(elements(Afac+conj(A))-(afac+conj(a)))<joTol
    end

end # end test loop
end
