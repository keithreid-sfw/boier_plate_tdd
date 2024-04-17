                                             # do not write past close bracket ]
#			0 LIBS

using Test

#			1 STRUCTS

struct Settings
	n::Int64
	testing::Bool
	verbose::Bool
end

# 			2 SET

function set_n()
	n::Int64	= 5
	return n
end

function set_testing()
	testing::Bool   = false # true # false
end

function set_verbose()
	verbose::Bool   = false # true
	return verbose
end

# 			3 GET

function get_settings()
	n	    = set_n()
	testing     = set_testing()
	verbose     = set_verbose()
	settings    = Settings(n, testing, verbose)
	return settings
end

#			4 MODEL

function init_attempt(n::Int64)
	attempt::Vector{Int64} = [1]
	if n == 0
		attempt = []
	else
		attempt = [1]
	end
	return attempt
end

function init_solutions()
	solutions::Vector{Vector{Int64}} = []
	return solutions
end

function maybe_add_solution(attempt::Vector{Int64}, 
		solutions::Vector{Vector{Int64}},
		settings::Settings)
	n = settings.n
	attempt_appendage = [attempt]
	if length(attempt) == n
		solutions = vcat(solutions, attempt_appendage)
	end
	return solutions
end
	

#			5 VIEW

function maybe_intro()
	settings = get_settings()
	if settings.verbose
		println("Hello and welcome to this N Queens.")
		println("It is a kata and it is written to give me a boiler plate TDD template.")
		println("If you can see this then settings.verbose is flagged as true.")
		println("The variable n is set as ", settings.n)
	end
end

#			6 CONTROL

function main()
	settings    = get_settings()
	n           = settings.n
	attempt     = init_attempt(n)
	maybe_intro()
end

main()

# 			7 TESTS

function test_maybe_add_solution()
	solutions       = init_solutions()
	settings        = Settings(4, true, false)
	attempt         = [2,4,1,3]
	new_solutions   = maybe_add_solution(attempt,
					 solutions, 
					 settings)
	if settings.verbose
		println("old ", solutions, " new ", new_solutions)
	end
	@test length(new_solutions) == 1

 	solutions       = init_solutions()
	settings        = Settings(4, true, false)
	attempt         = [2,4,1]
	new_solutions   = maybe_add_solution(attempt,
					 solutions, 
					 settings)
	if settings.verbose
		println("old ", solutions, " new ", new_solutions)
	end
	@test length(new_solutions) == 0

	solutions       = [[2,4,1,3]]
	settings        = Settings(4, true, false)
	attempt         = [3,1,4,2]
	new_solutions   = maybe_add_solution(attempt,
					 solutions, 
					 settings)
	if settings.verbose
		println("old ", solutions, " new ", new_solutions)
	end
	@test length(new_solutions) == 2
	@test new_solutions == [[2,4,1,3],[3,1,4,2]]

 	solutions       = init_solutions()
	settings        = Settings(1, true, false)
	attempt         = [1]
	new_solutions   = maybe_add_solution(attempt,
					 solutions, 
					 settings)
	if settings.verbose
		println("old ", solutions, " new ", new_solutions)
	end
	@test new_solutions == [[1]]

	println("passed maybe add solution")

end

function test_init_attempt()
	n = 0
	attempt = init_attempt(n)
	@test attempt == []
	n = 1
	attempt = init_attempt(n)
	@test attempt == [1]
	n = 2
	attempt = init_attempt(n)
	@test attempt == [1]
	n = 16
	attempt = init_attempt(n)
	@test attempt == [1]
	@test typeof(attempt) == Vector{Int64}
	println("passed init attempt")
end

function test_get_settings()
	settings    = get_settings()
	@test typeof(settings.n) == Int64
	@test typeof(settings.testing) == Bool
	println("passed get settings")
end

function test_set_testing()
	testing		= set_testing()
	@test typeof(testing) == Bool
	println("passed get testing")
end

function all_tests()
	testing 	= set_testing()
	if testing
		test_init_attempt()
		test_get_settings()
		test_maybe_add_solution()
		test_set_testing()
		println("passed all tests")
	else
         	println("not testing - see flag")
	end
end

all_tests()

function grow_or_throw(n::Int64,
			attempt::Vector{Int64},
    			banned::Vector{Vector{Int64}})
    if length(attempt) >= n
        return -1
    end
end

function test_grow_or_throw()

	n       = 0    # null
	attempt = []
	banned  = []
	output  = -1

	n       = 1     # singleton before first instance
	attempt = []
	banned  = []
	output  = [1]

	n       = 1     # singleton after instance means ban
	attempt = []
	banned  = [1]
	output  = -1

	n       = 4              # ##1#  ##1#
	attempt = [2,4,1]        # 2###  2###
	banned  = []             # ####  ###3
	output  = [2,4,1,3]      # #4##  #4##

	n       = 4              # #1##  #1##
	attempt = [3,1,4]        # ####  ###2
	banned  = []             # 3###  3###
	output  = [3,1,4,2]      # ##4#  ##4#

	n       = 4              # ##1#  ####
	attempt = [2,4,1]        # 2###  ####
	banned  = [2,4,1,3]      # ####  ####
	output  = -1             # #4##  ####

	n       = 5              # ##1## #####
	attempt = [2,4,1,3]      # 2#### #####
	banned  = [2,4,1,3,5]    # ###3# #####
	output  = -1             # #4### #####
                            # ##### #####

	n       = 5              # #1### #1###
	attempt = [3,1,4,2]      # ###2# ###2#
	banned  = []             # 3#### 3####
	output  = [3,1,4,2,5]    # ##4## ##4##
end                         # ##### ####5

#test_grow_or_throw()

function rising_diagonal_shadow(attempt::Vector{Int64}, 
				n::Int64)
	attempt_length = length(attempt)
	println("attempt",attempt)
	range          = collect(1:attempt_length)
	println("range", range)
	rev_range      = reverse(range)
	println("rev_range", rev_range)
	shadow         = attempt .- rev_range
	println("shadow", shadow)
	shadow_in_bounds = [x for x in shadow if 0 < x < n+1]
	println("shadow in bounds", shadow_in_bounds)
	return shadow_in_bounds
end

function test_rising_diag_shadow()
	n       = 4
	
	attempt = [1]
	rds     = rising_diagonal_shadow(attempt, n)
	@test rds == []

	attempt = [2]
	rds     = rising_diagonal_shadow(attempt, n)
	@test rds  == [1]

	attempt = [3]	
	rds     = rising_diagonal_shadow(attempt, n)
	@test rds == [2]

	attempt = [4]
	rds     = rising_diagonal_shadow(attempt, n)
	@test rds == [3]

	attempt = [2,4]
	rds     = rising_diagonal_shadow(attempt, n)
	@test rds == [3]

  #    x
  #  #/
  #  2#
  #  ##3
  #  #4

	attempt = [2,4,1]
	rds     = rising_diagonal_shadow(attempt, n)
	@test rds == [2]

  #   xx
  # #/1
  # 2##2
  # ##/
  # #4#
  
	println("passed rising diagonal shadow")

end

test_rising_diag_shadow()

function falling_diagonal_shadow(attempt::Vector{Int64}, 
				n::Int64)
end


function test_falling_diagonal_shadow()
	n       = 4
	
	attempt = [1]
	fds     = falling_diagonal_shadow(attempt, n)
	@test fds == [2]

	attempt = [2]
	fds     = falling_diagonal_shadow(attempt, n)

	attempt = [3]	
	fds     = falling_diagonal_shadow(attempt, n)

	attempt = [4]
	fds     = falling_diagonal_shadow(attempt, n)
	
	attempt = [2,4]
	fds     = falling_diagonal_shadow(attempt, n)

	attempt = [2,4,1]
	fds     = falling_diagonal_shadow(attempt, n)
	println("passed falling diagonal shadow")

end

#test_falling_diagonal_shadow()





