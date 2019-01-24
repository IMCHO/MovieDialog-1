//
//  ShowAllViewController.swift
//  MovieDialog
//
//  Created by linc on 17/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class ShowAllViewController: UIViewController{

    @IBOutlet weak var sort: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func indexChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            print("1")
            collectionView.isHidden = false
        }else if sender.selectedSegmentIndex == 1{
            print("2")
            collectionView.isHidden = true
        }else if sender.selectedSegmentIndex == 2{
            print("3")
            collectionView.isHidden = true
        }else if sender.selectedSegmentIndex == 3{
            print("4")
            collectionView.isHidden = true
        }
    }
    
    func getImage(imageName: String) -> String{
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        if fileManager.fileExists(atPath: imagePath){
            return imagePath
        }else{
            return ""
        }
    }
    
    var dialogs:[Dialog]=[]
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource=self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        indexChange(sort)
        
        if let data=try? Data(contentsOf: URL(fileURLWithPath:documentsPath+"/dialog.plist")){
            if let decodedDialogs=try? decoder.decode([Dialog].self, from: data){
                dialogs=decodedDialogs
                print(dialogs)
            }else{
                print("디코딩 실패")
            }
        }else{
            print("기존 데이터 없음")
        }
        
        collectionView.reloadData()
    }
    

}

extension ShowAllViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCollection", for: indexPath) as! DialogCollectionViewCell
        
//        let name=dialogs[9].image
//        print(name)
//        cell.movieImage.image=UIImage(contentsOfFile: getImage(imageName: name))
        
        return cell
    }
}

extension ShowAllViewController:UICollectionViewDelegate{
    
}
