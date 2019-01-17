//
//  challenge.swift
//  MovieDialog
//
//  Created by In Taek Cho on 17/01/2019.
//  Copyright © 2019 linc. All rights reserved.
//

import Foundation

class Challenge: Codable {
    var title:String
    var time:String
    var goal:Int
    var now:Int
}

extension Challenge: CustomStringConvertible {
    var description: String {
        return "Challenge<\(title), \(time), \(goal), \(now)>"
    }
}
