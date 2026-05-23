//
//  ExchaneRate.swift
//  LOTRConverter
//
//  Created by taher lamloum on 14/04/2026.
//

import SwiftUI


struct ExchangeRate: View {
    let leftImage: ImageResource
    let text: String
    let rightImage: ImageResource
    
    var body: some View {
        HStack {
//                     left currency img
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
//                    exchange rate text
            Text(text)
//                    right currency img
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpiece, text: "1 gold Piece = 4 Gold Pennies", rightImage: .goldpenny)
}

