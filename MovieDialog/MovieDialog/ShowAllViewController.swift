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
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    @IBAction func indexChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            print("1")
            collectionView1.isHidden = false
            collectionView2.isHidden=true
        }else if sender.selectedSegmentIndex == 1{
            print("2")
            collectionView1.isHidden = true
            collectionView2.isHidden=false
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
        
        collectionView1.delegate = self
        collectionView1.dataSource=self
        
        collectionView2.delegate = self
        collectionView2.dataSource=self
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
        
        collectionView1.reloadData()
        collectionView2.reloadData()
    }
    

}

extension ShowAllViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView==collectionView1{
            return 1
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView==collectionView1{
            return dialogs.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1{
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCollection", for: indexPath) as! DialogCollectionViewCell

            if dialogs.count>0{
                cell.movieImage.image=UIImage(contentsOfFile: getImage(imageName: dialogs.reversed()[indexPath.row].image))
            }
            return cell
        }else{
            let cell2=collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCollection2", for: indexPath) as! DialogCollectionViewCell
            return cell2
        }
    }

}

extension ShowAllViewController:UICollectionViewDelegate{

}
