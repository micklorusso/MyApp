//
//  PokemonApi.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//
import Foundation
import Alamofire


class PokemonApi{

    class RetryHandler: RequestInterceptor, @unchecked Sendable{
        let retryLimit = 3
        let retryDelay: TimeInterval = 2.0

        func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {

            if request.retryCount < retryLimit {
                DispatchQueue.global().asyncAfter(deadline: .now() + retryDelay) {
                    completion(.retry)
                }
            } else {
                completion(.doNotRetry)
            }
        }
    }

    class NetworkLogger: EventMonitor, @unchecked Sendable {
        func requestDidResume(_ request: Request) {
            print("Request started: \(request.description)")
        }
        
        func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
            print("Response: \(response.debugDescription)")
        }
    }

    func performRequest<T: Decodable>(with url: URL, logEvents: Bool = false) async throws -> T {
        var eventMonitors: [EventMonitor] = []
        if(logEvents){
            eventMonitors.append(NetworkLogger())
        }
        let session = Session(interceptor: RetryHandler(), eventMonitors: eventMonitors)
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let decodedData):
                        continuation.resume(returning: decodedData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }


}

