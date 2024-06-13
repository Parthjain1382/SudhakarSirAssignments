import Foundation

func truncateString(_ input: String, toLength length: Int) -> String {
   
    guard length < input.count else {
        return input
    }
    
    let truncatedString = input[..<input.index(input.startIndex, offsetBy: length)]
    
    return String(truncatedString)
}

let originalString = "Hello, World!"
let truncatedString = truncateString(originalString, toLength: 5)
print(truncatedString)
