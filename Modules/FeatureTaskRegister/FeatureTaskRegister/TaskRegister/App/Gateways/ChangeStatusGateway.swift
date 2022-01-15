//
//  ChangeStatusGateway.swift
//  FeatureEmployeesRegister
//
//  Created by Дмитрий Воронин on 08.01.2022.
//

import Foundation
import Networking

final class ChangeStatusGateway {
    private let apiSession: AsyncGenericApi
    private let token: String
    
    init(apiSession: AsyncGenericApi, token: String) {
        self.apiSession = apiSession
        self.token = token
    }
    
    func changeStatus(_ id: UUID, status: TaskStatus) async -> Result<Void, GatewayError> {
        do {
            let gatewayResult: GatewayResult = try await apiSession.postRequest(data: ChangeStatus(guid: id.uuidString.lowercased(), state: status), with: urlRequest())
            guard gatewayResult.errorCode == 0 else {
                return .failure(.unknownError)
            }
            return .success(())
        } catch {
            return .failure(.unknownError)
        }
    }
    
    private func urlRequest() -> URLRequest {
        let url = baseUrl.appendingPathComponent("Task/state", isDirectory: false)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request.addToken(token: token)
    }
}

fileprivate struct GatewayResult: Decodable {
    let errorCode: Int
}

fileprivate struct ChangeStatus: Encodable {
    let guid: String
    let state: TaskStatus
}
