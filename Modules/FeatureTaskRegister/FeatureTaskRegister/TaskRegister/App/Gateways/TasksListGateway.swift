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
    
    private func urlRequest(userId: UUID) -> URLRequest {
        let url = baseUrl.appendingPathComponent("Task/get-tasks", isDirectory: false)
        return URLRequest(url: url)
    }
}

// MARK: -

fileprivate struct GatewayTask: Decodable {
    let id: Int
    let title: String
    let description: String
    let createdDate: Date
    let finishDate: Date
    let state: Int
    let assigned: GatewayAssigned
    let created: GatewayAssigned
    let department: GatewayDepartament
}

fileprivate struct GatewayAssigned: Decodable {
    let id: Int
    let name: String
}

fileprivate struct GatewayDepartament: Decodable {
    let id: Int
    let name: String
}

fileprivate extension UserTask {
    init(model: GatewayTask) {
        self.init(
            id: UUID(),
            title: model.title,
            description: model.description,
            status: .notStarted,
            createdDate: model.createdDate,
            endDate: model.finishDate,
            creator: Employee(model: model.created),
            assigned: Employee(model: model.assigned),
            departament: Departament(model.department)
        )
    }
}

fileprivate extension Employee {
    init(model: GatewayAssigned) {
        self.init(
            id: UUID(),
            name: model.name,
            avatarUrl: nil
        )
    }
}

fileprivate extension Departament {
    init(_ model: GatewayDepartament) {
        self.init(
            id: UUID(),
            name: model.name
        )
    }
}
