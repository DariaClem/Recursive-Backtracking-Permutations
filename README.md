### Computer system architecture :computer: 
# Recursive Backtracking generating minimum lexicographic permutations
**Assignment**: 

Given n, m and 3 · n elements that can be either 0, or between 1 and n, where 1 ≤ n, m ≤ 30, generate the smallest permutation in the lexicographic order of the set {1, ..., n}, where each element appears exactly 3 times, having a minimum distance of m elements between any two equal elements, starting from certain fixed points already specified.

It is requested to be displayed in the standard output the permutation or -1, in case it doesn't exist any permutation that satisfy all the conditions.

_Example:_

> _Input_

``` assembly
5 1 1 0 0 0 0 0 3 0 0 0 0 0 0 4 5
```

> _Output_

``` assembly
1 2 1 2 1 2 3 4 3 5 3 4 5 4 5
```
