//
//  RootViewController.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RootViewController: BaseTableViewController {

    private var viewModel: RootViewModelType
    fileprivate lazy var stores = [Store]()

    init(_ viewModel: RootViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view.backgroundColor = .gray

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        NetworkManager.getStores { [weak self] (stores) in
            DispatchQueue.main.async(execute: { 
                self?.stores = stores
                self?.tableView.reloadData()
            })
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let store = stores[indexPath.row]
        cell.textLabel?.text = store.name
        return cell
    }
}
