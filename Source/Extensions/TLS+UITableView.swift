//
//  TLS+UITableView.swift
//  mibabeer
//
//  Created by Justin Ji on 31/05/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import UIKit

extension UITableView {

    func removeExtraEmptyCells() {
        self.tableFooterView = UIView()
        self.tableFooterView?.isHidden = true
    }

}
