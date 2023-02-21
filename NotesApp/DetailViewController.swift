//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Дмитрий on 20.02.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    var note: NoteModel!
    var currentIndexPath: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "Background")
        view.backgroundColor = UIColor(patternImage: image ?? UIImage())
        noteTextField.delegate = self
        
        noteTextField.text = note.note
        noteTextView.text = note.noteDetails
        
        let tap = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        tap.direction = .down
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        if currentIndexPath == nil {
            let currentNote = noteTextField.text ?? ""
            let currentNoteDetails = noteTextView.text ?? ""
            
            Notes.shared.saveNotes(note: currentNote, noteDetails: currentNoteDetails)
            navigationController?.popViewController(animated: true)
        } else {
            Notes.shared.notes.remove(at: currentIndexPath)
            let currentNote = noteTextField.text ?? ""
            let currentNoteDetails = noteTextView.text ?? ""
            
            Notes.shared.saveNotes(note: currentNote, noteDetails: currentNoteDetails)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            view.endEditing(true)
        }
    }
}

//MARK: - Protocols
extension DetailViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

