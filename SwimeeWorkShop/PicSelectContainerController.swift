//
//  PicSelectContainerController.swift
//  ColorHunting
//
//  Created by yuki takei on 2017/05/30.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit

protocol PicSelectContainerDelegate: class {
    
    func tappedButton(_ sourceType:UIImagePickerControllerSourceType)
}


class PicSelectContainerController: UIViewController{
    
    weak var delegate:PicSelectContainerDelegate!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    
    override func viewDidLoad() {
        self.title = "PicSelectContainerController"
    }
    
    
    @IBAction func tappedButton(_ sender: UIButton) {
        
        var imagePickerController = UIImagePickerController()
        
        if sender == cameraButton{
            print("cam")
            imagePickerController.sourceType = .camera
        }
        if sender == libraryButton{
            print("Library")
            imagePickerController.sourceType = .photoLibrary
        }
        
        delegate.tappedButton(imagePickerController.sourceType)
    }
    

    
}
