#  julia_boiler_plate_tdd
Boiler plate test driven dev snippet for Julia

happens to be an implementation of N Queens for fun

--
`
function grow_or_throw(attempt::Vector{Int64},
    banned::Vector{Vector{Int64}})
    settings = get_settings()
    n        = settings.n
    if length(attempt) >= n
        return 0
    end
end
`
--
TODO tests

n = 0
attempt = []
banned = []
throw -1

n = 1
attempt = []
banned = []
grow [1]

n = 1
attempt = []
banned = [1]
throw -1


