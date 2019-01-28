//
//  MyGoalViewController.swift
//  MovieDialog
//
//  Created by linc on 21/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class MyGoalViewController: UIViewController {

    @IBOutlet weak var goalList: UITableView!
    @IBOutlet weak var starNum: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    var challenges:[Challenge]=[]
    var dialogs:[Dialog]=[]
    var allStar:Int=0
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    var components: DateComponents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalList.dataSource = self
        goalList.delegate = self
        // Do any additional setup after loading the view.
        starImage.image = UIImage(named: "starLevel01")
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let data=try? Data(contentsOf: URL(fileURLWithPath:documentsPath+"/challenge.plist")){
            if let decodedChallenge=try? decoder.decode([Challenge].self, from: data){
                challenges=decodedChallenge
                if challenges.count > 0 {
                    let challenge = challenges[challenges.count - 1]
                    //challenge.time
                    //challenge.time -> Date
                    let startDate = challenge.startTime
                    let finishDate=challenge.time
                    
                    let today = Date()
                    
                    let calendar = Calendar.current
                    
                    // Replace the hour (time) of both dates with 00:00
                    let date1 = calendar.startOfDay(for: startDate)
                    let date2 = calendar.startOfDay(for: finishDate)
                    
                    components = calendar.dateComponents([.day], from: date1, to: date2)
//                    print(components.day)
                    
                }
                
                
//                print(challenges)
            }else{
                print("디코딩 실패")
            }
        }else{
            print("기존 데이터 없음")
        }
        
        if let data=try? Data(contentsOf: URL(fileURLWithPath:documentsPath+"/dialog.plist")){
            if let decodedDialog=try? decoder.decode([Dialog].self, from: data){
                dialogs=decodedDialog
                allStar=0
                for dialog in dialogs{
                    allStar+=dialog.star
                }
//                print(challenges)
            }else{
                print("디코딩 실패")
            }
        }else{
            print("기존 데이터 없음")
        }
        
        starNum.text = String(allStar)
        challenges = challenges.reversed()

        goalList.reloadData()
    }

}

extension MyGoalViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGoalCell", for: indexPath) as! MyGoalCell
        
        if challenges.count > 0{
            cell.goalName.text = challenges[indexPath.row].title
            //달성률
            cell.goalRate.text = String(Float(challenges[indexPath.row].now*100 / challenges[indexPath.row].goal))+"%"
            //진행바
            cell.progressFront.frame.size.width = CGFloat(298 * (challenges[indexPath.row].now / challenges[indexPath.row].goal))
            
            if let day = components.day {
                cell.goalDday.text = "D - \(day)"
            }
        }
        cell.progressBack.layer.cornerRadius = 10
        cell.progressFront.layer.cornerRadius = 7
     
        
        
        
        return cell
    }
}

extension MyGoalViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}



