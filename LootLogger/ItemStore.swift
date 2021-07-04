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
}
