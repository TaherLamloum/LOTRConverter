//
//  ContentView.swift
//  LOTRConverter
//
//  Created by taher lamloum on 26/03/2026.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeinfo = false
    @State var showSelectedCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmont = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    let currencyTip = CurrencyTip()
    
    var body: some View {
        ZStack {
             // background img
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // prancing pony img
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                   
                // currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                // conversion section
                HStack {
                    // left section
                    VStack {
                        // currency
                        HStack {
                            // currency img
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            // currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(-5)
                        .onTapGesture {
                            showSelectedCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        // text field
                       TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                    }
                    
                    //equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    // right section
                    VStack {
                        // currency
                        HStack {
                            // currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            // currency img
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                        }
                        .padding(-5)
                        .onTapGesture {
                            showSelectedCurrency.toggle()
                        }
                        
                        // text field
                        TextField("Amount", text: $rightAmont)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                    }
                }
                
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                .keyboardType(.decimalPad)
                Spacer()
                // info btn
                
                HStack {
                    Spacer()
                    
                    Button {
                        showExchangeinfo.toggle()
                        
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
            }
    //            .border(.blue)
                    }
        .task {
            try? Tips.configure()
        }
                    
                    .onChange(of: leftAmount) {
                        if leftTyping {
                            rightAmont = leftCurrency.convert(leftAmount, to: rightCurrency)
                        }
                    }
                    .onChange(of: rightAmont) {
                        if rightTyping {
                            leftAmount = rightCurrency.convert(rightAmont, to: leftCurrency)
                        }
                    }
                    .onChange(of: leftCurrency) {
                        leftAmount = rightCurrency.convert(rightAmont, to: leftCurrency)
                    }
                    .onChange(of: rightCurrency) {
                        rightAmont = leftCurrency.convert(leftAmount, to: rightCurrency)
                    }
                    .sheet(isPresented: $showExchangeinfo) {
                        ExchangeInfo()
                    }
                    .sheet(isPresented: $showSelectedCurrency) {
                       SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
                    }

    }
}

#Preview {
    ContentView()
}
