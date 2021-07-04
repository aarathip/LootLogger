//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Aarathi Prasad on 7/3/21.
//

import UIKit

//UITableViewController is a subclass of UIViewController, which has a view
//UITableViewController's view always an instance of UITableView, and it prepares and presents the UITableView
//When it creates the view, dataSource and delegate properties of the UITableView are automatically set to point at the UITableViewController


//In Main.Storyboard, delete default ViewController and add a TableViewController, set its class to ItemsViewController and set it as the initial view controller.

class ItemsViewController:UITableViewController {
    
    //this property should be set in SceneDelegate, when the scene method is called.
    //SceneDelegate in SceneDelegate.swift serves as the delegate for the app's scenes.
    
    //this is a dependency injection, used an injection through a property to give this controller a store
    var itemStore: ItemStore!
    
    //this method is required, so ItemsViewController must implement this
    //this method tells the data source to return the number of rows in a given section of a table view
    //by default a tableview has one section, but for e.g., in Contacts, all names starting with a letter are grouped together in one section. In this example, only one section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    //second required method asks datasource for a cell to insert at a particular index of the tableview
    //Each row of a table view is a view, an instance of UITableViewCell
    //Each cell has a contentView, and sometimes an accessory view
    //In this example, the contentView has three subviews, two UILabels and a UIImageView
    //First we will only add the labels, textLabel and detailTextLabel
    //Run after adding the labels
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create an instance of IOTableViewCell with default appearance
        let cell = UITableViewCell (style: .value1, reuseIdentifier: "UITableViewCell")
        
        //Set the text on the cell with the discription of the item
        //at the nth index of items, n = row of this cell
        //will appear in on the table view
        
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    //UITableView has an editing property, and when this property is set to true, the UITableView enters editing mode. Once the table view is in editing mode, the rows of the table can be manipulated by the user. Depending on how table view is configured, user can change order, add, or remove rows - editing mode does not allow user to edit the content.
    //To put UITAbleView in editing mode, we need to include a button in the header view of the table. Header view appears at the top of a table, and is useful for adding section-wide or table-wide titles and controls - can be any UIView instance.
    
    //We will add a View as a header, and then add two UIButtons to the header. We will add the actions here and the header and the buttons in storyboard file
    
    @IBAction func addNewItem(_ sender: UIButton) {
        
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        
    }
    
}
