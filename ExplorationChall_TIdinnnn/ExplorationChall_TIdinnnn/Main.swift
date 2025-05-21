//
//  Main.swift
//  ExplorationChall_TIdinnnn
//
//  Created by Marshia on 15/05/25.
//

import SwiftUI

struct Main: View {
    @State private var items: [Menu] = [
        .init(name: "XXL Crispy Chicken BBQ", qty: 2, price: 15),
        .init(name: "XXL Crispy Chicken Jagung Bakar + Balado", qty: 1, price: 18),
        .init(name: "XXL Crispy Chicken Balado", qty: 3, price: 20),
    ]

    var totalItems: Int {
        items.reduce(0) { $0 + $1.qty }
    }

    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.price * Double($1.qty)) }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Rekap Perhitungan")
                    .font(.largeTitle.bold())
                    .padding(.top, 15)
                    .padding(.horizontal, 13)

                    LazyVStack(spacing: 0) {
                        ForEach($items, id: \.name) { $item in
                            ViewCard(item: $item, items: $items)
                                .padding(.horizontal, 10)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            if totalItems > 0 {
                                Text("Total Price (\(totalItems) items)")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                Text("Rp\(String(format: "%.0f", totalPrice)).000")
                                    .font(.title3.bold())
                            } else {
                                VStack {
                                    Spacer(minLength: 250)
                                    Text("Tidak ada item")
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                            }
                            
                        }
                        .padding()
                    }
                }
            }
        }
    }


#Preview {
    Main()
}
