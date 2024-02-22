//
//  File.swift
//  
//
//  Created by Francesco Stabile on 22/02/24.
//

import UIKit

class WrapperFilter {
    private var excludedKey: [String] = []
    private var highlightKey: [String] = []
    private var colorHighlighted: UIColor = .blue
    
    // Metodi per impostare i valori
    func setExcludedKey(_ excludedKey: [String]) -> Self {
        self.excludedKey = excludedKey
        return self
    }
    
    func setHighlightKey(_ highlightKey: [String]) -> Self {
        self.highlightKey = highlightKey
        return self
    }
    
    func setColorHighlighted(_ colorHighlighted: UIColor) -> Self {
        self.colorHighlighted = colorHighlighted
        return self
    }
    
    // Metodi per ottenere i valori
    func getExcludedKey() -> [String] {
        return excludedKey
    }
    
    func getHighlightKey() -> [String] {
        return highlightKey
    }
    
    func getColorHighlighted() -> UIColor {
        return colorHighlighted
    }
}

