import Foundation

class UserTokenManager {
    static let shared = UserTokenManager()
    
    var authToken: String?
    
    private init() {
    }
    
    func saveToken(token: String) {
        authToken = token
    }
    
    func getToken() -> String? {
        return authToken
    }
    
    func clearToken() {
        authToken = nil
    }
}
