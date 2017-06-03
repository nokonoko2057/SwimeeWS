//
//  PictureViewController.swift
//  ColorHunting
//
//  Created by yuki takei on 2017/05/30.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import C4

class PictureViewController: CanvasController{
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var gestureView: UIView!{
        didSet{
            gestureView.backgroundColor = UIColor.clear
        }
    }
    
    
    var isCamShown = false
    
    var selecter:PicSelectContainerController!
    
    var triangle:Triangle?
    
  
    //MARK: - Normal
    
    
    //Like viewDidLoad()
    override func setup() {
        let containerNavigation = self.childViewControllers[0] as! UINavigationController
        selecter = containerNavigation.topViewController as! PicSelectContainerController
        selecter.delegate = self

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        firstCamera()
    }
    
    
    //MARK: - Navigation
    
    @IBAction func tappedNextButton(_ sender: UIBarButtonItem) {
        
        let containerNavigation = self.childViewControllers[0] as! UINavigationController
        let currentContainerViewController = containerNavigation.visibleViewController
        
        switch currentContainerViewController!.title! {
            
        case "PicSelectContainerController":
            currentContainerViewController?.performSegue(withIdentifier: "toFontContainer", sender: nil)
      
            let backButtonItem = UIBarButtonItem(title: "←", style: .plain, target: self, action: #selector(backOfNavigation))
            self.navigationItem.leftBarButtonItem = backButtonItem
            break
            
            
        case "GetColorContainerController":
            if imageView.image != nil{
                saveImage()
                performSegue(withIdentifier: "toTextInput", sender: nil)
            }

            break
            
            
            
        case "FontContainerController":
            currentContainerViewController?.performSegue(withIdentifier: "toGetColorContainer", sender: nil)
            
            let backButtonItem = UIBarButtonItem(title: "←", style: .plain, target: self, action: #selector(backOfNavigation))
            self.navigationItem.leftBarButtonItem = backButtonItem
            break

            
        default:
            break
        }
    }
    
    func backOfNavigation() {
        
        self.navigationItem.leftBarButtonItem = nil
        
        let containerNavigation = self.childViewControllers[0] as! UINavigationController
        containerNavigation.popViewController(animated: true)
    }
    
    
    
    //MARK: - Image
    
    
    func firstCamera(){
        if isCamShown == true{
            return
        }
        
        startImagePicker(.camera)
    }
    
    
    func startImagePicker(_ sourceType:UIImagePickerControllerSourceType){
        
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            
            isCamShown = true
            
            self.present(cameraPicker, animated: true, completion: nil)
            
            
        }else{
            print("error")    //アラート入れる

        }
    }
    
    
    func saveImage(){
        let rect:CGRect = imageView.frame

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        
        //Affine変換
        let affineMoveLeftTop = CGAffineTransform(translationX: -rect.origin.x, y: -rect.origin.y)
        context.concatenate(affineMoveLeftTop)
      
        self.view.layer.render(in: context)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
        appDelegate.colorHuntImage = capture
    }
    
    
    func makeTriangle(tappedPoint:CGPoint){
        
        let x = 100 * cos(M_PI * 6 / 9.0)
        let y = 100 * sin(M_PI * 6 / 9.0)
        
        let x2 = 100 * cos(M_PI * 7 / 9.0)
        let y2 = 100 * sin(M_PI * 7 / 9.0)

        
        let points = [Point(0,0), Point(x2, y2), Point(x, y)]
        let triangle = Triangle(points)
//        triangle.origin = Point(Double(tappedPoint.x) - triangle.size.width, Double(tappedPoint.y) + triangle.size.height)
        triangle.origin = Point(tappedPoint)
        triangle.rotation = M_PI
        self.triangle = triangle
        canvas.add(self.triangle)
        canvas.bringToFront(gestureView)


        
    }
    
    
    //MARK: - TapGesture
    
    @IBAction func tapGestureView(_ sender: UITapGestureRecognizer) {
        
        print("tap")
        print(sender.location(in: imageView))
        
        if triangle != nil{
            
        }else{
            makeTriangle(tappedPoint: sender.location(in: imageView))
        }
        
    }
    
    
    @IBAction func pinchGestureView(_ sender: UIPinchGestureRecognizer) {
        
        print("pinch")
        print(sender.scale)

        if triangle != nil{
            let pinchScale = 1.0 - (1.0 - Double(sender.scale))*0.01
            triangle?.transform.scale(pinchScale, pinchScale)

        }
        
        
    }
    
    
    @IBAction func rotationGestureView(_ sender: UIRotationGestureRecognizer) {
        print("rotation")
        print(sender.location(in: imageView))
        
        if triangle != nil{
            triangle?.rotation = Double(sender.rotation) * 1.1
        }
    }
    
    @IBAction func panGestureView(_ sender: UIPanGestureRecognizer) {
        print("pan")

        let newPoint = sender.location
        
        print(newPoint)
        
        triangle?.origin = Point(Double(newPoint.x) - (triangle?.size.width)!, Double(newPoint.y) + (triangle?.size.height)!)
        
    }
    
}


// MARK: - UIImagePickerControllerDelegate


extension PictureViewController:UIImagePickerControllerDelegate{
    
    
    //撮影完了
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        //閉じる処理
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    //撮影キャンセル
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
}


//MARK: - UINavigationControllerDelegate


extension PictureViewController:UINavigationControllerDelegate{
    
}

//MARK: - PicSelectContainerDelegate


extension PictureViewController: PicSelectContainerDelegate{
    
    func tappedButton(_ sourceType: UIImagePickerControllerSourceType) {
        print("delegate!!!!")
        startImagePicker(sourceType)
    }
    
}

extension PictureViewController: GetColorContainerDelegate{
    
    func tappedPostbutton() {
        print("delegate: GetColorContainerDelegate")
    }
    
    
}



