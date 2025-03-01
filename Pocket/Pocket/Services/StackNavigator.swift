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

import Foundation

class StackNavigator {
    
    public static let share = StackNavigator()
    
    private var stack : [(Group, String)] = []
    
    public var isEmpty: Bool {
        stack.isEmpty
    }

    public var count: Int {
        stack.count
    }

    public var peek: (Group, String)? {
        stack.last
    }
    
    public var pop: (Group, String)? {
        stack.popLast()
    }
    
    public func push(_ group: Group, search: String) {
        for it in stack where it.0.getid() == group.getid() {
            return;
        }
        stack.append((group, search))
    }

    public func size() -> Int {
        stack.count;
    }
    
    public func clear() {
        stack.removeAll()
    }
    
}
