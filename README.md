# FractionOperations

FractionOperations is a command line app that takes operations on fractions as input and produces a fractional
result.

It runs in "interactive mode", so runs continuously, handling any error and invalid input without crash till the user quits by typing "exit".
Legal operators are *, /, +, - (multiply, divide, add, subtract). Operands and operators can be separated by one or more spaces. Mixed numbers are represented by whole&amp;numerator/denominator; for example,
&quot;3&amp;1/4&quot;, “-1&amp;7/8”. Improper fractions, whole numbers, and negative numbers are allowed as operands.

It uses the Reverse Polish Notation to be able to perform operations from the user input correctly. The intermediate decimal result then converted to fraction result. That algorithm is fast but not the most accurate in some cases like 1/3, 2/3 etc., this is one limitation for now.
**The other limitation is that only 1 digit numbers can be entered as user inputs.** So e.g. 33&2/3 is not a valid input at the moment.

The solution is unit tested thoroughly, and can be found under "FractionOperationsTests".
