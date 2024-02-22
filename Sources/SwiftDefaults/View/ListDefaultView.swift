//
//  SwiftUIView.swift
//
//
//  Created by Francesco Stabile on 21/02/24.
//

import SwiftUI

struct ListDefaultView: View {
    @ObservedObject var viewModel: ListDefaultViewModel = ListDefaultViewModel(userDefault: UserDefaults.standard, wrapperFilter: nil)
    var body: some View {
        ZStack {
            VStack {
            HStack {
                TextField("Cerca...", text: $viewModel.searchText)
                Spacer()
                Picker("Appearance", selection: $viewModel.filterType) {
                    ForEach(TypPreferences.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }
                .pickerStyle(.automatic)
            }
            .padding()
            List(viewModel.listPreferences, id: \.key) { preference in
                PreferencesCellView(key: preference.key, value: "\(preference.value ?? "")")
                    .padding()
                    .background(Color(viewModel.getColorCell(key: preference.key)))
                    .onTapGesture {
                        viewModel.selectedItem = preference
                    }
            }
        }
            
            if let item = viewModel.selectedItem {
                OverlayChangeValueView(keyValue: item.key, value: "\(item.value ?? "")") { newKey, newValue in
                    viewModel.changeValue(key: newKey, newValue: newValue)
                }
            }
        }
    }
}


struct PreferencesCellView: View {
    var key: String
    var value: String
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    ListDefaultView()
}
