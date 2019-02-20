//
//  QuoteUpdateDelegate.swift
//  Quotes
//
//  Created by student1 on 2/15/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

// Functions that an object that wishes to receive
// quotes (or errors) must implement

protocol QuoteDelegate {
    func new(quote: Quote)
    func error(quoteError: QuoteError)
}
