# ModernSSG
 Modern SSG is a Static Site Generator which helps to convert text files to HTML made with Apple Swift version 5.4.2 with help of Argument Parser.

## Pre-requisites
Swift is an ios based development language. This requires Swift installed on your mac or windows. To work on this project xcode installation is required.

## Terminal Usage
```bash
$ mv ModernSSG Desktop/ModernSSG
$ swift package init --type executable
$ swift build
$ swift run
$ swift run ModernSSG [subcommands]
```

## Help
```bash
OVERVIEW: A program to convert text files to HTML site generator

USAGE: ModernSSG <subcommand>

OPTIONS:
  --version               Show the version.
  -h, --help              Show help information.

SUBCOMMANDS:
  input                 allow the user to specify an input file to be processed
  
  i                     allow the user to specify an input directory to be processed on all files
  
  output                allow the user to specify an output folder to be processed on all files
  
  stylesheet            allow the user to specify a stylesheet URL to be processed on all files

  See 'ModernSSG help <subcommand>' for detailed help.
Program ended with exit code: 0
```

## Version
This command allows the version to specify the current version of the tool.

```swift
swift run ModernSSG --version
0.0.1
```

## Input
This commands allows the user to specify the input file present in desktop directory for the command line tool to read and look for same file. Please mention the file extension to avoid reading error.

```swift
swift run ModernSSG input "your text file"
File URL to read file from "your text file URL"
File data copied
File Created at "your html file URL"
```
## Example

Before: "your filename.txt"

```
My first SSG Generator file
This is my first paragraph
This is my second paragraph
```

After: "your filename.html"
```
<!doctype html>
<html>
<head>
<LINK rel='stylesheet' href="URL">
<meta charset='utf-8'>
<title>"Your filename"</title>
<meta name='viewport' content='width=device-width', initial-scale=1'>
</head>
<body>
<h1>This is my first SSG Generator file</h1>
<p>This is my first paragraph</p>
<p>This is my second paragraph</p>
</body>
</html>"
```

## Output
This commands allows the user to specify the output folder present in current directory for the command line tool to read and move all output files to this folder.

```swift
swift run ModernSSG output "your output folder name"
[Your File Names]
```

## i
This commands allows the user to specify the input folder/directory present in current directory for the command line tool to read and look for all files. 

```swift
swift run ModernSSG i "your input folder directory" 
[Your File Names]
```
## Stylesheet
This command allow the user to specify a stylesheet URL to be processed on all files present in dist folder.

```swift
swift run ModernSSG stylesheet "https://cdn.jsdelivr.net/npm/water.css@2/out/water.css"
[Your File Names]
```


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Sources
[Build a Command Line Tool Using Swift Argument Parser by Riccardo](https://betterprogramming.pub/build-a-command-line-tool-using-swift-argument-parser-f7d9443b785)

[FileManager](https://developer.apple.com/documentation/foundation/filemanager/)

[Argument Parser](https://github.com/apple/swift-argument-parser)

## Author
[JAPNEET SINGH](https://github.com/japneetsingh035)
