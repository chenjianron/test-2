//
//  commonWord.swift
//  考核二
//
//  Created by GC on 2021/7/24.
//

import Foundation

class CommonWord {
    var commonWord:String!
    var date:String!
    var id:Int?
    init(commonWord:String, date:String, id:Int = -1) {
        self.commonWord = commonWord
        self.date = date
        self.id = id
    }
}
