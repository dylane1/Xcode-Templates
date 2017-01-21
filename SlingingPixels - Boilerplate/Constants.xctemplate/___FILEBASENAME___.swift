//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import Foundation

struct Constant {
    //MARK: - Storyboard
    
    struct StoryBoardID {
        static let main = "Main"
    }
    
    //MARK: - Storage
    
//    /// UserDefaults
//    static let userDefaults = UserDefaults.standard
//    
//    /// Core Data
//    static let persistentContainer = NSPersistentContainer(name: "___")
//    
//    /// File system
//    struct FileSystem {
//        static let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        static let applicationSupport = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0]
//    }
//    
//    struct ArchiveFile {
//        static let storedMemes = FileSystem.applicationSupport + "/storedMemes.json"
//    }
    
//    struct StorageKey {
//        static let unitsAreMetric = "com.slingingPixels.trackLogger.storageKeys.unitsAreMetric"
//        //        static let longitude        = "com.slingingPixels.virtualTourist.storageKeys.longitude"
//        //        static let latitudeDelta    = "com.slingingPixels.virtualTourist.storageKeys.latitudeDelta"
//        //        static let longitudeDelta   = "com.slingingPixels.virtualTourist.storageKeys.longitudeDelta"
//    }
    
    //MARK: - Simulator detection (for UI testing)
    
    #if (arch(i386) || arch(x86_64)) && os(iOS)
        static let isRunningInSimulator = true
    #else
        static let isRunningInSimulator = false
    #endif
}
