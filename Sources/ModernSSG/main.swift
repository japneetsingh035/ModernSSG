import ArgumentParser

enum Command {}

extension Command {
  struct Main: ParsableCommand {
    static var configuration: CommandConfiguration {
      .init(
        commandName: "ModernSSG",
        abstract: "A program to convert text files to HTML site generator",
        version: "0.0.1",
        subcommands: [
            Command.input.self
        ]
      )
    }
  }
}

Command.Main.main()
