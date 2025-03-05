//
//  ContentView.swift
//  QuoteFinder
//
//  Created by Haowen Chen on 2025-03-04.
//

import SwiftUI

struct QuoteView: View {
    
    // MARK: Stored properties
    
    // Create the view model (temporarily show the default joke)
    @State var viewModel = QuoteViewModel()
    
    // Controls punchline visibility
    @State var quoteAuthorOpacity = 0.0
    
    // Starts a timer to wait on revealing punchline
    @State var quoteAuthorTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // Starts a timer to wait on revealing button to get new joke
    @State var buttonTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    // Controls button visibility
    @State var buttonOpacity = 0.0
    
    // MARK: Computed properties
    var body: some View {
        VStack {
            
            // Show a joke if one exists
            if let currentQuote = viewModel.currentQuote {
                
                Group {
                    Text(currentQuote.quoteText)
                    
                    Text(currentQuote.quoteAuthor ?? "")
                        .opacity(quoteAuthorOpacity)
                        .onReceive(quoteAuthorTimer) { _ in
                            
                            withAnimation {
                                quoteAuthorOpacity = 1.0
                            }
                            
                            // Stop the timer
                            quoteAuthorTimer.upstream.connect().cancel()
                        }
                }
                .font(.title)
                .multilineTextAlignment(.center)
                
                Button {
                 
                    // Hide punchline and button
                    withAnimation {
                        viewModel.currentQuote = nil
                        quoteAuthorOpacity = 0.0
                        buttonOpacity = 0.0
                    }
                                        
                    // Get a new joke
                    Task {
                        await viewModel.fetchQuote()
                    }
                    
                    // Restart timers
                    quoteAuthorTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
                    buttonTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
                    
                } label: {
                 
                    Text("New Quote")
                    
                }
                .buttonStyle(.borderedProminent)
                .opacity(buttonOpacity)
                .onReceive(buttonTimer) { _ in
                    
                    withAnimation {
                        buttonOpacity = 1.0
                    }
                    
                    // Stop the timer
                    buttonTimer.upstream.connect().cancel()
                }
                
                
            }
            
        }
    }
}
 
#Preview {
    QuoteView()
}

