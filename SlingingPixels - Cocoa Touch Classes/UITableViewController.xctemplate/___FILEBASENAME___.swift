//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit

//MARK: - Reusable Views
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
extension UITableViewCell: ReusableView { }
extension UITableView {
    /// Note, you must set the identifier in the Storyboard!
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: NSIndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("No way, Jose... could not dequeue cell w/ identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

class ___FILEBASENAMEASIDENTIFIER___: UITableViewController, SegueHandlerType {

    enum SegueIdentifier: String {
        case example /// Must also set as Segue Identifier in Storyboard!
    }
    
    //MARK: - Properties
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
     // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segueIdentifierForSegue(segue) {
        case .example:
            break
//            let newVC = segue.destination as? NewViewController
//            
//            let handler = { [unowned self] in
//                magic("done")
//                
//            }
//            newVC?.configure(withHandler: handler)
        }
     }
 
    
}
    
// MARK: - Table view data source
extension ___FILEBASENAMEASIDENTIFIER___ {
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExampleTableViewCell.reuseIdentifier, for: indexPath) as! ExampleTableViewCell
        
        let model = ExampleTableViewCellModel(/*track: tracks[indexPath.row]*/)
        
        cell.configure(withDataSource: model)
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}

//MARK: - Table View Delegate
extension ___FILEBASENAMEASIDENTIFIER___ {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndexPath = indexPath
        performSegueWithIdentifier(.example, sender: self)
    }
    
//    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        /** Allows the bottom cell to be fully visible when scrolled to end of list */
//        return 2
//    }
//    
//    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView              = UIView()
//        footerView.frame            = CGRectMake(0, 0, view.bounds.size.width, 2.0)
//        footerView.backgroundColor  = UIColor.clearColor()
//        return footerView
//    }
}
