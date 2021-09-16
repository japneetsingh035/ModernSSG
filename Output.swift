//
//  Output.swift
//  
//
//  Created by Japneet Kalra on 2021-09-15.
//
import Foundation
import ArgumentParser

extension Command {
  struct Output: ParsableCommand {
    static var configuration: CommandConfiguration {
          .init(
            commandName: "output",
            abstract: "allow the user to specify an output folder to be processed"
          )
        }
    @Argument(help: "all html files moved to destination folder")
    var folder_name: String
    var result = "";
    mutating func run() throws {
        let url = URL(fileURLWithPath: NSHomeDirectory() + "/Desktop/ModernSSG/Sherlock-Holmes-Selected-Stories/")
        var files = [URL]()
        if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
            for case let fileURL as URL in enumerator {
                do {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    if fileAttributes.isRegularFile! {
                        result = try String(contentsOf: fileURL, encoding: .utf8)
                        files.append(fileURL)
                    }
                } catch { print(error, fileURL) }
            }
        }
        for i in 0..<files.count {
        let fileName = files[i].deletingPathExtension().lastPathComponent
        print(fileName);
        do {
            result = try String(contentsOf: files[i], encoding: .utf8)
            result = result.replacingOccurrences(of: "\n\n" , with: "<p>", options: .regularExpression)
            result = result.replacingOccurrences(of: fileName, with: "")
        }
        catch {
            print("Error in reading data")
        }
        let storedText =  "<!doctype html><html><head><meta charset='utf-8'><title>" + fileName + "</title><meta name='viewport' content='width=device-width', initial-scale=1'></head><body><h1>" + fileName + "</h1>" + result + "</body></html>";
        let filePath = NSHomeDirectory() + "/Desktop/ModernSSG/" + self.folder_name + "/" + fileName + ".HTML"
        if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
            {
                print("File Created")
                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
            }
        else{
                print("the specified output path is not a valid directory. Please add directory to same folder.")
            }
        }
    }
  }
}
