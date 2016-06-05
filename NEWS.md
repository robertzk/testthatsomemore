# Version 0.2.6

  * Extract `pretend_now_is` character to date interpolation into a separate package: https://github.com/peterhurford/strdate

# Version 0.2.5

  * Allow package stubbing for loaded, non-installed namespaces.

# Version 0.2.2

  * Added the `pretend_now_is` time-stubbing helper.

# Version 0.2.0

  * Can now stub methods coming from packages. For example,
    `package_stub("methods", "new", function(...) 'test', new('hello'))`
    will return `'test'`, as we have stubbed the `new` function
    in the `methods` package to just always return `'test'`.

    This can be very helpful when, e.g., wanting to stub HTTP
    requests (for example, by stubbing away RCurl functions).


