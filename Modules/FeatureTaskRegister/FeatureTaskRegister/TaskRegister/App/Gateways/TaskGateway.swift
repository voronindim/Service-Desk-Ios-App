//
//  TaskGateway.swift
//  FeatureTaskRegister
//
//  Created by Дмитрий Воронин on 07.01.2022.
//

import Foundation
import Networking

final class TaskGateway {
    private let apiSession: AsyncGenericApi
    
    init(apiSession: AsyncGenericApi) {
        self.apiSession = apiSession
    }
    
    func details(id: UUID) async -> Result<UserTask, GatewayError> {
        do {
            let gatewayResult = try await apiSession.fetch(type: GatewayTask.self, with: urlRequest(id: id))
            return .success(UserTask(model: gatewayResult))
        } catch {
            return .failure(.unknownError)
        }
    }
    
    private func urlRequest(id: UUID) -> URLRequest {
        let url = baseUrl.appendingPathComponent("Task/\(id.uuidString.lowercased())", isDirectory: false)
        return URLRequest(url: url)
    }
}

fileprivate struct GatewayTask: Decodable {
    let guid: String
    let title: String
    let description: String
    let createdDate: Date
    let finishDate: Date
    let state: Int
    let assigned: GatewayAssigned?
    let created: GatewayAssigned
    let department: GatewayDepartament?
}

fileprivate struct GatewayAssigned: Decodable {
    let guid: String
    let name: String
    let photoPath: String
}

fileprivate struct GatewayDepartament: Decodable {
    let guid: String
    let name: String
}

fileprivate extension UserTask {
    init(model: GatewayTask) {
        let assigned = model.assigned == nil ? nil : Employee(model: model.assigned!)
        let department = model.department == nil ? nil : Departament(model.department!)
        self.init(
            id: UUID(uuidString: model.guid)!,
            title: model.title,
            description: model.description,
            status: TaskStatus(rawValue: model.state) ?? .notStarted,
            createdDate: model.createdDate,
            endDate: model.finishDate,
            creator: Employee(model: model.created),
            assigned: assigned,
            departament: department
        )
    }
}

fileprivate extension Employee {
    init(model: GatewayAssigned) {
        self.init(
            id: UUID(uuidString: model.guid)!,
            name: model.name,
            avatarUrl: URL(string: model.photoPath)
        )
    }
}

fileprivate extension Departament {
    init(_ model: GatewayDepartament) {
        self.init(
            id: UUID(uuidString: model.guid)!,
            name: model.name
        )
    }
}
