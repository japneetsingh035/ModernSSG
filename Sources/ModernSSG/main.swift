import ArgumentParser

enum Command {}

extension Command {
    struct Main: ParsableCommand {
        static var configuration: CommandConfiguration {
            .init(
                commandName: "ModernSSG",
                abstract: "A program to convert text files to HTML site generator",
                version: "Modern SSG 0.0.1",
                subcommands: [
                    Command.input.self,
                    Command.i_input.self,
                    Command.Output.self,
                    Command.stylesheet.self,
                ]
            )
        }
    }
}

Command.Main.main()
