//
//  TasksListGateway.swift
//  FeatureTaskRegister
//
//  Created by Дмитрий Воронин on 07.01.2022.
//

import Foundation
import Networking

final class TasksListGateway {
    private let apiSession: AsyncGenericApi
    
    init(apiSession: AsyncGenericApi) {
        self.apiSession = apiSession
    }
    
    func reload(userId: UUID) async -> Result<[UserTask], GatewayError> {
        do {
            let gatewayResult = try await apiSession.fetch(type: [GatewayTask].self, with: urlRequest(userId: userId))
            return .success(gatewayResult.map({ UserTask(model: $0) }))
        } catch {
            return .failure(.unknownError)
        }
    }
    
    func reload(departmentId: UUID) async -> Result<[UserTask], GatewayError> {
        do {
            let gatewayResult = try await apiSession.fetch(type: [GatewayTask].self, with: urlRequest(departmentId: departmentId))
            return .success(gatewayResult.map({ UserTask(model: $0) }))
        } catch {
            return .failure(.unknownError)
        }
    }
    
    private func urlRequest(userId: UUID) -> URLRequest {
        let url = baseUrl.appendingPathComponent("Task/assigned/\(userId.uuidString.lowercased())", isDirectory: false)
        return URLRequest(url: url)
    }
    
    private func urlRequest(departmentId: UUID) -> URLRequest {
        let url = baseUrl.appendingPathComponent("Task/department/\(departmentId.uuidString.lowercased())", isDirectory: false)
        return URLRequest(url: url)
    }
    
}

// MARK: -

fileprivate struct GatewayTask: Decodable {
    let guid: String
    let title: String
    let description: String
    let createdDate: Date
    let finishDate: Date
    let state: Int
    let assigned: GatewayEmployee?
    let created: GatewayEmployee
    let department: GatewayDepartament?
}

fileprivate struct GatewayEmployee: Decodable {
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
        self.init(
            id: UUID(uuidString: model.guid)!,
            title: model.title,
            description: model.description,
            status: TaskStatus(rawValue: model.state) ?? .notStarted,
            createdDate: model.createdDate,
            endDate: model.finishDate,
            creator: Employee(model: model.created),
            assigned: model.assigned == nil ? nil : Employee(model: model.assigned!),
            departament: model.department == nil ? nil : Departament(model.department!)
        )
    }
}

fileprivate extension Employee {
    init(model: GatewayEmployee) {
        self.init(
            id: UUID(uuidString: model.guid) ?? UUID(),
            name: model.name,
            avatarUrl: URL(string: model.photoPath)
        )
    }
}

fileprivate extension Departament {
    init(_ model: GatewayDepartament) {
        self.init(
            id: UUID(uuidString: model.guid) ?? UUID(),
            name: model.name
        )
    }
}
