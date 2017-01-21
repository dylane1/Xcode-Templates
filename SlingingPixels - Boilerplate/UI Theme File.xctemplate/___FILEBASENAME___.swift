//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

/**
 Helpful tip: Create themes by searching Adobe Color CC
 Adobe Color CC: https://color.adobe.com/create/color-wheel/
 
 Generate UIColors using Sip
 Sip: http://sipapp.io
 */

import UIKit

struct Theme {
    /// Universal
//    static let textLight                = UIColor.
//    static let textStrokeLight          = UIColor.
//    static let textDark                 = UIColor.
//    static let destructiveButtonTint    = UIColor.
//    static let buttonTint               = UIColor.
//    static let presentationDimBGColor   = UIColor.
//    static let shadows                  = UIColor.rangoonGreen()
    
    /// Tab Bar / Navigation Bar
//    static let barTintColor             = UIColor.
//    static let navBarTitleColor         = UIColor.
    
    /// Buttons
}

extension UIColor {
    /// Example from Sip:
    
    
    /**
     name: Rangoon Green
     red: 0.1215686275
     green: 0.1215686275
     blue: 0.1019607843
     alpha: 1.0000000000
     hex: #1F1F1A
     **/
    
    public class func rangoonGreen() -> UIColor {
        return UIColor(red: 0.1215686275, green: 0.1215686275, blue: 0.1019607843, alpha: 1.0000000000);
    }
}
