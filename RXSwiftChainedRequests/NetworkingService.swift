//
//  NetworkingService.swift
//  RXSwiftChainedRequests
//
//  Created by Saulo Garcia on 9/22/20.
//

import Foundation
import RxSwift

class NetworkingService {
    func execute<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            // Network request
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) else { return
                }
        
                // Send event
                observer.onNext(decoded)
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
