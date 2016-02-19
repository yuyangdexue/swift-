//
//  HomeViewController.swift
//  project
//
//  Created by 于洋 on 16/1/6.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit
import ModelRocket
let  kCollectionIdentifierType_Cell : String =  "kCollectionIdentifierType_Cell"
let  kCollectionIdentifierType_Header : String =  "kCollectionIdentifierType_Header"
class HomeViewController: BaseViewController {
    private var arr = [TabarSubModel]()
    private var collectionView:UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self .hideTopView(true)
       self .initJson()
       self.initCollectionView()
        
    }
    
    func initJson(){
        let json = JSON(data:LibiaryAPI.shareInstance.dataFromResource("homemenu", typeName: "json"))
        if let tabarModel = TabarModel(strictJSON:json){
            for subModel in  tabarModel.items{
                arr.append(subModel)
            }
            
        }
        print(arr)
    }

    
    func initCollectionView(){
        let  layout :UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSizeMake(kDeviceWidth, HeaderHeight * kDeviceFactor)
        collectionView =  UICollectionView(frame: CGRectMake(0, kMarginTopHeight, kDeviceWidth, kDeviceHeight - kMarginTopHeight - kTabBarHeight - 1), collectionViewLayout: layout)
        collectionView?.dataSource=self
        collectionView?.delegate=self
        collectionView?.backgroundColor = kColor_MainBg_Color
        collectionView?.bounces = true
        collectionView?.showsVerticalScrollIndicator = false
        self.view .addSubview(collectionView!)
        
        collectionView?.registerClass(HomeMenuCell.self, forCellWithReuseIdentifier: kCollectionIdentifierType_Cell)
        collectionView?.registerClass(HomeMenuHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionIdentifierType_Header)
        
        
    }
    
    
    
}

extension HomeViewController : UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let  cell:HomeMenuCell  =  collectionView.dequeueReusableCellWithReuseIdentifier(kCollectionIdentifierType_Cell, forIndexPath: indexPath) as! HomeMenuCell
        let  model  : TabarSubModel = arr[indexPath.row]
        cell .resetWithModel(model)
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var   reusableview : UICollectionReusableView?
        if (kind == UICollectionElementKindSectionHeader){
            let  homeHeader : HomeMenuHeader = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionIdentifierType_Header, forIndexPath: indexPath) as!  HomeMenuHeader
            reusableview = homeHeader
        }
        return reusableview!
        
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
        
    }
    
}
extension HomeViewController: UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView .deselectItemAtIndexPath(indexPath, animated: true)
        
        let subModel = arr[indexPath.row]
        
        let viewController:UIViewController = LibiaryAPI.shareInstance.viewControllerWithKey(subModel.key.value!)
        viewController.title = subModel.title.value
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    

}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        return CGSizeMake(kDeviceWidth/3.0, kDeviceWidth/3.0 * (100/105.0))
    }
    
}


