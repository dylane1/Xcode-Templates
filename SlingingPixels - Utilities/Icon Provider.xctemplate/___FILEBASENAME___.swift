//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

/// Icon bezier drawing code generated in PaintCode

import UIKit

enum Icon: String {
    /*case Pin
     case Map
     case List
     case LocationMarker
     case LocationMarker30Point*/
    case disclosureIndicator
}

protocol IconProvidable {
    static func imageOfDrawnIcon(icon: Icon, size: CGSize, fillColor: UIColor, shadowColor: UIColor) -> UIImage
}

struct IconProvider { }

extension IconProvider: IconProvidable, DisclosureIndicatorDrawable {
    
    static func imageOfDrawnIcon(icon: Icon, size: CGSize, fillColor: UIColor = UIColor.black, shadowColor: UIColor = UIColor.black) -> UIImage {
        var image: UIImage {
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: size.height), false, 0)
            
            switch icon {
            case .disclosureIndicator:
                drawDisclosureIndicatorWithColor(fillColor: fillColor)
            }
            
            let img = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            return img
        }
        return image
    }
}
