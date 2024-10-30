//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Nana on 27/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var from: String = ""
    @State private var to: String = ""
    @State private var amount: String = ""
    @State private var rateForAmount: Double?
    @State private var options: [String] = []
    @StateObject private var converterVM: ConverterCurrencyViewModel = ConverterCurrencyViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 40) {
                Text("Currency Converter")
                    .font(Font.custom("Quicksand-Bold", size: 45))
                
                VStack(alignment: .leading) {
                    Text("From")
                        .font(Font.custom("Quicksand-Medium", size: 20))
                    
                    DropDown(selection: $from, options: options)
                }
                .zIndex(2)
                
                
                VStack(alignment: .leading) {
                    Text("To")
                        .font(Font.custom("Quicksand-Medium", size: 20))
                    
                    DropDown(selection: $to, options: options)
                }
                .zIndex(1)
                
                VStack(alignment: .leading) {
                    Text("Amount")
                        .font(Font.custom("Quicksand-Medium", size: 20))
                    
                    TextField("Type the amount", text: $amount)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black.opacity(0.1) ,lineWidth: 1)
                                .shadow(radius: 4))
                }
                
                
                Button(action: {
                    // Calls the fetchCurrencyConverter function with the specified parameters `from`, `to`, and `amount` and provides a completion handler
                    converterVM.fetchCurrencyConverter(from: from, to: to, amount: amount) { info in
                        
                        // Checks if converterInfo is non-nil and if it contains a rate for the target currency (`to`)
                        if let info = converterVM.converterInfo,
                           let rate = info.rates[to]
                        {
                            // Converts rateForAmount to Double and assigns it to a local variable
                            let rateForAmount = Double(rate.rateForAmount)
                            self.rateForAmount = rateForAmount  // Updates the rateForAmount property in the view
                        }
                    }
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(isValidAmount(amount: amount) && isAllFilled() ? .blue : .gray)
                            .frame(height: 60)
                            
                        Text("Convert")
                            .foregroundColor(.white)
                            .font(Font.custom("Quicksand-Medium", size: 20))
                    }
                })
                .disabled(!isValidAmount(amount: amount) || !isAllFilled())
                
                if (rateForAmount != nil) {
                    HStack {
                        Text("From: ")
                            .font(Font.custom("Quicksand-Medium", size: 20))
                        
                        Spacer()
                        
                        Text(amount)
                            .font(Font.custom("Quicksand-Medium", size: 20))
                        
                        Text(from)
                            .font(Font.custom("Quicksand-Medium", size: 20))
                        
                    }
                    
                    HStack {
                        Text("To: ")
                            .font(Font.custom("Quicksand-Medium", size: 20))
                        
                        Spacer()
                        
                        Text(String(format: "%.2f", rateForAmount!))
                            .font(Font.custom("Quicksand-Medium", size: 20))
                        
                        Text(to)
                            .font(Font.custom("Quicksand-Medium", size: 20))
                        
                    }
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 30)
        }
        .onAppear {
            converterVM.fetchCurrencyList() { _ in
                options = converterVM.currencyList
            }
        }
        
    }
    
    // Checks if the input amount is a valid positive Double
    func isValidAmount(amount: String) -> Bool {
        if let number = Double(amount), number > 0 {
            return true
        } else {
            return false
        }
    }
    
    // Checks if both `from` and `to` fields are non-empty
    func isAllFilled() -> Bool {
        if from != "" && to != "" {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    ContentView()
}
