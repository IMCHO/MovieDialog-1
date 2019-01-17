//
//  DiaryEditViewController.swift
//  MovieDialog
//
//  Created by linc on 17/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class DiaryEditViewController: UIViewController {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBAction func selectPicButton(_ sender: UIButton) {
        let actionSheet = UIAlertController(title:"포스터 입력 방식을 선택해 주세요", message:nil, preferredStyle:.actionSheet)
        actionSheet.addAction(UIAlertAction(title:"웹에서 검색하기", style:.default, handler:{result in
            //do something
            
        }))
        actionSheet.addAction(UIAlertAction(title:"내 파일에서 불러오기", style:.default, handler:{result in
            //do something22
        }))
        actionSheet.addAction(UIAlertAction(title:"취소", style:.cancel, handler:nil))
        self.present(actionSheet, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
