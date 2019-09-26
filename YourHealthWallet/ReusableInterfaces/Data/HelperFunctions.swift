//
//  swift
//  Juicer
//
//  Created by Shridhar on 2/12/16.
//  Copyright (c) 2015 Digital Juice. All rights reserved.
//

import UIKit

import Contacts
import AddressBook
import MessageUI

public func installMatchSuperViewWithChildView(superView : UIView, childView : UIView) {
    
    superView.addConstraint(NSLayoutConstraint(item: childView,
                                               attribute: NSLayoutAttribute.width,
                                               relatedBy: NSLayoutRelation.equal,
        toItem: superView,
        attribute: NSLayoutAttribute.width,
        multiplier: 1.0,
        constant: 0.0))
    
    superView.addConstraint(NSLayoutConstraint(item: childView,
                                               attribute: NSLayoutAttribute.height,
                                               relatedBy: NSLayoutRelation.equal,
        toItem: superView,
        attribute: NSLayoutAttribute.height,
        multiplier: 1.0,
        constant: 0.0))
    
    superView.addConstraint(NSLayoutConstraint(item: childView,
                                               attribute: NSLayoutAttribute.centerX,
        relatedBy: NSLayoutRelation.equal,
        toItem: superView,
        attribute: NSLayoutAttribute.centerX,
        multiplier: 1.0,
        constant: 0.0))
    
    superView.addConstraint(NSLayoutConstraint(item: childView,
                                               attribute: NSLayoutAttribute.centerY,
        relatedBy: NSLayoutRelation.equal,
        toItem: superView,
        attribute: NSLayoutAttribute.centerY,
        multiplier: 1.0,
        constant: 0.0))
}

public func isPortrait() -> Bool{
    return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
}

public func isLandscape() -> Bool{
    return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
}

public func createFolderAtPathIfNotExists(folderPath : String){
    var isDir : ObjCBool = false
    
    if( FileManager.default.fileExists(atPath: folderPath, isDirectory: &isDir) == false){
        do {
            try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
        }
    }
}

public func isValidEmailID(checkString : String?) -> Bool{
    let stricterFilterString : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest : NSPredicate = NSPredicate(format: "SELF MATCHES %@", stricterFilterString)
    return emailTest.evaluate(with: checkString)
}

public func documentsDirectory() -> String {
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    return documentsFolderPath
}

// Get path for a file in the directory
public func fileInDocumentsDirectory(filename: String) -> String {
    
    let writePath = (documentsDirectory() as NSString).appendingPathComponent("Contacts")
    
    if (!FileManager.default.fileExists(atPath: writePath)) {
        do {
            try FileManager.default.createDirectory(atPath: writePath, withIntermediateDirectories: false, attributes: nil) }
        catch let error as NSError {
            print(error.localizedDescription);
        }
    }
    return (writePath as NSString).appendingPathComponent(filename)
}

public func showNetworkActivityIndicator(){
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
}

public func hideNetworkActivityIndicator(){
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
}

public func failAssert() {
    assert(0 != 0, "")
}

public func failAssertWithMsg(msg : String) {
    assert(0 != 0, msg)
}

public func intToString(value : Int) -> String{
    return String(format: "%d", value)
}

public func int32ToString(value : Int32) -> String{
    return String(format: "%ld", value)
}

public func floatToString(value : Float) -> String{
    return String(format: "%f", value)
}

public func sizeOfWindowWrtEye() -> CGSize{
    return (UIApplication.shared.delegate?.window??.bounds.size)!
}

public func degreesToRadians(deg : Int) -> CGFloat {
    return CGFloat(deg) * CGFloat(Double.pi) / 180.0
}

public func scaleImageWithRespectToSize(image : UIImage, newSize : CGSize) -> UIImage! {
    var scaledSize = CGSize.zero;
    scaledSize.width = ceil(newSize.width);
    scaledSize.height = ceil(newSize.height);
    
    if(Float(fabs((image.size.width / image.size.height) - (scaledSize.width / scaledSize.height))) == Float.ulpOfOne){
        return image;
    }
    
    UIGraphicsBeginImageContextWithOptions( scaledSize, false, 0.0 );
    let scaledImageRect = CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height)
    image.draw(in: scaledImageRect);
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

func getImageHeightWithRespectWidth(imageName: String?, maxWidth: CGFloat) -> CGFloat {
    if isEmptyString(string: imageName) || maxWidth == 0 {
        return 0
    }
    
    let image = UIImage(named: imageName!)
    
    return getImageHeightWithRespectWidth(image: image, maxWidth: maxWidth)
}

func getImageHeightWithRespectWidth(image: UIImage?, maxWidth: CGFloat) -> CGFloat {
    if image == nil {
        return 0
    }
    
    
    let imageSize = image!.size
    let aspectRatio = imageSize.width / imageSize.height
    return maxWidth / aspectRatio
}

func getBase64String(image: UIImage, compressionQuality: CGFloat = 0.5) -> String? {
    
    print(image.size)
    
    var maxSize = CGSize(width: 414, height: 0)
    
    var newImage = image
    
    var temp = UIImageJPEGRepresentation(newImage, 1.0)
    print("Original \(temp!.count/1000)kb")
    
    
    temp = UIImageJPEGRepresentation(newImage, compressionQuality)
    print("Original size reducing quality \(temp!.count/1000)kb")
    
    if newImage.size.width > maxSize.width {
        maxSize.height = getImageHeightWithRespectWidth(image: newImage, maxWidth: maxSize.width)
        
        newImage = scaleImageWithRespectToSize(image: image, newSize: maxSize)
        
        let temp = UIImageJPEGRepresentation(newImage, 1.0)
        print("After reducing size \(temp!.count/1000)kb")
        print(newImage.size)
    }
    
    let imageData = UIImageJPEGRepresentation(newImage, compressionQuality)
    
    print("After resized size reducing quality \(imageData!.count/1000)kb")
    
    var base64ImageStr = imageData?.base64EncodedString(options: Data.Base64EncodingOptions.endLineWithLineFeed)
    
    if base64ImageStr != nil {
        base64ImageStr = "data:image/jpeg;base64," + base64ImageStr!
    }
    return base64ImageStr
}

public func printAllFonts() {
    for fontFamilyNames in UIFont.familyNames {
        for fontName in UIFont.fontNames(forFamilyName: fontFamilyNames) {
            print("FONTNAME:\(fontName)")
        }
    }
}

public func isAvailable9Version() -> Bool {
    if #available(iOS 9, *) {
        return true
    } else {
        return false
    }
}

func addHeaderSeperator(tableView: TableView) {
    let px = 1 / UIScreen.main.scale
    let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: px)
    let line: UIView = UIView(frame: frame)
    tableView.tableHeaderView = line
    line.backgroundColor = tableView.separatorColor
    
}


public func isEmptyString(string : String?) -> Bool {
//    if string == nil {
//        return true
//    }
//
//    return string!.isEmpty
    guard string != nil && !(string!.isEmpty) else {
        return false
    }
    return true
}

func showAlrt(fromController: UIViewController, title: String?, message: String?, cancelText: String?, cancelAction: (()-> ())?, otherText: String?, action: (()-> ())?) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    if isEmptyString(string: cancelText) == false {
        alert.addAction(UIAlertAction(title: cancelText, style: UIAlertActionStyle.cancel, handler: { (alertAction) in
            cancelAction?()
        }))
    }
    
    if isEmptyString(string: otherText) == false {
        alert.addAction(UIAlertAction(title: otherText, style: UIAlertActionStyle.default, handler: { (alertAction) in
            action?()
        }))
    }
    
    fromController.present(alert, animated: true, completion: nil)
}

func notificationRegisterCheck() ->Bool {
    
    if (UIApplication.shared.isRegisteredForRemoteNotifications) == true {
        
        return true
    }
    else {
        return false
    }
}

func validateUrl (urlString: String?) -> Bool {    
    let urlRegEx = "((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
    
    print(NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString))
    
    return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
}

func sizeOfText(string:String , textView:TextView) -> CGFloat{
    let fixedWidth = textView.frame.size.width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    var newFrame = textView.frame
    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    if newFrame.size.height <= 42.0 {
        return 42.0
    }else{
       return newFrame.size.height
    }
}

func getDateFomateString(_ format:String) -> DateFormatter{
    let dateFormmat = DateFormatter()
    dateFormmat.dateFormat = format
    return dateFormmat
}

func statusBarHeight() -> CGFloat {
    let statusBarSize = UIApplication.shared.statusBarFrame.size
    return Swift.min(statusBarSize.width, statusBarSize.height)
}

public func stringFromTimeInterval(interval: TimeInterval) -> String {
    
    let ti = NSInteger(interval)
    
    let seconds = ti % 60
    let minutes = (ti / 60) % 60
    let hours = (ti / 3600)
    return String(format: "%0.2d:%0.2d:%0.2d", hours,minutes,seconds)
}

public func getHourFromInteval(interval: TimeInterval) -> Int{
    let ti = NSInteger(interval)
    let hours = (ti / 3600)
    return hours
}

public func getMinutesFromInteval(interval: TimeInterval) -> Int{
    let ti = NSInteger(interval)
    let minutes = (ti / 60) % 60
    return minutes
}

public func getSecondsFromInteval(interval: TimeInterval) -> Int{
    let ti = NSInteger(interval)
    let seconds = ti % 60
    return seconds
}

public func getTotalMinutesFromInteval(interval: TimeInterval) -> Int{
    let ti = NSInteger(interval)
    let minutes = (ti / 60)
    return minutes
}
