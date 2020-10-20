//
//  JPHManager.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import PromiseKit
import Moya

protocol GeneralAPI {
    static func callApi<T: TargetType, U: Decodable>(_ target: T, dataReturnType: U.Type) -> Promise<U>
}

struct JPHManager: GeneralAPI {
    
    /// Generic function to call API endpoints using moya and decodable protocol
    ///
    /// - Parameters:
    ///   - target: The network moya target endpoint to call
    ///   - dataReturnType: The typpe of data that is expected to parse from endpoint response
    /// - Returns: A promise containing the dataReturnType set in function params
    static func callApi<Target: TargetType, ReturnedObject: Decodable>(_ target: Target, dataReturnType: ReturnedObject.Type) -> Promise<ReturnedObject> {
        
        let provider = MoyaProvider<Target>(plugins: [CachePolicyPlugin()])
        
        return Promise { seal in
            provider.request(target) { result in
                switch result {
                case let .success(response):
                    let decoder = JSONDecoder()
                    do {
                        let results = try decoder.decode(ReturnedObject.self, from: response.data)
                        seal.fulfill(results)
                    } catch {
                        seal.reject(error)
                    }
                case let .failure(error):
                    seal.reject(error)
                }
            }
        }
    }
}
