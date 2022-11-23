//
//  TaskList.swift
//  RealmApp
//
//  Created by Ilia D on 23.11.2022.
//  Copyright © 2022 Ilia D. All rights reserved.
//

import Foundation
import RealmSwift

class TaskList: Object {
    @Persisted var name = ""
    @Persisted var date = Date()
    @Persisted var tasks = List<Task>()
}

class Task: Object {
    @Persisted var name = ""
    @Persisted var note = ""
    @Persisted var date = Date()
    @Persisted var isComplete = false
}
