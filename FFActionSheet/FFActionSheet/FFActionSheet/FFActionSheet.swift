//
//  FFActionSheet.swift
//  FFActionSheet
//
//  Created by Liunex on 7/7/15.
//  Copyright © 2015 liufeifei0914@163.com. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor)
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, forState: forState)
    }
    
}



class FFAction:UIButton{
    
    
    
    init(actionName:String!){
        
        let x:CGFloat = 0.0
        let y:CGFloat = 0.0
        let w:CGFloat = 0.0
        let h:CGFloat = 0.0
        super.init(frame: CGRectMake(x,y,w,h))
        
        
        self.setTitle(actionName, forState: UIControlState.Normal)
        self.setTitleColor(UIColor.blackColor().colorWithAlphaComponent(0.8), forState: UIControlState.Normal)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class FFActionSheet:UIView  {
    
    var actions = Array<FFAction!>()
    let dimmingView = UIView()
    let actionView = UIView()
    let cancelButton = UIButton(type: UIButtonType.Custom)
    var selectBlock : ((Int) -> Void)!
    
    
    
    class func actionSheet() -> FFActionSheet{
        
        let x:CGFloat = 0.0
        let y:CGFloat = 0.0
        var w:CGFloat = 0.0
        var h:CGFloat = 0.0
        
        w = UIScreen.mainScreen().bounds.size.width
        h = UIScreen.mainScreen().bounds.size.height
        
        
        let sheet = FFActionSheet(frame: CGRectMake(x,y,w,h))
        sheet.hidden = true
        return sheet
    
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        //dimming view
        dimmingView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        dimmingView.frame = frame
        self.addSubview(dimmingView)
        
        
        
        //action view
        var x:CGFloat = 0.0
        var y:CGFloat = 0.0
        var w:CGFloat = 0.0
        var h:CGFloat = 0.0
        
        x = 0
        y = self.frame.size.height - 44;//initail height
        w = self.frame.size.width
        h = 44
        actionView.frame = CGRectMake(x,y,w,h)
        self.addSubview(actionView)
        actionView.backgroundColor = UIColor.whiteColor()
        
        
        
        // cancel button
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        cancelButton .setTitleColor(UIColor.redColor().colorWithAlphaComponent(0.8), forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.redColor().colorWithAlphaComponent(0.3), forState: UIControlState.Highlighted)
        
        cancelButton.setTitle("取消", forState: UIControlState.Normal)
        cancelButton.setBackgroundColor(UIColor.grayColor().colorWithAlphaComponent(0.2), forState: UIControlState.Highlighted)

        actionView.addSubview(cancelButton)
        

        cancelButton.autoSetDimension(ALDimension.Width, toSize: actionView.frame.size.width)
        cancelButton.autoSetDimension(ALDimension.Height, toSize: 44)
        cancelButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0.0)

        
        cancelButton.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func addActions(actionArray:Array<FFAction>!){
        actions = actionArray
        
        
        var x:CGFloat = 0.0
        var y:CGFloat = 0.0
        var w:CGFloat = 0.0
        var h:CGFloat = 0.0
        
        let count = actions.count
        
        for var i = 0;i<count;i++ {

            let action = actions[i]

            x = 0
            y = 0
            h = 44
            w = actionView.frame.width
            
            y = h * CGFloat(i);
            action.frame = CGRectMake(x,y,w,h)
            
            let line = UIView(frame:CGRectMake(20,h-0.5,w-40,0.5))
            line.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            action.addSubview(line)
            
            action.setBackgroundColor(UIColor.grayColor().colorWithAlphaComponent(0.2), forState: UIControlState.Highlighted)
            action.tag = i
            
            
            actionView.addSubview(action)
            
            action.addTarget(self, action: "selectAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
        }
        
        
        
        let actionViewH = CGFloat(count) * 44 + 44
        let actionY = self.frame.size.height
        actionView.frame = CGRectMake(x,actionY,w,actionViewH)
        
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func show(){
        self.hidden = false
    
        
        let count = actions.count
        let actionViewH = CGFloat(count) * 44 + 44
        let actionY = self.frame.size.height - actionViewH

        
        UIView.animateWithDuration (0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut ,animations: {

            self.actionView.frame = CGRectMake(0,actionY,self.frame.size.width,actionViewH)

            }, completion: { _ in
      
        })
        
        
        
    }
    
    func dismiss(){
        


        let actionY = self.frame.size.height
        
        UIView.animateWithDuration (0.15, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn ,animations: {
            self.actionView.frame = CGRectMake(0,actionY,self.frame.size.width,self.actionView.frame.size.height)
            }, completion: { _ in
                
        })
        
       
        
        UIView.animateWithDuration (0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear ,animations: {
            self.dimmingView.alpha = 0
            }, completion: { _ in
                self.hidden = true
                self.removeFromSuperview()
                self.dimmingView.removeFromSuperview()
        })
        
        
        
    }
    
    
    func selectAction(sender:FFAction){
        
        self.dismiss()
        selectBlock(sender.tag)
        
    }
    
    
    
}