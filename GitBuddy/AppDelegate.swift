//
//  AppDelegate.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 29.12.22.
//

import Cocoa
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {
    
    static private(set) var shared: AppDelegate? = nil
    
    @Published var currentRepoDir: String? = nil {
        didSet {
            print("this was set to \(currentRepoDir).")
        }
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        Self.shared = self
    }
    
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
    
    func reload() {
        let old = currentRepoDir
        currentRepoDir = old
    }
    
    func changePath(into: String) {
        let newpath = "\(currentRepoDir!)/\(into)"
        FileManager.default.changeCurrentDirectoryPath(newpath)
        currentRepoDir = newpath
    }
    
}
