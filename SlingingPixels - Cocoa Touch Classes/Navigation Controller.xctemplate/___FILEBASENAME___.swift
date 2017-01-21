//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit

class ___FILEBASENAMEASIDENTIFIER___: UINavigationController {
    internal func setNavigationBarAttributes(isAppTitle isTitle: Bool = false, isTransparent: Bool = false) {
        if isTransparent {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.backgroundColor = UIColor.clear
        }
        
        navigationBar.tintColor     = Theme.navBarTitleColor
        navigationBar.isTranslucent = true
        
//        var titleLabelAttributes: [String : AnyObject] = [NSForegroundColorAttributeName : Theme.navBarTitleColor]
        
//        if isTitle {
//            titleLabelAttributes[NSFontAttributeName] = UIFont(name: Constants.FontName.markerFelt, size: 18)!
//        } else {
//            titleLabelAttributes[NSFontAttributeName] = UIFont(name: Constants.FontName.avenirHeavy, size: 18)
//        }
        
//        navigationBar.titleTextAttributes = titleLabelAttributes
    }
}
