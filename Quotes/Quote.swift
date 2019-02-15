//
//  Quote.swift
//  Quotes
//
//  Created by student1 on 2/15/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

struct Quote: Decodable {

    let text: String
    let author: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case text = "content"
        case author = "title"
        case link
    }
}

