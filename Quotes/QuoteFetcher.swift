//
//  QuoteFetcher.swift
//  Quotes
//
//  Created by student1 on 2/15/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

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
                        print("error, no quotes returned")
                    }
                } else {
                    print("Error decoding quote response")
                }
            }
            
            if let error = error {
                delegate.error(quoteError: error)
            }
        })
        
        
        task.resume()
    
        }
    }

