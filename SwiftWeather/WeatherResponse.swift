//
//	WeatherResponse.swift
//
//	Create by Morteza Gharedaghi on 14/9/2019
//	Copyright © 2019 Solo. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct WeatherResponse: Codable{

	var city : City!
	var cnt : Int!
	var cod : String!
	var list : [List]!
	var message : Double!

}
