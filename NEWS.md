# Version 0.2.5

  * Added `make_packages` and `dispose_packages` thanks to [gaborcsardi's disposables](https://github.com/gaborcsardi/disposables).

# Version 0.2.2

  * Added the `pretend_now_is` time-stubbing helper.

# Version 0.2.0

  * Can now stub methods coming from packages. For example,
    `package_stub("methods", "new", function(...) 'test', new('hello'))`
    will return `'test'`, as we have stubbed the `new` function
    in the `methods` package to just always return `'test'`.

    This can be very helpful when, e.g., wanting to stub HTTP
    requests (for example, by stubbing away RCurl functions).


