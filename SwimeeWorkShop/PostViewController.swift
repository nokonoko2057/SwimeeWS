//
//  PostViewController.swift
//  ColorHunting
//
//  Created by yuki takei on 2017/05/31.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import FirebaseStorage



class PostViewController: UIViewController {
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var storage = FIRStorage.storage()
    var storageRef:FIRStorageReference!
    

    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.image = appDelegate.colorHuntImage
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageRef = storage.reference(forURL: "gs://colorhunting-11078.appspot.com/")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func postButton(_ sender: UIBarButtonItem) {
        postImage(imageFile: imageView.image!)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
    
    func postImage(imageFile: UIImage){
        
        let fileName:String = "test.png"
      
        // 画像をリサイズする(任意)
        /* Basic会員は５MB、Expert会員は100GBまでのデータを保存可能です */
        /* 上限を超えてしまうデータの場合はリサイズが必要です */
//        let imageW : Int = Int(imageFile.size.width*0.6) /* 20%に縮小 */
//        let imageH : Int = Int(imageFile.size.height*0.6) /* 20%に縮小 */
//        let resizeImage = resize(image: imageFile, width: imageW, height: imageH)

        
        // 画像をNSDataに変換
//        let pngData = NSData(data: UIImagePNGRepresentation(imageFile)!)

        
        let pngData = UIImagePNGRepresentation(imageFile)!
        let imagesRef = storageRef.child("images/test.png")
        imagesRef.put(pngData, metadata: nil) { (metaData, error) in
            print(metaData)
            print(error)
        }
        
        
        
        /*
        let file = NCMBFile.file(withName: fileName, data: pngData as Data!) as! NCMBFile
        
        // ファイルストアへ画像のアップロード
        file.saveInBackground({ (error) in
            if error != nil {
                // 保存失敗時の処理
                print(error)
            } else {
                // 保存成功時の処理
                print("++++++成功！+++++++")
            }
        }) { (int) in
            // 進行状況を取得するためのBlock
            /* 1-100のpercentDoneを返す */
            /* このコールバックは保存中何度も呼ばれる */
            /*例）*/
            print("\(int)%")
        }
 */
    }
    
    
    // 画像をリサイズする処理
    func resize (image: UIImage, width: Int, height: Int) -> UIImage {
        let size: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizeImage!
    }
}


