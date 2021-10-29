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
        
        //input
        @Option(name: .shortAndLong ,help:"allow the user to specify an input file or folder to be processed") var input: String
        
        //stylesheet
        @Option(name: .shortAndLong, help: "allow the user to optionally specify a URL to a CSS stylesheet.") var stylesheet: String?
        
        //output
        @Option(name: .shortAndLong, help: "allow the user to specify an output folder to be processed.") var output: String?
        
        //lang
        @Option(name: .shortAndLong, help:"allow the user to specify the language attribute on root html.") var lang: String?
        
        //lang
        @Option(name: .long, help:"allow the user to specify the image attribute on root html.") var image: String?
        
        mutating func run() throws{
            
            //Searching the argumented file in current directory
            if (self.input.hasSuffix(".txt")||self.input.hasSuffix(".md")){
                filereadAndWrite()
            }
            //Searching the argumented folder in current directory
            else{
                readAndWriteFolder()
            }
        }
        func filereadAndWrite() {
            do {
                //Reading & Copying the data
                //!!!!!!!!!!!!!!!!
                let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/" + self.input)
                let fileName: NSString = self.input as NSString
                let pathPrefix = fileName.deletingPathExtension
                print("File URL to read \(fileURL)")
                var data = try String(contentsOf: fileURL, encoding: .utf8)
                //conversion of text to html
                if(self.input.hasSuffix(".txt")) {
                    data = data.replacingOccurrences(of: "\r?\n\r?\n\r?\n", with: "<p>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "\r?\n\r?\n", with: "</p><p>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "\(pathPrefix)", with: "", options: .regularExpression)

                //conversion of MD to html
                } else if(self.input.hasSuffix(".md")){
                    
                    //Improved Accessibility of generated HTML
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
                    
                    //Full Markdown support
                    data = data.replacingOccurrences(of: "^**[A-Za-z0-9 !\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]$", with: "<b>", options: .regularExpression)
                    data = data.replacingOccurrences(of: "^[A-Za-z0-9 !\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]$**", with: "</b>", options: .regularExpression)
                    //Add support for a horizontal rule in Markdown
                    data = data.replacingOccurrences(of: "---", with: "<hr>", options: .regularExpression)
                }
                //Writing the data
                //!!!!!!!!!!!!!!!!
                let storedText =
                "<!doctype html><html lang = \(self.lang ?? "en-CA")><head><LINK rel='stylesheet' href=\(self.stylesheet ?? " ")><meta charset='utf-8'><title>\(pathPrefix)</title><meta name='viewport' content='width=device-width, initial-scale=1'></head><body><h1>\(pathPrefix)</h1><img src=\(self.image ?? "") alt = 'image-alt'>\(data)</body></html>";
                
                //if output path is mentioned
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
                //if output path is not mentioned
                else{
                    let filePath = FileManager.default.currentDirectoryPath + "/Dist/\(pathPrefix).html"
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
            catch {print("Error in reading file. Please check name and extension of file.*** File must be in current directory ***")}
        }
        func readAndWriteFolder(){
            let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(self.input)/")
            var files = [URL]()
            //Searching all text files in desktop directory
            if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
                for case let fileURL as URL in enumerator {
                    do {
                        let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                        if fileAttributes.isRegularFile! {
                            files.append(fileURL)
                        }
                    }
                    catch { print(error, fileURL) }
                }
            }
            //Determining number of files and creating loop
            for i in 0..<files.count {
                let fileName = files[i].deletingPathExtension().lastPathComponent
                if (files[i].lastPathComponent.hasSuffix(".txt")){
                    do {
                        //Reading & Copying the data
                        //!!!!!!!!!!!!!!!!
                        var data = try String(contentsOf: files[i], encoding: .utf8)
                        data = data.replacingOccurrences(of: "\r?\n\r?\n\r?\n", with: "<p>", options: .regularExpression)
                        data = data.replacingOccurrences(of: "\r?\n\r?\n", with: "</p><p>", options: .regularExpression)
                        data = data.replacingOccurrences(of: "\(fileName)", with: "", options: .regularExpression)
                        
                        //Writing the data
                        //!!!!!!!!!!!!!!!!
                        let storedText =  "<!doctype html><html lang =\(self.lang ?? "en-CA")><head><LINK rel='stylesheet' href=\(self.stylesheet ?? " ")><meta charset='utf-8'><title>\(fileName)</title><meta name='viewport' content='width=device-width,initial-scale=1'></head><body><h1>\(fileName)</h1><img src=\(self.image ?? "") alt = 'image-alt'>\(data)</body></html>";
                        
                        //if output path is mentioned
                        if (self.output != nil) {
                            let filePath = FileManager.default.currentDirectoryPath + "/\(self.output ?? " ")/\(fileName).html"
                            if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                            {
                                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                                print("File Created at \(filePath)")
                            }
                            else
                            {
                                print("Error in writing data! Please create folder in current directory");
                            }
                        }
                        //if output path is not mentioned
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
                    catch {print("Error in reading folder. Please check name and location of folder.*** Folder must be in current directory ***")}
                }
            }
        }
    }
}
Command.Main.main()
