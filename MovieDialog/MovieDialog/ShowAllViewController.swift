//
//  ShowAllViewController.swift
//  MovieDialog
//
//  Created by linc on 17/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import UIKit

class ShowAllViewController: UIViewController {

    @IBOutlet weak var sort: UISegmentedControl!
    
    @IBAction func indexChange(_ sender: UISegmentedControl) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if sort.selectedSegmentIndex == 0{
            print("ok")
        }
    }

    
    


}
