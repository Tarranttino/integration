//
//  FetchManager.swift
//  integration
//
//  Created by Taras on 23.04.2025.
//

import Foundation
import FirebaseDatabase

class FetchManager {
    
    private let ref = Database.database().reference()

    func fetchApps(completion: @escaping (AppsContainer?) -> Void) {
        ref.child("apps").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: ["apps": value])
                let decoder = JSONDecoder()
                let appsContainer = try decoder.decode(AppsContainer.self, from: data)
                completion(appsContainer)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchApp(withID appID: String, completion: @escaping (App?) -> Void) {
        ref.child("apps").observeSingleEvent(of: .value) { snapshot in
            guard let appsDict = snapshot.value as? [String: [String: Any]] else {
                completion(nil)
                return
            }
            
            for (_, appData) in appsDict {
                if let currentAppID = appData["appId"] as? Int,
                   String(currentAppID) == appID {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: appData)
                        let decoder = JSONDecoder()
                        let app = try decoder.decode(App.self, from: data)
                        completion(app)
                        return
                    } catch {
                        print("Decoding error: \(error)")
                        completion(nil)
                        return
                    }
                }
            }
            
            completion(nil)
        }
    }
}
