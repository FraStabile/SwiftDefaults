//
//  SwiftUIView.swift
//  
//
//  Created by Francesco Stabile on 21/02/24.
//

import SwiftUI

struct OverlayChangeValueView: View {
    var keyValue: String
    @State var value: String = "4"
    var onSaveItem: (String, String) -> () = { _,_ in }
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            VStack {
                HStack {
                    Text("Key")
                        .padding(.trailing)
                    Text(keyValue)
                }
                .padding()
                TextField("Value", text: $value)
                    .padding()
                Button {
                    onSaveItem(keyValue, value)
                } label: {
                    Text("Save")
                }
                .padding()
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()


        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    OverlayChangeValueView(keyValue: "Key")
}
