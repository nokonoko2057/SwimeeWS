//
//  FontContainerController.swift
//  SwimeeWorkShop
//
//  Created by yuki takei on 2017/06/03.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FontContainerController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "FontContainerController"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        
//        UIFont.familyNames().forEach { (familyName) in
//            let fontsInFamily = UIFont.fontNamesForFamilyName(familyName)
//            fontsInFamily.forEach({ (fontName) in
//                print(fontName)
//                let label = UILabel()
//                label.text = "フォント：" + fontName
//                label.font = UIFont(name: fontName, size: UIFont.labelFontSize())
//                label.sizeToFit()
//                label.frame.origin.y = view.contentSize.height
//                view.contentSize.width = max(view.contentSize.width, label.frame.width)
//                view.contentSize.height += label.frame.height + 10
//                view.addSubview(label)
//            })
//        }
        
//        UIFont.familyNames.forEach { (familyName) in
//            let fontsInFamily = UIFont.fontNames(forFamilyName: familyName)
//            fontsInFamily.forEach({ (fontName) in
//                code
//            })
//        }

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
//        var cell = CollectionViewCell()
        

        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 1.0)
        
        
//        cell.fontLabel.text = "Test"
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
