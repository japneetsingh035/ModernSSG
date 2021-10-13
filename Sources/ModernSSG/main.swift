import ArgumentParser
import Foundation

enum Command {}

extension Command {
    struct Main: ParsableCommand {
        static var configuration: CommandConfiguration {
            .init(
                commandName: "ModernSSG",
                abstract: "A program to convert text files to HTML site generator",
                version: "Modern SSG 0.0.1"
            )
        }
        
        //input
        @Option(name: .shortAndLong ,help:"allow the user to specify an input file or folder to be processed") var input: String?
        
        //config
        @Option(name: .shortAndLong ,help:"allow the user to specify an input file or folder to be processed") var config: String?
        
        //stylesheet
        @Option(name: .shortAndLong, help: "allow the user to optionally specify a URL to a CSS stylesheet.") var stylesheet: String?
        
        //output
        @Option(name: .shortAndLong, help: "allow the user to specify an output folder to be processed.") var output: String?
        
        //lang
        @Option(name: .shortAndLong, help:"allow the user to specify the language attribute on root html.") var lang: String?
        
        
        var result = ""
        var new_result = "";
        mutating func run() throws{
            if self.input == nil {
                if self.config == nil {
                    print("Nothing to see here")
                }else{
                    //   print("\(self.config!)")
                }
                let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/" + self.config!)
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                let myStrings = text2.components(separatedBy: .newlines)
                let index = myStrings[1].index(myStrings[1].endIndex, offsetBy: -10)
                let str = myStrings[1][index...] // playground
                let last = str.prefix(9)
                print( last)
                if (last.hasSuffix(".txt")||last.hasSuffix(".md")){
                    let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/" + last)
                    let fName: NSString = last as NSString
                    let pathPrefix = fName.deletingPathExtension
                    print("File URL to read \(fileURL)")
                    
                    do {
                        //Reading the data
                        //!!!!!!!!!!!!!!!!
                        result = try String(contentsOf: fileURL, encoding: .utf8)
                        
                        if(last.hasSuffix(".txt")) {
                            result = result.replacingOccurrences(of: "\r?\n\r?\n\r?\n", with: "<p>", options: .regularExpression)
                            result = result.replacingOccurrences(of: "\r?\n\r?\n", with: "</p><p>", options: .regularExpression)
                            //MD support - italics
                        } else if(self.input!.hasSuffix(".md")){
                            result = result.replacingOccurrences(of: " _", with: "<i>", options: .regularExpression)
                            result = result.replacingOccurrences(of: "_ ", with: "</i>", options: .regularExpression)
                            //Add support for inline <code> blocks //19
                            result = result.replacingOccurrences(of: "\r?\n`", with: "<code>", options: .regularExpression)
                            result = result.replacingOccurrences(of: "`\r?\n", with: "</code>", options: .regularExpression)
                            //Add support for a horizontal rule in Markdown
                            result = result.replacingOccurrences(of: "---", with: "<hr>", options: .regularExpression)
                        }
                        result = result.replacingOccurrences(of: pathPrefix, with: " ", options: .regularExpression)
                        print("File data copied")
                        
                        //Writing the data
                        //!!!!!!!!!!!!!!!!
                        let storedText =
                        "<!doctype html><html lang = \(self.lang ?? "en-CA")><head><LINK rel='stylesheet' href=\(self.stylesheet ?? " ")><meta charset='utf-8'><title>\(pathPrefix)</title><meta name='viewport' content='width=device-width, initial-scale=1'></head><body><h1>\(pathPrefix)</h1>\(result)</body></html>";
                        
                        if (self.output != nil) {
                            let filePath = FileManager.default.currentDirectoryPath + "/ \(self.output ?? "" )/\(pathPrefix).html"
                            if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                            {
                                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                print("File Created at \(filePath)")
                            }
                            else{
                                print("Error in writing data! Please create folder in current directory");
                            }
                        }
                        else{
                            let filePath = FileManager.default.currentDirectoryPath + "/Dist/\(pathPrefix).html"
                            if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                            {
                                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                print("File Created at \(filePath)")
                            }
                            else{
                                print("Error in writing data! Please create dist folder if missing.");
                                print("Error in writing data! Please create folder in current directory");
                            }
                        }
                    }
                    catch {print("Error in reading file. Please check name and extension of file.                                           *** File must be in current directory ***")}
                }
                
                
                else{
                    let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(self.input!)/")
                    var files = [URL]()
                    //Searching all text files in desktop directory
                    if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {                for case let fileURL as URL in enumerator {
                        do {
                            let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                            if fileAttributes.isRegularFile! {
                                new_result = try String(contentsOf: fileURL, encoding: .utf8)
                                new_result = new_result.replacingOccurrences(of: "\r?\n\r?\n\r?\n", with: "<p>", options: .regularExpression)
                                new_result = new_result.replacingOccurrences(of: "\r?\n\r?\n", with: "</p><p>", options: .regularExpression)
                                files.append(fileURL)
                            }
                        }catch { print(error, fileURL) }
                    }
                    }
                    //
                    for i in 0..<files.count {
                        let fileName = files[i].deletingPathExtension().lastPathComponent
                        if (files[i].lastPathComponent.hasSuffix(".txt")){
                            do {
                                //Reading the data
                                //!!!!!!!!!!!!!!!!
                                new_result = try String(contentsOf: files[i], encoding: .utf8)
                                new_result = new_result.replacingOccurrences(of: "\n\n\n", with: "<p>", options: .regularExpression)
                                new_result = new_result.replacingOccurrences(of: "\n\n", with: "</p><p>", options: .regularExpression)
                                new_result = new_result.replacingOccurrences(of: fileName, with: "", options: .regularExpression)
                                print("File data copied")
                                
                                //Writing the data
                                //!!!!!!!!!!!!!!!!
                                let storedText =  "<!doctype html><html lang =\(self.lang ?? "en-CA")><head><LINK rel='stylesheet' href=\(self.stylesheet ?? " ")><meta charset='utf-8'><title>\(fileName)</title><meta name='viewport' content='width=device-width,initial-scale=1'></head><body><h1>\(fileName)</h1>\(new_result)</body></html>";
                                if (self.output != nil) {
                                    let filePath = FileManager.default.currentDirectoryPath + "/\(self.output ?? " ")/\(fileName).html"
                                    if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                                    {
                                        try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                        print("File Created at \(filePath)")
                                    }
                                    else{
                                        print("Error in writing data! Please create folder in current directory");
                                    }
                                }
                                else{
                                    let filePath = FileManager.default.currentDirectoryPath + "/Dist/\(fileName).html"
                                    if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                                    {
                                        try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                        print("File Created at \(filePath)")
                                    }
                                    else{
                                        print("Error in writing data! Please create folder in current directory");
                                    }
                                }
                            }
                            catch {print("Error in reading folder. Please check name and location of folder.                                           *** Folder must be in current directory ***")}
                        }
                    }
                }
            }else{
                if (self.input!.hasSuffix(".txt")||self.input!.hasSuffix(".md")){
                    let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/" + self.input!)
                    let fName: NSString = self.input! as NSString
                    let pathPrefix = fName.deletingPathExtension
                    print("File URL to read \(fileURL)")
                    do {
                        //Reading the data
                        //!!!!!!!!!!!!!!!!
                        result = try String(contentsOf: fileURL, encoding: .utf8)
                        
                        if(self.input!.hasSuffix(".txt")) {
                            result = result.replacingOccurrences(of: "\r?\n\r?\n\r?\n", with: "<p>", options: .regularExpression)
                            result = result.replacingOccurrences(of: "\r?\n\r?\n", with: "</p><p>", options: .regularExpression)
                            //MD support - italics
                        } else if(self.input!.hasSuffix(".md")){
                            result = result.replacingOccurrences(of: " _", with: "<i>", options: .regularExpression)
                            result = result.replacingOccurrences(of: "_ ", with: "</i>", options: .regularExpression)
                            //Add support for inline <code> blocks //19
                            result = result.replacingOccurrences(of: "\r?\n`", with: "<code>", options: .regularExpression)
                            result = result.replacingOccurrences(of: "`\r?\n", with: "</code>", options: .regularExpression)
                            //Add support for a horizontal rule in Markdown
                            result = result.replacingOccurrences(of: "---", with: "<hr>", options: .regularExpression)
                        }
                        result = result.replacingOccurrences(of: pathPrefix, with: " ", options: .regularExpression)
                        print("File data copied")
                        
                        //Writing the data
                        //!!!!!!!!!!!!!!!!
                        let storedText =
                        "<!doctype html><html lang = \(self.lang ?? "en-CA")><head><LINK rel='stylesheet' href=\(self.stylesheet ?? " ")><meta charset='utf-8'><title>\(pathPrefix)</title><meta name='viewport' content='width=device-width, initial-scale=1'></head><body><h1>\(pathPrefix)</h1>\(result)</body></html>";
                        
                        if (self.output != nil) {
                            let filePath = FileManager.default.currentDirectoryPath + "/ \(self.output ?? "" )/\(pathPrefix).html"
                            if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                            {
                                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                print("File Created at \(filePath)")
                            }
                            else{
                                print("Error in writing data! Please create folder in current directory");
                            }
                        }
                        else{
                            let filePath = FileManager.default.currentDirectoryPath + "/Dist/\(pathPrefix).html"
                            if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                            {
                                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                print("File Created at \(filePath)")
                            }
                            else{
                                print("Error in writing data! Please create dist folder if missing.");
                                print("Error in writing data! Please create folder in current directory");
                            }
                        }
                    }
                    catch {print("Error in reading file. Please check name and extension of file.                                           *** File must be in current directory ***")}
                }
                
                
                else{
                    let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(self.input!)/")
                    var files = [URL]()
                    //Searching all text files in desktop directory
                    if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {                for case let fileURL as URL in enumerator {
                        do {
                            let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                            if fileAttributes.isRegularFile! {
                                new_result = try String(contentsOf: fileURL, encoding: .utf8)
                                new_result = new_result.replacingOccurrences(of: "\r?\n\r?\n\r?\n", with: "<p>", options: .regularExpression)
                                new_result = new_result.replacingOccurrences(of: "\r?\n\r?\n", with: "</p><p>", options: .regularExpression)
                                files.append(fileURL)
                            }
                        }catch { print(error, fileURL) }
                    }
                    }
                    //
                    for i in 0..<files.count {
                        let fileName = files[i].deletingPathExtension().lastPathComponent
                        if (files[i].lastPathComponent.hasSuffix(".txt")){
                            do {
                                //Reading the data
                                //!!!!!!!!!!!!!!!!
                                new_result = try String(contentsOf: files[i], encoding: .utf8)
                                new_result = new_result.replacingOccurrences(of: "\n\n\n", with: "<p>", options: .regularExpression)
                                new_result = new_result.replacingOccurrences(of: "\n\n", with: "</p><p>", options: .regularExpression)
                                new_result = new_result.replacingOccurrences(of: fileName, with: "", options: .regularExpression)
                                print("File data copied")
                                
                                //Writing the data
                                //!!!!!!!!!!!!!!!!
                                let storedText =  "<!doctype html><html lang =\(self.lang ?? "en-CA")><head><LINK rel='stylesheet' href=\(self.stylesheet ?? " ")><meta charset='utf-8'><title>\(fileName)</title><meta name='viewport' content='width=device-width,initial-scale=1'></head><body><h1>\(fileName)</h1>\(new_result)</body></html>";
                                if (self.output != nil) {
                                    let filePath = FileManager.default.currentDirectoryPath + "/\(self.output ?? " ")/\(fileName).html"
                                    if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                                    {
                                        try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                        print("File Created at \(filePath)")
                                    }
                                    else{
                                        print("Error in writing data! Please create folder in current directory");
                                    }
                                }
                                else{
                                    let filePath = FileManager.default.currentDirectoryPath + "/Dist/\(fileName).html"
                                    if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                                    {
                                        try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                        print("File Created at \(filePath)")
                                    }
                                    else{
                                        print("Error in writing data! Please create folder in current directory");
                                    }
                                }
                            }
                            catch {print("Error in reading folder. Please check name and location of folder.                                           *** Folder must be in current directory ***")}
                        }
                    }
                }
            }
        }
    }
}

Command.Main.main()
