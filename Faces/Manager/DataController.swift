//
//  DataController.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/27/22.
//

import CoreData

class DataController {
    
    let container: NSPersistentContainer
    
    init() {
        
        container = NSPersistentContainer(name: "Main")
        
        container.loadPersistentStores(completionHandler: { description, error in
            
            if let error = error {
                
                fatalError("Core Data store failed to load with error: \(error)")
                
            }
            
        })
        
    }
    
    func save() {
        
        if container.viewContext.hasChanges {
            
            try? container.viewContext.save()
            
        }
        
    }
    
    func delete(_ face: Face) {
        
        container.viewContext.delete(face)
                
    }
    
}
