//
//  DiaryEditViewController.swift
//  MovieDialog
//
//  Created by linc on 17/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class DiaryEditViewController: UIViewController, SendDataDelegate {
    let picker = UIImagePickerController() //갤러리 및 카메라에서 사진을 불러올 때 사용
    
    @IBAction func cancelNavButton(_ sender: Any) { //Cancel button
        let alert = UIAlertController(title: "저장하지 않은 데이터는 사라집니다", message: "창을 닫으시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"확인", style:UIAlertAction.Style.default) { UIAlertAction in
            self.dismiss(animated:true, completion:nil)
        })
        alert.addAction(UIAlertAction(title:"취소", style:UIAlertAction.Style.cancel){ UIAlertAction in })
        present(alert, animated:true, completion:nil)
    }
    
    @IBOutlet weak var movieImage: UIImageView! //영화 포스터
    @IBOutlet weak var movieTitle: UILabel! //영화 제목
    @IBOutlet weak var date: UILabel! //관람일
    
    @IBAction func selectPicButton(_ sender: UIButton) { //포스터 선택
        let actionSheet = UIAlertController(title:"포스터 입력 방식을 선택해 주세요", message:nil, preferredStyle:.actionSheet)
        actionSheet.addAction(UIAlertAction(title:"웹에서 검색하기", style:.default, handler:{result in
            //검색창 띄우기
            if let _ = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewID") as? SearchViewController{
                //self.present(searchController, animated:true, completion:nil)
                self.performSegue(withIdentifier: "toSearchSegue", sender: nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title:"갤러리에서 불러오기", style:.default, handler:{result in
            //갤러리에서 이미지 불러오기
            self.openLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title:"사진 찍기", style:.default, handler:{result in
            //카메라로 사진 찍기
            self.openCamera()
        }))
        actionSheet.addAction(UIAlertAction(title:"취소", style:.cancel, handler:nil))
        self.present(actionSheet, animated:true, completion:nil)
    }
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBAction func handleStar1(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = false
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
    }
    
    @IBAction func handleStar2(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
    }
    @IBAction func handleStar3(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = true
        star4.isSelected = false
        star5.isSelected = false
        
    }
    
    @IBAction func handleStar4(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = true
        star4.isSelected = true
        star5.isSelected = false
        
    }
    
    @IBAction func handleStar5(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = true
        star4.isSelected = true
        star5.isSelected = true
        
    }
    
   
    @IBAction func selectDate(_ sender: Any) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        alert.addAction(UIAlertAction(title:"완료", style:.default, handler:{result in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM. dd (yyyy년)"
            let dateString = dateFormatter.string(from:datePicker.date)
            self.date.font = UIFont(name:self.date.font.fontName, size:17)
            self.date.text = dateString
            
        }))
        alert.addAction(UIAlertAction(title:"취소", style:.cancel, handler:nil))
        self.present(alert, animated:true, completion:nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }
    
    //-----웹에서 검색한 데이터(제목, 사진)을 불러오는 함수
    func sendData(title:String, img:UIImage){
        movieTitle.text = title
        movieImage.image = img
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchSegue"{
            let nav:UINavigationController = segue.destination as! UINavigationController
            let viewController = nav.viewControllers[0] as! SearchViewController
            viewController.delegate = self
        }
    }
    
    
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated:false, completion:nil)
    }
    
    func openCamera(){
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated:false, completion:nil)
        } else{
            print("Camera not available")
        }
        
    }

}

extension DiaryEditViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            movieImage.image = image
            print(info)
        }
        dismiss(animated:true, completion:nil)
    }
}
