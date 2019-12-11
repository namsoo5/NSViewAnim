//
//  NSDownView.swift
//  NSViewAnim
//
//  Created by 남수김 on 2019/12/11.
//

import UIKit

@objc public protocol NSDownView {
    @objc func downViewControllerEvent(_ gesture: UIPanGestureRecognizer)
}

extension NSDownView where Self:UIViewController {
    
    public func downScrollDismissAnim() {
        let gestureAction = UIPanGestureRecognizer(target: self, action: #selector(downViewControllerEvent(_:)))
        self.view.addGestureRecognizer(gestureAction)
    }

    public func downViewController(_ gesture: UIPanGestureRecognizer, degree: CGFloat = 2/3){
        
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if windowScene.interfaceOrientation.isPortrait {
                    let trans = gesture.translation(in: self.view)
                    if trans.y > 0 {
                        self.view.transform = CGAffineTransform(translationX: 0, y: trans.y)
                    }

                    if gesture.state == .ended {
                        //   1/3지점까지는 원위치로
                        if self.view.frame.midY < self.view.frame.height * degree {
                            self.view.transform = .identity
                        }else{
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
