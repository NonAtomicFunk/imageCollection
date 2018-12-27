//
//  IcCellDataModel.swift
//  imageCollection
//
//  Created by admin2 on 12/23/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import Foundation

struct IcCellDataModel: Codable {
    let smallImagePath: String
    let weather: String
//    let adress: String?
    /*
     Fdress got obsoleted from API response,
     as it used to return "adress" fiel,
     but now it returns latitude and longtitude ones
     */
    
    enum CodingKeys: String, CodingKey {
        case smallImagePath
        case parameters
        case images
    }
    enum ParametersCodingKeys: String, CodingKey {
        case address = "address"
        case weather = "weather"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(smallImagePath, forKey: .smallImagePath)
//        try container.encode(weather, forKey: .weather)
//        try container.encode(adress, forKey: .adress)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        smallImagePath = try container.decode(String.self, forKey: .smallImagePath)
        
        let parametersContainer = try container.nestedContainer(keyedBy: ParametersCodingKeys.self, forKey: .parameters)
        self.weather = try parametersContainer.decode(String.self, forKey: .weather)
//        self.adress = try parametersContainer.decode(String.self, forKey: .address)
    }
}

struct IcCellDataModelList: Decodable {
    
    let images: [IcCellDataModel]
    
    enum CodingKeys: String, CodingKey {
        case images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.images = try container.decode([IcCellDataModel].self, forKey: .images)
    }
}
