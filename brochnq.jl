#			0 LIBS

using Test

#			1 STRUCTS

struct Settings
	n::Int64
	testing::Bool
end

# 			2 SET

function set_n()
	n::Int64	= 5
	return n
end

function set_testing()
	testing::Bool   = true # false
end

# 			3 GET

function get_settings()
	n	    = set_n()
	testing     = set_testing()
	settings    = Settings(n, testing)
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

#			5 VIEW

#			6 CONTROL

function main()
	settings    = get_settings()
	n           = settings.n
	attempt     = init_attempt(n)

end

main()

# 			7 TESTS

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
		test_set_testing()
		println("passed all tests")
	else
         	println("not testing - see flag")
	end
end

all_tests()


