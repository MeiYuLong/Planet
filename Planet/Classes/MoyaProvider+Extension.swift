//
//  MoyaProvider+Extension.swift
//  Planet_Example
//
//  Created by yulong mei on 2021/2/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

extension MoyaProvider {
    
    /**
     添加MoyaProvider扩展方法，使用HandyJSON添加泛型解析
     - Parameters:
         - protocol: 指定泛型的具体类
         - target: API TargetType
         - callbackQueue: 回调队列
         - progress: 进程监听
         - completion: 结束回调
         - Returns: 返回可以取消请求的协议
     */
    @discardableResult
    open func request<T: HandyJSON>(
        protocol: MBaseClass<T>,
        target: Target,
        callbackQueue: DispatchQueue? = .none,
        progress: ProgressBlock? = .none,
        completion: @escaping (MResult<T>) -> Void) -> Cancellable {
        
        return self.request(target , callbackQueue: callbackQueue, progress: progress) { (result) in
            switch result{
            case let .success(response):
                do {
                    let statusCode = response.statusCode
                    if statusCode >= 200 && statusCode < 300{
                        if response.data.count > 0 {
                            let json = try response.mapJSON()
                            if  let jsonDic = json as? [String: Any],
                                let model = MResponse<T>.deserialize(from: jsonDic){
                                if model.code == 1 {
                                    completion(.success(model))
                                    return
                                }else {
                                    let failure = MFailureResponse(code: model.code, message: model.message)
                                    completion(.failure(failure))
                                    return
                                }
                            }
                        }
                        completion(.success(MResponse<T>()))
                    }else{
                        let json = try response.mapJSON()
                        if let jsonDic = json as? [String: Any],
                           let model = MFailureResponse.deserialize(from: jsonDic){
                            completion(.failure(model))
                        }else {
                            completion(.failure(MFailureResponse()))
                        }
                    }
                } catch {
                    let failure = MFailureResponse(code: 0, message: error.localizedDescription)
                    completion(.failure(failure))
                }
            case let .failure(error):
                let failure = MFailureResponse(code: error.errorCode,message: error.errorDescription)
                completion(.failure(failure))
            }
        }
    }
}

