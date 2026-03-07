Game data (resources, balance, definitions)

# NOTE Avoid floats; instead, use an integer value and modifier if you need a fractional value.
(Избегайте чисел с плавающей запятой; вместо этого используйте целочисленное значение и модификатор, если вам нужно дробное значение.)

it values used in DB - so using int instead of float decrease memory usage
(Это значения, используемые в базе данных, поэтому использование целых чисел вместо чисел с плавающей запятой снижает потребление памяти.)

```
#avoid
var some_float : float # 0.001 - 0.009

# instead
const 
const VALUE_MOD: int = 100
var some_float_as_int : int # 1 - 9

#get in code
var real_float = some_float_as_int / VALUE_MOD # 0.001 - 0.009


```


difenitions scripts and data itself (as resurse, configs file), changes only in design-time

TODO 
- залажмить поля диапозоны типа - значение в диапозоне от - до, функци возврата уже отдаст правильное значение
    например - здоровье диапозон от 60 до 100, возратить случайное из диапозона, например 91 из гетера юнита
- описание данных в конфиг файлах, скрипты для конвертации / доступа из игры ?

получается данные от сюда нужны только на старте или получение чего то нового - если это меняется со времене в игре, или 
