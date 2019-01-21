//
//  InfoViewController.swift
//  MovieDialog
//
//  Created by In Taek Cho on 21/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var firstMovie: UIImageView!
    @IBOutlet weak var secondMovie: UIImageView!
    @IBOutlet weak var thirdMovie: UIImageView!
    
    var dialogs:[Dialog]=[]
    var timesOfMovie:[String:Int]=[:]
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        
        if let path = Bundle.main.path(forResource: "dialog", ofType: "plist") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                if let decodedDialogs = try? decoder.decode([Dialog].self, from: data) {
                    dialogs = decodedDialogs
                }
            }
            encoder.outputFormat = .xml
            if let data = try? encoder.encode(dialogs) {
                try? data.write(to: URL(fileURLWithPath: documentsPath + "/dialog.plist"))
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let data=try? Data(contentsOf: URL(fileURLWithPath:documentsPath+"/dialog.plist")){
            if let decodedDialogs=try? decoder.decode([Dialog].self, from: data){
                dialogs=decodedDialogs
                
                //                print(dialogs.count)
                
                //                print(dialogs.filter({$0.review != ""}).count)
                
                //                print(dialogs.filter({$0.simpleReview.count>0}).count)
                
                for dialog in dialogs{
                    if let times=timesOfMovie[dialog.title]{
                        timesOfMovie[dialog.title]=(times+1)
                    }else{
                        timesOfMovie[dialog.title]=1
                    }
                }
                //                print(timesOfMovie.sorted{$0.1>$1.1})
            }
        }
        
    }
    
}

extension InfoViewController:UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.detailTextLabel?.textColor = .blue
        
        if indexPath.row == 0 {
            cell.textLabel?.text="관람 작품 수"
            cell.detailTextLabel?.text = String(dialogs.count)+" 개"
        }else if indexPath.row==1{
            cell.textLabel?.text="작성 리뷰 수"
            cell.detailTextLabel?.text=String(dialogs.filter({$0.review != ""}).count)+" 개"
        }else{
            cell.textLabel?.text="작성 간편리뷰 수"
            cell.detailTextLabel?.text = String(dialogs.filter({$0.simpleReview.count>0}).count)+" 개"
        }
//        else{
//            cell.textLabel?.text="최다 관람 순위"
//            cell.detailTextLabel?.text = timesOfMovie.sorted{$0.1>$1.1}[0].0
//        }
        
        return cell
    }
    
}

extension InfoViewController:UITableViewDelegate{
    
}

