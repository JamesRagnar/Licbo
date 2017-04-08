//
//  ProductsViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-07.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: BaseTableViewController {
    
    private struct Constants {
        static let cellIdentifier = "productCell"
    }
    
    private lazy var productsViewModel = ProductsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        productsViewModel
            .products
            .bindTo(
                tableView
                    .rx
                    .items(cellIdentifier: Constants.cellIdentifier,
                           cellType: UITableViewCell.self)) {
                            (row, product, cell) in
                            cell.textLabel?.text = product.name()
            }.disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Product.self)
            .subscribe(onNext: { [weak self] product in
                self?.navigationController?.pushViewController(MapViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        productsViewModel.fetchProducts()
    }
}
