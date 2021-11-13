# ModernSSG #
 Modern SSG is a Static Site Generator which helps to convert text files to HTML made with Apple Swift version 5.4.2 with help of Argument Parser.

## Pre-requisites ##
Swift is an ios based development language. This requires Swift installed on your mac. To run this on windows you require minimum swift packge 5.3 to run or XCode version 12. To work on this project xcode installation is must!
[Install Swift](https://swift.org/getting-started/#installing-swift)

## Terminal Usage ##
```bash
$ gh repo clone japneetsingh035/ModernSSG
$ cd ModernSSG
$ swift package generate-xcodeproj
$ swift build
$ swift test
$ swift run ModernSSG [subcommands]
``` 

## To contribute to add more testing ##
Please update testExample function in ModernSSGUnitTests or feel free to add more functions.

## Brew Installation
[Installing brew on mac](https://brew.sh/)
```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install swiftformat
```bash
$ brew install swiftformat
$ swiftformat [fileName]
```

## Install swiftlint
```bash
$ brew install swiftlint
$ swiftLint [fileName]
```

### AppCode

To integrate SwiftLint with AppCode, install
[this plugin](https://plugins.jetbrains.com/plugin/9175) and configure
SwiftLint's installed path in the plugin's preferences.
The `autocorrect` action is available via `⌥⏎`.

### Atom

To integrate SwiftLint with [Atom](https://atom.io/), install the
[`linter-swiftlint`](https://atom.io/packages/linter-swiftlint) package from
APM.

### Visual Studio Code

To integrate SwiftLint with [vscode](https://code.visualstudio.com), install the
[`vscode-swiftlint`](https://marketplace.visualstudio.com/items?itemName=vknabel.vscode-swiftlint) extension from the marketplace.
