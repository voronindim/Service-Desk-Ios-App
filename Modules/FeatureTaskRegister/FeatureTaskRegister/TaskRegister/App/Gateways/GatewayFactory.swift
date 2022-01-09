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
    
    init(aqiSession: AsyncGenericApi) {
        self.apiSession = aqiSession
    }
    
    func tasksListGateway() -> TasksListGateway {
        let tasksListGateway = TasksListGateway(apiSession: apiSession)
        return tasksListGateway
    }
    
    func taskGateway() -> TaskGateway {
        let taskGateway = TaskGateway(apiSession: apiSession)
        return taskGateway
    }
    
    func editTaskGateway() -> EditTaskGateway {
        let editTaskGateway = EditTaskGateway(apiSession: apiSession)
        return editTaskGateway
    }
    
    func changeStatusGateway() -> ChangeStatusGateway {
        let changeStatusGateway = ChangeStatusGateway(apiSession: apiSession)
        return changeStatusGateway
    }
}
