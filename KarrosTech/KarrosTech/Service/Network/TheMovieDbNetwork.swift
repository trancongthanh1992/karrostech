//
//  TheMovieDbNetwork.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation
import Moya


public enum TheMovieDbNetwork {
//    case recommendations
//    case category
//    case popular
//    case topRated
//    case upcoming
    case upload(gif: Data)
}

extension TheMovieDbNetwork: TargetType {
    public var baseURL: URL { return URL(string: "https://upload.giphy.com")! } // swiftlint:disable:this force_unwrapping
       public var path: String {
           switch self {
           case .upload:
               return "/v1/gifs"
           }
       }
       public var method: Moya.Method {
           switch self {
           case .upload:
               return .post
           }
       }
       public var task: Task {
           switch self {
           case let .upload(data):
               let multipartFormData = [MultipartFormData(provider: .data(data), name: "file", fileName: "gif.gif", mimeType: "image/gif")]
               return .uploadCompositeMultipart(multipartFormData, urlParameters: ["api_key": "dc6zaTOxFJmzC", "username": "Moya"])
           }
       }
       public var sampleData: Data {
           switch self {
           case .upload:
               return "{\"data\":{\"id\":\"your_new_gif_id\"},\"meta\":{\"status\":200,\"msg\":\"OK\"}}".data(using: String.Encoding.utf8)! // swiftlint:disable:this force_unwrapping
           }
       }

       public var headers: [String: String]? {
           return nil
       }
}
