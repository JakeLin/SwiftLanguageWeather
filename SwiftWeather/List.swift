//
//	List.swift
//
//	Create by Morteza Gharedaghi on 14/9/2019
//	Copyright © 2019 Solo. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct List: Codable{

	var clouds : Cloud!
	var dt : Int!
	var dtTxt : String!
	var main : Main!
	var sys : Sy!
	var weather : [Weatherr]!
	var wind : Wind!


}
