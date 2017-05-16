//
//  CameraVC.swift
//  Project05
//
//  Created by YenShao on 2017/5/16.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

protocol UserInputMsg {
    
    func showMsg(image:UIImage, text:String)
}


class CameraVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var inputTextfield: UITextField!
    
    var takePhoto:UIImage?
    
    var userInputMsgDelegate:UserInputMsg?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = takePhoto
        {
            photo.image = image
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if let image = takePhoto, let text = inputTextfield.text
        {
            userInputMsgDelegate?.showMsg(image: image, text: text)
        }
        
    }
    
    
    //MARK: 文字框按下return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        inputTextfield.resignFirstResponder()
        return true
    }
    

    

}
















