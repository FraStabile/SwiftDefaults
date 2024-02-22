//
//  File.swift
//  
//
//  Created by Francesco Stabile on 21/02/24.
//

import Foundation
import Combine
import UIKit
enum TypPreferences : String, CaseIterable {
    case bool, integer,float,double,obj, all
}
@MainActor
public class ListDefaultViewModel: ObservableObject {
    var userDefault: UserDefaults
    @Published var listPreferences: [PreferencesModel] = []
    @Published var filterType: TypPreferences = .all
    @Published var searchText: String = ""
    @Published var selectedItem: PreferencesModel?
    private var subscribers: Set<AnyCancellable> = []
    private var wrapperFilter: WrapperFilter?
    init(userDefault: UserDefaults, wrapperFilter: WrapperFilter?) {
        self.userDefault = userDefault
        viewDidReady()
        self.wrapperFilter = wrapperFilter
        $filterType.sink { value in
            self.filterValue(filterType: value, and: self.searchText)
        }
        .store(in: &subscribers)
        
        $searchText.sink { value in
            self.filterValue(filterType: self.filterType, and: value)
        }
        .store(in: &subscribers)
    }
    
    
    func filterValue(filterType: TypPreferences, and key: String = "") {
        let keys = userDefault.dictionaryRepresentation().keys
        var preferences: [PreferencesModel] = []
        keys.forEach { key in
            let value = userDefault.object(forKey: key)
            preferences.append(PreferencesModel(key: key, value: value))
        }
        
        // filter Wrapper
        if let wrapperFilter = wrapperFilter {
            preferences = preferences.filter { model in
                return !wrapperFilter.getExcludedKey().contains { keyExclude in
                    return model.key.contains(keyExclude)
                }
            }
        }
        
        switch filterType {
        case .bool:
            preferences = preferences.filter({$0.value is Bool})
        case .integer:
            preferences = preferences.filter({$0.value is Int})
        case .float:
            preferences = preferences.filter({$0.value is Float})
        case .double:
            preferences = preferences.filter({$0.value is Double})
        case .obj:
            preferences = preferences.filter({$0.value is NSObject})
        case .all:
            break
        }
        
        listPreferences = preferences.filter({ model in
            if searchText.isEmpty {
                return true
            }
            return model.key.lowercased().contains(searchText.lowercased())
        })
    }
    
    func viewDidReady() {
        filterValue(filterType: filterType)
    }
    
    
    func changeValue(key: String, newValue: Any) {
        userDefault.setValue(newValue, forKey: key)
        selectedItem = nil
        filterValue(filterType: filterType, and: searchText)
    }
    
    
    func getColorCell(key: String) -> UIColor {
        guard let wrapperFilter = wrapperFilter else {
            return .clear
        }
        return wrapperFilter.getHighlightKey().first(where: {key.contains($0)}) != nil ? wrapperFilter.getColorHighlighted() : .clear
    }
}
