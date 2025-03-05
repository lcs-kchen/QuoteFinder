//
//  QuoteModel.swift
//  QuoteFinder
//
//  Created by Haowen Chen on 2025-03-04.
//


import Foundation
struct Quote: Identifiable, Codable {
    
    // MARK: Stored properties
    let quoteText: String
    let quoteAuthor: String?
    let senderName: String?
    let senderLink: String?
    let id: String?
        
}
 

let exampleQuote = Quote(
    quoteText:"The greater part of human pain is unnecessary. It is self-created as long as the unobserved mind runs your life.",
    quoteAuthor:"Eckhart Tolle",
    senderName:"",
    senderLink:"",
    id:"http://forismatic.com/en/a80b3379ac/"
 )







