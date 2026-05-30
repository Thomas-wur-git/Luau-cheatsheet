--!nocheck
-- Ignore this thing :P

-- //
-- ## Preamble
-- //

-- In lua, comments are indicated with "--", as can be seen before all the blah blah
-- There is also an alternate notation for block comments (instead of having "--" on every line)

--[[

	everything in between "--[\[" and "]\]" is a comment
	(ignore the \, without them, lua ends the block comment, and that creates a syntax error)

]]

-- //
-- ## The beginning
-- //

local num = 1 -- Variable declaration. "local" is optional, but in practice, I basically always include it. Explained in the ## Scope section
num = 2

num = num + 1
num += 1 -- luau only

print(num) --> 4


-- Other types of values
local bool = true -- or false
local some_text = "string" -- " and ' are equivalent in lua, you can use either


-- //
-- ## If statments and booleans
-- //

if true then
	-- The code here is executed
end


local IsNumSmall = num < 5 -- num < 5 is an expression that lua evaluates to a boolean. IsNumSmall will be "true" (boolean, not a string)
print(IsNumSmall) --> true

local BigNum = 0 -- I initialize my variable to 0, explanation in the ## Scope section
if IsNumSmall then BigNum = 50 end -- The way the code is formatted in lua doesn't affect how the code is executed. You can format and write it as messy as you want, lua wont care


-- Without much surprise, the inequation can go directly in the if statement
if BigNum < 5 then
	-- ...
else -- And else statements work like this
	print(BigNum) --> 50
end


if false then
	-- ...
elseif BigNum > 5 then -- And else if statements like this
	-- ...
else
	-- This is where this particular if statement leads
end


-- // Booleans

-- The keyword "not" inverts the boolean. not true -> false, and not false -> true
print(not true) --> false
print(not false) --> true

-- So, if we do the following, (BigNum < 5) is evaluated to false, but with the "not", it becomes true
-- (The parenthesies are needed, otherwise lua thinks that we're doing (not BigNum) < 5, which isn't actullay an error... Until lua tries to do (false < 5) ...)
if not (BigNum < 5) then
	print("Hello!") -- This print is executed
end


print(not BigNum) --> false

-- What is happening here is, when lua has to transform some value into a boolean (to calculate the result of a not, or the condition of an if statement, etc)
-- EVERYTHING that isn't "false" or "nil" is treated as being "true"

if BigNum then
	print("BigNum is neither 'nil', nor 'false'!")
end

BigNum = nil -- nil is a value in lua that represents the "absence" of value. Often used when something doesn't exist, for example, the character of a player that hasn't spawned in yet

if BigNum then
	-- The code in here isn't executed
end

if BigNum == nil then
	print("BigNum is 'nil' :O")
end

-- The other conditional operators are ==, ~= (which is != in most other languages), <=, >=

-- There are two other keywords similar to "not"
-- "or" returns the first element if it isn't "nil" or "false". Otherwise, returns the second element

local OrResult = false or "Hello!"
print(OrResult) --> "Hello!"

print(BigNum or "BigNum is not defined!") --> "BigNum is not defined!"

BigNum = 50

print(BigNum or "BigNum is not defined!") --> 50

-- The other keyword is "and"
-- "and" returns the first element if it's either "nil" or "false" (the inverse of "or")

local AndResult = false and "Hello!"
print(AndResult) --> "false"

print(BigNum and "BigNum is defined!") --> "BigNum is defined!"

BigNum = nil

print(BigNum and "BigNum is defined!") --> "nil"

-- A very common usage of these operators are for a "ternary operator", where, depending on a boolean, value A is returned, or value B is returned

local cond = true
local val1 = 1
local val2 = 2

-- If cond is "false", (cond and val1) is evaluated to "false"
-- Then, (false or val2) is evaluated to val2
--
-- If cond is "true", (cond and val1) is evaluated to "val1"
-- Then, (val1 or val2) is evaluated to val1 (***)
local val = cond and val1 or val2

print(val) --> 1

-- (***) If val1 is "false" or "nil", (val1 or val2) will be evaluated to val2!!!
-- Generally, this is unexpected behaviour (our "ternary operator" isn't quite a true "ternary operator"). This is something to keep in mind

-- For this reason, luau added an explicit syntax for ternary operators

-- Luau only!
val = if cond then val1 else val2 -- It might look like an if statment, but it isn't one. It's special syntax

-- In other languages, the ternary operator is generally cond ? val1 : val2
-- In python, it's val1 if cond else val2 (arghghgh what is thiss messs)


-- //
-- ## Scope
-- //

-- "scope" refers to regions of code, for example, the inside of an if statment is the scope of that if statment
-- "local" variabels follow the rule where, the variable is accessible in "higher" scopes, but not in "lower" scopes.
-- It can be seen with the indentation (higher or lower), or another way to see it, the scope of an if statement that is defined in the scope of
-- a particular variable, is part of the scope of that variable.

-- It's probably easier to just look at examples...

local Outside = "ye"

if true then
	print(Outside) --> "ye"

	local Inside1 = "ya"
	Inside2 = "yaaa" -- Here, I declare the variable without using "local", it's a global variable declaration
end

print(Inside1) --> nil (This doesn't cause an error, lua treats undefined variables as "nil")
print(Inside2) --> "yaaa". Since the variable was declared globally, I can access it outside the if statement


-- In practice, I baliscally never use "global" variable declaration. Reasons are valid but somewhat nitpicky, anyway, it's preferable to avoid it. You can search what those reasons are online
-- You can avoid the use of "global" variables by doing the following

local Inside3 -- Here, I declare the variable, but without assigning any value to it. By default, its value will be nil. You can but a default value if you want
if true then
	Inside3 = "yeeehaa"
end

print(Inside3) --> "yeeehaa"


-- In python, scope rules are different. I can't say how so, because I myself don't understand them (and I never really took the time to understand them)

-- Other thing.
do
	-- Equivalent to "if true then [...] end"
	-- This thing isn't useless, but it's basically useless
end


-- //
-- ## Loops
-- //

-- There are 3 types of loops in lua

num = 0

-- The while loop
while num < 3 do
	num = num + 1
	print(num) --> 1, then 2, then 3

	-- Be careful with loops, it is very easy to accidently freeze your program...
end

-- The repeat loop (very similar, but the condition is evaluated after the "body" of the loop was executed. And the condition is like, inverted)
-- Well, it reads like english
-- This type of loop is rarely used

num = 0

repeat
	num = num + 1
	print(num) --> 1, 2, 3, like before
until num == 3

-- And finaly the foor loop, which have a less intuitive notation

-- We define our variable i, then we tell it to go until 3
for i = 1, 3 do
	print(i) --> 1, 2, 3 (unlike python and other 0 based indexing languages, it doesn't stop at 2)
end

-- By default, i goes in steps of 1, but it is possible to specify that step
-- The step is given by the third number, like this

for i = 1, 3, 0.5 do
	print(i) --> 1, 1.5, 2, 2.5, 3
end

-- There is another form of for loop, to iterate over tables, and stuff

list = {"a", "b", "c"} -- This is how we define tables. See section ## Tables

-- For now, no need to know what ipairs does, other than, it takes the array, and returns every value (with its index, aka, the position in the table)
-- Ipairs is explained in the ## Tables section

-- i is for "index", v is for "value"
for i, v in ipairs(list) do
	-- (if you give more than 1 argument to the function "print", it will print each argument next to eachother)
	print(i, v) --> 1, "a" then, 2, "b", then 3, "c"
end
-- Unline python and other 0 based indexing languages, the first position in the table is "1", and not "0"

-- Complement on for loops: https://create.roblox.com/docs/tutorials/fundamentals/coding-4/intro-to-for-loops


-- There are 1, (or 2) keywords for loops, "break" and "continue" ("continue" only exists in luau)

local i = 0
while true do
	i += 1
	local v = list[i]

	if v == "b" then break end -- "Break", breaks the loop. The execution of the code exists directly the loop. Works the same way with for loops
	print(v) --> "a", and that's it
end

-- continue is only valid in luau
for i, v in ipairs(list) do
	if i < 3 then continue end -- "Continue", stops the execution of the loop, to go back to its start (in a for loop, it'll go to the next index, in a while loop, it'll go back to evaluating the condition)
	print(v) --> "c", and that's it
end

-- //
-- ## Tables
-- //

-- This is how you declare a table

local tab1 = {true, false, "and an impastar"}

-- To index a table, the main notation is [index]

print(tab1[1]) --> true (the first value is at index 1, instead of being at index 0 like python or most other languages)
print(tab1[2]) --> false
print(tab1[3]) --> "and an impastar"

-- Tables in lua return nil, if you index a value that doesn't exist

print(tab1[0]) --> nil
print(tab1[-1]) --> nil
print(tab1[10]) --> nil


-- Tables in lua are very generalized, as the index can be literally anything

print(tab1["A key impastar"]) --> nil

-- We can explicitly define the index, using one of the following methods
-- (In the example of tab1, I didn't specify the indexes, so 1, 2 and 3 were given by default)
local tab2 = {a = 1, ["b"] = 0.5}
tab2.c = 3
tab2["d"] = 4

-- These different notations are all equivalent
print(tab2["a"]) --> 1
print(tab2.b) --> 0.5

-- The last two insert the value after the table was created.
-- The notation with the dot only works with string indexes, and only string indexes that don't have spaces or any wierd characters
-- The [ ] notation also allows the use of a variable's value as the index

local Index = "a"
print(tab2[Index]) --> 1

-- And when I said you could use literally anything as the index, I meant, literally, any thing

tab2[tab1] = "Other programming languages generally don't allow this"
tab2[tab2] = "and this is just cursed..."

-- Here, I've used the tables themselves as the index (if I had to guess, I'd guess lua uses the memory adress of the tables as the "identifier"?)

print(tab2[tab1]) --> "Other programming languages generally don't allow this"
print(tab2[tab2]) --> "and this is just cursed..."

-- To remove an entry in a table, set its value to nil

tab2[tab1] = nil
tab2[tab2] = nil


-- An oddity with lua tables are that, they're an amalgamation of an array, and a dictionary (aka a hashmap)

-- Arrays are lists, where the index starts at 1, and successive values are at the next index
-- When you declare your table without explicitly giving the indicies (like tab1), lua creates an array

-- Everything that isn't part of the array is part of the dictionary. So, index of -1, string index, etc

local tab3 = {
	[1] = "a",
	[2] = "b",
	[-1] = "c",
	[3] = "d",
	[5] = "e",
	[true] = "f",
}

-- This distinction between the two parts of the table is important, since that changes how we treat the table

-- In this case, the array part is [1] = "a", [2] = "b" and [3] = "c". [5] = "e" is not part of the array, because [4] is nil. Arrays cannot have "holes"
-- Every other [index] = value pair are part of the "dictionary"

-- To get the length of a table, you can use #. But this only works on the "array" par of the table!

print(#tab3) --> 3

-- To get the "full" length of a table, you have to calculate it manually (which I do in the ## Functions section)

-- To iterate over every index value pair of the table, we can use ipairs and pairs, like this

-- ipairs only acts on the array aprt. How it works is that it starts at i = 1, returns the first index value pair, then goes to i = 2, ..., until it stumbles onto a nil value (which would be i = 4 here)
-- If i = 1 is nil, the inside of the for loop wont be executed
for i, v in ipairs(tab3) do
	print(i, v ) --> 1, "a"; 2, "b"; 3, "d"
end

-- pairs act on everything, but doesn't garantee the order in which it does
-- (The order in which you define the values when creating a table isn't important, nor has any effect, at least, I don't think it does)
for i, v in pairs(tab3) do
	print(i, v) --> 1, "a"; 2, "b", ..., true, "f"; -1, "c"
end


-- lua has many default libraries, such as "math", "string", "table", etc
-- Explanations about these libraries is in the ## Functions and ## Libraries sections
-- For the "table" library, there are many functions that only act on the array part of the table
-- Documentation for the "table" library: https://create.roblox.com/docs/reference/engine/libraries/table (might be a bit different in lua 5.1)

local tab4 = {}

-- Default libraries are accessible without doing any "import" or whatever
table.insert(tab4, "a")
table.insert(tab4, "b") -- By default, it inserts at the end of the list

for i, v in ipairs(tab4) do print(i, v) end --> 1, "a"; 2, "b"

table.insert(tab4, 1, "c") -- It is also possible to specify the index where we want to insert the element. The other elements are pushed to the next index

for i, v in ipairs(tab4) do print(i, v) end --> 1, "c"; 2, "a"; 3, "b"

table.remove(tab4) -- Removes the last element
table.remove(tab4, 1) -- Removes the element at index 1, and shifts the element that was at i = 2, to i = 1

for i, v in ipairs(tab4) do print(i, v) end --> 1, "a"


-- //
-- ## Functions
-- //

-- There are many ways to define functions

-- Rarely used notation, but it shows really well how a function is just a "value", that we assign to a variable
local foo = function()

end

-- This is the most common notation. It is entirely equivalent to the other one
local function foo()

end

--

local function Add(a, b)
	return a + b
end

local function FloorDivision(divident, divisor)

	local quotient = divident//divisor -- The // operator is a "floor division" (7//3 = 2), the decimal values are wiped. Not available in lua 5.1 (but is available in lua 5.3+ and luau). The alternatie is math.floor(7/3)
	local reminder = divident % divisor -- The reminder of the division

	return quotient, reminder -- It is possible to return multiple values, by seperating them with a comma
end

print(Add(1, 2)) --> 3

-- Declaring 2 variables at once (since the function returns two variables)
local q, r = FloorDivision(7, 3)
print(q, r) --> 2, 1


-- Add is just like a variable, only difference is that its value is a function

print(Add) --> [lua 5.5]: function: 0x55fd2ee636c0 (it's the memory address of the function);
			  --> [luau]: <function> (bruh. Need to do print(tostring(Add)) for luau to show the memory address)

-- What lua does is, when you put () after a variable, lua tries to call that variable. If the value of the variable is a function, it works as expected.
-- But if the value of the variable is, for example, a string, you'll have this error: test.lua:8: attempt to call a string value

-- But you don't actually need it to be a variable, for lua to try to call it

-- This is a bit of a monstrocity, and you'll basically never see it (other than in my own code...)
-- What happens here is that, I define a function, suround it with parentheses (otherwise lua complains with a syntax error),
-- and then, I call it with (). What the functions returns is assigned to the variable a
local a = (function()
	local sum = 0
	for i = 1, 100 do sum += i end

	return sum
end)()

print(a) --> 5050

--[[

	-- This is a value, which is a function. We could assign it to a variable, but you don't actually need to
	(function()

	end)

	-- By adding () after the function, we try to call that function. The function is thus executed
	(function()

	end)()

	-- However, for lua to evaluated that expression (without a syntax error), we need to do this

	local a = (function()

	end)()

]]

-- Note that I've never assigned a variable to that function, it doesn't have a name
-- That's what we call an "anonymous funtion"
-- Here is a typical usage of said anonymous funtions

local function DoSomething(callback)

	-- ... Do an http request or whatever
	-- The way http requests are made in lua depends on the runtime (love2d, luvit, lune, or random C/C++ program that embeds lua)
	-- The way threads work (which allow the code to do something else during the http request) can also be dependant on the "runtime". Lua has coroutines, but I don't cover them in this document

	local result = "418 I'm a teapot" -- Result of the http request

	-- Callback is a variable that contains a function as its value
	callback(result)
end

-- We directly pass the funtion as an argument. We could assign the function to a variable first, and pass that variable, but it's more verbose
DoSomething(function(result)
	print(result) --> "418 I'm a teapot"
end)

-- Anonymous functions in lua are similar to Java (Runnable interface). What is nice in lua is that they use the same notation as normal functions (if you use the first notation shown at the beginning of this section)
-- In python, anonymous functions are writen with a special syntax (lambda: blahblah), and they are much more limited


--


-- Functions are very very often put inside tables

local Utils = {}

-- We can directly assing a function to an index in the table. The function is never assigned to a variable. (Though we don't call it an anonymous function? Perhaps because it kind of has a name, the index in the table)
Utils.GetDictLength = function(dict)
	local length = 0
	for i, v in pairs(dict) do length += 1 end -- Using pairs to count the number of elements. i and v are never used

	return length
end

-- We access the function, Utils.GetDictLength, and we call it
-- tab3 was the array/dict mixed table (#tab3 was equal to 3)
local Length = Utils.GetDictLength(tab3)
print(Length) --> 6


-- Another notation, much more common, but entirely equivalent, is:
-- (These notations are like "syntactic sugar". It's more pretty, but they are less descriptive of what really happens under the hood)

-- (No local here, since this isn't a variable declaration)
function Utils.GetArrayLength(array)
	return #array
end

print(Utils.GetArrayLength(tab3)) --> 3

-- You can also put the functions inside the table while declaring said table

local tab5 = {
	function()
		print("Function 1")
	end,
	a = function()
		print("Function 2")
	end,
	["b"] = function()
		print("Function 3")
	end,
}

-- I didn't specify the index for function 1, lua gave it the index of 1, just like in the ## Tables section
tab5[1]() --> it'll print "Function 1"
tab5.b() --> it'll print "Function 3"

-- This is how lua libraries are structured. See the ## Libraries section

print(math.floor(2.5)) -- 2

-- math is a table, math.floor is your function, at the index "floor", in the table

local floor = math.floor
print(floor(3.9)) --> 3

if false then
	-- In theory, if math was a table, we should be able to do this right?
	math.HELLO = 1
	-- In theory, yes, but in practice, (with luau): /home/chilly28/Sync/Code/rand/cheatsheet:489: attempt to modify a readonly table
	-- The table was "frozen" (see table.freeze()), such that, we aren't allowed to modify it
	-- Thus why this bit of code is in an if statement that'll never run, otherwise, this would throw an error

	-- However, in lua, you can do this without any issue :P
end


--


-- A more advance usage of anonymous functions, is signals
-- Here, I've written a little code example, that (crudely) replicates Roblox's signal api

local SignalModule = {}

-- SignalModule.New() is like a "constructor", it creates, and returns, a table, kind of equivalent to an "object", which is our signal
function SignalModule.New()
	local Signal = {}

	local ConnectedFunctions = {}

	function Signal.Fire()
		-- Here we clone the function list, and clear it (table.clear resets the table to an empty one)
		-- This is to avoid sneeky bugs, that could appear when one of the connected functions intereacts with the signal, in its callback
		local FuncList = table.clone(ConnectedFunctions)
		table.clear(ConnectedFunctions)

		for _, f in ipairs(FuncList) do
			-- Here, it's preferable to create a new thread (either with the coroutine library, or whatever thread implementation your "runtime" has)
			-- Doing so prevents errors in the callback funtions from propagating everywhere else, and also allows it to yield, ...
			f()
		end
	end

	function Signal.Connect(func)
		-- Inserts the function in the list
		table.insert(ConnectedFunctions, func)
	end

	return Signal
end

-- We create a new signal "object"
local Signal = SignalModule.New()

-- We connect some functions to that signal
Signal.Connect(function()
	print("First connection!")
end)

Signal.Connect(function()
	print("Second connection!")
end)

-- And then we execuate all those connected functions
Signal.Fire()  --> First connection!
					--> Second connection!

-- Signals are really useufl in games, for example, if you have a player that joined (signal), when a player dies (signal), or when a round ends (signal)
-- It also isn't hard (once you know how...) to modify the code, such that an arbitrary amount of arguments can be passed to Signal.Fire(arg1, arg2), which will then be sent to the connected functions


-- And here is another somewhat unrelated example

local function TweenUi(Distance, EasingStyle)

	-- This example isn't great, because I'm not in a game engine.
	-- Normally, you'd update the position prior to the frame being rendered. The alpha is calculated
	-- using the computer's clock (that way, if there is 0.01 second between frame 1 and 2, but 0.02 seconds
	-- between frame 2 and 3 (aka, lag), the animation way remain constant in time)
	for a = 0, 1, 0.1 do
		local Position = Distance * EasingStyle(a)
		print("Ui is at position "..Position.." at time "..a) -- .. is used to "concatenate" strings togheter, unlike + in python
	end

	-- Result: (the ugly numbers is because floating point inprecision...)
	-- The animation starts slowly, then picks up speed at the end
	--[[
		Ui is at position 0 at time 0
		Ui is at position 0.010000000000000002 at time 0.1
		Ui is at position 0.08000000000000002 at time 0.2
		Ui is at position 0.27000000000000013 at time 0.30000000000000004
		Ui is at position 0.6400000000000001 at time 0.4
		Ui is at position 1.25 at time 0.5
		Ui is at position 2.16 at time 0.6
		Ui is at position 3.4299999999999993 at time 0.7
		Ui is at position 5.119999999999999 at time 0.7999999999999999
		Ui is at position 7.289999999999997 at time 0.8999999999999999
		Ui is at position 9.999999999999996 at time 0.9999999999999999
	]]
end

-- Takes an alpha between 0 and 1, as argument, and returns another aloha, between 0 and 1
-- This function is like the easeInCubic on this website: https://easings.net/
local function CubicEasingStyle(a)
	return a^3 -- Unline python, the exponent operator is ^
end

TweenUi(10, CubicEasingStyle)

-- This method, of giving a funtion as an argument, is really useful, since, I can write my main function once,
-- but I am still able to give it any easing style in existence (without having rewrite the main function for
-- each easing style)


--


-- Another notation that I wont explain is

local tab6 = {}

function tab6:Foo()
	print("Fooya")
end

tab6:Foo() --> it'll print "Fooya"

-- This notation is like the previous one, but where the dots were replaced with :
-- This notation isn't equivalent, there is a little oddity that isn't an easy explanation. But if you avoid mixing the two notations, they are equivalent
-- I can explain it if you want, or if it becomes important

-- This is the notation that I use most often, simply because I prefer the look it has :P


-- //
-- ## Librairies
-- //

-- As I've explained in the ## Funtions section, libraries are just tables with functions inside (or values, it's not just functions)

print(math.pi) --> 3.141592653589793

-- The main libraries are:

--[[
	math -- For maths
	string -- To mess with strings. Things like string.lower(), string.substring(), string.split() (luau only), etc
	table -- To mess with tables, but especially arrays
	os -- Functions to obtain time, and other stuff. lua has a lot more functions here than luau, otherwise, script kiddies on Roblox would be able to mess with player's computers... :P
	io -- input output, allows writing and reading files. Completely removed in Roblox, for the same reason

	and more
]]
-- luau documetatoin (really nice documentation): https://create.roblox.com/docs/reference/engine/libraries/os
-- lua 5.1 documentation (it's more like, written like a book...): https://www.lua.org/manual/5.1/manual.html

-- I wont explain how to read the documentation (like how to interpret the Roblox docs), but, ask me

-- If you want to make your own libraries, you can create another lua script, that returns a table, with funtions inside.
-- To make the script return a table, you just have to put "return Library", (if Library is the name of the table),
-- as if the script is a giant function (thinking about it, it very well might be just that)

-- For example, if you have a script named test.luau (in the same folder, and if your working directory is also that same folder)

--[[
	local Library = {}

	function Library.Test()
		print("Test library is working!")
	end

	return Library
]]

if false then
	local TestLib = require("./test") -- . means the current folder (of the script), so it's a relative path, that leads to the test.luau files (.luau is ommited with the runtime that I use)
	TestLib.Test() --> "Test library is working!"
end

-- If you are in lua, I think you instead have to do require("./test.lua")


-- //
-- ## Misc
-- //

-- Section on random stuff

-- There are some functions that are predefined, without being in a library. The first example is print, but there is also tostring, and more

print(tostring(true)) --> "true", but as a string
print(tostring(nil)) --> "nil"
print(tostring(tab3)) --> table: 0x000055c507a143c0 (to print tables with a nice little formatting, either have to write your own pretty print function, or use someone else's)

print(tonumber("5")) --> 5
print(tonumber("3e-6")) --> 0.000003

local small_num = 3e-6 -- 3X10^-6. There are other "formats" like this one, for binary and hexadecimal
print(small_num) --> 0.000003

print("5" + 3) --> 8. Lua automatically converts string to numbers, when doing mathematical operations on them
print("5"..3) --> "53". And the opposite happens when doing string operations on numbers, lua converts them to strings

print("a".."b") --> "ab", .. is the concatenation operator in lua

-- And probably other things I forgot


-- Other things I didn't mention in this document:

-- Coroutines (threads. /!\ NOT PARALELISM THREADS, LUA ISN'T PARALELISABLE)
-- Metatables (allows for OOP-ish (object oriented), operator overloading, and some neat funky stuff)
-- Variadic arguments (special notation that allows functions to have an arbitrary amount of arguments)
