//
//  AddGoalView.swift
//  MovieDialog
//
//  Created by 박지호 on 21/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit


class AddGoalViewController: UIViewController, UITextFieldDelegate {
    
    var challenges:[Challenge]=[]
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    

    //목표 제목
    @IBOutlet weak var inputTitle: UITextField!{
        didSet{
            inputTitle.delegate = self
        }
    }
    
    //목표 개수
    @IBOutlet weak var inputNum: UITextField!{
        didSet{
            inputNum.delegate = self
        }
    }
    
    //목표 기간 선택
    @IBOutlet weak var startDay: UILabel!
    @IBOutlet weak var finishDay: UILabel!
    
    var finish:Date!
    var start:Date!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func setDate(_ sender: Any) {
        
        if inputTitle.canResignFirstResponder{
            inputTitle.resignFirstResponder()
        }
        if inputNum.canResignFirstResponder{
            inputNum.resignFirstResponder()
        }
        
        let datePicked: UIDatePicker = UIDatePicker()
        datePicked.datePickerMode = .date
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicked)
        
        alert.addAction(UIAlertAction(title:"완료", style:.default, handler:{result in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            
            if (sender as! UIButton).restorationIdentifier == "start"{
                self.start=datePicked.date
                let dateString = dateFormatter.string(from:datePicked.date)
                self.startDay.text = dateString //시작 날짜 받아와서 저장
            }else{
                self.finish = datePicked.date
                let dateString = dateFormatter.string(from:datePicked.date)
                self.finishDay.text = dateString
            }
        }))
        alert.addAction(UIAlertAction(title:"취소", style:.cancel, handler:nil))
        self.present(alert, animated:true, completion:nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let data=try? Data(contentsOf: URL(fileURLWithPath:documentsPath+"/challenge.plist")){
            if let decodedChallenge=try? decoder.decode([Challenge].self, from: data){
                challenges=decodedChallenge
//                print(challenges)
            }else{
                print("Can't find any challenges")
            }
        }
    }
    
    //목표 저장
    @IBAction func saveGoal(_ sender: Any) {
        if inputTitle.text == "" {
            let alert = UIAlertController(title: "내용을 모두 입력해 주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title:"확인", style:UIAlertAction.Style.default) { UIAlertAction in })
            present(alert, animated:true, completion:nil)
            return
        } else if inputNum.text == "" {
            let alert = UIAlertController(title: "내용을 모두 입력해 주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title:"확인", style:UIAlertAction.Style.default) { UIAlertAction in })
            present(alert, animated:true, completion:nil)
            return
        } else if finish == nil {
            let alert = UIAlertController(title: "내용을 모두 입력해 주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title:"확인", style:UIAlertAction.Style.default) { UIAlertAction in })
            present(alert, animated:true, completion:nil)
            return
        } else if start == nil {
            let alert = UIAlertController(title: "내용을 모두 입력해 주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title:"확인", style:UIAlertAction.Style.default) { UIAlertAction in })
            present(alert, animated:true, completion:nil)
            return
        }
        
        if let goalTitle=inputTitle.text, let goalNum=inputNum.text, let finishTime=finish, let startTime=start{
            let newChallenge=Challenge(title:goalTitle, time:finishTime, startTime:startTime,goal:Int(goalNum)!,now:0)
            challenges.append(newChallenge)
//            print(challenges)
//            print(newChallenge)
            encoder.outputFormat = .xml
            
            if let data = try? encoder.encode(challenges){
                try? data.write(to: URL(fileURLWithPath: documentsPath + "/challenge.plist"))
//                print("ok")
            }
        }else{
            print("Need all data to be input")
        }

        if let tbc=presentingViewController as? UITabBarController{
            if let nvc=tbc.selectedViewController as? UINavigationController{
                if let presentingView=nvc.topViewController as? MyGoalViewController{
                    presentingView.challenges=challenges.reversed()
                    presentingView.goalList.reloadData()
                }else{
                    print("Something is wrong to convert view to MyGoalViewController.")
                }
            }else{
                print("Something is wrong to convert view to UINavigationController.")
            }
        }else{
            print("Something is wrong to convert view to UITabBarController.")
        }

        self.dismiss(animated:true, completion:nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    @IBAction func cancelGoal(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
    }
}
