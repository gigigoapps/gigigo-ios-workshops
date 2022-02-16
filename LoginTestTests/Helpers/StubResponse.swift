//
//  StubResponse.swift
//  wallyTests
//
//  Created by Jerilyn Gonçalves on 27/02/2020.
//  Copyright © 2020 Gigigo. All rights reserved.
//

import Foundation
import OHHTTPStubs
import OHHTTPStubsSwift
//import GIGLibrary
@testable import LoginTest


class StubResponse {
    
    class func mockSuccessResponse(for urlPath: String, with jsonFile: String) {
        _ = stub(condition: isPath(urlPath), response: { _ in
            return StubResponse.successResponse(with: jsonFile)
        })
    }
    
    class func mockSuccessResponse(for urlPath: String, query: [String: String], with jsonFile: String) {
        _ = stub(condition: isPath(urlPath) && containsQueryParams(query), response: { _ in
            return StubResponse.successResponse(with: jsonFile)
        })
    }
    
    class func mockFailureResponse(for urlPath: String, query: [String: String], with jsonFile: String) {
        _ = stub(condition: isPath(urlPath) && containsQueryParams(query), response: { _ in
            return StubResponse.failureResponse(with: jsonFile)
        })
    }
    
    class func mockFailureResponse(for urlPath: String, with jsonFile: String) {
        _ = stub(condition: isPath(urlPath), response: { _ in
            return StubResponse.failureResponse(with: jsonFile)
        })
    }
    
    class func mockFailureResponseWithDescriptor(for urlPath: String, with jsonFile: String) -> HTTPStubsDescriptor {
        return stub(condition: isPath(urlPath), response: { _ in
            return StubResponse.failureResponse(with: jsonFile)
        })
    }
    
    class func successResponse(with json: String) -> HTTPStubsResponse {
        Self.stubResponse(with: json, code: 200)
    }
    
    class func failureResponse(with json: String) -> HTTPStubsResponse {
        Self.stubResponse(with: json, code: 400)
    }
    
//    /// Matching: URL, Query Params, JSON Body, Headers
//    class func testRequest(with json: String = "ko.json", url: String? = nil, code: Int = 200, matching: @escaping (String, [String: String]?, JSON?, [String: String]?) -> Void) {
//        HTTPStubs.stubRequests(passingTest: { request -> Bool in
//            let urlRequest = (request as NSURLRequest)
//            let data = urlRequest.ohhttpStubs_HTTPBody()
//            let json = data.flatMap { try? JSON.dataToJson($0) }
//            let headers = urlRequest.allHTTPHeaderFields
//            let query = urlRequest.url?.query?.dictionaryFromQuery()
//            let requestURL = urlRequest.url?.path ?? "NO_URL"
//            let expectedURL = url ?? requestURL
//
//            if requestURL == expectedURL {
//                matching(requestURL, query, json, headers)
//                return true
//            } else {
//                return false
//            }
//        }, withStubResponse: { _ in StubResponse.stubResponse(with: json, code: code) })
//    }
    
    class func stubResponse(with json: String, code: Int) -> HTTPStubsResponse {
        return HTTPStubsResponse(
            fileAtPath: OHPathForFile(json, StubResponse.self)!,
            statusCode: Int32(code),
            headers: ["Content-Type": "application/json"]
        )
    }
    
}

extension String {
    
    func dictionaryFromQuery() -> [String: String]? {
        return self.components(separatedBy: "&").reduce([:]) { result, keyValue in
            var result = result
            let keyValueSplitted = keyValue.components(separatedBy: "=")
            if keyValueSplitted.count == 2 {
                result?[keyValueSplitted[0]] = keyValueSplitted[1]
            }
            return result
        }
    }
    
}
