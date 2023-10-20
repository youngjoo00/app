import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func sendEmailForVerification(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        AF.request("http://localhost:8888/users/mailAuthentication", method: .post, parameters: ["email": email])
            .responseString { response in
                switch response.result {
                case .success(let verificationCode):
                    completion(.success(verificationCode))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
