//
//  PhotoInfo.swift
//  JSON Practice
//
//  Created by Denis Bystruev on 02/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

struct PhotoInfo {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
}

// MARK: - Codable
extension PhotoInfo: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        description = try container.decode(String.self, forKey: CodingKeys.description)
        url = try container.decode(URL.self, forKey: CodingKeys.url)
        copyright = try? container.decode(String.self, forKey: CodingKeys.copyright)
    }
}
