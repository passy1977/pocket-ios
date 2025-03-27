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

class CopyMoveVCCell: UITableViewCell {
    
    public enum Kind {
        case Group
        case Field
        case None
    }
    
    @IBOutlet private weak var imgType: UIImageView!
    @IBOutlet private weak var txtTitle: UILabel!
    
    //MARK: - static fields
    public static let identifier = "copyMoveVCCell"
    
    //MARK: - references
    
    public var titile : String? {
        didSet {
            txtTitle.text = titile
        }
    }
    
    public var kind : Kind? {
        didSet {
            switch kind ?? .Group {
            case .Group:
                imgType.image = UIImage(systemName: "folder")
            case .Field:
                imgType.image = UIImage(systemName: "text.justify")
            case .None:
                imgType.image = UIImage(systemName: "arrowshape.turn.up.left.circle")
            }
        }
    }
    

    //MARK: - system
    
    override func prepareForReuse() {
        txtTitle.text = ""
        imgType.image = UIImage(systemName: "text.justify")
    }
}
