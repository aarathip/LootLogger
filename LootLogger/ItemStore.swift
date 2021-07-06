//
//  ItemStore.swift
//  LootLogger
//
//  Created by Aarathi Prasad on 7/3/21.
//

import UIKit
import Firebase

//In Cocoa Touch (collection of frameworks used to build iOS apps), the table view asks another object, the datasource, what it should display
//The ItemsViewcontroller is the data source, but it needs a way to store the item data. Items will be stored in an Item array, but this array is abstracted into another object, an ItemStore
//If an object wants to see all the items, it wil ask ItemStore for the array that contains them. Store is also responsible for reordering, adding, removing items, and saving and loading items from the disk

//We need to add the ItemStore to the ItemsViewController, since that's what will be using the store

class ItemStore {
    var allItems = [Item] ()
    
    //handle writing to and reading from a file in the Documents/ directory
    //Instead of assigning a value to a property, value is being set using a closure
    //with a signature of ()->URL, meaning it does not take any arguments but returns a URL
    //using a closure allows you to set a value for a variable or a constant that requires multiple lines of code. Makes the code maintable since it keeps the property and the code needed to configure the property together
    let itemArchiveURL: URL = {
        //method urls(for:in:) searches the filesystem for a URL that meets the criteria given by the arguments
        //first argument is a SearchPathDirecotry that specifies the directory in the sandbox you want the URL (.cachesDirectory returns Caches directory
        //returns an array of URLS
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //in iOS, there is usually only one URL
        let documentDirectory = documentsDirectories.first!
        //name is appended to the first and only url
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    
    //save the encoded data when the application 'exits'. When the user leaves the application (such as going to the Home screen), the notification UIScene.didEnterBackgroundNotification is posted to the NotificationCenter. This method listens for that notification and saves the items when it is posted, by adding an observer
    //notification center is written in Obj-C, so saveChanges should have @objc annotation
    init() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
    
    //populate the ItemStore with Item objects
    //by creating the store here instead of ItemsViewController, decouple objects in the application
    
    //when commenting this out, make sure to have createItem return an Item by adding -> Item
//    init() {
//        for _ in 0..<5 {
//            createItem()
//        }
//    }
    
    //unlike in the textbook, this method does not return an item initially, so I skip the discardableResult
    //return of Item added after init() commented out, after Add button added to the TableView
    func createItem () -> Item {
        //create a random Item object
        let newItem = Item (random: true)
        
        allItems.append(newItem)
        
        
        //add this when commenting the above init() out
        return newItem
        
    }
    
    //this method removes a specific item
    //to connect this to tableview, need to add tableView method in ItemsViewController
    func removeItem(_ item: Item) {
        //unlike textbook, nxt statement uses where instead of of:
        if let index = allItems.firstIndex(where: {$0.name == item.name}) {
            allItems.remove(at: index)
        }
    }
    
    //this method changes the order of items in its allItems array
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        //Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        //Remove item from array
        allItems.remove(at: fromIndex)
        
        //Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    
    //Property lists can hold Array, Bool, Data, Date, Dictionary, Float, Int and String
    //This method will encode and save items
    
    @objc func saveChanges() -> Bool {
       print("Saving items to: \(itemArchiveURL)")
        
        do {
            let encoder = PropertyListEncoder()
                
                // encode must be in a do-catch block
                //func encode (_ value: Encodable) throws-> Data
                //Data that is returns holds some number of bytes of binary data
                //Encoding is a recursive process, when an instance is encoded, it is sent
                //to encode(to:) -> which calls encode(_:forKey:)
            let data = try encoder.encode(allItems)
            
            //.atomic ensures no data corruption. it works by writing the data to a temporary auxiliary file and hten, if that succeeds, renaming that auxiliary file to the final filename. this is usually because there could be a items.plist that will need to be replaced, but if error occurs, original file will not be modified
            try data.write(to: itemArchiveURL, options: [.atomic])
            //data will be 'persisted' to disk when the saveChanges() method is called. The final step, then, is to call the saveChanges() method when you are ready to save, using the notification center.
            print("Saved all of the items")
            return true
        }
        catch let encodingError{
            //implicit 'error' constant that describes the error
            //print("Error encoding allItems: \(error)")
            
            //optionally you can give this an explicit name
            print("Error encoding allItems: \(encodingError)")
            return false
        }
        
    }
    
}
