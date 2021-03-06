
<a id='JOLI-reference-1'></a>

# JOLI reference

- [JOLI reference](REFERENCE.md#JOLI-reference-1)
    - [Functions](REFERENCE.md#Functions-1)
    - [Macros](REFERENCE.md#Macros-1)
    - [Types](REFERENCE.md#Types-1)
    - [Index](REFERENCE.md#Index-1)


<a id='Functions-1'></a>

## Functions

<a id='JOLI.joAddSolverAll-Union{Tuple{DDT}, Tuple{JOLI.joAbstractLinearOperator{DDT,RDT},Function,Function,Function,Function}, Tuple{RDT}} where RDT where DDT' href='#JOLI.joAddSolverAll-Union{Tuple{DDT}, Tuple{JOLI.joAbstractLinearOperator{DDT,RDT},Function,Function,Function,Function}, Tuple{RDT}} where RDT where DDT'>#</a>
**`JOLI.joAddSolverAll`** &mdash; *Method*.



joAddSolver outer constructor

```
joAddSolverAll(A::joAbstractLinearOperator{DDT,RDT},
    solver::Function,solver_T::Function,solver_CT::Function,solver_C::Function)
```

Create joLinearOperator with added specific solver(s) for (jo,[m]vec), distinct for each form of the operator.

**Examples**

```
O=joAddSolverAll(O,
    (s,x)->my_solver(s,x),
    (s,x)->my_solver_T(s,x),
    (s,x)->my_solver_CT(s,x),
    (s,x)->my_solver_C(s,x))
O=joAddSolverAll(O,
    (s,x)->my_solver(s,x),
    @joNF,
    (s,x)->my_solver_CT(s,x),
    @joNF)
O=joAddSolverAll(O,
    (s,x)->my_solver(s,x),
    @joNF,
    @joNF,
    @joNF)
```


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearOperator/constructors.jl#L29-L55' class='documenter-source'>source</a><br>

<a id='JOLI.joAddSolverAny-Union{Tuple{DDT}, Tuple{JOLI.joAbstractLinearOperator{DDT,RDT},Function}, Tuple{RDT}} where RDT where DDT' href='#JOLI.joAddSolverAny-Union{Tuple{DDT}, Tuple{JOLI.joAbstractLinearOperator{DDT,RDT},Function}, Tuple{RDT}} where RDT where DDT'>#</a>
**`JOLI.joAddSolverAny`** &mdash; *Method*.



joAddSolver outer constructor

```
joAddSolverAny(A::joAbstractLinearOperator{DDT,RDT},solver::Function)
```

Create joLinearOperator with added solver for (jo,[m]vec), same for each form of the operator

**Example (for all forms of O)**

```
O=joAddSolverAny(O,(s,x)->my_solver(s,x))
```


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearOperator/constructors.jl#L6-L17' class='documenter-source'>source</a><br>

<a id='JOLI.joBlock-Union{Tuple{Array{RVDT,1},Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{RVDT}, Tuple{WDT}} where WDT<:Number where RVDT<:Integer' href='#JOLI.joBlock-Union{Tuple{Array{RVDT,1},Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{RVDT}, Tuple{WDT}} where WDT<:Number where RVDT<:Integer'>#</a>
**`JOLI.joBlock`** &mdash; *Method*.



Block operator composed from different square JOLI operators

```
joBlock(rows::Tuple{Vararg{Int}},ops::joAbstractLinearOperator...;
    weights::AbstractVector,name::String)
```

**Example**

```
a=rand(Complex{Float64},4,4);
A=joMatrix(a;DDT=Complex{Float32},RDT=Complex{Float64},name="A")
b=rand(Complex{Float64},4,8);
B=joMatrix(b;DDT=Complex{Float32},RDT=Complex{Float64},name="B")
c=rand(Complex{Float64},6,6);
C=joMatrix(c;DDT=Complex{Float32},RDT=Complex{Float64},name="C")
d=rand(Complex{Float64},6,6);
D=joMatrix(d;DDT=Complex{Float32},RDT=Complex{Float64},name="D")
# either
    S=joBlock([2,2],A,B,C,D) # basic block in function syntax
# or
    S=[A B; C D] # basic block in [] syntax
w=rand(Complex{Float64},4)
S=joBlock(A,B,C;weights=w) # weighted block
```

**Notes**

  * operators are to be given in row-major order
  * all operators in a row must have the same # of rows (M)
  * sum of Ns for operators in each row must be the same
  * all given operators must have same domain/range types
  * the domain/range types of joBlock are equal to domain/range types of the given operators


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearOperatorConstructors/joCoreBlockConstructors/joBlock.jl#L14-L43' class='documenter-source'>source</a><br>

<a id='JOLI.joBlockDiag-Union{Tuple{Integer,JOLI.joAbstractLinearOperator}, Tuple{WDT}} where WDT<:Number' href='#JOLI.joBlockDiag-Union{Tuple{Integer,JOLI.joAbstractLinearOperator}, Tuple{WDT}} where WDT<:Number'>#</a>
**`JOLI.joBlockDiag`** &mdash; *Method*.



Block-diagonal operator composed from l-times replicated square JOLI operator

```
joBlockDiag(l::Int,op::joAbstractLinearOperator;weights::AbstractVector,name::String)
```

**Example**

```
a=rand(Complex{Float64},4,4);
w=rand(Complex{Float64},3)
A=joMatrix(a;DDT=Complex{Float32},RDT=Complex{Float64},name="A")
BD=joBlockDiag(3,A) # basic block diagonal
BD=joBlockDiag(3,A;weights=w) # weighted block diagonal
```

**Notes**

  * all given operators must have same domain/range types
  * the domain/range types of joBlockDiag are equal to domain/range types of the given operators


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearOperatorConstructors/joCoreBlockConstructors/joBlockDiag.jl#L83-L99' class='documenter-source'>source</a><br>

<a id='JOLI.joBlockDiag-Union{Tuple{Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{WDT}} where WDT<:Number' href='#JOLI.joBlockDiag-Union{Tuple{Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{WDT}} where WDT<:Number'>#</a>
**`JOLI.joBlockDiag`** &mdash; *Method*.



Block-diagonal operator composed from different square JOLI operators

```
joBlockDiag(ops::joAbstractLinearOperator...;
    weights::AbstractVector,name::String)
```

**Example**

```
a=rand(Complex{Float64},4,4);
A=joMatrix(a;DDT=Complex{Float32},RDT=Complex{Float64},name="A")
b=rand(Complex{Float64},8,8);
B=joMatrix(b;DDT=Complex{Float32},RDT=Complex{Float64},name="B")
c=rand(Complex{Float64},6,6);
C=joMatrix(c;DDT=Complex{Float32},RDT=Complex{Float64},name="C")
BD=joBlockDiag(A,B,C) # basic block diagonal
w=rand(Complex{Float64},3)
BD=joBlockDiag(A,B,C;weights=w) # weighted block diagonal
```

**Notes**

  * all operators must be square (M(i)==N(i))
  * all given operators must have same domain/range types
  * the domain/range types of joBlockDiag are equal to domain/range types of the given operators


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearOperatorConstructors/joCoreBlockConstructors/joBlockDiag.jl#L14-L36' class='documenter-source'>source</a><br>

<a id='JOLI.joCurvelet2D-Tuple{Integer,Integer}' href='#JOLI.joCurvelet2D-Tuple{Integer,Integer}'>#</a>
**`JOLI.joCurvelet2D`** &mdash; *Method*.



2D Curvelet transform (wrapping) over fast dimensions

```
joCurvelet2D(n1,n2
            [;DDT=Float64,RDT=DDT,
             nbscales=#,nbangles_coarse=16,all_crvlts=false,real_crvlts=true,zero_finest=false])
```

**Arguments**

  * n1,n2 - image sizes
  * nbscales - # of scales (requires #>=default; defaults to max(1,ceil(log2(min(n1,n2))-3)))
  * nbangles_coarse - # of angles at coarse scale (requires #%4==0, #>=8; defaults to 16)
  * all_crvlts - curvelets at finnest scales (defaults to false)
  * real_crvlts - real transform (defaults to true) and requires real input
  * zero_finest - zero out finnest scales (defaults to false)

**Examples**

  * joCurvelet2D(32,32) - real transform (64-bit)
  * joCurvelet2D(32,32;real_crvlts=false) - complex transform (64-bit)
  * joCurvelet2D(32,32;all_crvlts=true) - real transform with curevelts at the finnest scales (64-bit)
  * joCurvelet2D(32,32;zero_finest=true) - real transform with zeros at the finnest scales (64-bit)
  * joCurvelet2D(32,32;DDT=Float64,real_crvlts=false) - complex transform with real 64-bit input for forward
  * joCurvelet2D(32,32;DDT=Float32,RDT=Float64,real_crvlts=false) - complex transform with just precision specification for curvelets
  * joCurvelet2D(32,32;DDT=Float32,RDT=Complex{Float64},real_crvlts=false) - complex transform with full type specification for curvelets (same as above)

**Notes**

  * if DDT:<Real for complex transform then imaginary part will be neglected for transpose/ctranspose
  * isadjoint test at larger sizes (above 128) might require reseting tollerance to bigger number.


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunctionConstructors/joCurvelet2D.jl#L43-L71' class='documenter-source'>source</a><br>

<a id='JOLI.joCurvelet2DnoFFT-Tuple{Integer,Integer}' href='#JOLI.joCurvelet2DnoFFT-Tuple{Integer,Integer}'>#</a>
**`JOLI.joCurvelet2DnoFFT`** &mdash; *Method*.



2D Curvelet transform (wrapping) over fast dimensions without FFT

```
joCurvelet2DnoFFT(n1,n2
            [;DDT=Complex{Float64},RDT=DDT,
             nbscales=#,nbangles_coarse=16,all_crvlts=false,real_crvlts=true,zero_finest=false])
```

**Arguments**

  * n1,n2 - image sizes
  * nbscales - # of scales (requires #>=default; defaults to max(1,ceil(log2(min(n1,n2))-3)))
  * nbangles_coarse - # of angles at coarse scale (requires #%4==0, #>=8; defaults to 16)
  * all_crvlts - curvelets at finnest scales (defaults to false)
  * real_crvlts - real transform (defaults to true) and requires real input
  * zero_finest - zero out finnest scales (defaults to false)

**Examples**

  * joCurvelet2DnoFFT(32,32) - real transform (64-bit)
  * joCurvelet2DnoFFT(32,32;real_crvlts=false) - complex transform (64-bit)
  * joCurvelet2DnoFFT(32,32;all_crvlts=true) - real transform with curevelts at the finnest scales (64-bit)
  * joCurvelet2DnoFFT(32,32;zero_finest=true) - real transform with zeros at the finnest scales (64-bit)
  * joCurvelet2DnoFFT(32,32;DDT=Float64,real_crvlts=false) - complex transform with complex 64-bit input for forward
  * joCurvelet2DnoFFT(32,32;DDT=Float32,RDT=Float64,real_crvlts=false) - complex transform with just precision specification for curvelets
  * joCurvelet2DnoFFT(32,32;DDT=Float32,RDT=Complex{Float64},real_crvlts=false) - complex transform with full type specification for curvelets (same as above)

**Notes**

  * real joCurvelet2DnoFFT passed adjoint test while either combined with joDFT, or with isadjont flag userange=true
  * isadjoint test at larger sizes (above 128) might require reseting tollerance to bigger number.


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunctionConstructors/joCurvelet2DnoFFT.jl#L44-L72' class='documenter-source'>source</a><br>

<a id='JOLI.joDCT-Tuple{Vararg{Integer,N} where N}' href='#JOLI.joDCT-Tuple{Vararg{Integer,N} where N}'>#</a>
**`JOLI.joDCT`** &mdash; *Method*.



Multi-dimensional DCT transform over fast dimension(s)

```
joDCT(m[,n[, ...]] [;DDT=Float64,RDT=DDT])
```

**Examples**

  * joDCT(m) - 1D DCT
  * joDCT(m,n) - 2D DCT
  * joDCT(m; DDT=Float32) - 1D DCT for 32-bit vectors
  * joDCT(m; DDT=Float32,RDT=Float64) - 1D DCT for 32-bit input and 64-bit output


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunctionConstructors/joDCT.jl#L32-L43' class='documenter-source'>source</a><br>

<a id='JOLI.joDFT-Tuple{Vararg{Integer,N} where N}' href='#JOLI.joDFT-Tuple{Vararg{Integer,N} where N}'>#</a>
**`JOLI.joDFT`** &mdash; *Method*.



Multi-dimensional FFT transform over fast dimension(s)

```
joDFT(m[,n[, ...]]
        [;centered=false,DDT=Float64,RDT=(DDT:<Real?Complex{DDT}:DDT)])
```

**Examples**

  * joDFT(m) - 1D FFT
  * joDFT(m; centered=true) - 1D FFT with centered coefficients
  * joDFT(m,n) - 2D FFT
  * joDFT(m; DDT=Float32) - 1D FFT for 32-bit input
  * joDFT(m; DDT=Float32,RDT=Complex{Float64}) - 1D FFT for 32-bit input and 64-bit output

**Notes**

  * if DDT:<Real then imaginary part will be neglected for transpose/ctranspose


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunctionConstructors/joDFT.jl#L62-L79' class='documenter-source'>source</a><br>

<a id='JOLI.joDict-Union{Tuple{Integer,JOLI.joAbstractLinearOperator}, Tuple{WDT}} where WDT<:Number' href='#JOLI.joDict-Union{Tuple{Integer,JOLI.joAbstractLinearOperator}, Tuple{WDT}} where WDT<:Number'>#</a>
**`JOLI.joDict`** &mdash; *Method*.



Dictionary operator composed from l-times replicated square JOLI operator

```
joDict(l::Int,op::joAbstractLinearOperator;
    weights::AbstractVector,name::String)
```

**Example**

```
a=rand(Complex{Float64},4,4);
w=rand(Complex{Float64},3)
A=joMatrix(a;DDT=Complex{Float32},RDT=Complex{Float64},name="A")
D=joDict(3,A) # basic dictionary
D=joDict(3,A;weights=w) # weighted dictionary
```

**Notes**

  * all operators must have the same # of rows (M)
  * all given operators must have same domain/range types
  * the domain/range types of joDict are equal to domain/range types of the given operators


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearOperatorConstructors/joCoreBlockConstructors/joDict.jl#L85-L103' class='documenter-source'>source</a><br>

<a id='JOLI.joDict-Union{Tuple{Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{WDT}} where WDT<:Number' href='#JOLI.joDict-Union{Tuple{Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{WDT}} where WDT<:Number'>#</a>
**`JOLI.joDict`** &mdash; *Method*.



Dictionary operator composed from different square JOLI operators

```
joDict(ops::joAbstractLinearOperator...;
    weights::AbstractVector,name::String)
```

**Example**

```
a=rand(Complex{Float64},4,4);
A=joMatrix(a;DDT=Complex{Float32},RDT=Complex{Float64},name="A")
b=rand(Complex{Float64},4,8);
B=joMatrix(b;DDT=Complex{Float32},RDT=Complex{Float64},name="B")
c=rand(Complex{Float64},4,6);
C=joMatrix(c;DDT=Complex{Float32},RDT=Complex{Float64},name="C")
# either
    D=joDict(A,B,C) # basic dictionary in function syntax
#or
    D=[A B C] # basic dictionary in [] syntax
w=rand(Complex{Float64},3)
D=joDict(A,B,C;weights=w) # weighted dictionary
```

**Notes**

  * all operators must have the same # of rows (M)
  * all given operators must have same domain/range types
  * the domain/range types of joDict are equal to domain/range types of the given operators


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearOperatorConstructors/joCoreBlockConstructors/joDict.jl#L14-L39' class='documenter-source'>source</a><br>

<a id='JOLI.joExtension-Union{Tuple{T,JOLI.EXT_TYPE}, Tuple{T}} where T<:Integer' href='#JOLI.joExtension-Union{Tuple{T,JOLI.EXT_TYPE}, Tuple{T}} where T<:Integer'>#</a>
**`JOLI.joExtension`** &mdash; *Method*.



1D extension operator 

joExtension(n,pad_type; pad_lower=0,pad_upper=0,DDT=Float64,RDT=DDT)

**Arguments**

  * n : size of input vector
  * pad_type : one of EXT_TYPE 

      * pad_zeros - pad signal with zeros
      * pad_border - pad signal with values at the edge of the domain
      * pad_periodic - periodic extension of the signal
  * pad_lower : number of points to pad on the low end index (keyword arg, default=0)
  * pad_upper : number of points to pad on the upper index (keyword arg, default=0)

**Examples**

  * joExtension(n,pad_zeros,pad_lower=10,pad_upper=10)

      * pads a n- length vector with 10 zeros on either side
  * joExtension(n,pad_periodic,pad_lower=10)

      * extends an n-length vector by its periodic extension starting at index 1
  * joExtension(n,pad_border,pad_upper=10)

      * extends a n-length vector so that x[n+1:n+10] = x[n]


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunctionConstructors/joExtension.jl#L40-L64' class='documenter-source'>source</a><br>

<a id='JOLI.joLinearFunctionAll' href='#JOLI.joLinearFunctionAll'>#</a>
**`JOLI.joLinearFunctionAll`** &mdash; *Function*.



joLinearFunction outer constructor

```
joLinearFunctionAll(m::Integer,n::Integer,
    fop::Function,fop_T::Function,fop_CT::Function,fop_C::Function,
    iop::Function,iop_T::Function,iop_CT::Function,iop_C::Function,
    DDT::DataType,RDT::DataType=DDT;
    fMVok::Bool=false,iMVok::Bool=false,
    name::String="joLinearFunctionAll")
```

Look up argument names in help to joLinearFunction type.

**Notes**

  * the developer is responsible for ensuring that used functions take/return correct DDT/RDT


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunction/constructors.jl#L4-L19' class='documenter-source'>source</a><br>

<a id='JOLI.joLinearFunctionCT' href='#JOLI.joLinearFunctionCT'>#</a>
**`JOLI.joLinearFunctionCT`** &mdash; *Function*.



joLinearFunction outer constructor

```
joLinearFunctionCT(m::Integer,n::Integer,
    fop::Function,fop_CT::Function, iop::Function,iop_CT::Function,
    DDT::DataType,RDT::DataType=DDT;
    fMVok::Bool=false,iMVok::Bool=false,
    name::String="joLinearFunctionCT")
```

Look up argument names in help to joLinearFunction type.

**Notes**

  * the developer is responsible for ensuring that used functions take/return correct DDT/RDT


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunction/constructors.jl#L62-L76' class='documenter-source'>source</a><br>

<a id='JOLI.joLinearFunctionFwd' href='#JOLI.joLinearFunctionFwd'>#</a>
**`JOLI.joLinearFunctionFwd`** &mdash; *Function*.



joLinearFunction outer constructor

```
joLinearFunctionFwd(m::Integer,n::Integer,
    fop::Function,fop_T::Function,fop_CT::Function,fop_C::Function,
    DDT::DataType,RDT::DataType=DDT;
    fMVok::Bool=false,
    name::String="joLinearFunctionAll")
```

Look up argument names in help to joLinearFunction type.

**Notes**

  * the developer is responsible for ensuring that used functions take/return correct DDT/RDT


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunction/constructors.jl#L94-L108' class='documenter-source'>source</a><br>

<a id='JOLI.joLinearFunctionFwdCT' href='#JOLI.joLinearFunctionFwdCT'>#</a>
**`JOLI.joLinearFunctionFwdCT`** &mdash; *Function*.



joLinearFunction outer constructor

```
joLinearFunctionFwdCT(m::Integer,n::Integer,
    fop::Function,fop_CT::Function,
    DDT::DataType,RDT::DataType=DDT;
    fMVok::Bool=false,
    name::String="joLinearFunctionFwdCT")
```

Look up argument names in help to joLinearFunction type.

**Notes**

  * the developer is responsible for ensuring that used functions take/return correct DDT/RDT


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunction/constructors.jl#L146-L160' class='documenter-source'>source</a><br>

<a id='JOLI.joLinearFunctionFwdT' href='#JOLI.joLinearFunctionFwdT'>#</a>
**`JOLI.joLinearFunctionFwdT`** &mdash; *Function*.



joLinearFunction outer constructor

```
joLinearFunctionFwdT(m::Integer,n::Integer,
    fop::Function,fop_T::Function,
    DDT::DataType,RDT::DataType=DDT;
    fMVok::Bool=false,
    name::String="joLinearFunctionFwdT")
```

Look up argument names in help to joLinearFunction type.

**Notes**

  * the developer is responsible for ensuring that used functions take/return correct DDT/RDT


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunction/constructors.jl#L118-L132' class='documenter-source'>source</a><br>

<a id='JOLI.joLinearFunctionT' href='#JOLI.joLinearFunctionT'>#</a>
**`JOLI.joLinearFunctionT`** &mdash; *Function*.



joLinearFunction outer constructor

```
joLinearFunctionT(m::Integer,n::Integer,
    fop::Function,fop_T::Function, iop::Function,iop_T::Function,
    DDT::DataType,RDT::DataType=DDT;
    fMVok::Bool=false,iMVok::Bool=false,
    name::String="joLinearFunctionT")
```

Look up argument names in help to joLinearFunction type.

**Notes**

  * the developer is responsible for ensuring that used functions take/return correct DDT/RDT


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunction/constructors.jl#L30-L44' class='documenter-source'>source</a><br>

<a id='JOLI.joMask-Tuple{BitArray{1}}' href='#JOLI.joMask-Tuple{BitArray{1}}'>#</a>
**`JOLI.joMask`** &mdash; *Method*.



Mask operator

```
joMask(mask[;DDT=Float64,RDT=DDT,makecopy=true])
```

**Arguments**

  * mask::BitArray{1} - BitArray mask of true indecies

**Examples**

  * mask=falses(3)
  * mask[[1,3]]=true
  * A=joMask(mask)
  * A=joMask(mask;DDT=Float32)
  * A=joMask(mask;DDT=Float32,RDT=Float64)


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunctionConstructors/joMask.jl#L35-L50' class='documenter-source'>source</a><br>

<a id='JOLI.joMask-Union{Tuple{Integer,Array{VDT,1}}, Tuple{VDT}} where VDT<:Integer' href='#JOLI.joMask-Union{Tuple{Integer,Array{VDT,1}}, Tuple{VDT}} where VDT<:Integer'>#</a>
**`JOLI.joMask`** &mdash; *Method*.



Mask operator

```
joMask(n,idx[;DDT=Float64,RDT=DDT])
```

**Arguments**

  * n::Integer - size of square operator
  * idx::Vector{Integer} - vector of true indecies

**Examples**

  * A=joMask(3,[1,3])
  * A=joMask(3,[1,3];DDT=Float32)
  * A=joMask(3,[1,3];DDT=Float32,RDT=Float64)


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunctionConstructors/joMask.jl#L4-L18' class='documenter-source'>source</a><br>

<a id='JOLI.joNFFT' href='#JOLI.joNFFT'>#</a>
**`JOLI.joNFFT`** &mdash; *Function*.



1D NFFT transform over fast dimension (wrapper to https://github.com/tknopp/NFFT.jl/tree/master)

```
joNFFT(N,nodes::Vector{Float64} [,m=4,sigma=2.0,window=:kaiser_bessel,K=2000;centered=false,DDT=Complex{Float64},RDT=DDT])
```

**Examples**

  * joNFFT(N,nodes) - 1D NFFT

**Notes**

  * NFFT always uses Complex{Float64} vectors internally
  * see https://github.com/tknopp/NFFT.jl/tree/master for docs for optional parameters to NFFTplan


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunctionConstructors/joNFFT.jl#L34-L46' class='documenter-source'>source</a><br>

<a id='JOLI.joRestriction-Union{Tuple{Integer,Array{VDT,1}}, Tuple{VDT}} where VDT<:Integer' href='#JOLI.joRestriction-Union{Tuple{Integer,Array{VDT,1}}, Tuple{VDT}} where VDT<:Integer'>#</a>
**`JOLI.joRestriction`** &mdash; *Method*.



Restriction operator

```
joRestriction(n,idx[;DDT=Float64,RDT=DDT,makecopy=true])
```

**Arguments**

  * n::Integer - number of columns
  * idx::AbstractVector{Int} - vector of indecies

**Exmaple**

  * A=joRestriction(3,[1,3])
  * A=joRestriction(3,[1,3];DDT=Float32)
  * A=joRestriction(3,[1,3];DDT=Float32,RDT=Float64)


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearFunctionConstructors/joRestriction.jl#L4-L18' class='documenter-source'>source</a><br>

<a id='JOLI.joStack-Union{Tuple{Integer,JOLI.joAbstractLinearOperator}, Tuple{WDT}} where WDT<:Number' href='#JOLI.joStack-Union{Tuple{Integer,JOLI.joAbstractLinearOperator}, Tuple{WDT}} where WDT<:Number'>#</a>
**`JOLI.joStack`** &mdash; *Method*.



Stack operator composed from l-times replicated square JOLI operator

```
joStack(l::Int,op::joAbstractLinearOperator;
    weights::AbstractVector,name::String)
```

**Example**

```
a=rand(Complex{Float64},4,4);
w=rand(Complex{Float64},3)
A=joMatrix(a;DDT=Complex{Float32},RDT=Complex{Float64},name="A")
S=joStack(3,A) # basic stack
S=joStack(3,A;weights=w) # weighted stack
```

**Notes**

  * all operators must have the same # of columns (N)
  * all given operators must have same domain/range types
  * the domain/range types of joStack are equal to domain/range types of the given operators


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearOperatorConstructors/joCoreBlockConstructors/joStack.jl#L85-L103' class='documenter-source'>source</a><br>

<a id='JOLI.joStack-Union{Tuple{Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{WDT}} where WDT<:Number' href='#JOLI.joStack-Union{Tuple{Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{WDT}} where WDT<:Number'>#</a>
**`JOLI.joStack`** &mdash; *Method*.



Stack operator composed from different square JOLI operators

```
joStack(ops::joAbstractLinearOperator...;
    weights::AbstractVector,name::String)
```

**Example**

```
a=rand(Complex{Float64},4,4);
A=joMatrix(a;DDT=Complex{Float32},RDT=Complex{Float64},name="A")
b=rand(Complex{Float64},8,4);
B=joMatrix(b;DDT=Complex{Float32},RDT=Complex{Float64},name="B")
c=rand(Complex{Float64},6,4);
C=joMatrix(c;DDT=Complex{Float32},RDT=Complex{Float64},name="C")
# either
    S=joStack(A,B,C) # basic stack in function syntax
# or
    S=[A; B; C] # basic stack in [] syntax
w=rand(Complex{Float64},3)
S=joStack(A,B,C;weights=w) # weighted stack
```

**Notes**

  * all operators must have the same # of columns (N)
  * all given operators must have same domain/range types
  * the domain/range types of joStack are equal to domain/range types of the given operators


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/joLinearOperatorConstructors/joCoreBlockConstructors/joStack.jl#L14-L39' class='documenter-source'>source</a><br>

<a id='JOLI.jo_check_type_match-Tuple{DataType,DataType,String}' href='#JOLI.jo_check_type_match-Tuple{DataType,DataType,String}'>#</a>
**`JOLI.jo_check_type_match`** &mdash; *Method*.



Check type match

```
jo_check_type_match(DT1::DataType,DT2::DataType,where::String)
```

The bahaviour of the function while types do not match depends on values of jo_type_mismatch_warn and jo_type_mismatch_error flags. Use jo_type_mismatch_error_set to toggle those flags from warning mode to error mode.

**EXAMPLE**

  * jo_check_type_match(Float32,Float64,"my session")


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L157-L170' class='documenter-source'>source</a><br>

<a id='JOLI.jo_complex_eltype-Tuple{DataType}' href='#JOLI.jo_complex_eltype-Tuple{DataType}'>#</a>
**`JOLI.jo_complex_eltype`** &mdash; *Method*.



Type of element of complex data type

```
jo_complex_eltype(DT::DataType)
```

**Example**

  * jo_complex_eltype(Complex{Float32})


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L108-L116' class='documenter-source'>source</a><br>

<a id='JOLI.jo_complex_eltype-Union{Tuple{Complex{T}}, Tuple{T}} where T' href='#JOLI.jo_complex_eltype-Union{Tuple{Complex{T}}, Tuple{T}} where T'>#</a>
**`JOLI.jo_complex_eltype`** &mdash; *Method*.



Type of element of complex scalar

```
jo_complex_eltype(a::Complex)
```

**Example**

  * jo_complex_eltype(1.+im*1.)
  * jo_complex_eltype(zero(Complex{Float64}))


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L97-L106' class='documenter-source'>source</a><br>

<a id='JOLI.jo_convert-Union{Tuple{DataType,AbstractArray{VT,N} where N,Bool}, Tuple{DataType,AbstractArray{VT,N} where N}, Tuple{VT}} where VT<:Integer' href='#JOLI.jo_convert-Union{Tuple{DataType,AbstractArray{VT,N} where N,Bool}, Tuple{DataType,AbstractArray{VT,N} where N}, Tuple{VT}} where VT<:Integer'>#</a>
**`JOLI.jo_convert`** &mdash; *Method*.



Convert vector to new type

```
jo_convert(DT::DataType,v::AbstractArray,warning::Bool=true)
```

**Limitations**

  * converting integer array to shorter representation will throw an error
  * converting float/complex array to integer will throw an error
  * converting from complex to float drops immaginary part and issues warning; use jo_convert_warn_set(false) to turn off the warning

**Example**

  * jo_convert(Complex{Float32},rand(3))


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L199-L213' class='documenter-source'>source</a><br>

<a id='JOLI.jo_convert-Union{Tuple{DataType,NT,Bool}, Tuple{DataType,NT}, Tuple{NT}} where NT<:Integer' href='#JOLI.jo_convert-Union{Tuple{DataType,NT,Bool}, Tuple{DataType,NT}, Tuple{NT}} where NT<:Integer'>#</a>
**`JOLI.jo_convert`** &mdash; *Method*.



Convert number to new type

```
jo_convert(DT::DataType,n::Number,warning::Bool=true)
```

**Limitations**

  * converting integer number to shorter representation will throw an error
  * converting float/complex number to integer will throw an error
  * converting from complex to float drops immaginary part and issues warning; use jo_convert_warn_set(false) to turn off the warning

**Example**

  * jo_convert(Complex{Float32},rand())


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L251-L265' class='documenter-source'>source</a><br>

<a id='JOLI.jo_convert_warn_set-Tuple{Bool}' href='#JOLI.jo_convert_warn_set-Tuple{Bool}'>#</a>
**`JOLI.jo_convert_warn_set`** &mdash; *Method*.



Set warning mode for jo_convert

```
jo_convert_warn_set(flag::Bool)
```

**Example**

  * jo_convert_warn_set(false) turns of the warnings


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L184-L192' class='documenter-source'>source</a><br>

<a id='JOLI.jo_set_iterative_solver4square-Tuple{Function}' href='#JOLI.jo_set_iterative_solver4square-Tuple{Function}'>#</a>
**`JOLI.jo_set_iterative_solver4square`** &mdash; *Method*.



Set default iterative solver for (jo,vec) and square jo

```
jo_set_iterative_solver4square(f::Function)
```

Where f must take two arguments (jo,vec) and return vec.

**Example (using IterativeSolvers)**

  * jo_set_iterative_solver4square((A,v)->gmres(A,v))


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L36-L46' class='documenter-source'>source</a><br>

<a id='JOLI.jo_set_iterative_solver4tall-Tuple{Function}' href='#JOLI.jo_set_iterative_solver4tall-Tuple{Function}'>#</a>
**`JOLI.jo_set_iterative_solver4tall`** &mdash; *Method*.



Set default iterative solver for (jo,vec) and tall jo

```
jo_set_iterative_solver4tall(f::Function)
```

Where f must take two arguments (jo,vec) and return vec.

**Example**

  * jo_set_iterative_solver4tall((A,v)->tall_solve(A,v))


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L56-L66' class='documenter-source'>source</a><br>

<a id='JOLI.jo_set_iterative_solver4wide-Tuple{Function}' href='#JOLI.jo_set_iterative_solver4wide-Tuple{Function}'>#</a>
**`JOLI.jo_set_iterative_solver4wide`** &mdash; *Method*.



Set default iterative solver for (jo,vec) and wide jo

```
jo_set_iterative_solver4wide(f::Function)
```

Where f must take two arguments (jo,vec) and return vec.

**Example**

  * jo_set_iterative_solver4wide((A,v)->wide_solve(A,v))


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L76-L86' class='documenter-source'>source</a><br>

<a id='JOLI.jo_type_mismatch_error_set-Tuple{Bool}' href='#JOLI.jo_type_mismatch_error_set-Tuple{Bool}'>#</a>
**`JOLI.jo_type_mismatch_error_set`** &mdash; *Method*.



Toggle between warning and error for type mismatch

```
jo_type_mismatch_error_set(flag::Bool)
```

**Examples**

  * jo_type_mismatch_error_set(true) turns on error
  * jo_type_mismatch_error_set(false) reverts to warnings


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L129-L138' class='documenter-source'>source</a><br>


<a id='Macros-1'></a>

## Macros

<a id='JOLI.@joNF-Tuple{Expr}' href='#JOLI.@joNF-Tuple{Expr}'>#</a>
**`JOLI.@joNF`** &mdash; *Macro*.



Nullable{Function} macro for given function

```
@joNF ... | @joNF(...)
```


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L23-L27' class='documenter-source'>source</a><br>

<a id='JOLI.@joNF-Tuple{}' href='#JOLI.@joNF-Tuple{}'>#</a>
**`JOLI.@joNF`** &mdash; *Macro*.



Nullable{Function} macro for null function

```
@joNF
```


<a target='_blank' href='https://github.com/slimgroup/JOLI.jl/tree/aeb55c984c7538bc0b737d867e8593989a8d714b/src/Utils.jl#L14-L18' class='documenter-source'>source</a><br>


<a id='Types-1'></a>

## Types


<a id='Index-1'></a>

## Index

- [`JOLI.joAddSolverAll`](REFERENCE.md#JOLI.joAddSolverAll-Union{Tuple{DDT}, Tuple{JOLI.joAbstractLinearOperator{DDT,RDT},Function,Function,Function,Function}, Tuple{RDT}} where RDT where DDT)
- [`JOLI.joAddSolverAny`](REFERENCE.md#JOLI.joAddSolverAny-Union{Tuple{DDT}, Tuple{JOLI.joAbstractLinearOperator{DDT,RDT},Function}, Tuple{RDT}} where RDT where DDT)
- [`JOLI.joBlock`](REFERENCE.md#JOLI.joBlock-Union{Tuple{Array{RVDT,1},Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{RVDT}, Tuple{WDT}} where WDT<:Number where RVDT<:Integer)
- [`JOLI.joBlockDiag`](REFERENCE.md#JOLI.joBlockDiag-Union{Tuple{Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{WDT}} where WDT<:Number)
- [`JOLI.joBlockDiag`](REFERENCE.md#JOLI.joBlockDiag-Union{Tuple{Integer,JOLI.joAbstractLinearOperator}, Tuple{WDT}} where WDT<:Number)
- [`JOLI.joCurvelet2D`](REFERENCE.md#JOLI.joCurvelet2D-Tuple{Integer,Integer})
- [`JOLI.joCurvelet2DnoFFT`](REFERENCE.md#JOLI.joCurvelet2DnoFFT-Tuple{Integer,Integer})
- [`JOLI.joDCT`](REFERENCE.md#JOLI.joDCT-Tuple{Vararg{Integer,N} where N})
- [`JOLI.joDFT`](REFERENCE.md#JOLI.joDFT-Tuple{Vararg{Integer,N} where N})
- [`JOLI.joDict`](REFERENCE.md#JOLI.joDict-Union{Tuple{Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{WDT}} where WDT<:Number)
- [`JOLI.joDict`](REFERENCE.md#JOLI.joDict-Union{Tuple{Integer,JOLI.joAbstractLinearOperator}, Tuple{WDT}} where WDT<:Number)
- [`JOLI.joExtension`](REFERENCE.md#JOLI.joExtension-Union{Tuple{T,JOLI.EXT_TYPE}, Tuple{T}} where T<:Integer)
- [`JOLI.joLinearFunctionAll`](REFERENCE.md#JOLI.joLinearFunctionAll)
- [`JOLI.joLinearFunctionCT`](REFERENCE.md#JOLI.joLinearFunctionCT)
- [`JOLI.joLinearFunctionFwd`](REFERENCE.md#JOLI.joLinearFunctionFwd)
- [`JOLI.joLinearFunctionFwdCT`](REFERENCE.md#JOLI.joLinearFunctionFwdCT)
- [`JOLI.joLinearFunctionFwdT`](REFERENCE.md#JOLI.joLinearFunctionFwdT)
- [`JOLI.joLinearFunctionT`](REFERENCE.md#JOLI.joLinearFunctionT)
- [`JOLI.joMask`](REFERENCE.md#JOLI.joMask-Tuple{BitArray{1}})
- [`JOLI.joMask`](REFERENCE.md#JOLI.joMask-Union{Tuple{Integer,Array{VDT,1}}, Tuple{VDT}} where VDT<:Integer)
- [`JOLI.joNFFT`](REFERENCE.md#JOLI.joNFFT)
- [`JOLI.joRestriction`](REFERENCE.md#JOLI.joRestriction-Union{Tuple{Integer,Array{VDT,1}}, Tuple{VDT}} where VDT<:Integer)
- [`JOLI.joStack`](REFERENCE.md#JOLI.joStack-Union{Tuple{Vararg{JOLI.joAbstractLinearOperator,N} where N}, Tuple{WDT}} where WDT<:Number)
- [`JOLI.joStack`](REFERENCE.md#JOLI.joStack-Union{Tuple{Integer,JOLI.joAbstractLinearOperator}, Tuple{WDT}} where WDT<:Number)
- [`JOLI.jo_check_type_match`](REFERENCE.md#JOLI.jo_check_type_match-Tuple{DataType,DataType,String})
- [`JOLI.jo_complex_eltype`](REFERENCE.md#JOLI.jo_complex_eltype-Tuple{DataType})
- [`JOLI.jo_complex_eltype`](REFERENCE.md#JOLI.jo_complex_eltype-Union{Tuple{Complex{T}}, Tuple{T}} where T)
- [`JOLI.jo_convert`](REFERENCE.md#JOLI.jo_convert-Union{Tuple{DataType,AbstractArray{VT,N} where N,Bool}, Tuple{DataType,AbstractArray{VT,N} where N}, Tuple{VT}} where VT<:Integer)
- [`JOLI.jo_convert`](REFERENCE.md#JOLI.jo_convert-Union{Tuple{DataType,NT,Bool}, Tuple{DataType,NT}, Tuple{NT}} where NT<:Integer)
- [`JOLI.jo_convert_warn_set`](REFERENCE.md#JOLI.jo_convert_warn_set-Tuple{Bool})
- [`JOLI.jo_set_iterative_solver4square`](REFERENCE.md#JOLI.jo_set_iterative_solver4square-Tuple{Function})
- [`JOLI.jo_set_iterative_solver4tall`](REFERENCE.md#JOLI.jo_set_iterative_solver4tall-Tuple{Function})
- [`JOLI.jo_set_iterative_solver4wide`](REFERENCE.md#JOLI.jo_set_iterative_solver4wide-Tuple{Function})
- [`JOLI.jo_type_mismatch_error_set`](REFERENCE.md#JOLI.jo_type_mismatch_error_set-Tuple{Bool})
- [`JOLI.@joNF`](REFERENCE.md#JOLI.@joNF-Tuple{Expr})
- [`JOLI.@joNF`](REFERENCE.md#JOLI.@joNF-Tuple{})

