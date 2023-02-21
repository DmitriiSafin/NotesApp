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
    
    let note = NoteModel(note: "Description", noteDetails: """
                                     Приложение 'Заметки'.
                             
                              Данное приложение состоит из двух экранов.
                             
                              На первом экране отображается список всех созданных заметок. При необходимости их можно удалять свайпом влево. А так же можно добавить новую заметку нажав "+". При клике на ячейку вы перейдете на экран редактирования заметки.
                             
                              На втором экране есть возможность вписать заголовок заметки и добавить более подробное описание. С TextView клавиатура убирается свайпом вниз. Заметка сохраняется нажатием по кнопке "Save".
                             
                              Все заметки сохраняются в памяти вашего телефона. Наслаждайтесь!
                             """)
    
    var notes: [NoteModel] {
                
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
    
    init() {
        if notes.isEmpty {
            notes.append(note)
        }
    }
    
    func saveNotes(note: String, noteDetails: String?) {
        let note = NoteModel(note: note, noteDetails: noteDetails)
        notes.insert(note, at: 0)
    }
}
