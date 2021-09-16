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
            abstract: "allow the user to specify an input file to be processed"
          )
        }
    @Argument(help: "convert this text file to html")
    var filename: String
    var result = ""
    mutating func run() throws{
        
        //Searching the file in desktop directory
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(self.filename)
            let fName: NSString = self.filename as NSString
            let pathPrefix = fName.deletingPathExtension
            
            //Reading the data
            do {
                result = try String(contentsOf: fileURL, encoding: .utf8)
                result = result.replacingOccurrences(of: "\n\n" , with: "<p>", options: .regularExpression)
                result = result.replacingOccurrences(of: pathPrefix, with: "")
                print("File data red")
            }
            catch {print("Error in reading data")}
            
            //Writing the data
            let storedText =  "<!doctype html><html><head><meta charset='utf-8'><title>" + pathPrefix + "</title><meta name='viewport' content='width=device-width', initial-scale=1'></head><body><h1>" + pathPrefix + "</h1>" + result + "</body></html>";
            let filePath = NSHomeDirectory() + "/Desktop" + pathPrefix + ".HTML"
            if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
            {
                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
            }
            else{
                print("error in writing data");
            }
        }
    }
  }
}
