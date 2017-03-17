function index = countLookup(InputString)
global wordCounter
if wordCounter.isKey(InputString)
    index = wordCounter(InputString);
else
    index = 1;
end
