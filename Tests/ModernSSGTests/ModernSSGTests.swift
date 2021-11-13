import XCTest
import ArgumentParser
import class Foundation.Bundle

final class ModernSSGTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        // Mac Catalyst won't have `Process`, but it is supported for executables.
        #if !targetEnvironment(macCatalyst)

        let fooBinary = productsDirectory.appendingPathComponent("ModernSSG")

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        XCTAssertEqual(output, "")
//            do {
//                let storedText = "<!doctype html><html lang =\(lang ?? "en-CA")><head><LINK rel='stylesheet' href=\(stylesheet ?? " ")><meta charset='utf-8'><title>\(input)</title><meta name='viewport' content='width=device-width,initial-scale=1'></head><body><h1>\(input)</h1><img src=\(image ?? "") alt = 'image-alt'>\(input)</body></html>"
//                let filePath = FileManager.default.currentDirectoryPath + "/Dist/\(input).html"
//                if FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil) {
//                    try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
//                    print("File Created at \(filePath)")
//                } else {
//                    print("Error in writing data! Please create folder in current directory")
//                }
//            }
//                catch { print("Error in reading folder. *** Folder must be in current directory ***") }
//            }
//}
        #endif
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }
}
