//
//  String.swift
//  Codejo
//
//  Created by Cole James on 5/20/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit

extension String {

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    func capitalizingOnlyFirstLetter() -> String {

        return lowercased().prefix(1).capitalized + lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    func first(_ count: Int) -> String {
        return String(self.prefix(count))
    }

    func last(_ count: Int) -> String {
        return String(self.suffix(count))
    }

    func replacingRouteParams(_ keyValues: [String: String?]) -> String {
        var mutatableString = self
        for (key, value) in keyValues {
            if let value = value {
                mutatableString = mutatableString.replacingOccurrences(of: "{\(key)}", with: value)
            } else {
                mutatableString = mutatableString.replacingOccurrences(of: "{\(key)}", with: "")
            }

        }
        return mutatableString
    }

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailPred.evaluate(with: self)
    }

    func isValidPassword() -> Bool {
        return count > 6
    }

    func isValidZipCode() -> (isValid:Bool, countryCode: String?) {
        let postalCodeRegex = [
            "US"    : "^[0-9]{5}(-[0-9]{4})?$",
            "CA"    : "^[A-Za-z]{1}[0-9]{1}[A-Za-z]{1}[ -]?[0-9]{1}[A-Za-z]{1}[0-9]{1}$"
        ]

        for regex in postalCodeRegex {
            let pinPredicate = NSPredicate(format: "SELF MATCHES %@", regex.value)

            if pinPredicate.evaluate(with: self) {
                return (true, regex.key)
            }
        }

        return (false, nil)
    }

    func estimatedHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        return actualSize.height
    }

    subscript(offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]

    }

    // returns nil if there is no nth occurence
    // or the index of the nth occurence if there is
    func findNthIndexOf(n: Int, character: Character) -> Int? {
        guard n > 0 else { return nil }

        var count = 0

        for (index, char) in self.enumerated() where char == character{
            count += 1
            if count == n {
                return index
            }
        }

        return nil
    }

    mutating func replace(_ index: Int?, _ newChar: Character) {
        guard let index = index else { return }

        var chars = Array(self)
        chars[index] = newChar
        self = String(chars)
    }

    func onlyNumChars() -> String {
        return self.filter { char -> Bool in
            return char.isNumberCharacter()
        }
    }

    func onlyNumCharsAndDashes() -> String {
        let charSet = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890-")
        return self.filter {charSet.contains($0) }
    }

    func replacingUTMTags(prependCampaign: String? = nil, storedCampaigns: [String]?) -> String {
        var mutableString = self

        if mutableString.contains("utm_medium=&") {
            mutableString = mutableString.replacingOccurrences(of: "utm_medium=&", with: "utm_medium=ios&")
        } else if mutableString.suffix(11) == "utm_medium=" {
            mutableString = mutableString.replacingOccurrences(of: "utm_medium=", with: "utm_medium=ios")
        }

        if mutableString.contains("utm_campaign=&") {
            mutableString = mutableString.replacingOccurrences(of: "utm_campaign=&", with: "utm_campaign=\(storedCampaigns?.commaDelimited(prependString: prependCampaign) ?? "")&")
        } else if mutableString.suffix(13) == "utm_campaign=" {
            mutableString = mutableString.replacingOccurrences(of: "utm_campaign=", with: "utm_campaign=\(storedCampaigns?.commaDelimited(prependString: prependCampaign) ?? ""))")
        }

        return mutableString
    }
}

extension String {

    var replacingPTags: String {
        let string = self.replacingOccurrences(of: "</p><p>", with: "\n\n").replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "")
        return string
    }

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    func formattedNewLines() -> String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }

    func autoplay(_ value: Bool = true) -> String {
        var newStr = self
        if !self.contains("?") {
            newStr.append("?")
        } else {
            newStr.append("&")
        }
        newStr.append("autoplay=\(value ? 1 : 0)")
        return newStr
    }

    func playinline(_ value: Bool = true) -> String {
        var newStr = self
        if !self.contains("?") {
            newStr.append("?")
        } else {
            newStr.append("&")
        }
        newStr.append("playsinline=\(value ? 1 : 0)")
        return newStr
    }

    func emailEncoding() -> String? {
        let allowedCharacters = NSMutableCharacterSet()
        allowedCharacters.formUnion(with: NSCharacterSet.letters)
        allowedCharacters.formUnion(with: NSCharacterSet.decimalDigits)
        allowedCharacters.addCharacters(in: "._@")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters as CharacterSet)
    }

}
