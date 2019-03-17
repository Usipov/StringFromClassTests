A demo project with a benchmark on getting a string from 1000 different classes. Supports [this](https://stackoverflow.com/questions/55206679/why-stringdescribing-class-self-is-slower-than-nsstringfromclassclass-sel) stackoverflow question.

Go into AppDelegate.swift and uncomment one of `Benchmarker.benchmark()` lines to see that
- Swift's `String(describing: Class.self)` works slower, than Objective-C's `NSClassFromString(Class.self)` (30..150μs vs 4..12μs)
- Calling Swift's `String(describing: Class.self)` on different classes gets slower and slower with every new class,
while Objective-C times remain the same