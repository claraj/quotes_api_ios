//
//  QuoteFetcher.swift
//  Quotes
//
//  Created by student1 on 2/15/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

class QuoteError: Error {
    let message: String
    init(message: String) {
        self.message = message
    }
}


class QuoteFetcher {
    
    var quoteDelegate: QuoteDelegate?
    
    func fetchRandomQuote() {
        
        print("fetching")
        
        guard let delegate = quoteDelegate else {
            print("Warning - no delegate set")
            return
        }
        
        let urlString = "https://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1"
        
        let url = URL(string: urlString)
        
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            if let quoteData = data {
                let decoder = JSONDecoder()
                if let quote = try? decoder.decode([Quote].self, from: quoteData) {
                    if let randomQuote = quote.first {
                        delegate.new(quote: randomQuote)
                    } else {
                        delegate.error(quoteError: QuoteError(message: "No quotes returned"))
                    }
                } else {
                    delegate.error(quoteError: QuoteError(message: "Unable to decode response from quote server"))
                }
            }
            
            if let error = error {
                delegate.error(quoteError: QuoteError(message: error.localizedDescription))
            }
        })
        
        
        task.resume()
    
        }
    }

