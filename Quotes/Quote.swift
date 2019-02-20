//
//  Quote.swift
//  Quotes
//
//  Created by student1 on 2/15/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

struct Quote: Decodable {

    let id: Int
    let text: String
    let author: String
    let link: String
    
    // The names for keys in the JSON response don't describe the data very well
    // Map the content key in the response to text property
    // Map the title key to the author property
    enum CodingKeys: String, CodingKey {
        
        case id = "ID"
        case text = "content"
        case author = "title"
        case link   // Even though link is not mapped, it must be included
    }
}

