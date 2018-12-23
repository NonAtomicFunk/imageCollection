//
//  IcCellDataModel.swift
//  imageCollection
//
//  Created by admin2 on 12/23/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import Foundation

struct IcCellDataModel: Codable {
    let imageUrl: String
    let weather: String
    let adress: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl
        case weather
        case adress
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(weather, forKey: .weather)
        try container.encode(adress, forKey: .adress)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        weather = try container.decode(String.self, forKey: .weather)
        adress = try container.decode(String.self, forKey: .adress)
    }
}
