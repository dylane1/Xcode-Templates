//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit
import MapKit

/**
 Adapted from Natasha "The Robot"'s WWDC 2016 POP talk:
 
 https://realm.io/news/appbuilders-natasha-muraschev-practical-protocol-oriented-programming
 */


protocol ReusableView: class { }

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

/**
 * Example of usage
 */
extension MKAnnotationView: ReusableView { }
extension MKPinAnnotationView: ReusableView { }
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

//extension UICollectionView {
//    internal func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
//        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
//            fatalError("No way, Jose... could not dequeue cell w/ identifier: \(T.reuseIdentifier)")
//        }
//        return cell
//    }
//}
