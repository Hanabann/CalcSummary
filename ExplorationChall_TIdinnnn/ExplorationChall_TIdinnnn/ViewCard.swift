//
//  ViewCard.swift
//  ExplorationChall_TIdinnnn
//
//  Created by Marshia on 15/05/25.
//

import SwiftUI

struct ViewCard: View {
    @Binding var item: Menu
    @Binding var items: [Menu]
    
    @State private var offset: CGFloat = 0
    @State private var showDeleteConfirmation = false
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: 10)
           .fill(Color.red)
           .frame(maxHeight: .infinity) // Match expected card height
           .overlay(
            VStack{
                HStack {
                    Spacer()
                    Button(role: .destructive) {
                        showDeleteConfirmation = true
                    } label: {
                        VStack {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                                .frame(width: 60, height: 20)
                            
                            Text("Delete")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                        .frame(height: 80)
                    }.padding(.trailing, 10)
                }
            }
           )

            // Foreground content
            VStack(alignment: .leading) {
                HStack {
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()

                    Text("Rp\(String(format: "%.0f", item.price * Double(item.qty))).000")
                        .font(.headline.bold())
                        .padding(.top, 40)
                }

                HStack {
                    Button {
                        if item.qty > 1 {
                            item.qty -= 1
                        } else {
                            showDeleteConfirmation = true
                        }
                    } label: {
                        Image(systemName: "minus.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.gray)
                    }

                    Text("\(item.qty)")
                        .font(.subheadline)
                        .frame(minWidth: 20)

                    Button {
                        item.qty += 1
                    } label: {
                        Image(systemName: "plus.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.gray)
                    }

                    Text("x Rp\(String(format: "%.0f", item.price)).000")
                        .foregroundColor(.gray)
                }

                Divider()
            }
            .padding(.horizontal, 6)
            .background(Color.white)
            .offset(x: offset + dragOffset)
            .gesture(DragGesture()
                //                    .onEnded { value in
                //                        if value.translation.width < -80 {
                //                            withAnimation {
                //                                offset = -180
                //                                showDeleteConfirmation = true
                //                            }
                //                        }
                //                        else {
                //                            withAnimation {
                //                                offset = 0
                //                            }
                //                        }
                //                    }
                
                .onEnded { value in
                    if value.translation.width < -(UIScreen.main.bounds.width/2) {
                        withAnimation {
                            offset = -800
                            showDeleteConfirmation = true
                        }
                    } else if value.translation.width < -80 {
                        withAnimation {
                            offset = -80
                        }
                    } else {
                        // Balik ke posisi semula
                        withAnimation {
                            offset = 0
                        }
                    }
                }
            )
            .alert("Hapus menu ini", isPresented: $showDeleteConfirmation) {
                Button("Hapus", role: .destructive) {
                    if let index = items.firstIndex(where: { $0.name == item.name }) {
                        items.remove(at: index)
                    }
                }
                Button("Batal", role: .cancel) {
                    withAnimation {
                        offset = 0
                    }
                }
            } message: {
                Text("Anda yakin ingin menghapus menu ini?")
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var previewMenu = Menu(name: "XXL Crispy Chicken Jagung Bakar + Balado", qty: 1, price: 100)
        @State private var previewItems: [Menu] = [
            Menu(name: "XXL Crispy Chicken Jagung Bakar + Balado", qty: 1, price: 100)
        ]

        var body: some View {
            ViewCard(item: $previewMenu, items: $previewItems)
                .padding()
        }
    }

    return PreviewWrapper()
}
