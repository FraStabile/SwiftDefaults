//
//  ShakeController.swift
//  
//
//  Created by Francesco Stabile on 21/02/24.
//

import UIKit

extension UIWindow {
    
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake && SDM.current.isListen && SDM.current.getGesture() == .shake {
            SDM.current.showPreferecens()
        }
    }
}
