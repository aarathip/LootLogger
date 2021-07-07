//
//  Item.swift
//  LootLogger
//
//  Created by Aarathi Prasad on 7/3/21.
//

import UIKit
import OSLog

//Make Codable to make instances
//For item to be encoded and decoded, you will need a coder.
//Coder is responsible for encoding a type into some external representation
//Either as a PropertyListEncoder or a JSONEncoder
//In this example, we will serialize Item using a property list
class Item : Codable {
    var name: String
    var valueInDollars: Int
    var serialNumber: String? //optional String, since not all items may have serial numbers
    let dateCreated: Date
    
    //Unlike book, iOS threw error saying Items does not confirm, so had to manually add encode and decode
    //First need to create the coding keys
    enum CodingKeys: String, CodingKey {
        case name
        case valueInDollars
        case serialNumber
        case dateCreated
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(valueInDollars, forKey: .valueInDollars)
        try container.encode(serialNumber, forKey: .serialNumber)
        try container.encode(dateCreated, forKey: .dateCreated)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        valueInDollars = try container.decode(Int.self, forKey: .valueInDollars)
        serialNumber = try container.decode(String?.self, forKey: .serialNumber)
        dateCreated = try container.decode(Date.self, forKey: .dateCreated)
    }
    
    var logger = Logger(subsystem: "cs.skidmore.LootLogger", category: "Functionality")
    
    //if properties dont have initial values, it will throw an error "Class Item has no initializers
    
    //this is a designated initializer, every class has at least one such initializer
    //ensures all properties in the class have a value
    //calls designated initializer on its superclass
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        //since argument names and property names are the same, need self to distinguish
        //the property from the argument
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = Date() //today's date
    }
    
    //a convenience initializer is optional and can call the designated initializer
    //we can use a convenience initializer to create a randomly generated item
    convenience init (random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            //randomElement could return null, if array is empty, hence yo have to force unwrap the call to randomElement()
            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()!
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            //returns a value between 0 and 100
            let randomValue = Int.random(in: 0..<100)
            //returns the first element of the collection
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            //By adding this, the warning that the values above aren't used should disappear
            //use the values above to initialize an Item object
            self.init(name: randomName,
                      serialNumber: randomSerialNumber,
                      valueInDollars: randomValue)
            
            logger.debug("Added object \(randomName)")
        }
        //if not generating a random Item object, set values to empty, nil and 0
        else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
}
