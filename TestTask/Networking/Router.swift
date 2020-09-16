import Foundation
import Alamofire

enum Router {
    case cocktails
    case filters
    
    var scheme: String {
        switch self {
        case .filters, .cocktails:
            return "https://"
        }
    }
    
    var host: String {
        switch self {
        case .filters, .cocktails:
            return "thecocktaildb.com"
        }
    }
    
    var path: String {
        switch self {
        case .filters:
            return "/api/json/v1/1/list.php?c=list"
        case .cocktails:
            return "/api/json/v1/1/filter.php?"
        }
    }
    
//    var headers: HTTPHeaders {
//        let headers: HTTPHeaders = ["Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImUxZjIzMTViMGNlMTdkNmQ1OGU0ZTdlYmFmMDc1MGY5YTI0NjBmZWYzNmMyN2IwNDViMjNiOTc0ZDBmMTE2MTgzZDMxMzk4ZDFiYzc5ZjdlIn0.eyJhdWQiOiIzIiwianRpIjoiZTFmMjMxNWIwY2UxN2Q2ZDU4ZTRlN2ViYWYwNzUwZjlhMjQ2MGZlZjM2YzI3YjA0NWIyM2I5NzRkMGYxMTYxODNkMzEzOThkMWJjNzlmN2UiLCJpYXQiOjE1ODE4Nzg3NjAsIm5iZiI6MTU4MTg3ODc2MCwiZXhwIjoxNjEzNTAxMTYwLCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.Psmr0Sr1OWOI8HpX62uTla3uVRyFtpu1qzW3FpyJymz1UQCdjNv0r8dLF0E41zieixLK0BorHZcRPirg_LwZQ7veDrPwMgxjiVY6Zfm2SfhrhmLxpkrKYoTiGVta6rcsh5w9bC2GH47NNgcrCvK2p84tdNUk1ettZuoW5gg6KOLIyn0MzMTAJ6jS12riGvwIn7WebpbE6T6t_uhcb7Y1JzhxVndcczaK1f3MfFHchC_P-xo5uANJz_Ek4WRSx0L0tjaYHfPSoan0Sn_gYSyi0JspLy9tTz1ZQ1QoVTRCGsSow9tWtdxT2yAuzVIDdOszTC3zPsV-rhM1qoofzczkEASGLy0t9nkBYbLh7Cldnr5BuG6_ImsaD8aqk5k2kmVvAKb6K-oK3F7QP7bLr8t_xK9mwaQgQRN6slKkPc9UwYfhVkbwWU_fQhUamWdmfgDqQ6stlJy09DU7jsRWNmBjyliCleHhDeMtXZXB_s_LT6vWhsApfFZcleDVma5aSRbpZaYesbcbqyq9l5iizGTUhF33Dicvf0odNdCPO_gtM_ZU0r0OfLvl688CrpHfEF7CWJf_xBg9jDtJUjTQkWZW3IHNMRw7PoQz3e3wzkFBJPhpcitk2aiFVLC0cwV7OSp8_AhlqAmbfghjwjh0km0ohcNZ8MZtfmXOQSd1FLdCpko"]
//        switch self {
//        case .profile, .group, .schedule, .message, .task, .grade, .mark, .user, .subject, .classroom, .file, .rating, .lesson, .student, .teacher:
//            return headers
//        }
//    }
}
