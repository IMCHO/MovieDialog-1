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
    
    @IBOutlet weak var simpleView: UIView!
    @IBOutlet weak var normalView: UIView!
    
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
    
    
    
    @IBOutlet weak var reviewLabel: UILabel!
    
    var dialog:Dialog?
    
    @IBAction func segmentButton(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            simpleView.isHidden = false
            normalView.isHidden = true
        } else {
            simpleView.isHidden = true
            normalView.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        simpleView.isHidden = false
        normalView.isHidden = true
        
        titleLabel.text = dialog?.title
        dateLabel.text = dialog?.date
        //이미지
        switch(dialog!.star){
        case 1:
            star1.isEnabled = true
            star2.isEnabled = false
            star3.isEnabled = false
            star4.isEnabled = false
            star5.isEnabled = false
        case 2:
            star1.isEnabled = true
            star2.isEnabled = true
            star3.isEnabled = false
            star4.isEnabled = false
            star5.isEnabled = false
        case 3:
            star1.isEnabled = true
            star2.isEnabled = true
            star3.isEnabled = true
            star4.isEnabled = false
            star5.isEnabled = false
        case 4:
            star1.isEnabled = true
            star2.isEnabled = true
            star3.isEnabled = true
            star4.isEnabled = true
            star5.isEnabled = false
        case 5:
            star1.isEnabled = true
            star2.isEnabled = true
            star3.isEnabled = true
            star4.isEnabled = true
            star5.isEnabled = true
        default:
            star1.isEnabled = false
            star2.isEnabled = false
            star3.isEnabled = false
            star4.isEnabled = false
            star5.isEnabled = false
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
