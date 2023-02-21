//
//  MainViewController.swift
//  NotesApp
//
//  Created by Дмитрий on 20.02.2023.
//

import UIKit

class MainViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "Background")
        tableView.backgroundView = UIImageView(image: image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

//MARK: - Protocols
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notes.shared.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = Notes.shared.notes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = note.note
        cell.contentConfiguration = content
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "cell":
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                detailVC.note = Notes.shared.notes[indexPath.row]
                detailVC.currentIndexPath = indexPath.row
            }
        case "add":
            let detailVC = segue.destination as! DetailViewController
            let noteAdd = NoteModel(note: "Your note", noteDetails: "Here you can write the details")
            detailVC.note = noteAdd
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Notes.shared.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
