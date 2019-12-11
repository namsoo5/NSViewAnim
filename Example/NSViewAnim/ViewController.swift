//
//  ViewController.swift
//  NSViewAnim
//
//  Created by namsoo5 on 12/10/2019.
//  Copyright (c) 2019 namsoo5. All rights reserved.
//

import UIKit
import NSViewAnim

class ViewController: UIViewController, NSDownView, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    let circleView = NSCircleAnim()
    
    // MARK: - Circle Anim
    // presentAnim
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return circleView.animState(mode: .present)
            .animStartPoint(point: self.nextButton.center)
            .animColor(color: self.nextButton.backgroundColor!)
        
    }
    
    // dismissAnim
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return circleView.animState(mode: .dismiss)
            .animStartPoint(point: self.nextButton.center)
            .animColor(color: self.nextButton.backgroundColor!)
    }
    
    // MARK: - Down Drag Dismiss
    // Drag View Dismiss
    func downViewControllerEvent(_ gesture: UIPanGestureRecognizer) {
        // add gesture
        downViewController(gesture)
        downViewController(gesture, degree: 1/3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // apply Anim
        self.downScrollDismissAnim()
        
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        if #available(iOS 13.0, *) {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "Second") else {return}
            
            // Chaining Option
            nextVC.setPresentStyle(presentMode: .custom)  // CircleAnim Require Option
                .setTransStyle(transMode: .coverVertical)
                .setTransDelegate(self)  // CircleAnim Require Option
                .done()
            
            
            self.present(nextVC, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
