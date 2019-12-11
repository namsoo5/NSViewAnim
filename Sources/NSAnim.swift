//
//  NSAnim.swift
//  NSViewAnim
//
//  Created by 남수김 on 2019/12/10.
//

import Foundation
import UIKit

public protocol NSAnim {}

extension NSAnim where Self:UIViewController {
    
    public func setPresentStyle(presentMode: UIModalPresentationStyle = .fullScreen) -> Self {
        self.modalPresentationStyle = presentMode
        return self
    }
    
    public func setTransStyle(transMode: UIModalTransitionStyle = .coverVertical) -> Self {
        self.modalTransitionStyle = transMode
        return self
    }
    
    public func setTransDelegate(_ curVC :UIViewController) -> Self {
        self.transitioningDelegate = curVC as? UIViewControllerTransitioningDelegate
        return self
    }
    
    public func done() { return }
    
}


extension UIViewController: NSAnim {}
