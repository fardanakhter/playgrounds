import UIKit

let jsonString =
"""
{\"messageText\":\"hello testing\",\"media\":[{\"mediaType\":\"video\",\"fileName\":\"https:\\/\\/s3.amazonaws.com\\/pointters_dev\\/dev\\/20200926_233600.mp4\"},{\"mediaType\":\"image\",\"fileName\":\"https:\\/\\/s3.amazonaws.com\\/pointters_dev\\/dev\\/20200926_233619.jpg\"}]}
"""

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

if let dict = convertToDictionary(text: jsonString){
    print(dict)
}

