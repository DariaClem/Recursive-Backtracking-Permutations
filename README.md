### Computer system architecture :computer: 
# Recursive Backtracking generating minimum lexicographic permutations

###### The language used is Assembly x86 AT&T syntax.
**Assignment**: 

Given n, m, and 3n elements that can be either 0 or between 1 and n, where 1 ≤ n, m ≤ 30, generate the smallest permutation in lexicographic order from the set {1, ..., n} such that each element appears exactly 3 times and has a minimum distance of m elements between any two equal elements, starting from certain fixed points already specified.

It is required to display the permutation in the standard output or -1 if no permutation satisfying all the conditions exists.
_Example:_

> _Input_

``` assembly
5 1 1 0 0 0 0 0 3 0 0 0 0 0 0 4 5
```

> _Output_

``` assembly
1 2 1 2 1 2 3 4 3 5 3 4 5 4 5
```
