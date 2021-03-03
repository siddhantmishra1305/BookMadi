//
//  SearchPlaceResponse.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 08/02/21.
//

import Foundation

import Foundation
import ObjectMapper

struct SearchPlaceResponse : Mappable {
    var places : [Places]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        places <- map["Places"]
    }

}

