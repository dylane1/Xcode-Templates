//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

/**
 * Note, the protocol, extension & struct can be pulled out into a different
 * file & used as the data source for both table & collection cells if needed.
 */

import UIKit

protocol ___FILEBASENAMEASIDENTIFIER___DataSource {
//    var myObject: MyObject { get }
//    var textAttributes: [String : AnyObject] { get }
}

extension ___FILEBASENAMEASIDENTIFIER___DataSource {
//    var textAttributes: [String : AnyObject] {
//        return [
//            NSForegroundColorAttributeName: Constants.ColorScheme.white,
//            NSStrokeColorAttributeName:     Constants.ColorScheme.black,
//            NSStrokeWidthAttributeName:     -3.0
//        ]
//    }
}

struct ___FILEBASENAMEASIDENTIFIER___Model: ___FILEBASENAMEASIDENTIFIER___DataSource {
//    internal var myObject: MyObject
    
}

class ___FILEBASENAMEASIDENTIFIER___: UITableViewCell {

    //MARK: - Properties
    
    private var dataSource: ___FILEBASENAMEASIDENTIFIER___DataSource!
    
    
    //MARK: - IBOutlets
    ///labels, imageviews, etc.
    
    //MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Configuration
    
    internal func configure(withDataSource dataSource: ___FILEBASENAMEASIDENTIFIER___DataSource) {
        self.dataSource = dataSource
        
//        configureLabels()
//        configureCell()
    }

//    private func configureLabels() {
//        
//    }
    
//    private func configureCell() {
//        /// backgroundColor, etc.
//    }
}
