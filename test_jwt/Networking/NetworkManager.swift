
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getJWT(
        binaryString: String,
        completion: @escaping (Result<xmlResponse, Error>) -> Void
    ) {
        guard let url = URL(string: "https://pehchaanstage.uidai.gov.in/samvaad/mobile/v1/post") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["values": binaryString]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            completion(.failure(NSError(domain: "Serialization Error", code: 500, userInfo: nil)))
            return
        }
        request.httpBody = jsonData
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
           if let error = error {
               completion(.failure(error))
               return
           }
           
           guard let data = data else {
               completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
               return
           }
           do {
               let decodedResponse = try JSONDecoder().decode(xmlResponse.self, from: data)
               completion(.success(decodedResponse))
           } catch {
               completion(.failure(error))
           }
       }.resume()
    }
}
