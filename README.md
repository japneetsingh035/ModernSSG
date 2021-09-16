# ModernSSG
 Modern SSG is a Static Site Generator which helps to convert text files to HTML using Swift with Argument Parser.

## Pre-requisites
Swift is an ios based development language. THis requires XCode Installed.

```bash
$ mv ModernSSG Desktop/ModernSSG
$ swift package init --type executable
```

## help
```bash
OVERVIEW: A program to convert text files to HTML site generator

USAGE: ModernSSG <subcommand>

OPTIONS:
  --version               Show the version.
  -h, --help              Show help information.

SUBCOMMANDS:
  --input                 allow the user to specify an input file or folder to
                          be processed
  -i                      allow the user to specify an input directory to be
                          processed
  --output                allow the user to specify an output folder to be
                          processed
  --stylesheet            allow the user to optionally specify a --stylesheet
                          or -s URL to a CSS stylesheet 

  See 'ModernSSG help <subcommand>' for detailed help.
Program ended with exit code: 0
```

## Usage
"USAGE: ModernSSG subcommand"

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Sources
[Build a Command Line Tool Using Swift Argument Parser by Riccardo](https://betterprogramming.pub/build-a-command-line-tool-using-swift-argument-parser-f7d9443b785)
[FILEMANAGER](https://developer.apple.com/documentation/foundation/filemanager/)
[ARGUMENT PARSER](https://github.com/apple/swift-argument-parser)

## Author
[JAPNEET SINGH](https://github.com/japneetsingh035)
