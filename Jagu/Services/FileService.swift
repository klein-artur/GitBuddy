//
//  FileService.swift
//  Jagu
//
//  Created by Artur Hellmann on 23.01.23.
//

import Foundation
import GitCaller

class FileService {
    
    let fileManager: FileManager
    let repository: any Repository
    
    init(fileManager: FileManager, repository: any Repository) {
        self.fileManager = fileManager
        self.repository = repository
    }
    
    func delete(file: String) throws {
        try fileManager.removeItem(atPath: file)
        repository.needsUpdate()
    }
}
