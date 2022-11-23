//
//  StorageManager.swift
//  RealmApp
//
//  Created by Ilia D on 23.11.2022.
//  Copyright © 2022 Ilia D. All rights reserved.
//

import Foundation
import RealmSwift

class StorageManager {

    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Task List
    func create(_ taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func create(_ taskList: String, completion: (TaskList) -> Void) {
        write {
            let taskList = TaskList(value: [taskList])
            realm.add(taskList)
            completion(taskList)
        }
    }
    
    func delete<T>(_ data: T) {
        write {
            if let taskList = data as? TaskList {
                realm.delete(taskList.tasks)
                realm.delete(taskList)
            } else if let task = data as? Task {
                realm.delete(task)
            }
        }
    }
    
    func update<T>(_ data: T, withValue value: String, withNote note: String? = nil) {
        write {
            if let taskList = data as? TaskList {
                taskList.name = value
            } else if let task = data as? Task {
                task.name = value
                task.note = note ?? ""
            }
        }
    }

    func done<T>(_ data: T) {
        write {
            if let taskList = data as? TaskList {
                taskList.tasks.setValue(true, forKey: "isComplete")
            } else if let task = data as? Task {
                task.isComplete.toggle()
            }
        }
    }

    // MARK: - Tasks
    func create(_ task: String, withNote note: String, to taskList: TaskList, completion: (Task) -> Void) {
        write {
            let task = Task(value: [task, note])
            taskList.tasks.append(task)
            completion(task)
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
