############################################################
# joLinearFunction - miscaleneous constructor-only operators 
############################################################

# FFT operators: joDFT
include("joLinearFunctionConstructors/joDFT.jl")

# DCT operators: joDCT
include("joLinearFunctionConstructors/joDCT.jl")

# NFFT operators: joNFFT
include("joLinearFunctionConstructors/joNFFT.jl")

# CurveLab operators: joCurvelet2D joCurvelet2DnoFFT
include("joLinearFunctionConstructors/joCurvelet2D.jl")
include("joLinearFunctionConstructors/joCurvelet2DnoFFT.jl")

# restriction operator
include("joLinearFunctionConstructors/joRestriction.jl")

# mask operator
include("joLinearFunctionConstructors/joMask.jl")

# Padding/extension operators: joExtension
include("joLinearFunctionConstructors/joExtension.jl")

# Permutation operator: joPermutation
include("joLinearFunctionConstructors/joPermutation.jl")

