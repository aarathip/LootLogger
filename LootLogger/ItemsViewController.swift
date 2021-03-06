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
    //Two ways to add rows to a table view at runtime, using a button, or a tap a green + next to the record - in this example, we do first one
    
    @IBAction func addNewItem(_ sender: UIButton) {
        
        //Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        //Where is that item in the array
        //in the textbook, it uses firstIndex(of: newItem), which no longer is supported
        //so we add where and check for the first match for the name
        if let index = itemStore.allItems.firstIndex(where: {$0.name == newItem.name}) {
            let indexPath = IndexPath (row: index, section: 0)
        
           
        //Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        
        //Turn off and turn on editing mode
        //if you are in editing mode
        if isEditing {
            //Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            //Turn off editing mode
            setEditing(false, animated: true)
        }
        else {
            //Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            //Enter editing mode
            setEditing(true, animated: true)
        }
        
    }
    
    //this method is from UITableViewDataSource protocol
    //ItemSource is where data is kept, table's views dataSource is ItemsViewController
    //tableView(_:commit:forRowAt:) takes two arguments: 1) UITableViewCell.EditingStyle which in this case is .delete, and 2) the IndexPath of the row in hte table
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //if the table view is asking to commit a delete command
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            //Remove item from the store
            itemStore.removeItem(item)
            
            //Also remove the row from the table view with an animation
            //automatic means the tableView chooses the animation
            //swipe to delete also works, not just the delete button
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //To chnage order of rows, use another method from UITableViewDataSource protocol, tableView (_:moveRowAt:to:)
    //Moving a row does not need confirmation, which means you don't need to call a method in tableView, like you did for
    //deleteRows. The table view moves the row on its own authority and reports the move to its data source by calling the method tableView(_:moveRowAt:to:). By implementing this method, you update your data source to match the new order
    //Before that, make sure to add a moveItem method in ItemStore
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
}
