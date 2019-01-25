//
//  AddGoalView.swift
//  MovieDialog
//
//  Created by 박지호 on 21/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit
var goalTitle: UITextField! //넘겨줄 목표 제목
var goalNum: UITextField!   //넘겨줄 목표 개수

class AddGoalView: UIViewController {
    

    //목표 제목
    @IBOutlet weak var inputTitle: UITextField!
    
    //목표 개수
    @IBOutlet weak var inputNum: UITextField!
    
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
        // Do any additional setup after loading the view
        
    }
    
    //목표 저장
    @IBAction func saveGoal(_ sender: Any) {
        goalTitle = inputTitle
        goalNum = inputNum
        self.dismiss(animated:true, completion:nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

}
