//
//  ShowDiaryViewController.swift
//  MovieDialog
//
//  Created by linc on 23/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class ShowDiaryViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel! //영화 이름
    @IBOutlet weak var dateLabel: UILabel! //관람일
    @IBOutlet weak var imageLabel: UIImageView! //영화 포스터
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBOutlet weak var simpleView: UIView!
    @IBOutlet weak var normalView: UIView!
    
    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBAction func segmentButton(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            simpleView.isHidden = false
            normalView.isHidden = true
        } else {
            simpleView.isHidden = true
            simpleView.isHidden = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
