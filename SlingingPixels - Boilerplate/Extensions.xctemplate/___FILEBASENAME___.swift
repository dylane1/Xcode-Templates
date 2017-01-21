//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit
import MapKit
import CoreData
import HealthKit

//MARK: - Reusable Views
/**
 Adapted from Natasha "The Robot"'s WWDC 2016 POP talk:
 
 https://realm.io/news/appbuilders-natasha-muraschev-practical-protocol-oriented-programming
 */
extension MKAnnotationView: ReusableView { }
//extension MKPinAnnotationView: ReusableView { }
extension UITableViewCell: ReusableView { }
extension UICollectionViewCell: ReusableView { }

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: NSIndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("No way, Jose... could not dequeue cell w/ identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionView {
    internal func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("No way, Jose... could not dequeue cell w/ identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func drawLineAcrossBottomWithContext(height: CGFloat, color: UIColor) {
        
        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(height)
        context.setStrokeColor(color.cgColor)
        context.move(to: CGPoint(x: 0, y: bounds.height))
        context.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        context.strokePath()
    }
    //
    //    func drawLineAcrossRightSideWithContext(context: CGContext, height: CGFloat, color: UIColor) {
    //        CGContextSetLineWidth(context, height)
    //        CGContextSetStrokeColorWithColor(context, color.CGColor)
    //        CGContextMoveToPoint(context, bounds.width, 0)
    //        CGContextAddLineToPoint(context, bounds.width, bounds.height)
    //        CGContextStrokePath(context)
    //    }
}

extension UIView {
    /// Found this here: http://stackoverflow.com/questions/39283807/how-to-take-screenshot-of-portion-of-uiview
    /// Create snapshot
    ///
    /// - parameter rect: The `CGRect` of the portion of the view to return. If `nil` (or omitted),
    ///                   return snapshot of the whole view.
    ///
    /// - returns: Returns `UIImage` of the specified portion of the view.
    
    func snapshot(of rect: CGRect? = nil) -> UIImage? {
        // snapshot entire view
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let wholeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // if no `rect` provided, return image of whole view
        
        guard let image = wholeImage, let rect = rect else { return wholeImage }
        
        // otherwise, grab specified `rect` of image
        
        let scale = image.scale
        let scaledRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        guard let cgImage = image.cgImage?.cropping(to: scaledRect) else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
    }
    
}

extension UIButton {
    internal func configure(withTitle title: String,
                            backgroundColor bgColor: UIColor,
                            textColor: UIColor,
                            shadowColor: UIColor? = nil,
                            cornerRadius corner: CGFloat = 0,
                            font: UIFont = UIFont.systemFont(ofSize: 22, weight: UIFontWeightMedium)) {
        cornerRadius = corner
        titleLabel?.font = font
        
        setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        backgroundColor = bgColor
        
        if shadowColor != nil {
            layer.masksToBounds = false
            layer.shadowColor   = shadowColor?.cgColor
            layer.shadowOpacity = 1
            layer.shadowOffset  = CGSize(width: 0, height: 1)
            layer.shadowRadius  = 1
            //            layer.shadowPath    = UIBezierPath(rect: bounds).cgPath
        }
    }
}

extension UINavigationController {
    
    internal func setNavigationBarAttributes(isAppTitle isTitle: Bool = false, isTransparent: Bool = false) {
        if isTransparent {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.backgroundColor = UIColor.clear
        }
        
        navigationBar.tintColor    = Theme.navBarTitleColor
        navigationBar.isTranslucent  = true
        
        var titleLabelAttributes: [String : AnyObject] = [NSForegroundColorAttributeName : Theme.navBarTitleColor]
        
        if isTitle {
            titleLabelAttributes[NSFontAttributeName] = UIFont(name: Constant.FontName.markerFelt, size: 18)!
        } else {
            titleLabelAttributes[NSFontAttributeName] = UIFont(name: Constant.FontName.avenirHeavy, size: 18)
        }
        
        navigationBar.titleTextAttributes = titleLabelAttributes
    }
}


// MARK: - Email & URL validation

extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var safariOpenableURL: NSURL? {
        /// Remove whitespace
        let trimmedString = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        guard var url = NSURL(string: trimmedString) else {
            return nil
        }
        
        /// Test for valid scheme
        if !(["http", "https"].contains(url.scheme!.lowercased())) {
            let appendedLink = "http://".appending(trimmedString)
            url = NSURL(string: appendedLink)!
        }
        
        return url
    }
}


// MARK: - Core Data

/**
 * https://www.hackingwithswift.com/read/38/3/adding-core-data-to-our-project-nspersistentcontainer
 *
 * I decided putting it in an extension would make more sense than having to
 * call the app delegate each time to save
 */
extension NSPersistentContainer {
    class func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                magic("An error occurred while saving: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    internal func autoSave(context: NSManagedObjectContext, delayInSeconds seconds: Int) {
        if seconds > 0 {
            NSPersistentContainer.saveContext(context)
            
            let delayInNanoSeconds = UInt64(seconds) * NSEC_PER_SEC
            let time = DispatchTime.now() + Double(Int64(delayInNanoSeconds)) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.autoSave(context: context, delayInSeconds: seconds)
            }
        }
    }
}

//MARK: - Device Identification

/**
 * This is really just for UI testing in the simulator -- Need to show the user
 * a choice of activity types before starting the track, if CMMotionActivityManager
 * is not available. in order to check availablity, you can use:
 *      CMMotionActivityManager.isActivityAvailable()
 *
 * However, this fails on simulator, so I adapted this solution on Stack Overflow
 * for testing the device model for simulator testing.
 *
 * http://stackoverflow.com/questions/26028918/ios-how-to-determine-iphone-model-in-swift
 *
 */


extension UIDevice {
    var isCMMotionActivityAvailable: Bool {
        var machineString = ""
        
        if let model = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            machineString = model
        }
        
        switch machineString {
        case "iPod4,1":                                 return false //"iPod Touch 4G"
        case "iPod5,1":                                 return false //"iPod Touch 5G"
        case "iPod7,1":                                 return true //"iPod Touch 6G"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return false //"iPhone 4"
        case "iPhone4,1":                               return false //"iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return false //"iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return false //"iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return true //"iPhone 5s"
        case "iPhone7,2":                               return true //"iPhone 6"
        case "iPhone7,1":                               return true //"iPhone 6 Plus"
        case "iPhone8,1":                               return true //"iPhone 6s"
        case "iPhone8,2":                               return true //"iPhone 6s Plus"
        case "iPhone8,4":                               return true //"iPhone SE"
        case "iPhone9,1", "iPhone9,3":                  return true //"iPhone 7"
        case "iPhone9,2", "iPhone 9,4":                 return true //"iPhone 7 Plus"
            //        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            //        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            //        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            //        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            //        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            //        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            //        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            //        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            //        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            //        case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7 inch)"
            //        case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9 inch)"
        //        case "AppleTV5,3":                              return "Apple TV"
        default:                                        return false
        }
    }
}
