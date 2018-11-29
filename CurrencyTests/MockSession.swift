//
//  MockSession.swift
//  CurrencyTests
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import Foundation

// Mock session classes used for testing DataService

class MockURLSessionDataTask: URLSessionDataTask {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    var taskResponse: (Data?, URLResponse?, Error?)?
    
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler?(self.taskResponse?.0, self.taskResponse?.1, self.taskResponse?.2)
        }
    }
}

class MockURLSession: URLSession {
    
    var url: URL?
    private let mocDataTask: MockURLSessionDataTask
    
    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        mocDataTask = MockURLSessionDataTask()
        mocDataTask.taskResponse = (data, response, error)
    }
    
    init(error: Error?) {
        mocDataTask = MockURLSessionDataTask()
        mocDataTask.taskResponse = (nil, nil, error)
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.mocDataTask.completionHandler = completionHandler
        
        return mocDataTask
    }
    
}
