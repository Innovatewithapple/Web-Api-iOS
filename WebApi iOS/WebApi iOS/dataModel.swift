//
//  dataModel.swift
//  WebApi iOS
//
//  Created by MihirVyas on 07/02/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import Foundation

struct HolidayResponse:Decodable {
    var response: Holidays
}

struct Holidays:Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail:Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}
