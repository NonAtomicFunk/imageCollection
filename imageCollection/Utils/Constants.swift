//
//  Constants.swift
//  imageCollection
//
//  Created by admin2 on 12/20/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import Foundation

enum LoginOptions: String {
    case auth = "/create"
    case login = "/login"
}

enum GetType: String {
    case all = "/all"
    case gif = "/git"
    case postImage = "/image"
}

class Constants {
    let baseURL = "http://api.doitserver.in.ua"
}
