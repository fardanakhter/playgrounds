import UIKit

//extension String {
//    var containsNonEnglishNumbers: Bool {
//        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
//    }
//
//    var english: String {
//        return self.applyingTransform(StringTransform.toLatin, reverse: false) ?? self
//    }
//}

extension String {
    private static let formatter = NumberFormatter()

    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }

        Self.formatter.locale = locale
        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            guard let digit = Self.formatter.number(from: String($0)) else {
                assertionFailure("Can not convert to number from: \(original)")
                return (original, original)
            }
            guard let localized = Self.formatter.string(from: digit) else {
                assertionFailure("Can not convert to string from: \(digit)")
                return (original, original)
            }
            return (original, localized)
        }

        var converted = self
        for map in maps { converted = converted.replacingOccurrences(of: map.original, with: map.converted) }
        return converted
    }
}


"12345".convertedDigitsToLocale(Locale(identifier: "AR")) /* ۱۲۳۴۵ */
"123123123".convertedDigitsToLocale(Locale(identifier: "EN")) /* 12345 */
