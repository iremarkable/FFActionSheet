# FFActionSheet
###Simple Action Sheet coding with [PureLayout](https://github.com/smileyborg/PureLayout)

Language: Swift



Screen Shot:

![Demo Image](https://github.com/iremarkable/FFActionSheet/blob/master/FFActionSheet/demo.png)


###Demo:


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