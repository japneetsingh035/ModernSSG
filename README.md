# ModernSSG
 Modern SSG is a Static Site Generator converting text to HTML using Swift.

## Installation


```bash

```

## Usage

```Swift
//Initializing the extension and searching file
if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(self.filename)
            let fName: NSString = self.filename as NSString
            let pathPrefix = fName.deletingPathExtension
```            


```Swift
//Reading the data
            do {
                result = try String(contentsOf: fileURL, encoding: .utf8)
                result = result.replacingOccurrences(of: "\n\n" , with: "<p>", options: .regularExpression)
                result = result.replacingOccurrences(of: pathPrefix, with: "")
            }
            catch {print("Error in reading data")}
```

```Swift
//Writing the data
let storedText =  "<!doctype html><html><head><meta charset='utf-8'><title>" + pathPrefix + "</title><meta name='viewport' content='width=device-width', initial-scale=1'></head><body><h1>" + pathPrefix + "</h1>" + result + "</body></html>";
            let filePath = NSHomeDirectory() + "/Desktop/ModernSSG/Dist/" + pathPrefix + ".HTML"
            if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil))
            {
                try storedText.write(toFile: filePath, atomically: false, encoding: .utf8)
            }
```
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Author
japneetsingh035
