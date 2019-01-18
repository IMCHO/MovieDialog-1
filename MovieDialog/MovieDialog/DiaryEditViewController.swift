//
//  DiaryEditViewController.swift
//  MovieDialog
//
//  Created by linc on 17/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class DiaryEditViewController: UIViewController, SendDataDelegate {
    
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
    
    @IBAction func selectPicButton(_ sender: UIButton) { //Alert Controller
        let actionSheet = UIAlertController(title:"포스터 입력 방식을 선택해 주세요", message:nil, preferredStyle:.actionSheet)
        actionSheet.addAction(UIAlertAction(title:"웹에서 검색하기", style:.default, handler:{result in
            //검색창 띄우기
            if let _ = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewID") as? SearchViewController{
                //self.present(searchController, animated:true, completion:nil)
                self.performSegue(withIdentifier: "toSearchSegue", sender: nil)
            }
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

}
