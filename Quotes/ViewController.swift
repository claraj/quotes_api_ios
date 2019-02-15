//
//  ViewController.swift
//  Quotes
//
//  Created by student1 on 2/15/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, QuoteDelegate {
    
    let quoteFetcher = QuoteFetcher()
    
    @IBOutlet var newQuoteButton: UIButton!
    @IBOutlet var quoteTextView: UITextView!
 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        quoteFetcher.quoteDelegate = self
        quoteFetcher.fetchRandomQuote()
        newQuoteButton.setTitle("Fetching quote...", for: .disabled)
        newQuoteButton.isEnabled = false
    }
    
    @IBAction func newQuoteButtonTapped(_ sender: Any) {
        newQuoteButton.isEnabled = false
        quoteFetcher.fetchRandomQuote()
        
    }
    
    func new(quote: Quote) {
        DispatchQueue.main.async() {
            
            let quoteText = "\(quote.text)<p><em>\(quote.author)</em></p>"
            let data = Data(quoteText.utf8)
            
            let attributedString = try? NSAttributedString(
                data: data,
                options:
                    [.documentType: NSAttributedString.DocumentType.html,
                     .characterEncoding: String.Encoding.utf8.rawValue ],
                documentAttributes: nil)
            
            self.quoteTextView.attributedText = attributedString
            self.newQuoteButton.isEnabled = true
        }
    }
    
    
    func error(quoteError: Error) {
        let alert = UIAlertController(title: "Error", message: "Error fetching quote", preferredStyle: .alert)
        present(alert, animated: true)
        newQuoteButton.isEnabled = true
    }
    
}

