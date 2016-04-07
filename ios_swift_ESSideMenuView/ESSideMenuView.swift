//
//  ESSideMenuView.swift
//  ios_swift_ESSideMenuView
//
//  Created by LiuYongyuan on 16/4/7.
//  Copyright © 2016年 LiuYongyuan. All rights reserved.
//

import UIKit

class ESSideMenuView: UIView {
    var menuView:UIView!
    var containerView:UIView!
    private var startPoint = CGPointZero
    private var endPoint = CGPointZero
    private var shouldMove = false
    private var recordCount = 0
    private var locatePoint:CGFloat = 0
    private var xOffSet:CGFloat{
        get{
        return locatePoint - startPoint.x
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func drawRect(rect: CGRect) {
        self.addSubview(menuView)
        self.addSubview(containerView)
       let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ESSideMenuView.onContainerSwipe(_:)))
        print("left = \(UISwipeGestureRecognizerDirection.Left) right = \(UISwipeGestureRecognizerDirection.Right)")
        swipe.direction = [UISwipeGestureRecognizerDirection.Left,UISwipeGestureRecognizerDirection.Right]
//        containerView.addGestureRecognizer(swipe)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ESSideMenuView.onContainerTap(_:)))
//        containerView.addGestureRecognizer(tap)
        
        let move = UIPanGestureRecognizer(target: self, action: #selector(ESSideMenuView.onContainerMove(_:)))
//        containerView.addGestureRecognizer(move)
        
    }
    func onContainerTap(ges:UITapGestureRecognizer){
    print("tap = \(ges.locationInView(self))")
    }
    
    func onContainerMove(ges:UIPanGestureRecognizer){
        print("move = \(ges.locationInView(self))")
    
    }
    func onContainerSwipe(ges:UISwipeGestureRecognizer){
        
        print("orientation \(ges.direction) \(ges.locationInView(self.containerView))")
        self.containerView.frame.origin = CGPoint(x: 50, y: 0)
    
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan = \(touches.first?.locationInView(self))")
        startPoint = (touches.first?.locationInView(self))!
        locatePoint = self.containerView.frame.origin.x
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved = \(touches.first?.locationInView(self)) previ = \(touches.first?.previousLocationInView(self))")
        if shouldTrack((touches.first?.locationInView(self))!) {
            
            moveContainerView(touches.first!)
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesEnded = \(touches.first?.locationInView(self))")
        endPoint = touches.first!.locationInView(self)
        recordCount = 0
        moveEnd()
        
    }
    
    func shouldTrack(point:CGPoint)->Bool{
        return true
        recordCount += 1
        let a = recordCount >= 15
        if a {
            print("count = \(recordCount)")
        return shouldMove
        }
        if recordCount % 5 == 0 {
        let b = startPoint.y + 3 > point.y && startPoint.y - 3 < point.y
            print("a = \(a) b = \(b) ")
            shouldMove = b && a
        return shouldMove
        }
        return shouldMove
    }
    
    func moveContainerView(touch:UITouch){
        print("x = \(self.containerView.frame.origin.x)")
        let currentX = xOffSet + touch.locationInView(self).x
        self.containerView.frame.origin.x = currentX >= 0 ? currentX : 0
        
    }
    func moveEnd(){
        print("move end = \(xOffSet) width = \(self.frame.size.width)")
        let distance = endPoint.x - startPoint.x
        if distance > self.frame.size.width / 3 {
            UIView.animateWithDuration(0.2, animations: {
            self.containerView.frame.origin.x = self.frame.size.width / 3 * 2
            self.containerView.transform = CGAffineTransformMakeScale(1, 0.8)
            })
        }
        else if -distance > self.frame.size.width / 3 {
            UIView.animateWithDuration(0.2, animations: {
                self.containerView.frame.origin.x = 0
                self.containerView.transform = CGAffineTransformMakeScale(1, 1)
            })
        }
        else {
            UIView.animateWithDuration(0.2, animations: {
                self.containerView.frame.origin.x = self.locatePoint
            })
        }
    }
    
}
