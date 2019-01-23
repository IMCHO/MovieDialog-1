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
    
    //목표 기간 선택
    @IBOutlet weak var startDay: UILabel!
    @IBOutlet weak var finishDay: UILabel!
    
    //시작 날짜 선택
    @IBAction func startDate(_ sender: Any) {
        let startDate: UIDatePicker = UIDatePicker()
        startDate.datePickerMode = .date
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(startDate)
        
        alert.addAction(UIAlertAction(title:"완료", style:.default, handler:{result in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let dateString = dateFormatter.string(from:startDate.date)
            self.startDay.text = dateString //시작 날짜 받아와서 저장
            
        }))
        alert.addAction(UIAlertAction(title:"취소", style:.cancel, handler:nil))
        self.present(alert, animated:true, completion:nil)
    }
    
    //종료 날짜 선택
    @IBAction func finishDate(_ sender: Any) {
        let finishDate: UIDatePicker = UIDatePicker()
        finishDate.datePickerMode = .date
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(finishDate)
        
        alert.addAction(UIAlertAction(title:"완료", style:.default, handler:{result in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let dateString = dateFormatter.string(from:finishDate.date)
            self.finishDay.text = dateString //종료 날짜 받아와서 저장
            
        }))
        alert.addAction(UIAlertAction(title:"취소", style:.cancel, handler:nil))
        self.present(alert, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleButton.layer.borderColor = UIColor.lightGray.cgColor
        titleButton.layer.borderWidth = 1
        titleButton.layer.cornerRadius = 10
        
    }

}
