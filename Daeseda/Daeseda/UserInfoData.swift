import Foundation
import Alamofire

struct UserInfoData: Codable {
    var userEmail: String
    var userName: String
    var userNickname: String
    var userPhone: String
    var authorityDtoSet: [AuthorityDto]
}
