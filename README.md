# ModernSSG #
 Modern SSG is a Static Site Generator which helps to convert text files to HTML made with Apple Swift version 5.4.2 with help of Argument Parser.

# Features #
## Help ##
```bash
OVERVIEW: A program to convert text files to HTML site generator

USAGE: ModernSSG --input [--stylesheet ] [--output] [--image]

OPTIONS:
  -i, --input             allow the user to specify an input file or folder to
                          be processed
  -s, --stylesheet
                          allow the user to optionally specify a URL to a CSS
                          stylesheet.
  -o, --output            allow the user to specify an output folder to be
                          processed.
  --image                 
  --version               Show the version.
  -h, --help              Show help information.
```

## Version ##
This command allows the version to specify the current version of the tool.

```bash
swift run ModernSSG --version
ModernSSG 0.0.1
```

## Input ##
This commands allows the user to specify the input file present in desktop directory for the command line tool to read and look for same file. Please mention the file extension to avoid reading error.

```bash
swift run ModernSSG --input "your text file"
swift run ModernSSG --config modernSsgConfing.json
```

## Output ##
This commands allows the user to specify the output folder present in current directory for the command line tool to read and move all output files to this folder.

```bash
swift run ModernSSG --input "your text file" --output "your output folder name"
```

## i ##
This commands allows the user to specify the input folder/directory present in current directory for the command line tool to read and look for all files. 

```bash
swift run ModernSSG -i "your input folder directory" 
```
## Stylesheet ##
This command allow the user to specify a stylesheet URL to be processed on all files present in dist folder.

```bash
swift run ModernSSG --input "your text file" --stylesheet "your link here" "https://cdn.jsdelivr.net/npm/water.css@2/out/water.css"
```

## Image ##
This command allow the user to specify a image URL to be processed on file present in dist folder.

```bash
swift run ModernSSG --input "your text file" --image "your link here" "https://cdn.jsdelivr.net/npm/water.css@2/out/water.css"
```

## Example ##

**Before** "your filename.txt"

```bash
My first SSG Generator file
This is my first paragraph
This is my second paragraph
```

**After** "your filename.html"
```bash
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

## Contributing ##
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License ##
[MIT](https://choosealicense.com/licenses/mit/)

## Sources ##
[Build a Command Line Tool Using Swift Argument Parser by Riccardo](https://betterprogramming.pub/build-a-command-line-tool-using-swift-argument-parser-f7d9443b785)

[FileManager](https://developer.apple.com/documentation/foundation/filemanager/)

[Argument Parser](https://github.com/apple/swift-argument-parser)

## Author
[JAPNEET SINGH](https://github.com/japneetsingh035)
