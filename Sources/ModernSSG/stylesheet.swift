//
//  stylesheet.swift
//  
//
//  Created by Japneet Kalra on 2021-09-15.
//

import Foundation
import ArgumentParser

extension Command {
    struct stylesheet: ParsableCommand {
        static var configuration: CommandConfiguration {
            .init(
                commandName: "--stylesheet",
                abstract: "allow the user to optionally specify a --stylesheet or -s URL to a CSS stylesheet "
            )
        }
        //allows the user to argument for URL Stylesheet
        @Argument(help: "enter the stylesheet URL to be added in body tags.")
        var stylesheet: String
    }
}
