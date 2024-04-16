#  julia_boiler_plate_tdd
Boiler plate test driven dev snippet for Julia

happens to be an implementation of N Queens for fun

--


```
function grow_or_throw(attempt::Vector{Int64},
    banned::Vector{Vector{Int64}})
    settings = get_settings()
    n        = settings.n
    if length(attempt) >= n
        return -1
    end
end
```


--
TODO tests

```
n = 0
attempt = []
banned  = []
output  -1

n       = 1
attempt = []
banned  = []
output [1]

n       = 1
attempt = []
banned  = [1]
output -1

n = 4
attempt = [2,4,1]
banned  = []
output  = [2,4,1,3]

n       = 4
attempt = [3,1,4]
banned  = []
output  = [3,1,4,2]

n       = 4
attempt = [2,4,1]
banned  = [2,4,1,3]
output  = -1

n       = 5
attempt = [2,4,1,3]
banned  = [2,4,1,3,5]
output  = -1

n       = 5
attempt = [3,1,4,2]
banned  = []
output  = [3,1,4,2,5]

```