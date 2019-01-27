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
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalList.dataSource = self
        goalList.delegate = self
        // Do any additional setup after loading the view.
        starNum.text = "총 몇개"
        starImage.image = UIImage(named: "starLevel01")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let data=try? Data(contentsOf: URL(fileURLWithPath:documentsPath+"/challenge.plist")){
            if let decodedChallenge=try? decoder.decode([Challenge].self, from: data){
                challenges=decodedChallenge
                print(challenges)
            }else{
                print("디코딩 실패")
            }
        }else{
            print("기존 데이터 없음")
        }
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
        cell.goalName.text = challenges[indexPath.row].title
        cell.goalRate.text = "목표 달성률"
        
        return cell
    }
}

extension MyGoalViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


