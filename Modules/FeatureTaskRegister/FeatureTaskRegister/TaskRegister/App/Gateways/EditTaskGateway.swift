//
//  EditTaskGateway.swift
//  FeatureTaskRegister
//
//  Created by Дмитрий Воронин on 07.01.2022.
//

import Foundation
import Networking

final class EditTaskGateway {
    private let apiSession: AsyncGenericApi
    
    init(apiSession: AsyncGenericApi) {
        self.apiSession = apiSession
    }
    
    func edit(model: EditTaskModel) async -> Result <Void, GatewayError> {
        do {
            let _: Int? = try await apiSession.postRequest(data: model, with: urlRequest())
            return .success(())
        } catch {
            return .failure(.unknownError)
        }
    }
    
    private func urlRequest() -> URLRequest {
        let url = baseUrl.appendingPathComponent("Task/add", isDirectory: false)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type") 
        return request
    }
}
