//
//  DropDown.swift
//  CurrencyConverter
//
//  Created by Nana on 27/10/24.
//

import SwiftUI

struct DropDown: View {
    @State private var isExpanded = false
    @Binding var selection: String
    var options: [String]
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                HStack {
                    Text(selection == "" ? "Select" : selection)
                        .font(Font.custom("Quicksand-Regular", size: 16))
                        .foregroundColor(selection == "" ? .gray : .black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .rotationEffect(.init(degrees: isExpanded ? -180 : 0))
                    
                    
                }
                .padding(.horizontal, 15)
                .frame(width: size.width, height: size.height)
                .background(.white)
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                
                if isExpanded {
                    
                    VStack {
                        ScrollView {
                            ForEach(options, id: \.self) { option in
                                HStack {
                                    Text(option)
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                        .foregroundColor(selection == option ? .black : .gray)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "checkmark")
                                        .opacity(selection == option ? 1 : 0)
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                                .onTapGesture {
                                    withAnimation {
                                        selection = option
                                        isExpanded.toggle()
                                    }
                                }
                            }
                            
                        }
                        .frame(width: size.width, height: 120)
                    }
                    .background(.white)
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.black.opacity(0.15) ,lineWidth: 1)
                    .shadow(radius: 4)
            }
            .frame(height: size.height, alignment: .top)
        }
        .frame(height: 50)
        .background(.white)
    }
}

#Preview {
    DropDown(selection: .constant("Option 1"), options: ["Option 1", "Option 2", "Option 3"])
}

