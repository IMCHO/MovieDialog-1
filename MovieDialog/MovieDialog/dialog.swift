//
//  dialog.swift
//  MovieDialog
//
//  Created by In Taek Cho on 17/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import Foundation

class Dialog: Codable {
    var title:String
    var date:String
    var star:Int
    var simpleReview:[String]
    var review:String
    var createdDate:String
}

extension Dialog: CustomStringConvertible {
    var description: String {
        return "Dialog<\(title), \(date), \(star), \(simpleReview), \(review), \(createdDate)>"
    }
}
