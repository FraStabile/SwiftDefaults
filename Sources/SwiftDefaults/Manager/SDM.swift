//
//  File.swift
//
//
//  Created by Francesco Stabile on 21/02/24.
//

import Foundation
import SwiftUI

public enum TypGesture {
    case shake, noGesture
}

@MainActor
public class SDM {
    public static let current = SDM()
    var isListen: Bool = false
    public var userDefault: UserDefaults?
    private var gesture: UITapGestureRecognizer!
    private var showManual: Bool = false
    private var gestureActive: TypGesture = .shake
    private var wrapperUI: WrapperFilter = WrapperFilter()
    private var controller: UIHostingController<ListDefaultView>!
    
    public init(userDefault: UserDefaults? = nil) {
        self.userDefault = userDefault
        
    }
    
    public func setGesture(gesture: TypGesture) {
        self.gestureActive = gesture
    }
    
    public func getGesture() -> TypGesture {
        return gestureActive
    }
    
    public func start() {
        isListen = true
    }
    
    public func stop() {
        isListen = false
    }
    
    public func show() {
        !showManual ? showPreferecens() : ()
        showManual = true
    }
    
    public func hide() {
        if showManual {
            controller.dismiss(animated: true)
            showManual = false
        }
    }
    func showPreferecens() {
        guard let userDefault = userDefault else {
            print("SwiftDefaults: USERDEFAULT NOT SETTING")
            return
        }
        controller = UIHostingController(rootView: ListDefaultView(viewModel: ListDefaultViewModel(userDefault: userDefault, wrapperFilter: wrapperUI)))
        let topView = UIApplication.getTopViewController()
        controller.modalPresentationStyle = .formSheet
        topView?.present(controller, animated: true)
    }
}


// MARK : Utils

public extension SDM {
    func setExcludedKey(exKey: [String] = []) {
        wrapperUI = wrapperUI.setExcludedKey(exKey)
    }
    
    func setHighlightedKey(highlightedKey: [String] = []) {
        wrapperUI = wrapperUI.setHighlightKey(highlightedKey)
    }
    
    func setColorForHighlightedKey(color: UIColor = .black) {
        wrapperUI = wrapperUI.setColorHighlighted(color)
    }
}
