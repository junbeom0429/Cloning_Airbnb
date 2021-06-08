//
//  SearchResponse.swift
//  airbnb
//
//  Created by JB on 2021/06/04.
//
// 임시 토큰 : eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoyLCJpYXQiOjE2MjIwNTg1NTYsImV4cCI6MTY1MzU5NDU1Niwic3ViIjoidXNlckluZm8ifQ.uj6qwT9cVcs0pLaZEfZbZ4O3Hd6Cri85Ns4qX44qjfw
import Foundation

struct SearchRequest: Encodable {
    var state: String
    var startDate: String
    var endDate: String
    var guest: Int
}

struct SearchResponse: Decodable {
    var isSuccess: String
    var code: Int
    var message: String
    var result: [result]
    
}
struct result: Decodable {
    var idx: String
    var hostName: String
    var hostImg: [hosting]
    var hostType: String
    var state: String
    var avaliableReservation: String
    var price: String
    var hostGuestCnt: String
    var registerDate: String
    var rating: String?
    var ReviewCnt: String?
}
struct hosting: Decodable {
    var imgIdx: String
    var imgPath: String
}

struct SearchHeader: Encodable {
    var x_access_token: String
    var Authorization: String?
}
