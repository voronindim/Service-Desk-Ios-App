//
//  GatewayFactory.swift
//  FeatureTaskRegister
//
//  Created by Дмитрий Воронин on 07.01.2022.
//

import Foundation
import Networking

final class GatewayFactory {
    private let apiSession: AsyncGenericApi
    private let token: String
    
    init(aqiSession: AsyncGenericApi, token: String) {
        self.apiSession = aqiSession
        self.token = token
    }
    
    func tasksListGateway() -> TasksListGateway {
        let tasksListGateway = TasksListGateway(apiSession: apiSession, token: token)
        return tasksListGateway
    }
    
    func taskGateway() -> TaskGateway {
        let taskGateway = TaskGateway(apiSession: apiSession, token: token)
        return taskGateway
    }
    
    func editTaskGateway() -> EditTaskGateway {
        let editTaskGateway = EditTaskGateway(apiSession: apiSession, token: token)
        return editTaskGateway
    }
    
    func changeStatusGateway() -> ChangeStatusGateway {
        let changeStatusGateway = ChangeStatusGateway(apiSession: apiSession, token: token)
        return changeStatusGateway
    }
}
