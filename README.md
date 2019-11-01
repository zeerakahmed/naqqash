# Naqqash نقّاش

A library of common string parsing functions for the Arabic script. If you are conducting natural language processing of any kind – for machine learning, linguistic analysis, or applications software, Naqqash provides common function such as removing diacritics, identifying Unicode points, and displaying contextual forms of letters in the Arabic script.

## Technology Stack

Naqqash is a Swift package. This choice of technology stack was made due to the requirements of the [Matnsaz keyboard](https://matnsaz.net), for which Naqqash was built. Matnsaz is an Urdu keyboard for iOS. A number of text processing functions required by Matnsaz will be useful for other applications, and hence we are open sourcing this library for general use.

Programming for iOS meant Swift was the necessary choice. However approaches taken in this library will scale to other languages. We encourage collaborations and suggestions on porting these methods to other technology stacks if needed.

## Structure

All library functions can be found in [`/Sources/Naqqash/Naqqash.swift`](/Sources/Naqqash/Naqqash.swift). Declarations have extensive comments. A test suite is provided in [`/Tests/NaqqashTests/NaqqashTests.swift`](/Tests/NaqqashTests/NaqqashTests.swift) which is also a good place to see the methods in use.

## How to use

To add the package to an existing Xcode project, [follow these instructions](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app). Once you have added the package dependency to your app, simply add an import statement in any file where you would like to use these methods by adding `import Naqqash` to the top of the file.

To use the package on the command line clone this repository:
- make sure you have swift installed
- `cd` into the directory
- and run `swift build`
This will build the repository on your machine.

To run test cases run `swift test`. 

Sample use is as follows:

```
print(Naqqash.isLetter("ب"))
>>> true

print(Naqqash.isLetter("۲"))
>>> false

print(Naqqash.isLeftJoining("ب"))
>>> true

print(Naqqash.addTatweelTo("ب", toDisplay: Naqqash.ContextualForm.Medial))
>>> "ـبـ"

print(Naqqash.removeDiacritics("اَب"))
>>> "اب"

```

## Languages Supported

The core of Naqqash supports all languages the use the Arabic script. However, due to Naqqash's development as a component of Matnsaz, a number of methods have been written with an Urdu frame of reference. Some of these will not scale to other languages. For example, diacritics have been divided into essential and non-essential sets, and these reflect their use in Urdu publishing. As support for new languages is requested we will revisit these choices and provide more generic and configurable options.

## Contribution and Engagement

For feature requests, issues, and comments please raise an issue on GitHub or get in touch [via our website](https://matnsaz.net/en/contact)

## License

This code is provided under the MIT license.