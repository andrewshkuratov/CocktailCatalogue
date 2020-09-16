import Foundation
import Alamofire
import SwiftyJSON

class ServiceLayer {
    class func request(router: Router, _ params: String = "", completion: @escaping (_ json: JSON) -> Void) {
        guard let url = URL(string: router.scheme + router.host + router.path + params) else { return }
        
        
        AF.request(url).responseJSON { (response) in
            guard response.error == nil else { return }
            guard response.data != nil else { return }
            
            let json = JSON(arrayLiteral: response.data!)
            
            print(response)
            
            DispatchQueue.main.async {
                completion(json)
            }
        }
    }
}
