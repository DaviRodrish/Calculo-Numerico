
function taylor(d::Vector{&lt;:Real}, x0::Real, x::Real)
    dx = Float64(x - x0)
    s = Float64(d[end])
    for k in (length(d)-1):-1:1
        s = Float64(d[k]) + (dx / k) * s
    end
    return s
end

taylor(d::Vector{&lt;:Real}, x0::Real, x::AbstractVector{&lt;:Real}) = [taylor(d, x0, xi) for xi in x]

d = [1]
x0 = 0
x = 1

println(taylor(d, x0, x))
