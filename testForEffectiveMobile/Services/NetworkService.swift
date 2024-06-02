//
//  NetworkService.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 31.05.24.
//
//
//  NetworkService.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 10.01.24.
//

import Foundation
struct NetworkServiceSession {
    let sessionQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .utility
        queue.name = "sessionQueue"
        return queue
    }()
    lazy var session = URLSession(
        configuration: .default,
        delegate: nil,
        delegateQueue: sessionQueue
    )
    static var shared = NetworkServiceSession()
}
enum NetworkError: Error {
    case custom(description: String)
    case server
    case unknown
}

struct NetworkService {
    static func requestURL(for url: String, completion: @escaping (Result<Data, NetworkError>) -> Void){
        guard let url = URL(string: url) else {
            print("=== Wrong URL")
            return
        }
        let request = URLRequest(url: url)
        let task = NetworkServiceSession.shared.session.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.custom(description: error.localizedDescription)))
                }
            }
            guard response is HTTPURLResponse else { return }

            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.server))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
