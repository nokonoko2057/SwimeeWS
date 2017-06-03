//
//  GetColorContainerController.swift
//  ColorHunting
//
//  Created by yuki takei on 2017/05/31.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit

protocol GetColorContainerDelegate: class{
 
    
//    func show()
    
    func tappedPostbutton()
}

class GetColorContainerController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GetColorContainerController"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func nextButton(_ sender: UIButton) {        
    }
    
    

}
