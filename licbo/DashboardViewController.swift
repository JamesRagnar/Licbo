//
//  DashboardViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-07.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DashboardViewController: BaseTableViewController {
    
    private struct Constants {
        static let cellIdentifier = "dashboardCell"
    }
    
    private lazy var dashboardViewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Constants.cellIdentifier)
        
        dashboardViewModel
            .menuItems
            .bindTo(
                tableView
                    .rx
                    .items(cellIdentifier: Constants.cellIdentifier,
                           cellType: UITableViewCell.self)) {
                            (row, item, cell) in
                            cell.textLabel?.text = item
            }.disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(String.self)
            .subscribe(onNext: { [weak self] item in
                self?.rowSelected(item)
            })
            .disposed(by: disposeBag)
    }
    
    private func rowSelected(_ title: String) {
        if title == "Products" {
            self.navigationController?.pushViewController(ProductsViewController(),
                                                          animated: true)
        } else if title == "Stores" {
            self.navigationController?.pushViewController(MapViewController(),
                                                          animated: true)
        }
    }
}
