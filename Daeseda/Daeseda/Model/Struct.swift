
import Foundation

struct UserData: Codable {
    let userEmail: String
    let userName: String
    let userNickname: String
    let userPhone: String
    let userPassword: String
}

struct Order: Codable {
    var address: Address
    let clothesCount: [ClothesCount]
    let totalPrice: Int
    let washingMethod: String
    let pickupDate: String
    let deliveryDate: String
    let deliveryLocation: String
}

struct Address: Codable {
    var addressId: Int
    var addressName: String
    var addressDetail: String
    var addressZipcode: String
}

struct ClothesCount: Codable {
    let clothes: Clothes
    let count: Int
}

struct Clothes: Codable {
    let clothesId: Int
    let clothesName: String
    let categoryId: Int
}

struct Category : Codable {
    let categoryId : Int
    let categoryName : String
}

struct QnaListData: Codable {
    let boardId: Int
    let userId: Int
    let userNickname: String
    let boardCategory: String
    let boardTitle: String
    let boardContent: String
    let regDate: String
    let modDate: String
}

struct ComentData: Codable {
    let replyId: Int
    let userId: Int
    let userNickname: String
    let boardId: Int
    let replyContent: String
    let regDate: String
    let modDate: String
}

struct QnaWriteData: Codable {
    let boardCategory: String
    let boardTitle: String
    let boardContent: String
}

struct ComentPostData: Codable {
    let boardId: Int
    let replyContent: String
}

struct ReviewData: Codable {
    let reviewId: Int
    let userId: Int
    let imageUrl: String
    let categories: String?
    let orderId: Int
    let rating: Float?
    let userNickname: String?
    let reviewTitle: String?
    let reviewContent: String?
    let regDate: String
    let modDate: String
}

struct AuthorityDto: Codable {
    var authorityName: String
}

struct UserInfoData: Codable {
    let userEmail: String
    let userName: String
    let userNickname: String
    let userPhone: String
    let authorityDtoSet: [AuthorityDto]
}

struct AddressCreateData: Codable {
    var addressName: String
    var addressDetail: String
    var addressZipcode: String
}
