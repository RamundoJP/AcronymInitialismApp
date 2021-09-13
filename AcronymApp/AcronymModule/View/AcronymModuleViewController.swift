//
//  AcronymModuleViewController.swift
//  AcronymApp
//
//  Created by Ramundo, Juan Pablo on 12/09/2021.
//

import UIKit

class AcronymModuleViewController: UIViewController, AcronymModuleViewProtocol {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var acronymSwitch: UISwitch!
    @IBOutlet weak var typeTitle: UILabel!
    
    let cellNibName = "AcronymTableViewCell"
    let reusableIdentifier = "cell"

    var results: [LF] = []
    
    var presenter: AcronymModulePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureSearchBar()
        configureSwitch()
        fetchFirstAppearance()
    }
    
    @objc func switchChanged() {
        typeTitle.text = acronymSwitch.isOn ? "Acronym" : "Initialism"
    }
    
    private func configureSwitch() {
        acronymSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    private func fetchFirstAppearance() {
        showLoader(isActive: false)
        presenter?.fetch(type: .ACRONYM, query: "www")
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: reusableIdentifier)
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func show(_ results: [LF]) {
        self.results = results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        showLoader(isActive: true)
    }
    
    func showError() {
        debugPrint("DEBUG: has been an error trying to fetch")
        self.results = []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        showLoader(isActive: true)
    }
    
    func showLoader(isActive: Bool) {
        if isActive {
            LoadingOverlay.shared.hideOverlayView()
        } else {
            LoadingOverlay.shared.showOverlay(view: self.view)
        }
    }

}

// MARK: - UISearchBarDelegate

extension AcronymModuleViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
            let type = acronymSwitch.isOn ? Type.ACRONYM : Type.INITIALISM
            showLoader(isActive: false)
            presenter?.fetch(type: type, query: text)
        }
        view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate - UITableViewDataSource

extension AcronymModuleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! AcronymTableViewCell
        
        cell.selectionStyle = .none
        let selectedResult = results[indexPath.row]
        cell.configure(with: selectedResult)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
