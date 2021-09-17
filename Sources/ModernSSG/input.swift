//
//  input.swift
//  
//
//  Created by Japneet Kalra on 2021-09-14.
//
import Foundation
import ArgumentParser

extension Command {
    struct input: ParsableCommand {
        static var configuration: CommandConfiguration {
            .init(
                commandName: "input",
                abstract: "allow the user to specify an input file to be processed",
                subcommands: [Command.Output.self, Command.stylesheet.self]
            )
        }
        @Argument(help: "convert this text file to html")
        var filename: String
        var result = ""
        mutating func run() throws{
            
            //Searching the file in desktop directory
            
            let fileURL = URL(fileURLWithPath: NSHomeDirectory() + "/Desktop/ModernSSG/" + self.filename)
            let fName: NSString = self.filename as NSString
            let pathPrefix = fName.deletingPathExtension
            print("File URL to read \(fileURL)")
            
            //Reading the data
            
            do {
                result = try String(contentsOf: fileURL, encoding: .utf8)
                result = result.replacingOccurrences(of: "\n\n\n", with: "<p>", options: .regularExpression)
                result = result.replacingOccurrences(of: "\n\n", with: "</p><p>", options: .regularExpression)
                result = result.replacingOccurrences(of: pathPrefix, with: "")
                print("File data copied")
            }
            catch {print("Error in reading file. Please store text in desktop directory")}
            
            //Writing the data
            
            let storedText =  "<!doctype html><html><head><meta charset='utf-8'><title>\(pathPrefix)</title><meta name='viewport' content='width=device-width, initial-scale=1'></head><body><h1>\(pathPrefix)</h1>\(result)</body></html>";
            let filePath = NSHomeDirectory() + "/Desktop/ModernSSG/Dist/" + pathPrefix + ".html"
            
            if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
            {
                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
                print("File Created at \(filePath)")
            }
            else{
                print("error in writing data");
            }
        }
    }
}
