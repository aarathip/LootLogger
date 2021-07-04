//
//  ItemStore.swift
//  LootLogger
//
//  Created by Aarathi Prasad on 7/3/21.
//

import UIKit

//In Cocoa Touch (collection of frameworks used to build iOS apps), the table view asks another object, the datasource, what it should display
//The ItemsViewcontroller is the data source, but it needs a way to store the item data. Items will be stored in an Item array, but this array is abstracted into another object, an ItemStore
//If an object wants to see all the items, it wil ask ItemStore for the array that contains them. Store is also responsible for reordering, adding, removing items, and saving and loading items from the disk

//We need to add the ItemStore to the ItemsViewController, since that's what will be using the store

class ItemStore {
    var allItems = [Item] ()
    
    //populate the ItemStore with Item objects
    //by creating the store here instead of ItemsViewController, decouple objects in the application
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    //unlike in the textbook, this method does not return an item
    func createItem () {
        //create a random Item object
        let newItem = Item (random: true)
        
        allItems.append(newItem)
        
    }
    
    
}
