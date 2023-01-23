//
//  FileService.swift
//  Jagu
//
//  Created by Artur Hellmann on 23.01.23.
//

import Foundation

class FileService {
    
    func delete(file: String) throws {
        try FileManager.default.removeItem(atPath: file)
    }
}
