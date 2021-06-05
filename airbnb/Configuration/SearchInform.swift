//
//  SearchInform.swift
//  airbnb
//
//  Created by JB on 2021/06/03.
//

import Foundation

struct SearchInform {
    static var text: String = ""
    static var startDate: Date = Date()
    static var startDay: Int = Int()
    static var endDay: Int = Int()
    var type: [Type] = []
    static var guest: Int = Int()
}
struct Type {
    static var isPetAllowed = Bool()
}
struct Guest {
    static var total = Int()
    static var adult = Int()
    static var child = Int()
    static var bady = Int()
}
