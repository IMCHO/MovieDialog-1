//
//  DiaryEditViewController.swift
//  MovieDialog
//
//  Created by linc on 17/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit
import Photos

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
    @IBOutlet weak var textTitle: UITextField!//영화 제목
    @IBOutlet weak var date: UILabel! //관람일
    
    var dialogs:[Dialog]=[]
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    
    @IBAction func saveNavButton(_ sender: Any) { //save button
        let today = NSDate() //현재 날짜
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: today as Date)
        
        let dateFormatterForFileName = DateFormatter()
        dateFormatterForFileName.dateFormat = "yyyy_MM_dd_HH_mm"
        let imageName = dateFormatterForFileName.string(from: today as Date)+".png"
        
        if let saveImg = movieImage.image{
            saveImage(incomeImage: saveImg, imageName: imageName) //사진 저장
        }
        var optionalFreeReviewText = ""
        if let tempReviewText = reviewInputText.text{
            optionalFreeReviewText = tempReviewText
        }
        let newDiary = Dialog(title: textTitle.text!, image: imageName, date: date.text!, star: countStar, simpleReview: checkBoxChecked(), review: optionalFreeReviewText, createdDate: todayString)

        if let data=try? Data(contentsOf: URL(fileURLWithPath:documentsPath+"/dialog.plist")){
            if let decodedDialogs=try? decoder.decode([Dialog].self, from: data){
                dialogs=decodedDialogs
            }
        }else{
            print("기존 데이터 없음")
        }
        
        dialogs.append(newDiary)
        print(dialogs)
        encoder.outputFormat = .xml
        
        if let data = try? encoder.encode(dialogs){
            try? data.write(to: URL(fileURLWithPath: documentsPath + "/dialog.plist"))
        }

        self.dismiss(animated:true, completion:nil)
    }
    
    
    
    func saveImage(incomeImage:UIImage, imageName:String){
        //create an instance of the FileManager
        let fileManager = FileManager.default
        
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        print(imagePath)
        
        //get the image
        let image = incomeImage
        
        //get the PNG data for this image
        let data = image.pngData()
        
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    
    
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
    var countStar:Int = 0
    
    @IBAction func handleStar1(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = false
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
        countStar = 1
    }
    
    @IBAction func handleStar2(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
        countStar = 2
    }
    @IBAction func handleStar3(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = true
        star4.isSelected = false
        star5.isSelected = false
        countStar = 3
    }
    
    @IBAction func handleStar4(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = true
        star4.isSelected = true
        star5.isSelected = false
        countStar = 4
    }
    
    @IBAction func handleStar5(_ sender: Any) {
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = true
        star4.isSelected = true
        star5.isSelected = true
        countStar = 5
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
            self.date.frame.origin = CGPoint(x:207, y:150)
            self.date.text = dateString
            
        }))
        alert.addAction(UIAlertAction(title:"취소", style:.cancel, handler:nil))
        self.present(alert, animated:true, completion:nil)
        
    }
    
    @IBOutlet weak var simpleView:UIView!
    @IBOutlet weak var normalView:UIView!
    @IBAction func segControl(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            simpleView.isHidden = false
            normalView.isHidden = true
        } else {
            simpleView.isHidden = true
            normalView.isHidden = false
        }
    }
    
    @IBOutlet weak var check1: UIButton!
    @IBOutlet weak var check2: UIButton!
    @IBOutlet weak var check3: UIButton!
    @IBOutlet weak var check4: UIButton!
    @IBOutlet weak var check5: UIButton!
    @IBOutlet weak var check6: UIButton!
    @IBOutlet weak var check7: UIButton!
    @IBOutlet weak var check8: UIButton!
    @IBOutlet weak var check9: UIButton!
    @IBOutlet weak var check10: UIButton!
    @IBOutlet weak var check11: UIButton!
    @IBOutlet weak var check12: UIButton!
    @IBOutlet weak var check13: UIButton!
    @IBOutlet weak var check14: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label9: UILabel!
    @IBOutlet weak var label10: UILabel!
    @IBOutlet weak var label11: UILabel!
    @IBOutlet weak var label12: UILabel!
    @IBOutlet weak var label13: UILabel!
    @IBOutlet weak var label14: UILabel!
    
    
    @IBAction func checkAction1(_ sender: Any) {
        if check1.isSelected == true{
            check1.isSelected = false
        } else {
            check1.isSelected = true
        }
    }
    @IBAction func checkAction2(_ sender: Any) {
        if check2.isSelected == true{
            check2.isSelected = false
        } else {
            check2.isSelected = true
        }
    }
    @IBAction func checkAction3(_ sender: Any) {
        if check3.isSelected == true{
            check3.isSelected = false
        } else {
            check3.isSelected = true
        }
    }
    @IBAction func checkAction4(_ sender: Any) {
        if check4.isSelected == true{
            check4.isSelected = false
        } else {
            check4.isSelected = true
        }
    }
    @IBAction func checkAction5(_ sender: Any) {
        if check5.isSelected == true{
            check5.isSelected = false
        } else {
            check5.isSelected = true
        }
    }
    @IBAction func checkAction6(_ sender: Any) {
        if check6.isSelected == true{
            check6.isSelected = false
        } else {
            check6.isSelected = true
        }
    }
    @IBAction func checkAction7(_ sender: Any) {
        if check7.isSelected == true{
            check7.isSelected = false
        } else {
            check7.isSelected = true
        }
    }
    @IBAction func checkAction8(_ sender: Any) {
        if check8.isSelected == true{
            check8.isSelected = false
        } else {
            check8.isSelected = true
        }
    }
    @IBAction func checkAction9(_ sender: Any) {
        if check9.isSelected == true{
            check9.isSelected = false
        } else {
            check9.isSelected = true
        }
    }
    @IBAction func checkAction10(_ sender: Any) {
        if check10.isSelected == true{
            check10.isSelected = false
        } else {
            check10.isSelected = true
        }
    }
    @IBAction func checkAction11(_ sender: Any) {
        if check11.isSelected == true{
            check11.isSelected = false
        } else {
            check11.isSelected = true
        }
    }
    @IBAction func checkAction12(_ sender: Any) {
        if check12.isSelected == true{
            check12.isSelected = false
        } else {
            check12.isSelected = true
        }
    }
    @IBAction func checkAction13(_ sender: Any) {
        if check13.isSelected == true{
            check13.isSelected = false
        } else {
            check13.isSelected = true
        }
    }
    @IBAction func checkAction14(_ sender: Any) {
        if check14.isSelected == true{
            check14.isSelected = false
        } else {
            check14.isSelected = true
        }
    }
    
    func checkBoxChecked() -> [String] {
        var simpleReviewResult:[String] = []
        if check1.isSelected == true{
            simpleReviewResult += [label1.text!]
        }
        if check2.isSelected == true{
            simpleReviewResult += [label2.text!]
        }
        if check3.isSelected == true{
            simpleReviewResult += [label3.text!]
        }
        if check4.isSelected == true{
            simpleReviewResult += [label4.text!]
        }
        if check5.isSelected == true{
            simpleReviewResult += [label5.text!]
        }
        if check6.isSelected == true{
            simpleReviewResult += [label6.text!]
        }
        if check7.isSelected == true{
            simpleReviewResult += [label7.text!]
        }
        if check8.isSelected == true{
            simpleReviewResult += [label8.text!]
        }
        if check9.isSelected == true{
            simpleReviewResult += [label9.text!]
        }
        if check10.isSelected == true{
            simpleReviewResult += [label10.text!]
        }
        if check11.isSelected == true{
            simpleReviewResult += [label11.text!]
        }
        if check12.isSelected == true{
            simpleReviewResult += [label12.text!]
        }
        if check13.isSelected == true{
            simpleReviewResult += [label13.text!]
        }
        if check14.isSelected == true{
            simpleReviewResult += [label14.text!]
        }
        
        return simpleReviewResult
    }
    
    
    @IBOutlet weak var reviewInputText: UITextField!
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        simpleView.isHidden = false
        normalView.isHidden = true
        self.textTitle.placeholder = "영화 제목을 입력해 주세요"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }
    
    //-----웹에서 검색한 데이터(제목, 사진)을 불러오는 함수
    func sendData(title:String, img:UIImage){
        textTitle.text = title
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
