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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalList.dataSource = self
        goalList.delegate = self
        // Do any additional setup after loading the view.
        starNum.text = "총 몇개"
        starImage.image = UIImage(named: "starLevel01")
        
        
    }

}

extension MyGoalViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGoalCell", for: indexPath) as! MyGoalCell
        cell.goalName.text = "목표 제목"
        cell.goalRate.text = "목표 달성률"
        
        return cell
    }
}

extension MyGoalViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


