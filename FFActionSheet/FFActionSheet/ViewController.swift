//
//  ViewController.swift
//  FFActionSheet
//
//  Created by Liunex on 7/7/15.
//  Copyright © 2015 liufeifei0914@163.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.createSubViews()
    }

   
    func createSubViews() ->Void{
        
        let btn:UIButton! = UIButton(type: UIButtonType.Custom)
        self.view.addSubview(btn)
        
        
        btn.autoSetDimension(ALDimension.Height, toSize: 50);
        btn.autoSetDimension(ALDimension.Width, toSize: 100);
        
        btn.autoCenterInSuperview()
        
        
        btn.backgroundColor = UIColor.purpleColor()
        btn.setTitle("Show", forState: UIControlState.Normal)
        
        
        //add target action
        btn.addTarget(self, action:"showAction" , forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    
    func showAction(){

        let sheet = FFActionSheet.actionSheet()
        self.view.addSubview(sheet)
        
        
        let a1 = FFAction(actionName: "Choose photo from album");
        let a2 = FFAction(actionName: "Open Camera");
        
        var array = Array<FFAction>()
        array.append(a1)
        array.append(a2)
        
        sheet.addActions(array)
        
        sheet.selectBlock = { ( index:Int ) -> ()  in
            print(index)
        }
        
        sheet.show()
    
    }
    
    

}

