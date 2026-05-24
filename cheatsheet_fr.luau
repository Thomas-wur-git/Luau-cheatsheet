--!nocheck
-- Ignore ce truc :P

-- //
-- ## Préambule
-- //

-- En lua, les commentaires sont précédés par "--", comme tu peux le voir avant tout mon blah blah
-- Il y a aussi un notation pour les gros blocs de commentaires (au lieu de mettre "--" sur chaque ligne)

--[[

	Tout ce qui est entre "--[\[" et "]\]" est mis en commentaire
	(ignore les \, sans eux, lua termine le bloc comment, et fait une erreure de syntaxe)

]]

-- //
-- ## Le commencement
-- //

local num = 1 -- Déclation d'une variable. "local" optionel, mais en pratique je le met pratiquement toujours. Explication dans la section ## Scope
num = 2

num = num + 1
num += 1 -- luau seulement

print(num) --> 4


-- D'autres types de valeurs
local bool = true -- ou false
local some_text = "string" -- " ou ' est identique en lua


-- //
-- ## If statments et booléen
-- //

if true then
	-- Le code ici est exécuté
end


local IsNumSmall = num < 5 -- num < 5 est une exprésion que lua évalue en booléen. IsNumSmall sera "true" (booléen, pas un string)
print(IsNumSmall) --> true

local BigNum = 0 -- J'initialize ma variable à 0, explication dans la section ## Scope
if IsNumSmall then BigNum = 50 end -- lua, contrairement à python, est très peu contraignant par rapport au formattage. Tu peux écrire ton code aussi croche que tu veux, pas de problème


-- Sans grande surprise, on peut mettre l'inéquation directement dans le if
if BigNum < 5 then
	-- ...
else -- Et les elses marchent comme çi
	print(BigNum) --> 50
end


if false then
	-- ...
elseif BigNum > 5 then -- Et les else if, comme ça
	-- ...
else
	-- Le if statement nous mène ici
end


-- // Booléens

-- Le keyword "not" inverse le booléen. not true -> false, et not false -> true
print(not true) --> false
print(not false) --> true

-- Donc, si on fait ceci, (BigNum < 5) est évalué à false, mais avec le "not", ça devient true
-- (Les parenthèses sont nécessaire, sinon lua pense qu'on fait (not BigNum) < 5, ce qui, étonament n'est pas une erreure... Jusqu'à ce que lua essaye de faire (false < 5) ...)
if not (BigNum < 5) then
	print("Hello!") -- Ce print est exécuté
end


print(not BigNum) --> false

-- Ce qui se passe ici est que, quand lua doit transformé qqch en booléen (pour calculé l'effect du not, ou la condition d'un if, etc)
-- TOUT ce qui est pas "false" ou "nil" est traité comme étant "true"

if BigNum then
	print("BigNum est ni 'nil', ni 'false'!")
end

BigNum = nil -- nil est une valeur en lua qui signifie "l'absence" de valeur. Souvent utilisé quand que quelque chose n'existe pas, par exemple, le charactère d'un joueur qui n'a pas encore spawn

if BigNum then
	-- Le code ici n'est pas exécuté
end

if BigNum == nil then
	print("BigNum est 'nil' :O")
end

-- Les autres opérateurs pour les conditions sont ==, ~= (contrairement à != en python et beaucoup d'autres langages), <=, >=

-- Il existe deux autres keywords, similaires à "not"
-- "or" retourne le premier élément si il est ni "nil", ni "false". Autrement, retourne le deuxième élément

local OrResult = false or "Hello!"
print(OrResult) --> "Hello!"

print(BigNum or "BigNum is not defined!") --> "BigNum is not defined!"

BigNum = 50

print(BigNum or "BigNum is not defined!") --> 50

-- L'autre keyword est "and"
-- "and" retrourne le premier élément s'il est soit "nil", ou "false" (donc l'inverse de "or")

local AndResult = false and "Hello!"
print(AndResult) --> "false"

print(BigNum and "BigNum is defined!") --> "BigNum is defined!"

BigNum = nil

print(BigNum and "BigNum is defined!") --> "nil"

-- Une utilisation très commune de ses opérateurs des les "ternary operator", où selon un booléean, tu retourne soit valeur A, ou valeur B

local cond = true
local val1 = 1
local val2 = 2

-- Si cond est "false", (cond and val1) est évalué à "false"
-- Ensuite, (false or val2) est évalué à val2
--
-- Si cond est "true", (cond and val1) est évalué à "val1"
-- Ensuite, (val1 or val2) est évalué à val1 (***)
local val = cond and val1 or val2

print(val) --> 1

-- (***) Si val1 est "false" ou "nil", (val1 or val2) sera évalué à val2!!!
-- En général, c'est pas ce qui est attendu (ce n'est pas un vrai opérateur ternaire), alors il faut faire attention

-- Pour cette raison, luau ajoute une syntaxe explicite pour un opérateur ternaire

-- Luau seulement!
val = if cond then val1 else val2 -- Ça resemble à un if statement, mais ce n'en n'est pas un. C'est vraiment une syntaxe spéciale pour ça

-- Dans d'autres languages, l'opérateur ternaire est généralement cond ? val1 : val2
-- En python, c'est val1 if cond else val2 (arghghgh what is thiss messs)


-- //
-- ## Scope
-- //

-- Le "scope" réfère à des régions, par exemple, l'intérieur d'un if statement sera le scope de se if statement.
-- Les variables "locales" suivent comme règle, que la variable est accessible dans les scopes "montant", mais pas dans ceux "déscendant".
-- Tu peux le voir selon l'indentation (montante et déscendante), ou sinon, tu peux le voir comme, le scope d'un if statement qui est définit dans le scope
-- d'une certaine variable, fait partie du scope de cette varible.

-- C'est probablement plus facile de juste regarder des exemples...

local Outside = "ye"

if true then
	print(Outside) --> "ye"

	local Inside1 = "ya"
	Inside2 = "yaaa" -- Ici, je déclare la variable sans mettre "local", c'est une déclaration "globale"
end

print(Inside1) --> nil (Ce n'est pas une erreure, les variables indéfinies sont juste considérées comme étant "nil")
print(Inside2) --> "yaaa". Comme la variable à été déclaré de manière "globale", je peux y accédé en dehors du if


-- En pratique, j'utilise jamais les déclarations "globables". Pour des raisons de blah blah blah (un peu du nitpick mais bon), c'est préférable de faire
-- Tu peux éviter l'utilisation de variables "globables" en fesant ceci

local Inside3 -- Ici, je déclare la variable, mais je lui donne aucune valeurs. Par défaut, ça valeur sera "nil". Tu peux mettre une valeur par défaut si tu veux
if true then
	Inside3 = "yeeehaa"
end

print(Inside3) --> "yeeehaa"


-- En python, les règles de scopes sont différentes. Je peux pas te dire comment, parce que je comprends pas le scope en python (et j'ai pas pris le temps pour le comprendre non plus)

-- Autre machin.
do
	-- Équivalent a "if true then [...] end"
	-- Ce machin à umm. Pas 0 d'utilité, mais à peu près 0 d'utilité
end


-- //
-- ## Loops
-- //

-- Il y a 3 types de loops en lua

num = 0

-- Les whiles loops
while num < 3 do
	num = num + 1
	print(num) --> 1, après 2, puis 3

	-- Fait attention avec les while loops, c'est très facilement d'accidentellement gelé le programme... Je l'ai fait trop de fois
end

-- Les repeat loops (qui sont très semblablent, mais la condition est évaluer après que le "corps" à été exécuté. Et la condition est "inversé")
-- En fait, ça ce lit comme de l'anglais
-- Ce type de loops est très rarement utilisé

num = 0

repeat
	num = num + 1
	print(num) --> 1, 2, 3, comme tantôt
until num == 3

-- Et finalement les for loops, qui on une notation moins évidente, mais bon

-- On définit notre variable i, puis on dit, va justqu'à 3
for i = 1, 3 do
	print(i) --> 1, 2, 3 (contrairement à python, ça va jusqu'à 3, au lieu de 2)
end

-- Par défaut, i fait des bon de 1, mais il est possible de spécifier le "step"
-- le "step" est donné dans le troisème chiffre, comme ça

for i = 1, 3, 0.5 do
	print(i) --> 1, 1.5, 2, 2.5, 3
end

-- Mais il y a une autre forme pour les for loops, pour itérer sur des tableaus et machins

list = {"a", "b", "c"} -- C'est comme ça qu'on définit un tableau. Voir section sur les ## Tableaux

-- pas besoin de savoir ce que ipairs fait, autre que ipairs prend les array, et te donne toutes les valeurs (avec leurs index, aka position dans le tableau)
-- Ipairs est expliqué dans la section ## Tableaux

-- i est pour "index", v est pour "value"
for i, v in ipairs(list) do
	-- (si tu donne plus d'un argument à la fonction "print", elle imprime chaqu'un d'eux à la suite)
	print(i, v) --> 1, "a" et après, 2, "b", et enfin 3, "c"
end
-- Contrairement à python, la première position dans un tableau est "1", et non "0"

-- Complément sur les for loops: https://create.roblox.com/docs/tutorials/fundamentals/coding-4/intro-to-for-loops


-- Il y a 1, (ou 2) keyword pour les loops, "break" et "continue" ("continue" existe seulement en luau)

local i = 0
while true do
	i += 1
	local v = list[i]

	if v == "b" then break end -- "Break", brise la loop. L'exécution du code sort directement de la loop. Fonctionne de la même manière avec les for loops
	print(v) --> "a", et c'est tout
end

-- continue est valide seulement en luau
for i, v in ipairs(list) do
	if i < 3 then continue end -- "Continue", arête l'éxécution de la loop pour retourné au début de celle-ci. (Pour une for loop, on traite le prochain index. Pour une while loop, on retourne à l'étape de l'évaluation de la condition)
	print(v) --> "c", et c'est tout
end

-- //
-- ## Tableaux
-- //

-- Pour déclaré un tableau, c'est comme ça

local tab1 = {true, false, "and an impastar"}

-- Pour indexé un tableau, la manière principale est [index]

print(tab1[1]) --> true (la première valeure est à l'index 1, au lieu de l'index 0 comme en python)
print(tab1[2]) --> false
print(tab1[3]) --> "and an impastar"

-- Les tableau en lua retournent nil, si tu index une valeur qui n'existe pas

print(tab1[0]) --> nil
print(tab1[-1]) --> nil
print(tab1[10]) --> nil


-- Les tableau en lua sont très généraux, dans le sens que, l'index peu être absolument n'importe quoi

print(tab1["A key impastar"]) --> nil

-- C'est plus pratique si on définit l'index explicitement, d'une des manières suivantes
-- (dans l'exemple de tab1, j'ai pas donné l'index, donc les indexes 1, 2 et 3, on été données par défaut)
local tab2 = {a = 1, ["b"] = 0.5}
tab2.c = 3
tab2["d"] = 4

-- Ces différentes notations sont toutes équivalentes
print(tab2["a"]) --> 1
print(tab2.b) --> 0.5

-- Les deux dernières insèrent la valeur après que le tableau à été crée.
-- La notation avec le . marche juste avec les des indexes strings, et juste avec les strings sans espaces ou trucs douteux.
-- La notation [ ] permet aussi d'utilisé la valeur d'une variable comme index

local Index = "a"
print(tab2[Index]) --> 1

-- Et quand que je disais que absolument n'importe quoi peux être un index, je veux dire, n'importe quoi

tab2[tab1] = "Les autres langages ne permettent généralement pas ça"
tab2[tab2] = "et ça c'est vraiment cursed"

-- Ici, j'ai utilisé les tableaus eux mêmes comme index (si j'avais à deviné, lua prend peut être l'adresse mémoire du tableau comme "identifiant"?)

print(tab2[tab1]) --> "Les autres langages ne permettent généralement pas ça"
print(tab2[tab2]) --> "et ça c'est vraiment cursed"

-- Pour effacer une entrée dans un tableau, met sa valeur à nil

tab2[tab1] = nil
tab2[tab2] = nil


-- Une particularité avec les tableaux lua est que, les tableau lua sont une combinaison d'une liste (array), et d'un dictionaire (dictionary, en anglais. Aussi une hashmap)

-- Array c'est quand tu as une liste, qui comment avec un index de 1, et chaques valeurs successive à l'index suivant.
-- Quand tu définit un tableau sans mentionner les index (come tab1), lua crée un array

-- Dictionary c'est toutes ce qui n'est pas un array. Index de -1, index de string, etc

local tab3 = {
	[1] = "a",
	[2] = "b",
	[-1] = "c",
	[3] = "d",
	[5] = "e",
	[true] = "f",
}

-- Cette distinction entre les deux partie du tableau est importante, parce que ça va changé comment tu traite le tableau

-- Dans ce cas ci, la partie array est [1] = "a", [2] = "b" et [3] = "c". [5] = "e" n'en fait pas partie, parce que [4] est nil. Les array ne peuvent pas avoir de "trou"
-- Tous les aures couples [index] = valeur font partie de la partie "dictionaire" du tableau

-- Pour avoir la longeur du tableau, tu peux utilisé #. Mais ça marche seulement sur la partie "array" du tableau!

print(#tab3) --> 3

-- Pour avoir la longeur du tableau au "complet", il faut le calculer manuellement (ce que je fais dans la section ## Fonctions)

-- Pour itérer sur tous les couples index valeur du tableau, on peux utilisé ipairs et pairs, comme ça

-- ipairs agit que sur la partie array. Comment il fonctionne est qu'il comment à i = 1, retourne le couple index valeur, passe à i = 2, ..., jusqu'à ce que il tombe sur nil (où ici, nil est à i = 4)
-- Si i = 1 est nil, l'intérieur de la for loop ne sera jamais exécuté
for i, v in ipairs(tab3) do
	print(i, v ) --> 1, "a"; 2, "b"; 3, "d"
end

-- pairs agit sur tout, mais ne garantit pas l'ordre dans lequel les couples index valeur sont données
-- (l'ordre dans lequel les valeurs sont définis lors de la déclaration du tableau n'a pas d'importante ou d'effet, enfin je pense pas)
for i, v in pairs(tab3) do
	print(i, v) --> 1, "a"; 2, "b", ..., true, "f"; -1, "c"
end


-- lua a plusieurs libraries par défaut, dont la librarie "math", "string", "table", etc
-- Les explication sur les libraries sont dans les sections ## Fonctions et ## Librairies
-- Pour ce qui est de la librarie "table", il y a plusieurs fonctions pour faire de quoi sur les array (ou la partie array des tableaux)
-- Documentation pour la librarie "table": https://create.roblox.com/docs/reference/engine/libraries/table (en lua 5.1, ça ce peux que ça soit légèment différent)

local tab4 = {}

-- Les libraries par défaut sont accessiblent sans avoir à faire de "import" ou machin
table.insert(tab4, "a")
table.insert(tab4, "b") -- Par défaut, ça insère à la fin de la liste

for i, v in ipairs(tab4) do print(i, v) end --> 1, "a"; 2, "b"

table.insert(tab4, 1, "c") -- Il est aussi possible de spécifier l'index où l'on veux inséré l'élément. Les autres éléments seront "repoussés"

for i, v in ipairs(tab4) do print(i, v) end --> 1, "c"; 2, "a"; 3, "b"

table.remove(tab4) -- Retire le dernier élément
table.remove(tab4, 1) -- Retire l'élément à l'index 1, et shift l'élément qui était en i = 2 vers i = 1

for i, v in ipairs(tab4) do print(i, v) end --> 1, "a"


-- //
-- ## Fonctions
-- //

-- Il y a plusieurs manières de définir une fonction

-- Manière très peu utilisé, mais qui montre bien comment une fonction est une "valeur", qui est ici attribué à une variable
local foo = function()

end

-- Notation très courament utilisé, et qui est entièrement équivalente à l'autre
local function foo()

end

--

local function Add(a, b)
	return a + b
end

local function FloorDivision(divident, divisor)

	local quotient = divident//divisor -- l'opérateur // est un "floor division" (7/3 = 2), les virgules sont effacé. Pas disponible en lua 5.1 (mais disponible en lua 5.3+ et luau). L'aternative est math.floor(7/3)
	local reminder = divident % divisor -- calcule le reste

	return quotient, reminder -- Il est possible de retourner plusieurs valeurs, qui sont séparé par un ","
end

print(Add(1, 2)) --> 3

-- Déclaration de 2 variables en même temps (car la fonction retourne deux variables)
local q, r = FloorDivision(7, 3)
print(q, r) --> 2, 1


-- Add est comme une variable, seule différence est que sa valeur est une fonction

print(Add) --> [lua 5.5]: function: 0x55fd2ee636c0 (c'est l'adresse mémoire de la fonction);
			  --> [luau]: <function> (bruh. Il faut faire print(tostring(Add)) pour que luau imprime l'adresse mémoire)

-- Ce que lua fait est que, quand tu met () après un variable, lua essaye de call cette variable. Si la valeur de la variable est une fonction, pas de problème.
-- Si la valeur de la variable est, par exemple, un string, tu auras cette erreure: test.lua:8: attempt to call a string value

-- Pas besoin que ce soit dans une variable pour que lua essaye de l'appeler

-- Ce bizou est un peu cursed, et tu veras ça à peu près jamais (sauf dans mon code...)
-- Ce qui se passe est que, je définis une fonction, je l'entoure de parenthèse (parce que sinon lua donne une erreure de syntaxe),
-- et après, j'appelle la fonction avec (). Ce que la fonction retourne est assigné à la variable a
local a = (function()
	local sum = 0
	for i = 1, 100 do sum += i end

	return sum
end)()

print(a) --> 5050

--[[

	-- Ceci représente une valeur, qui est une fonction. On pourrait l'assigné à une variable, mais ce n'est pas requis
	(function()

	end)

	-- En ajoutant () à la fin, on essaye de call la valeur qui précède le (). La valeur est ici une fonction, donc celle-ci est exécuté
	(function()

	end)()

	-- Cependant, pour que lua évalue cette expression (et ne fasse pas d'erreure de syntaxe), il faut faire ceci

	local a = (function()

	end)()

]]

-- Note que je n'ai jamais assigné de variable à la fonction, la fonction n'a pas de nom
-- C'est ce qu'on appele une fonction "anonyme" (anonymous function)
-- Un usage typique des fonctions anonymes est le suivant

local function DoSomething(callback)

	-- ... Fait une requête http ou whatever
	-- La manière dont les requêtes https sont fait en lua dépend du "runtime" (love2d, luvit, lune, ou program C/C++ random qui embed lua)
	-- La manière dont les treads sont gérés (permettant ainsi au code de faire autre chose pendant la requête http) peut aussi dépendre du "runtime". Lua a des coroutines, que je ne traite pas

	local result = "418 I'm a teapot" -- résultat de la requette http

	-- callback est une variable, qui contient comme valeur une fonction
	callback(result)
end

-- On passe directement la fonction comme argument. On pourrait aussi très bien assigner notre fonction à une variable, et passer cette variable
DoSomething(function(result)
	print(result) --> "418 I'm a teapot"
end)

-- Les fonctions anonymes en lua sont plutôt semblablent à celles en Java (interface Runnable). Ce qui est agréable est que lua utilise la même notation pour les fonctions anonymes que celles normales (si tu utilise la première notation présenté au début de la section)
-- En python, les fontions anonymes sont écritent avec une syntaxe spéciale (lambda: machin), et sont beaucoups plus limités


--


-- Les fonctions sont très très souvent mise dans des tableaux

local Utils = {}

-- On assigne directement la fonction à un index dans le tableau. La fonction n'est jamais assigné à une variable. (Par contre, on dit pas que c'est une fonction anonyme? Probablement parce que elle a quand même un nom dans le tableau, aka sont index)
Utils.GetDictLength = function(dict)
	local length = 0
	for i, v in pairs(dict) do length += 1 end -- J'utilise pairs pour compter le nombre d'élément. i et v ne sont pas utilisé

	return length
end

-- On accède à la fonction, qui est Utils.GetDictLength, et on l'appèle
-- tab3 était le tableau mélangé array/dict (#tab3 était égal à 3)
local Length = Utils.GetDictLength(tab3)
print(Length) --> 6


-- Une autre notation, plus courante, mais complètement équivalente est:
-- (Ses notations là sont comme du "syntactic sugar". Ça fait plus joli, mais elles sont beaucoup moins descriptives de ce qui se passe réellement)

-- (pas de local ici, parce que on est pas en train de déclaré une variable)
function Utils.GetArrayLength(array)
	return #array
end

print(Utils.GetArrayLength(tab3)) --> 3

-- Et tu peux aussi directement mettre des fonctions dans un tableau, lors de ça déclaration

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

-- J'ai pas donné d'index à la fonction 1, mais lua lui à donné l'indexe 1, comme dans la section ## Tableaux
tab5[1]() --> ça imprimera "Function 1"
tab5.b() --> ça imprimera "Function 3"

-- C'est comme ça que les libraries en lua sont structurés. Voir la section ## Librairies

print(math.floor(2.5)) -- 2

-- math est un tableau, math.floor est une function, qui est à l'index "floor", dans le tableau

local floor = math.floor
print(floor(3.9)) --> 3

if false then
	-- En théorie, si math est un tableau, on deverait pouvoir faire ça right?
	math.HELLO = 1
	-- Alors, en théorie, oui, mais en pratique, avec luau: /home/chilly28/Sync/Code/rand/cheatsheet:489: attempt to modify a readonly table
	-- Le tableau de math à été gelé (voir table.freeze()), de telle sorte qu'on a pas le droit de la modifier
	-- d'où pourquoi ce bout de code est dans un if statement qui ne tournera jamais, autrement le code aurait une erreure

	-- Par contre, en lua, tu peux le faire sans problème :P
end


--


-- Un autre usage plus avancé, des fonctions anonymes, est le système de signaux
-- Ici j'ai un petit example codé directement en lua, qui réplique (rudement) l'interface de signaux de roblox

local SignalModule = {}

-- SignalModule.New() est comme un "constructeur", il crée et retourne un tableau, qui est l'équivalent d'un "objet" qui est notre signal
function SignalModule.New()
	local Signal = {}

	local ConnectedFunctions = {}

	function Signal.Fire()
		-- On clone la liste de fonctions, et on la clear (table.clear reset le tableau à un tableau vide)
		-- C'est pour évité des bugs bizarre, qui surviennent lorsqu'une des fonctions connectées intéragit avec le signal
		local FuncList = table.clone(ConnectedFunctions)
		table.clear(ConnectedFunctions)

		for _, f in ipairs(FuncList) do
			-- Ici, il est préférable de crée un nouveau thread (soit avec la librarie coroutine, ou l'implémentation de thread du "runtime")
			-- Ça évite que les erreures dans les fonctions connectés se propagent partout, et ça permet de yield, ...
			f()
		end
	end

	function Signal.Connect(func)
		-- Insère la fonction dans la liste
		table.insert(ConnectedFunctions, func)
	end

	return Signal
end

-- On crée un nouvel "object" signal
local Signal = SignalModule.New()

-- On connecte des fonctions à ce signal
Signal.Connect(function()
	print("First connection!")
end)

Signal.Connect(function()
	print("Second connection!")
end)

-- On exécute toutes les fonctions connectées
Signal.Fire()  --> First connection!
					--> Second connection!

-- Les signaux sont très utiles dans les jeux, par example, quand on joueur rejoint le jeux (signal), quand un joueur meurt (signal), quand un round se termine (signal)
-- Il est aussi pas trop difficile (une fois qu'on sait comment...) de modifier le code, permettant de passer un nombre arbitraire d'arguments à Signal.Fire(arg1, arg2), qui seronts ensuite transmits aux fonctions connectées


-- Et Voici un autre exemple quelconque

local function TweenUi(Distance, EasingStyle)

	-- Cet example set pas super, parce que je suis pas dans un moteur de jeux.
	-- En temp normal, tu met à jour la position à chaque "frame". Le alpha est calculé
	-- en utilisant l'horloge de l'ordinateur (comme ça, si il y a 0.01 secondes entre les deux premiers frames,
	-- mais qu'il y a 0.02 secondes entre le deuxième et troisième (du lag), l'animation reste constante dans le temps)
	for a = 0, 1, 0.1 do
		local Position = Distance * EasingStyle(a)
		print("Ui is at position "..Position.." at time "..a) -- .. est utilisé pour "concaténer" des strings ensemble, contrairement à + en python
	end

	-- Résultat: (les nombres dégeulasses, c'est parce que c'est des floats...)
	-- L'animation commence lentement, puis prend de la vitesse à la fin
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

-- Prend comme argument alpha, un nombre entre 0 et 1, et retourne un autre alpha encore entre 0 et 1
-- Cette fonction est comme le easeInCubic sur ce site: https://easings.net/
local function CubicEasingStyle(a)
	return a^3 -- contrairement à python, l'opérateur d'exposant est ^
end

TweenUi(10, CubicEasingStyle)

-- Cette méthode, de donner une fonction en argument, est très utile, parce que je peux écrite ma fonction une seule fois,
-- mais malgré tout, je peux lui donné n'importe quel EasingStyle imaginable (au lieu de devoir coder une function différente
-- pour chaque EasingStyle)


--


-- Une autre notation, que je n'expliquerais pas, est

local tab6 = {}

function tab6:Foo()
	print("Fooya")
end

tab6:Foo() --> ça imprimera "Fooya"

-- Cette notation est comme celle précédente, mais où les . ont été remplacés par :
-- Cette notation n'est pas équivalent, il y a une particularité un peu compliqué à expliqué. Mais si tu ne mélange pas les deux notations, c'est équivalent
-- Je peux te l'expliquer si tu veux, ou sinon, si ça devient important

-- C'est la notation que j'utilise, simplement parce que je préfère le style :P


-- //
-- ## Librairies
-- //

-- Comme expliqué dans la section ## Fonctions, les libraries lua sont juste des tableau avec des fonctions dedant, ou des valeurs

print(math.pi) --> 3.141592653589793

-- Les libraries principales sont:

--[[
	math -- Pour les math
	string -- Pour jouer avec des string. Trucs du genre string.lower(), string.substring(), string.split() (luau seulement), etc
	table -- Pour jouer avec les tableau, mais surtout les array
	os -- Fonctions pour obtenir le temps, et autres machins. lua à plus de fonction ici que luau, car sinon les jeux roblox pourrait exécuté n'importe quoi sur les ordis des joueurs :P
	io -- input output, permets de lire et d'écrire des fichiers. Complètement absent en luau, pour les mêmes raisons

	et autres
]]
-- Documentation luau (documentation très nice): https://create.roblox.com/docs/reference/engine/libraries/os
-- Documentation lua 5.1 (c'est genre un livre...): https://www.lua.org/manual/5.1/manual.html

-- Je vais pas mettre comment lire la documentation (genre comment interprété celle de Roblox) dans la cheatsheet, mais, demande le moi

-- Si tu veux faire tes propres librairies, tu peux faire un autre script lua, qui retourne un tableau avec des fonctions dedans.
-- Pour faire que le script retourne un tableau, tu fait juste mettre un "return Library", (si Library est le nom de ton tableau),
-- comme si le script lui même est une très grosse fonction (ce qui en fait je pense est le cas)

-- Par exemple, si tu as un script test.luau (dans le même dossier, et si ton working directory est ce même dossier)

--[[
	local Library = {}

	function Library.Test()
		print("Test library is working!")
	end

	return Library
]]

if false then
	local TestLib = require("./test") -- . veut dire le dossier actuel (du script), donc c'est un chemin relatif qui mène vers le fichier test.luau (.luau est omis avec le runtime que j'utilise)
	TestLib.Test() --> "Test library is working!"
end

-- Si tu est en lua, je pense qu'il faut plutôt faire require("./test.lua")


-- //
-- ## Misc
-- //

-- Section sur des machins plus random

-- Il y a certaines fonctions qui sont définies juste comme ça, sans être dans une libraries. Le premier expemple est print, mais il y a aussi, tostring, et d'autres

print(tostring(true)) --> "true", mais en string
print(tostring(nil)) --> "nil"
print(tostring(tab3)) --> table: 0x000055c507a143c0 (pour pouvoir imprimer des tableau avec un beau petit formatage, il faut une fonction soit écrite par soit même, ou par quelqun d'autre)

print(tonumber("5")) --> 5
print(tonumber("3e-6")) --> 0.000003

local small_num = 3e-6 -- 3X10^-6. Il y a d'autres trucs comme ça pour écrire des nombres en format binaire, ou hexadecimal
print(small_num) --> 0.000003

print("5" + 3) --> 8. Lua converti automatiquement les string en nombre, quand tu fait des opérations mathématiques dessus
print("5"..3) --> "53". Et l'inverse survient quand tu veux faire une opération de string sur un nombre, lua converti le nombre en string

print("a".."b") --> "ab", .. est l'opérateur de concaténation en lua

-- Et probablement d'autres trucs que j'ai oublié


-- Certains aspets qui n'ont pas étés mentionnés:

-- Coroutines (système de threads. /!\ PAS DES TREADS DE PARALÉLISME, LUA N'EST PAS PARALÉLISABLE)
-- Metatables (permets de faire du code OOP-ish (orienté object), operator overloading, et trucs funky)
-- Variadic arguments (notation spéciale pour permettre à une fonction d'avoir un nombre d'arguments arbitraires)
