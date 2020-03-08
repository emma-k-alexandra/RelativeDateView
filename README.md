# RelativeDateView

An autoupdating SwiftUI view for displaying time relative to a `Date`. 

## Examples

For a `Date` that's 1 minute in the past, display "1 minute ago".

For a `Date` that's 2 weeks in the future, display "in 2 weeks".

For a `Date` that's now, display "right now".

Text is fully customizable, and display automatically updates as the time delta between now and your date changes.

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Contact](#contact)
- [Contributing](#contributing)
- [License](#license)

## Requirements

- Swift 5.1+
- macOS 10.15+, iOS 13+, tvOS 13+, watchOS 6+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/emma-k-alexandra/RelativeDateView.git", from: "3.0.0")
]
```

## Usage

```swift
import RelativeDateView

struct ContentView: View {
    @State private var isFuture = true
    @State private var date = Date().addingTimeInterval(2 * 60)
    
    var body: some View {
        if self.isFuture {
            return AnyView(
                RelativeDateView(
                    date: $date,
                    format: [
                        .nowFuture: "ARR",
                        .nowPast: "BRD",
                        .secondsFuture: "1",
                        .secondsPast: "BRD",
                        .oneMinuteFuture: "1",
                        .minutesFuture: "%.f"
                    ],
                    isFuture: $isFuture
                ) { text in 
                    text.bold()
                }
            )
            
        } else {
            return AnyView(Text("It's in the past"))
        
        }
        
    }

}
```
For details on `format`, see [DateHelper](https://github.com/emma-k-alexandra/DateHelper#4-string-with-relative-time-format).

## Dependencies

- DateHelper

## Contact

Feel free to email questions and comments to [emma@emma.sh](mailto:emma@emma.sh)

## License

RelativeDateView is released under the MIT license. [See LICENSE](https://github.com/emma-k-alexandra/RelativeDateView/blob/master/LICENSE) for details.
