//
//  textField+addDone.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

extension UITextView {
    static var textFieldDoneButtonAction = "textFieldDoneButtonAction"

    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard(barColor: UIColor? = UINavigationBar.appearance().barTintColor ?? .white, textColor: UIColor? = UINavigationBar.appearance().tintColor ?? UIColor.black, doneButtonAction: (() -> Void)? = nil) {
        
        objc_setAssociatedObject(self, &UITextField.textFieldDoneButtonAction, doneButtonAction, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50.0))
        doneToolbar.isTranslucent = true
        doneToolbar.barStyle = UINavigationBar.appearance().barStyle
        doneToolbar.barTintColor = barColor
        doneToolbar.tintColor = UINavigationBar.appearance().tintColor
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: self, action: #selector(self.doneButtonAction))
        var doneButtonAttr = UIBarButtonItem.appearance().titleTextAttributes(for: UIControl.State.normal)
        doneButtonAttr?[NSAttributedString.Key.foregroundColor] = textColor ?? UIColor.black
        done.setTitleTextAttributes(doneButtonAttr, for: UIControl.State.normal)
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        if let doneButtonAction = objc_getAssociatedObject(self, &UITextField.textFieldDoneButtonAction) as! (() -> Void)? {
            doneButtonAction()
        }
    }
    
    func addDoneButtonToKeyboard(myAction:Selector?) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}


extension UITextField {
    static var textFieldDoneButtonAction = "textFieldDoneButtonAction"

    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard(barColor: UIColor? = UINavigationBar.appearance().barTintColor ?? .white, textColor: UIColor? = UINavigationBar.appearance().tintColor ?? UIColor.black, doneButtonAction: (() -> Void)? = nil) {
        
        objc_setAssociatedObject(self, &UITextField.textFieldDoneButtonAction, doneButtonAction, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50.0))
        doneToolbar.isTranslucent = true
        doneToolbar.barStyle = UINavigationBar.appearance().barStyle
        doneToolbar.barTintColor = barColor
        doneToolbar.tintColor = UINavigationBar.appearance().tintColor
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: self, action: #selector(self.doneButtonAction))
        var doneButtonAttr = UIBarButtonItem.appearance().titleTextAttributes(for: UIControl.State.normal)
        doneButtonAttr?[NSAttributedString.Key.foregroundColor] = textColor ?? UIColor.black
        done.setTitleTextAttributes(doneButtonAttr, for: UIControl.State.normal)
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        if let doneButtonAction = objc_getAssociatedObject(self, &UITextField.textFieldDoneButtonAction) as! (() -> Void)? {
            doneButtonAction()
        }
    }
}

extension UITextField {
    
    func addDoneButtonToKeyboard(myAction:Selector?) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}

