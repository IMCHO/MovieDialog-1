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
    
    var challenges:[Challenge]=[]
    var dialogs:[Dialog]=[]
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    var components: DateComponents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalList.dataSource = self
        goalList.delegate = self
        // Do any additional setup after loading the view.
        
        
        
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

        challenges = challenges.reversed()
        
        goalList.reloadData()
    }
    
}

extension MyGoalViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row==0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGoalCell", for: indexPath) as! MyGoalCell
            
            if challenges.count>0{
                cell.goalName.text = challenges[indexPath.row].title
                //달성률
                cell.goalRate.text = String(Float(challenges[indexPath.row].now*100 / challenges[indexPath.row].goal))+"%"
                //진행바
                cell.progressFront.frame.size.width = CGFloat(298 * challenges[indexPath.row].now / challenges[indexPath.row].goal)
                
                if let day = components.day {
                    cell.goalDday.text = "D - \(day)"
                }
                
                cell.progressBack.layer.cornerRadius = 10
                cell.progressFront.layer.cornerRadius = 7
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGoalListCell", for: indexPath) as! MyGoalListCell
            if indexPath.row != challenges.count{
                cell.goalListTitle.text = challenges[indexPath.row].title
                cell.goalListDate.text = "\(challenges[indexPath.row].startTime) - \(challenges[indexPath.row].time)"
                cell.goalListNum.text = "목표 영화 개수 : \(challenges[indexPath.row].goal)"
            }
            
            return cell
        }
    }
}

extension MyGoalViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}



