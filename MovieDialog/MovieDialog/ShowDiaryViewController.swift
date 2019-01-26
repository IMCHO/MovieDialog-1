//
//  ShowDiaryViewController.swift
//  MovieDialog
//
//  Created by linc on 23/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class ShowDiaryViewController: UIViewController {
    
    //-----Cancel button
    @IBAction func cancelNavButton(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
    }

    @IBOutlet weak var titleLabel: UILabel! //영화 이름
    @IBOutlet weak var dateLabel: UILabel! //관람일
    @IBOutlet weak var imageLabel: UIImageView! //영화 포스터
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var reviewLabel: UILabel!
    
    var dialog:Dialog?
    
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = dialog?.title
        dateLabel.text = dialog?.date
        //이미지
        switch(dialog!.star){
        case 1:
            star1.isSelected = true
            star2.isSelected = false
            star3.isSelected = false
            star4.isSelected = false
            star5.isSelected = false
        case 2:
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = false
            star4.isSelected = false
            star5.isSelected = false
        case 3:
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = false
            star5.isSelected = false
        case 4:
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
            star5.isSelected = false
        case 5:
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
            star5.isSelected = true
        default:
            star1.isSelected = false
            star2.isSelected = false
            star3.isSelected = false
            star4.isSelected = false
            star5.isSelected = false
        }
        
        
        
        if let simpleReview = dialog?.simpleReview{
            var count = 0
            for item in simpleReview{
                count += 1
                switch(count){
                case 1: label1.text = "#\(item)"
                //case 2: label2.text = "#\(item)"
                //case 3: label3.text = "#\(item)"
                //case 4: label4.text = "#\(item)"
                //case 5: label5.text = "#\(item)"
                //case 6: label6.text = "#\(item)"
                //case 7: label7.text = "#\(item)"
                //case 8: label8.text = "#\(item)"
                //case 9: label9.text = "#\(item)"
                //case 10: label10.text = "#\(item)"
                //case 11: label11.text = "#\(item)"
                //case 12: label12.text = "#\(item)"
                //case 13: label13.text = "#\(item)"
                //case 14: label14.text = "#\(item)"
                default:
                    break
                }
            }
        }
        
        reviewLabel.text = dialog?.review
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage(imageName: (dialog?.image)!)
        // Do any additional setup after loading the view.
    }
    

    func getImage(imageName:String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath:imagePath){
            imageLabel.image = UIImage(contentsOfFile:imagePath)
        } else{
            print("no image")
        }
    }
    
}
