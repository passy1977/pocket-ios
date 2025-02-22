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

final class GroupsFieldsVCCell: UITableViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var imgType: UIImageView!
    @IBOutlet private weak var txtTitle: UILabel!
    @IBOutlet private weak var btnValue: UIButton!
    @IBOutlet private weak var btnNote: UIButton!
    @IBOutlet private weak var btnShare: UIButton!
    @IBOutlet private weak var cnstBtnNoteRight: NSLayoutConstraint!
    @IBOutlet private weak var cnstBtnNoteWidth: NSLayoutConstraint!
    
    //MARK: - static fields
    public static let identifier = "groupsFieldsVCCell"
    private static let buttonControlStates: Array<UIControl.State> = [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved]
    private static let buttonFieldSize : CGFloat = 14
    
    //MARK: - references
    public weak var father : UIViewController?
    public weak var controller : GroupController?
    public weak var fieldController : FieldController?
    
    //MARK: - data
    var tuple : (group: Group?, field: Field?)?
    
    private(set) var fontSizeOriginal : CGFloat = 0
    private var showValue = false
    
    //MARK: - system
    override func awakeFromNib() {
        super.awakeFromNib()
        fontSizeOriginal = self.txtTitle.font.pointSize
    }

    //prepara la cella per il riutilizzo IMPORTANTISSIMO! se non si impostano i valori di default per ogni variabile la tabella non funziona correttamente in fase di scrolling
    override func prepareForReuse() {
//        super.prepareForReuse()
        tuple = nil
        father = nil
        controller = nil
        txtTitle.text = ""
        showValue(btnValue, value: "", isHidden: false, show: false)
        imgType.image = UIImage(systemName: "text.justify")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        guard let controller = self.controller, let fieldController = self.fieldController else {
            return
        }
        
        if let group = tuple?.group {
            imgType.image = UIImage(systemName: "folder")
            txtTitle.text = group.getTitle()

            if controller.countChild(group) > 0 {
                txtTitle.font = UIFont.systemFont(ofSize: fontSizeOriginal)
            } else {
                txtTitle.font = UIFont.italicSystemFont(ofSize: fontSizeOriginal)
            }

            let hiddenBtnShare = fieldController.sizeFiled(group.getid()) == 0
            let hiddenBtnNote = group.getNote().isEmpty
            
            showValue(btnValue, value: "", isHidden: false, show: false)
            btnValue.isHidden = true
            
            btnShare.isHidden = hiddenBtnShare
            btnNote.isHidden = hiddenBtnNote
            cnstBtnNoteRight.constant = hiddenBtnShare && !hiddenBtnNote ? 0 : 30

        } else if let field = tuple?.field {
            imgType.image = UIImage(systemName: "text.justify")

            txtTitle.text = field.getTitle()
            txtTitle.font = UIFont.systemFont(ofSize: fontSizeOriginal)
            
            showValue(btnValue, value: field.getValue(), isHidden: field.getIsHidden(), show: false)

            cnstBtnNoteRight.constant = 0
            cnstBtnNoteWidth.constant = 0
            
            btnValue.isHidden = false
            btnShare.isHidden = true
            btnNote.isHidden = true
        }
    }

    
    //MARK: - Act
    @IBAction private func actBtnNote(_ sender: UIButton) {
        guard let father = self.father, let group = tuple?.group else {
            return
        }
        
        alertShow(father, title: "Note", message: group.getNote())
    }
    
    @IBAction private func actBtnShare(_ sender: UIButton) {
        guard let father = self.father, let group = tuple?.group else {
            return
        }
        
        var textToShare = """
        Title: \(group.getTitle())
        Note: \(group.getNote())
        ----
        
        """
        
        fieldController?.getListField(group.getid(), search: "").forEach {
            textToShare += "\($0.getTitle())=\($0.getValue())\n"
        }

        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = sender
        father.present(activityVC, animated: true, completion: nil)
        
        
    }

    @IBAction private func actBtnValue(_ sender: UIButton) {
        guard let field = tuple?.field else {
            return
        }
        showValue = !showValue
        showValue(sender, value: field.getValue(), isHidden: field.getIsHidden(), show: showValue, noLink: false)
    }
    

    
    
    //MARK: - Function
    
    private func showValue(_ button: UIButton, value: String, isHidden: Bool, show : Bool, noLink : Bool = true) {
        var isLink = false
        var valueToDisplay = ""
        if (isHidden && show) {
            valueToDisplay = value
            isLink = value.starts(with: "http://") || value.starts(with: "https://")
        } else if(isHidden && !show) {
            valueToDisplay = String(repeating: "*", count: value.count)
            isLink = false
        } else {
            valueToDisplay = value
            isLink = value.starts(with: "http://") || value.starts(with: "https://")
        }
        if valueToDisplay != "" {
            if isLink {
                showButtonLinkValue(button, value: valueToDisplay)
                if !noLink {
                    UIApplication.shared.open(URL(string: valueToDisplay)!)
                }
            } else {
                showButtonStdValue(button, value: valueToDisplay)
            }
        } else {
            showButtonStdValue(button, value: " ")
        }
    }
    
    @inline(__always)
    private func showButtonStdValue(_ button: UIButton, value: String) {
        for controlState in GroupsFieldsVCCell.buttonControlStates {
            button.setAttributedTitle(
                NSAttributedString(
                    string: value,
                    attributes: [
                        .font : UIFont.systemFont(ofSize: GroupsFieldsVCCell.buttonFieldSize),
                        .foregroundColor : UIColor { tc in
                            switch tc.userInterfaceStyle {
                            case .dark:
                                return UIColor.white
                            default:
                                return UIColor.black
                            }
                        }
                    ]
                ),
                for: controlState
            )
        }
    }
    
    
    @inline(__always)
    private func showButtonLinkValue(_ button: UIButton, value: String) {
        for controlState in GroupsFieldsVCCell.buttonControlStates {
            button.setAttributedTitle(
                NSAttributedString(
                    string: value,
                    attributes: [
                        .font : UIFont.systemFont(ofSize: GroupsFieldsVCCell.buttonFieldSize),
                        .foregroundColor : UIColor.blue,
                        .underlineStyle : NSUnderlineStyle.single.rawValue
                    ]
                ),
                for: controlState
            )
        }
    }
}
