function backtracking_line_search(f::Function,
                                  g::Function,
                                  x::Vector,
                                  dx::Vector,
                                  alpha::Float64,
                                  beta::Float64,
                                  max_iterations::Int64)
  
  # Keep track of the number of iterations.
  i = 0
  
  # Store a copy of the function and gradient evaluted at x.
  f_x = f(x)
  g_x = g(x)
  angle = (g_x' * dx)[1]
  
  # The default step-size is always 1.
  t = 1
  
  # Keep coming closer to x until we find a point that is as good
  # as the gradient suggests we can do.
  while f(x + t * dx) > f_x + alpha * t * angle
    t = beta * t
    
    i = i + 1
    
    if i > max_iterations
      error("Too many iterations in backtracking_line_search(alpha: $alpha, beta: $beta)")
    end
  end
  
  t
end

function backtracking_line_search(f::Function,
                                  g::Function,
                                  x::Vector,
                                  dx::Vector,
                                  alpha::Float64,
                                  beta::Float64)
  backtracking_line_search(f, g, x, dx, alpha, beta, 1000)
end

function backtracking_line_search(f::Function,
                                  g::Function,
                                  x::Vector,
                                  dx::Vector)
  backtracking_line_search(f, g, x, dx, 0.1, 0.8, 1000)
end
