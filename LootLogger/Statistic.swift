//
//  Statistic.swift
//  LootLogger
//
//  Created by Aarathi Prasad on 7/7/21.
//

import UIKit

class Statistic : Codable {
    var itemCount = 0
    final var itemFirstDate = Date()
    
    //Unlike book, iOS threw error saying Items does not confirm, so had to manually add encode and decode
    //First need to create the coding keys
    enum CodingKeys: String, CodingKey {
        case itemCount
        case itemFirstDate
    }
    
    init(itemCount: Int) {
        self.itemCount = itemCount
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemCount, forKey: .itemCount)
        try container.encode(itemFirstDate, forKey: .itemFirstDate)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemCount = try container.decode(Int.self, forKey: .itemCount)
        itemFirstDate = try container.decode(Date.self, forKey: .itemFirstDate)
    }
    
}
