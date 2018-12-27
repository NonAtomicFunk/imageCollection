//
//  IcCellDataModel.swift
//  imageCollection
//
//  Created by admin2 on 12/23/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import Foundation

struct IcCellDataModel: Codable {
    let smallImage: String
    let weather: String
    let adress: String
    
    enum CodingKeys: String, CodingKey {
        case smallImage
        case parameters
        case items
//        case weather
//        case adress
    }
    enum ParametersCodingKeys: String, CodingKey {
        case address = "address"
        case weather = "weather"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(smallImage, forKey: .smallImage)
//        try container.encode(weather, forKey: .weather)
//        try container.encode(adress, forKey: .adress)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        smallImage = try container.decode(String.self, forKey: .smallImage)
        
        let parametersContainer = try container.nestedContainer(keyedBy: ParametersCodingKeys.self, forKey: .parameters)
        self.weather = try parametersContainer.decode(String.self, forKey: .weather)
        self.adress = try parametersContainer.decode(String.self, forKey: .address)
//        weather = try container.decode(String.self, forKey: .weather)
//        adress = try container.decode(String.self, forKey: .adress)
    }
}
