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
                commandName: "--output",
                abstract: "allow the user to specify an --output or -o folder to be processed"
            )
        }
        @Argument(help: "all html files moved to destination folder")
        var output: String
    }
}
