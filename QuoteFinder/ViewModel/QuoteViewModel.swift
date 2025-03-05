//
//  QuoteViewModel.swift
//  QuoteFinder
//
//  Created by Haowen Chen on 2025-03-04.
//

import Foundation
 
@Observable
class QuoteViewModel {
    
    var currentQuote: Quote?
    
    // MARK: Initializer(s)
    init(currentQuote: Quote? = nil) {
        
        self.currentQuote = currentQuote
        
               
               Task {
                   await self.fetchQuote()
               }
           }
           
           // MARK: Function(s)
           
           func fetchQuote() async {
               
            
               let endpoint = "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en"
               guard let url = URL(string: endpoint) else {
                   print("Invalid address for JSON endpoint.")
                   return
               }
               
             
               do {
                   
                   let (data, _) = try await URLSession.shared.data(from: url)
        
                   print("Got data from endpoint, contents of response are:")
                   print(String(data: data, encoding: .utf8)!)
                   

                   let decoder = JSONDecoder()
                   

                   let decodedData = try decoder.decode(Quote.self, from: data)
                   

                   self.currentQuote = decodedData
                   
               } catch {
                   

                   print("Count not retrieve data from endpoint, or could not decode into an instance of a Swift data type.")
                   print("----")
                   

                   print(error)
                   
               }
           }
    }
