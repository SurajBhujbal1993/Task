//
//  Created by Aman on 27/07/23.
//

import Foundation

struct postModel :Codable{
    let userID, id: Int
        let title, body: String

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case id, title, body
        }
}
