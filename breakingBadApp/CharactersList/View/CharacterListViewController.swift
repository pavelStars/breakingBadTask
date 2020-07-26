//
//  CharacterListViewController.swift
//  breakingBadApp
//
//  Created by Pavel Terziyski on 26.07.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {
    var output: CharacterListViewOutput?
    private var characterSection: CharacterSection<CharacterViewModel> = .empty
    private var isFiltering: Bool = false

    @IBOutlet private weak var charactersTableView: UITableView!
    @IBOutlet private weak var seasonButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchController()
        output?.viewIsReady()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.loadCharacters()
    }

    private func configureTableView() {
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        charactersTableView.separatorStyle = .none
        charactersTableView.rowHeight = UITableView.automaticDimension
    }

    private func reloadCharacters(newSection: CharacterSection<CharacterViewModel>) {
        characterSection = newSection
        charactersTableView.reloadData()
    }

    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Character"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func configure(cell: CharacterTableViewCell, forRowAt indexPath: IndexPath) {
        switch characterSection {
        case .empty:
            return
        case .viewModels(let viewModels):
            let viewModel = viewModels[indexPath.row]
            cell.configure(viewModel: viewModel)
        }
    }
}

extension CharacterListViewController: CharacterListViewInput {
    func display(characterSection: CharacterSection<CharacterViewModel>) {
        reloadCharacters(newSection: characterSection)
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch characterSection {
        case .empty:
            return 0
        case .viewModels(let viewModels):
            return viewModels.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        configure(cell: cell, forRowAt: indexPath)
        return cell
    }
}

extension CharacterListViewController: UITableViewDelegate {
}

extension CharacterListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchText = searchBar.text else {
            isFiltering = false
            return
        }
        isFiltering = searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
        output?.didMakeSearchWithString(string: searchText, isFiltering: isFiltering)
    }
}

