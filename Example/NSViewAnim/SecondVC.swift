//
//  SecondVC.swift
//  NSViewAnim_Example
//
//  Created by 남수김 on 2019/12/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import NSViewAnim

class SecondVC: UIViewController, NSDownView {

    // MARK: - Down Drag Dismiss
    // Drag View Dismiss
    func downViewControllerEvent(_ gesture: UIPanGestureRecognizer) {
        // add gesture
        downViewController(gesture)
        downViewController(gesture, degree: 2/3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // apply Anim
        self.downScrollDismissAnim()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
