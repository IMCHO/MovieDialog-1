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
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var challenges:[Challenge]=[]
    var dialogs:[Dialog]=[]
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalList.dataSource = self
        goalList.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let data = try? Data(contentsOf: URL(fileURLWithPath:documentsPath + "/challenge.plist")){
            if let decodedChallenge = try? decoder.decode([Challenge].self, from: data){
                challenges = decodedChallenge
//                print(challenges)
                challenges = challenges.reversed()
                checkDateForButton()
                goalList.reloadData()
            }else{
                print("디코딩 실패")
            }
        }else{
            print("기존 데이터 없음")
        }
    }
    
    
    func checkDateForButton(){
        if challenges.count > 0{
            let calendar = Calendar.current
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: challenges[0].time)
            let components1 = calendar.dateComponents([.day], from: date2, to: date1)
            
            if let day = components1.day{
                if challenges[0].goal > challenges[0].now , day < 0 {
                    addButton.isEnabled = false
                }else{
                    addButton.isEnabled = true
                }
            }
        }
    }
    
    @IBAction func addChallenge(_ sender: UIBarButtonItem) {
        if let view = self.storyboard?.instantiateViewController(withIdentifier: "addGoal"){
            present(view,animated: true)
        }else{
            print("Can't not present addGoalView")
        }
    }
}

extension MyGoalViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return 1
        }else{
            if challenges.count==0{
                return 0
            }else{
                return challenges.count-1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0{
            return "진행 중인 목표"
        }else{
            return "지난 목표들"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if challenges.count>0{
            if indexPath.section==0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyGoalCell", for: indexPath) as! MyGoalCell
                let challenge = challenges[indexPath.row]
                
                cell.goalName.text = challenge.title
                
                //달성률
                cell.goalRate.text = String(Float(challenge.now*100 / challenge.goal))+"%"
                
                //진행바
                cell.progressBar.progress = Float(challenge.now) / Float(challenge.goal)
                cell.progressBar.transform = .identity
                cell.progressBar.transform = cell.progressBar.transform.scaledBy(x: 1, y: 10)
                
                let startDate = challenge.startTime
                let finishDate = challenge.time
                let startDateString = dateFormatter.string(from: startDate)
                let finishDateString = dateFormatter.string(from: finishDate)
                
                cell.goalDday.text = "\(startDateString) ~ \(finishDateString)"

                let today = Date()
                let calendar = Calendar.current
                
                let startDateInCal = calendar.startOfDay(for: startDate)
                let finishDateInCal = calendar.startOfDay(for: finishDate)
                let todayInCal = calendar.startOfDay(for: today)
                
                let diffFromTodayToStart = calendar.dateComponents([.day], from: todayInCal, to: startDateInCal)
                let diffFromTodayToFinish = calendar.dateComponents([.day], from: todayInCal, to:finishDateInCal)
                
                
                if diffFromTodayToStart.day! > 0{
                    cell.status.text="진행 예정"
                }else if diffFromTodayToStart.day! <= 0, diffFromTodayToFinish.day! > 0{
                    if let day=diffFromTodayToFinish.day{
                        cell.status.text="D - \(day)"
                    }
                }else{
                    cell.status.text="마감"
                }
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyGoalListCell", for: indexPath) as! MyGoalListCell
                
                cell.goalListTitle.text = challenges[indexPath.row+1].title
                
                let start = dateFormatter.string(from: challenges[indexPath.row+1].startTime)
                let finish = dateFormatter.string(from: challenges[indexPath.row+1].time)
                
                cell.goalListDate.text = "\(start) ~ \(finish)"
                cell.goalListNum.text = "목표 영화 개수 : \(challenges[indexPath.row+1].goal)"
                
                //image rotate
                cell.goalListImage.transform = CGAffineTransform(rotationAngle: (-7.0 * .pi) / 180.0)
                
                if challenges[indexPath.row+1].now == challenges[indexPath.row+1].goal{
                    cell.goalListImage.image = UIImage(named: "missioncomplete")
                    // 달성 시
                }else{
                    // 미 달성시
                    cell.goalListImage.image = UIImage(named: "missionfail")
                }
                return cell
            }
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "MyGoalEmptyTableViewCell", for: indexPath) as! MyGoalEmptyTableViewCell
        }
    }
}

extension MyGoalViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
}


