/***************************************************************************
 *
 * Pocket
 * Copyright (C) 2018/2025 Antonio Salsi <passy.linux@zresa.it>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ***************************************************************************/
import UIKit
import Reachability

class CopyMoveVC: UITableViewController {

    private let reachability = try! Reachability()
    
    //MARK: - Data
    private var tupleList : [(group: Group?, field: Field?)] = []
    
    //MARK: - references
    public weak var father : UIViewController?
    public weak var groupController : GroupController?
    public weak var fieldController : FieldController?
    
    public var field : Field? = nil
    public var group : Group? = nil
    public var showFieldIdGroup : UInt32? = nil
    public var showGroupIdGroup : UInt32? = nil
    
    private var fieldForSegue : Field? = nil
    private var groupForSegue : Group? = nil
    
    public override var title : String? {
        didSet {
            navigationController?.topViewController?.navigationItem.title = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)

        if let group = group, let groupId = group.groupId as UInt32? {
            title = group.title
            reloadList(groupId)
        } else if let field = field, let groupId = field.groupId as UInt32? {
            title = field.title
            reloadList(groupId)
        } else if let id = showFieldIdGroup {
            reloadList(id)
        } else if let id = showGroupIdGroup {
            reloadList(id)
        }
        
    }
    
    //MARK: - Segue
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "copyMoveLoop" {
            if let copyMove = segue.destination as? CopyMoveVC {
                copyMove.groupController = groupController
                copyMove.fieldController = fieldController
                copyMove.title = title
                if let groupForSegue = self.groupForSegue {
                    copyMove.showGroupIdGroup = groupForSegue._id
                } else if let fieldForSegue = self.fieldForSegue {
                    copyMove.showFieldIdGroup = fieldForSegue._id
                }
           }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tupleList.count
    }

    //set cell value
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CopyMoveVCCell.identifier, for: indexPath) as? CopyMoveVCCell else {
            return tableView.dequeueReusableCell(withIdentifier: CopyMoveVCCell.identifier, for: indexPath)
        }

        if let group = tupleList[indexPath.row].group {
            cell.kind = .Group
            cell.titile = group.title
        } else if let field = tupleList[indexPath.row].field {
            cell.kind = .Field
            cell.titile = field.title
        } else {
            cell.kind = .None
            cell.titile = ""
        }
        
        return cell
    }
    
    
    //cell click
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        if indexPath.row == 0 || (tupleList[indexPath.row].group == nil && tupleList[indexPath.row].field == nil) {
            navigationController?.popViewController(animated: true)
        } else {
            if let group = tupleList[indexPath.row].group {
                groupForSegue = groupController?.getGroup(group._id)
            } else if let _ = tupleList[indexPath.row].field {
                alertShow(self, message: "You are in the lowest level of the hierarchy. You cannot move or copy further")
            }
            performSegue(withIdentifier: "copyMoveLoop", sender: self)
        }
    }

    // MARK: - Reachability
    
    @objc func reachabilityChanged(note: Notification) {
      if let reachability = note.object as? Reachability, reachability.connection == .unavailable {
        print("Network not reachable")
        groupController?.reachability = false
        fieldController?.reachability = false
      } else {
        groupController?.reachability = true
        fieldController?.reachability = true
      }
    }
    
    // MARK: - Method

    private func reloadList(_ groupId: UInt32, search : String = "") {
        tupleList.removeAll()
        tupleList.append((group: nil, field: nil))
        do {
            groupController?.getListGroup(groupId, search: search).forEach {
                tupleList.append((group: $0, field: nil))
            }
            fieldController?.getListField(groupId, search: search).forEach {
                tupleList.append((group: nil, field: $0))
            }
        } catch {
            alertShow(self, message: "Decryption error")
            Globals.shared().logout(true)
        }
        
        tableView.reloadData()
    }
    
}
