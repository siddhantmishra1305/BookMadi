//
//  Places.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 04/02/21.
//

import Foundation
import ObjectMapper

struct searchPlaces : Mappable {
	var placeId : String?
	var placeName : String?
	var countryId : String?
	var regionId : String?
	var cityId : String?
	var countryName : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		placeId <- map["PlaceId"]
		placeName <- map["PlaceName"]
		countryId <- map["CountryId"]
		regionId <- map["RegionId"]
		cityId <- map["CityId"]
		countryName <- map["CountryName"]
	}

}
