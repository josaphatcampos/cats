//
//  CatsCollectionViewController.swift
//  cats
//
//  Created by Josaphat Campos Pereira on 01/04/20.
//  Copyright © 2020 Josaphat Campos Pereira. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class CatsCollectionViewController: UICollectionViewController {
    
    var loadIndicator: UIView = UIView()
    var catsArray = [String]()
    
    var pagina:Int = 1
    var carrega:Bool = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        configLayoutCollectionView()
        getCats()
    }
    
    func configLayoutCollectionView(){
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right:  5)
        layout.minimumInteritemSpacing = 5
        
        let width:CGFloat
        
        if UtilityHelper.isIphone(){
            width = (view.frame.size.width - 20) / 2
        }else{
            width = (view.frame.size.width - 40) / 4
        }
        
        
        layout.itemSize = CGSize(width: width, height: width)
        
        
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return catsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellCollectionViewCell
    
//        let img:UIImageView = cell.image
        cell.image.kf.indicatorType = .activity
        cell.image.kf.setImage(with: URL(string: catsArray[indexPath.item]), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == catsArray.count - 1 && carrega{
            getCats()
        }
    }
    
    func getCats(){
        
        if !UtilityHelper.isNetworkAvailable() {
            UIHelper.stopsIndicator(view: self.view)
            UIHelper.showAlertController(uiController: self, message: "Verifique sua conexão!")
            return
        }
        
        self.loadIndicator = UIHelper.activityIndicator(view: self.view, title: "Carregando");
        carrega = false
        
        let headers: HTTPHeaders = [
        .authorization("Client-ID 1ceddedc03a5d71")
        ]
        
        AF.request("https://api.imgur.com/3/gallery/search/\(pagina)/?q=cats", headers: headers).responseJSON { response in
            
            switch response.result {
            case .success:
                if let data = response.data {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            
                            let results = json["data"] as? NSArray
                            if results == nil {
                                UIHelper.stopsIndicator(view: self.loadIndicator)
                                return
                            }
                            for result in results! {
                                
                                let item = result as! NSDictionary
                                
                                if let images = item["images"] as? NSArray {
                                    
                                    for img in images {
                                        let imagedic = img as! NSDictionary
                                        if imagedic["type"] as! String == "image/jpeg"{
                                            self.catsArray.append(imagedic["link"] as! String)
                                        }
                                    }
                                    
                                }
                            }
                            self.pagina += 1
                            self.carrega = true
                            self.collectionView.reloadData()
                            
                        }
                    }catch let error as NSError{
                        print("ERRO: \(error.localizedDescription)")
                    }
                }
            case let .failure(error):
                print(error)
            }
            
            UIHelper.stopsIndicator(view: self.loadIndicator)
        }
    }

}
