import ArgumentParser
import Foundation

enum Command {}

extension Command {
    struct Main: ParsableCommand {
        static var configuration: CommandConfiguration {
            .init(
                commandName: "ModernSSG",
                abstract: "A program to convert text or md files to HTML site generator",
                version: "ModernSSG 0.0.1"
            )
        }

        // input
        @Option(name: .shortAndLong, help: "allow the user to specify an input file or folder.") var input: String
        // stylesheet
        @Option(name: .shortAndLong, help: "allow the user to specify a URL CSS stylesheet.") var stylesheet: String?
        // output
        @Option(name: .shortAndLong, help: "allow the user to specify output folder.") var output: String?
        // lang
        @Option(name: .shortAndLong, help: "allow the user to specify the language attribute.") var lang: String?
        // image
        @Option(name: .long, help: "allow the user to specify the image attribute on root html.") var image: String?
        mutating func run() throws {
            // Searching the argumented file in current directory
            if input.hasSuffix(".txt") || input.hasSuffix(".md") {
                filereadAndWrite()
            }
            // Searching the argumented folder in current directory
            else {
                readAndWriteFolder()
            }
        }

        func filereadAndWrite() {
            do {
                // Reading & Copying the data
                // !!!!!!!!!!!!!!!!
                let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/" + input)
                let fileName: NSString = input as NSString
                let pathPrefix = fileName.deletingPathExtension
                print("File URL to read \(fileURL)")
                var data = try String(contentsOf: fileURL, encoding: .utf8)
                // Conversion of text to html
                if input.hasSuffix(".txt") {
                    data = data.replacingOccurrences(of: "\r?\n\r?\n\r?\n", with: "<p>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "\r?\n\r?\n", with: "</p><p>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "\(pathPrefix)", with: "", options: .regularExpression)
                    // Conversion of MD to html
                } else if input.hasSuffix(".md") {
                    // Improved Accessibility of generated HTML
                    data = data.replacingOccurrences(of: "](", with: "<a href='", options: .regularExpression)
                    data = data.replacingOccurrences(of: ")", with: "'>Click the Link</a>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "### ", with: "<h3>", options: .regularExpression)
                    data = data.replacingOccurrences(of: " ###", with: "</h3>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "## ", with: "<h2>", options: .regularExpression)
                    data = data.replacingOccurrences(of: " ##", with: "</h2>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "# ", with: "<h1>", options: .regularExpression)
                    data = data.replacingOccurrences(of: " #", with: "</h1>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "```bash", with: "<pre><code>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "```", with: "</code></pre>", options: .regularExpression)
                    data = data.replacingOccurrences(of: " _", with: "<i>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "_ ", with: "</i>", options: .regularExpression)
                    // Full Markdown support
                    data = data.replacingOccurrences(of: "^**[A-Za-z0-9]$", with: "<b>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "^[A-Za-z0-9]$**", with: "</b>", options: .regularExpression)
                    // Add support for a horizontal rule in Markdown
                    data = data.replacingOccurrences(of: "---", with: "<hr>", options: .regularExpression)
                }
                // Writing the data
                // !!!!!!!!!!!!!!!!
                let storedText =
                    "<!doctype html><html lang = \(lang ?? "en-CA")><head><LINK rel='stylesheet' href=\(stylesheet ?? " ")><meta charset='utf-8'><title>\(pathPrefix)</title><meta name='viewport' content='width=device-width, initial-scale=1'></head><body><h1>\(pathPrefix)</h1><img src=\(image ?? "") alt = 'image-alt'>\(data)</body></html>"
                // if output path is mentioned
                if output != nil {
                    let filePath = FileManager.default.currentDirectoryPath + "/ \(output ?? "")/\(pathPrefix).html"
                    if FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil) {
                        try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                        print("File Created at \(filePath)")
                    } else {
                        print("Error in writing data! Please create folder in current directory")
                    }
                }
                // If output path is not mentioned
                else {
                    let filePath = FileManager.default.currentDirectoryPath + "/Dist/\(pathPrefix).html"
                    if FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil) {
                        try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                        print("File Created at \(filePath)")
                    } else {
                        print("Error in writing data! Please create folder in current directory")
                    }
                }
            } catch { print("Error in reading file. Please check name and extension of file.*** File must be in current directory ***") }
        }

        func readAndWriteFolder() {
            if(input.isEmpty){
                print("Error. Please enter input folder or add suffix to file name")
                return
            }
            let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(input)/")
            var files = [URL]()
            // Searching all text files in desktop directory
            if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
                for case let fileURL as URL in enumerator {
                    do {
                        let fileAttributes = try fileURL.resourceValues(forKeys: [.isRegularFileKey])
                        if fileAttributes.isRegularFile! {
                            files.append(fileURL)
                        }
                    } catch { print(error, fileURL) }
                }
            }
            // Determining number of files and creating loop
            for int in 0 ..< files.count {
                let fileName = files[int].deletingPathExtension().lastPathComponent
                if files[int].lastPathComponent.hasSuffix(".txt") {
                    do {
                        // Reading & Copying the data
                        // !!!!!!!!!!!!!!!!
                        var data = try String(contentsOf: files[int], encoding: .utf8)
                        data = data.replacingOccurrences(of: "\r?\n\r?\n\r?\n", with: "<p>", options: .regularExpression)
                        data = data.replacingOccurrences(of: "\r?\n\r?\n", with: "</p><p>", options: .regularExpression)
                        data = data.replacingOccurrences(of: "\(fileName)", with: "", options: .regularExpression)
                        // Writing the data
                        // !!!!!!!!!!!!!!!!
                        let storedText = "<!doctype html><html lang =\(lang ?? "en-CA")><head><LINK rel='stylesheet' href=\(stylesheet ?? " ")><meta charset='utf-8'><title>\(fileName)</title><meta name='viewport' content='width=device-width,initial-scale=1'></head><body><h1>\(fileName)</h1><img src=\(image ?? "") alt = 'image-alt'>\(data)</body></html>"
                        // if output path is mentioned
                        if output != nil {
                            let filePath = FileManager.default.currentDirectoryPath + "/\(output ?? " ")/\(fileName).html"
                            if FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil) {
                                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                print("File Created at \(filePath)")
                            } else {
                                print("Error in writing data! Please create folder in current directory")
                            }
                        }
                        // if output path is not mentioned
                        else {
                            let filePath = FileManager.default.currentDirectoryPath + "/Dist/\(fileName).html"
                            if FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil) {
                                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                print("File Created at \(filePath)")
                            } else {
                                print("Error in writing data! Please create folder in current directory")
                            }
                        }
                    } catch { print("Error in reading folder. *** Folder must be in current directory ***") }
                }
            }
            print("Error: The value \(input) is invalid for '--input <input>'")
        }
    }
}

Command.Main.main()
