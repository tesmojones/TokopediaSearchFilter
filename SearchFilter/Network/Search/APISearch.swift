//
//  API.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/16/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import Alamofire

public enum APISearch: URLRequestConvertible {
    static var baseURLString: String = Base.URL+"search/v2.5/"
    
    case getProductSearchList(param: SearchParam)
    
    // Set HTTP Method
    var method: HTTPMethod {
        switch self {
        case .getProductSearchList(_):
            return .get
        }
    }
    
    // Set path according to base
    var path: String {
        switch self {
        case .getProductSearchList(_):
            return "product"
        }
    }
    
    // Passing params
    var param: [String:Any] {
        switch self {
        case .getProductSearchList(let param):
            return param.asParam()
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        var url: URL?
        var urlRequest: URLRequest?
        url = try APISearch.baseURLString.asURL()
        urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
        urlRequest?.httpMethod = method.rawValue
        urlRequest = try URLEncoding.default.encode(urlRequest!, with: param)
        print("URL API => "+(urlRequest?.url?.absoluteString)!)
        print("Parameter => \(param)")
        return urlRequest!
    }
}
