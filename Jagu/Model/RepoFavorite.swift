//
//  RepoFavorite.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import Foundation

struct RepoFavorite {
    let path: String
    
    var name: String {
        path.lastPathComponent ?? path
    }
}
 
