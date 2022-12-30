//
//  AppDelegate.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 29.12.22.
//

import Cocoa
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @Published var currentRepoDir: String? = nil
    
    func openFile() {
        let dialog = NSOpenPanel();

        dialog.title = "choose repository title".localized;
        dialog.showsResizeIndicator = true;
        dialog.showsHiddenFiles = false;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseDirectories = true;
        dialog.canChooseFiles = false;

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            if let result = dialog.url {
                openRepo(path: result.path)
            }
            
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    fileprivate func openRepo(path: String) {
        FileManager.default.changeCurrentDirectoryPath(path)
        currentRepoDir = path
    }
    
}
