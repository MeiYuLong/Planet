//
//  MPlanetAPI.swift
//  Planet_Example
//
//  Created by yulong mei on 2021/2/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Moya

enum MPlanetAPI {
    case login
}

extension MPlanetAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .login:
            return "{\"code\": \"1\", \"message\": \"success\"}".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .login:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

/**
 从 Target 到 Endpoint MoyaProvider 会有一个defaultEndpointMapping 最终被用来生成网络请求
 这个参数让你创建一个  `Endpoint` 实例对象，Moya将会使用它来生成网络API调用。 在某一时刻,
 `Endpoint` 必须被转化成 `URLRequest` 从而给到 Alamofire。
 */
var endpointClosure = { (target: MPlanetAPI) -> Endpoint in
    return MoyaProvider.defaultEndpointMapping(for: target)
}


/// 决定是否执行以及应执行什么请求的闭包。
let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 10
        print(endpoint.url)
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

/**
    决定是否/如何搁置请求的闭包。
    使用模拟测试数据 是否使用sampleData 模拟数据
    never(默认) -> 不使用，
    immediate -> 使用并立刻返回，
    delayed(seconds: 0.5) -> 使用并延迟0.5秒返回
 */
let stubClosure = { (target: MPlanetAPI) -> Moya.StubBehavior in
    return .delayed(seconds: 0.5)
}

let MProvider = MoyaProvider<MPlanetAPI>.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, plugins: [], trackInflights: true)
