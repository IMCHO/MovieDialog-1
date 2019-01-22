//
//  AddGoalView.swift
//  MovieDialog
//
//  Created by 박지호 on 21/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit
var goalTitle: UITextField!
var goalNum: UITextField!

class AddGoalView: UIViewController {

    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var titleButton: UIButton!
    @IBAction func insertTitle(_ sender: Any) {
        print(inputTitle)
        goalTitle = inputTitle
        inputTitle.text = ""
    }
    
    @IBOutlet weak var inputNum: UITextField!
    @IBAction func insertNum(_ sender: Any) {
        print(inputNum)
        goalNum = inputNum
        inputNum.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleButton.layer.borderColor = UIColor.lightGray.cgColor
        titleButton.layer.borderWidth = 1
        titleButton.layer.cornerRadius = 10
        
    }

}
