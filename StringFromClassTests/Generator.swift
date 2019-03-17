import Foundation

func iToS(_ i: Int) -> String {
    return String(format: "%04d", i)
}

let max = 1000

func printClasses() {
    print("import Foundation\n")
    for i in 0..<1000 {
        print("""
            final class Class\(iToS(i))/*: NSObject*/ {}
            """)
    }
}

func printBenchmarks(swift: Bool) {
    let launguageSuffix = swift ? "_swift" : "_objc"
    
    print("""
import Foundation

final class Benchmarker_\(launguageSuffix) {
    static func benchmark() {
        benchmark0000()
    }

    private static func toGoogleSheetString(_ from: String) -> String {
        return from.replacingOccurrences(of: ".", with: ",")
    }

""")
    
    for i in (0..<max) {
        let formattedI = iToS(i)
        let classType = "Class\(formattedI).self"
        let stringFromClass = swift
            ? "String(describing: \(classType))"
            : "NSStringFromClass(\(classType))"
        
        print("""
            private static func benchmark\(formattedI)() {
                let (_, time\(iToS(i))) = Stopwatch.measure {
                    \(stringFromClass)
                }
                print(toGoogleSheetString(String(time\(iToS(i)))))
        """)
        
        if i+1 < max {
            print("""
                    DispatchQueue.main.async {
                        self.benchmark\(iToS(i+1))()
                    }
            """)
        } 
        
        print("    }")
        print("")
    }
    print("}")
}
