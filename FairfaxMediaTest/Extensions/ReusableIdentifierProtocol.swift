//
//  ReusableIdentifierProtocol.swift
//  FairfaxMediaTest
//
//  Created by Alexey on 9/6/19.
//  Copyright © 2019 Alexey Zhilnikov. All rights reserved.
//

import UIKit

protocol HasReusableIdentifier: class {
  static var reusableIdentifier: String { get }
}

extension HasReusableIdentifier where Self: UIView {
  static var reusableIdentifier: String {
    return String(describing: self).components(separatedBy: ".").last!
  }
}

extension UITableViewCell: HasReusableIdentifier {}

extension UITableView {
  
  func dequeueReusableCell<T: UITableViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
    guard let cell = self.dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
      fatalError("Dequeue failed for reusable identifier: \(T.reusableIdentifier)")
    }
    
    return cell
  }
}
