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
            let data = GatewayRequest(model)
            let gatewayResult: GatewayResult = try await apiSession.postRequest(data: data, with: urlRequest())
            guard gatewayResult.errorCode == 0 else {
                return .failure(.unknownError)
            }
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

fileprivate struct GatewayResult: Decodable {
    let errorCode: Int
}

fileprivate struct GatewayRequest: Encodable {
    let guid: String?
    let title: String
    let description: String
    let finishDate: Date
    let assigned: GatewayAssigned?
    let created: GatewayAssigned
    let department: GatewayDepartament?
    
    init(_ model: EditTaskModel) {
        let guid = model.id == nil ? nil : model.id!.uuidString.lowercased()
        
        let assgined = model.assigned == nil ? nil : GatewayAssigned(guid: model.assigned!.id.uuidString.lowercased(), name: model.assigned!.name, photoPath: "")
        
        let dep = model.departament == nil ? nil : GatewayDepartament(guid: model.departament!.id.uuidString.lowercased(), name: model.departament!.name)
        
        self.guid = guid
        self.title = model.title
        self.description = model.description
        self.finishDate = model.endDate
        self.assigned = assgined
        self.created = GatewayAssigned(guid: model.creator.id.uuidString.lowercased(), name: model.creator.name, photoPath: "")
        self.department = dep
    }
    
}

fileprivate struct GatewayAssigned: Encodable {
    let guid: String
    let name: String
    let photoPath: String
}

fileprivate struct GatewayDepartament: Encodable {
    let guid: String
    let name: String
}

