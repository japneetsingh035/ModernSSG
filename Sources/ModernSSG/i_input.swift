//
//  i_input.swift
//  
//
//  Created by Japneet Kalra on 2021-09-15.
//

import Foundation
import ArgumentParser

extension Command {
    struct i_input: ParsableCommand{
        static var configuration: CommandConfiguration {
            .init(
                commandName: "i",
                abstract: "allow the user to specify an input directory to be processed",
                subcommands: [Command.stylesheet.self,
                              Command.Output.self]
            )
        }
        @Option(name: .shortAndLong, help: "Enter the stylesheet URL to be added in body tags.") var stylesheet: String?
        
        @Option(name: .long, help: "Enter the output folder to move html file") var output: String?
        
        @Argument(help: "convert all text files in current directory to html")
        var folder_name : String
        var new_result = " ";
        mutating func run() throws{
            
            //defining the url of folder
            //!!!!!!!!!!!!!!!!!!!!!!!!!!
            let url = URL(fileURLWithPath: NSHomeDirectory() + "/Desktop/ModernSSG/\(self.folder_name)/")
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
                    let storedText =  "<!doctype html><html><head><LINK rel='stylesheet' href=\(self.stylesheet ?? " ")><meta charset='utf-8'><title>\(fileName)</title><meta name='viewport' content='width=device-width,initial-scale=1'></head><body><h1>\(fileName)</h1>\(new_result)</body></html>";
                    if (self.output != nil) {
                        let filePath = NSHomeDirectory() + "/Desktop/ModernSSG/\(self.output ?? " ")/\(fileName).html"
                        if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                        {
                            try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                            print("File Created at \(filePath)")
                        }
                        else{
                            print("Error in writing data");
                        }
                    }
                    else{
                        let filePath = NSHomeDirectory() + "/Desktop/ModernSSG/Dist/\(fileName).html"
                        if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
                        {
                            try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                            print("File Created at \(filePath)")
                        }
                        else{
                            print("Error in writing data");
                        }
                    }
                }
                catch {print("Error in reading folder. Please check name and location of folder.                                           *** Folder must be in current directory ***")}
                }
            }
        }
    }
}

