//
//  HolidayRequest.swift
//  WebApi iOS
//
//  Created by MihirVyas on 07/02/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import Foundation

enum HolidayError {
    case NODataAvailable
    case CannotProcessData
}

struct HolidayRequest {
    let resourceURL: URL
    var API_KEY = "1afbb3d61a4d913d9fbf54cf39bb15edcf01c74d"

    init(countryCode: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let currentYear = formatter.string(from: date)
        
         let resouceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resouceURL = URL(string: resouceString) else {fatalError()}
        self.resourceURL = resouceURL
        
    }
    
    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidayError>)-> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.NODataAvailable))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            } catch {
                completion(.failure(.CannotProcessData))
            }
            
        }
        dataTask.resume()
    }


}
