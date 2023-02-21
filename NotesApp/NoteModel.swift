//
//  NoteModel.swift
//  NotesApp
//
//  Created by Дмитрий on 20.02.2023.
//

import Foundation

struct NoteModel: Codable {
    let note: String
    let noteDetails: String?
}

class Notes {
    
    let defaults = UserDefaults.standard
    static let shared = Notes()
    
    var notes: [NoteModel]  {
        
        get {
            if let data = defaults.value(forKey: "notes") as? Data {
                return try! PropertyListDecoder().decode([NoteModel].self, from: data)
            } else {
                return [NoteModel]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "notes")
            }
        }
    }
    
    func saveNotes(note: String, noteDetails: String?) {
        let note = NoteModel(note: note, noteDetails: noteDetails)
        notes.insert(note, at: 0)
    }
}
