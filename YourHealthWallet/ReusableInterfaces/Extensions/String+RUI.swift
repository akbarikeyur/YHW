//
//  String+RUI.swift
//  Juicer
//
//  Created by Srikanth KV on 24/04/15.
//  Copyright (c) 2015 Digital Juice. All rights reserved.
//

import UIKit

extension String {
    public func length() -> Int{
        return self.lengthOfBytes(using: String.Encoding.utf8)
    }
    
    func equalsIgnoreCase (str : String) -> Bool {
        return self.compare(str, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil) == .orderedSame
    }
    
    func sizeOfString (width: CGFloat, font : UIFont) -> CGSize {
        return NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                                   options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                   attributes: [NSAttributedStringKey.font: font],
        context: nil).size
    }
    
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
    
    var removeExcessiveSpaces: String {
        let components = self.components(separatedBy: NSCharacterSet.whitespaces)
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joined(separator: " ")
    }
    
    
    func getDate(_ currFormat:String) -> Date?{
        var dateFormmat = DateFormatter()
        dateFormmat.dateFormat = currFormat
        dateFormmat.timeZone = NSTimeZone.local
        if let date = dateFormmat.date(from: self){
            return date
        }
        else{
            return nil
        }
    }
    
    func getDateString(_ currFormat:String, format:String) -> String{
        var dateFormmat = DateFormatter()
        if(currFormat != "")
        {
            dateFormmat.dateFormat = currFormat
        }
        if let date = dateFormmat.date(from: self){
            dateFormmat.dateFormat = format
            //dateFormmat.timeZone = TimeZone(identifier: "UTC")
            return dateFormmat.string(from: date)
        }
        else{
            return ""
        }
    }
    
    func getDateStringWithTimeZone(_ currFormat:String, format:String) -> String{
        var dateFormmat = DateFormatter()
        dateFormmat.timeZone = TimeZone(identifier: CONSTANT.TIME_ZONE)
        
        if(currFormat != "")
        {
            dateFormmat.dateFormat = currFormat
        }
        if let date = dateFormmat.date(from: self){
            dateFormmat.dateFormat = format
            dateFormmat.timeZone = TimeZone.ReferenceType.default
            return dateFormmat.string(from: date)
        }
        else{
            return ""
        }
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var isValidEmail: Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var trimmed:String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    var encoded:String{
        let str = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let data: Data? = str.data(using: String.Encoding.nonLossyASCII)
        let Value = String(data: data!, encoding: String.Encoding.utf8)
        return Value ?? ""
    }
    var urlEncoded:String{
        let data: Data? = self.data(using: String.Encoding.nonLossyASCII)
        let Value = String(data: data!, encoding: String.Encoding.utf8)
        return Value ?? ""
    }
    var decoded: String {
        let str = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let data: Data? = str.data(using: String.Encoding.utf8)
        let Value = String(data: data!, encoding: String.Encoding.nonLossyASCII)
        return Value ?? ""
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}
