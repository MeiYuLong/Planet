//
//  MHttpSupport.swift
//  Planet_Example
//
//  Created by yulong mei on 2021/2/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import HandyJSON


/// 数据模型基类，
open class MBaseModel: NSObject,HandyJSON {
    required public override init() {}
    
    public var baseMessage: String?
    
    public func didFinishMapping() {}
}

/**
 基类定义泛型 MBaseClass<LoginResponse>()(具体使用)
 可统一定义一些协议方法，如果不使用这种方式可以使用<T: HandyJSON>、T.Type泛型解析效果相同
 */
open class MBaseClass<T: HandyJSON> {
    required public init() {}
}

/// 基类响应数据<泛型Model T>
open class MResponse<T>: HandyJSON {
    public var code: Int?
    public var data: T?
    public var message: String?
    
    /// 兼容与T不同类型的数据
    public var anyData: Any?
    
    required public init() {
        self.code = 1
    }
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<<
        self.anyData <-- "data"
    }
}

/// 失败响应数据
open class MFailureResponse: HandyJSON {
    public var code: Int
    public var data: Any?
    public var message: String
    
    convenience init(code: Int? ,message: String?) {
        self.init()
        self.code = code ?? 0
        if let message = message, !message.isEmpty {
            self.message = message
        }
    }
    
    required public init() {
        self.code = 0
        self.message = "Unknown Error!"
    }
}

/// Result
public enum MResult<T> {
    case success(MResponse<T>)
    case failure(MFailureResponse)
}

public func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}
