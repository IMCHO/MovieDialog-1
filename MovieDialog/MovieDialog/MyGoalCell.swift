//
//  MyGoalCell.swift
//  MovieDialog
//
//  Created by linc on 21/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class MyGoalCell: UITableViewCell {
    @IBOutlet weak var goalName: UILabel!   //목표 이름
    @IBOutlet weak var goalRate: UILabel!   //목표 달성률
    @IBOutlet weak var goalDday: UILabel!   //목표 디데이
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
}
