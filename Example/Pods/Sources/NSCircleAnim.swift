//
//  NSCircleAnim.swift
//  NSViewAnim
//
//  Created by 남수김 on 2019/12/10.
//

import UIKit
import Foundation

public class NSCircleAnim: NSObject {
    private var circle = UIView()
    
    private var startingPoint = CGPoint.zero {
        didSet {
            circle.center = self.startingPoint
        }
    }
    
    public enum CircularTransitionMode: Int {
        case present, dismiss
    }
    
    private var circleColor = UIColor.white
    
    private var duration = 0.3
    
    private var transitionMode:CircularTransitionMode = .present
    
}

extension NSCircleAnim {
    public func animColor(color: UIColor) -> Self {
        self.circleColor = color
        return self
    }
    
    public func animStartPoint(point: CGPoint) -> Self {
        self.startingPoint = point
        return self
    }
    
    public func animDuration(second duration: Double) -> Self{
        self.duration = duration
        return self
    }
    
    public func animState(mode: CircularTransitionMode) -> Self {
        self.transitionMode = mode
        return self
    }
    
    public func done() { return }
}

extension NSCircleAnim: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = .identity
                    presentedView.transform = .identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: { (success:Bool) in
                    transitionContext.completeTransition(success)
                })
                
            }
        }else {
            let transitionModeKey =  UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
//                    if self.transitionMode == .pop {
//                        containerView.insertSubview(returningView, belowSubview: returningView)
//                        containerView.insertSubview(self.circle, belowSubview: returningView)
//                    }
                }, completion: { (success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
                
            }
            
        }
    }
    
    // Circle Effect Range
    private func frameForCircle(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
}
