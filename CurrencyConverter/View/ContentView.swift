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
                    converterVM.fetchCurrencyConverter(from: from, to: to, amount: amount) { info in
                        if let info = converterVM.converterInfo,
                           let rate = info.rates[to]
                        {
                            let rateForAmount = Double(rate.rateForAmount)
                            self.rateForAmount = rateForAmount
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
                        Text(from)
                        
                    }
                    
                    HStack {
                        Text("To: ")
                            .font(Font.custom("Quicksand-Medium", size: 20))
                        
                        Spacer()
                        
                        Text(String(format: "%.2f", rateForAmount!))
                        Text(to)
                        
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
    
    func isValidAmount(amount: String) -> Bool {
        if let number = Double(amount), number > 0 {
            return true
        } else {
            return false
        }
    }
    
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
