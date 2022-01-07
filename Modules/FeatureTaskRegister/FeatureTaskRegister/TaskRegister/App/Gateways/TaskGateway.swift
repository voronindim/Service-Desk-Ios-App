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
            let gatewayResult = try await apiSession.fetch(type: GatewayResult.self, with: urlRequest(id: id))
            return .success(UserTask(model: gatewayResult.task))
        } catch {
            return .failure(.unknownError)
        }
    }
    
    private func urlRequest(id: UUID) -> URLRequest {
        let url = baseUrl.appendingPathComponent("Task/get-task-by-id/\(id.uuidString)", isDirectory: false)
        return URLRequest(url: url)
    }
}


fileprivate struct GatewayResult: Decodable {
    let task: GatewayTask
}

fileprivate struct GatewayTask: Decodable {
    let id: String
    let title: String
    let description: String
    let createdDate: Date
    let finishDate: Date
    let state: Int
    let assigned: GatewayAssigned
    let created: GatewayAssigned
    let departament: GatewayDepartament
}

fileprivate struct GatewayAssigned: Decodable {
    let id: String
    let name: String
}

fileprivate struct GatewayDepartament: Decodable {
    let id: String
    let name: String
}

fileprivate extension UserTask {
    init(model: GatewayTask) {
        self.init(
            id: UUID(uuidString: model.id)!,
            title: model.title,
            description: model.description,
            status: .notStarted,
            createdDate: model.createdDate,
            endDate: model.finishDate,
            creator: Employee(model: model.created),
            assigned: Employee(model: model.assigned),
            departament: Departament(model.departament)
        )
    }
}

fileprivate extension Employee {
    init(model: GatewayAssigned) {
        self.init(
            id: UUID(uuidString: model.id)!,
            name: model.name,
            avatarUrl: nil
        )
    }
}

fileprivate extension Departament {
    init(_ model: GatewayDepartament) {
        self.init(
            id: UUID(uuidString: model.id)!,
            name: model.name
        )
    }
}
