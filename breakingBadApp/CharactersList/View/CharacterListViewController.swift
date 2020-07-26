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
    private var pickerItems: [Int] = []
    private var selectedSeason: Int? = 0
    private var pickerContainerView = UIView()

    @IBOutlet private weak var charactersTableView: UITableView!
    @IBOutlet private weak var seasonButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchController()
        configureSeasonButton()
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

    private func configureSeasonButton() {
        seasonButton.addTarget(self, action: #selector(userDidTapSeasonButton), for: .touchUpInside)
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

    private func setupPickerContainerWithData(data: [Int]) {
        pickerItems = data
        pickerContainerView = UIView(frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0),
                                                   size: view.bounds.size))
        pickerContainerView.backgroundColor = UIColor(red: 211.0 / 255.0,
                                                      green: 211.0 / 255.0,
                                                      blue: 211.0 / 255.0,
                                                      alpha: 0.7)
        let picker = UIPickerView()
        picker.frame = CGRect(x: 0,
                              y: view.frame.size.height - 240,
                              width: view.frame.size.width,
                              height: 240)

        let doneButton = UIButton(frame: CGRect(x: 0,
                                                y: 0,
                                                width: 160,
                                                height: 40))
        doneButton.center = CGPoint(x: pickerContainerView.center.x,
                                    y: pickerContainerView.center.y)

        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.addTarget(self, action: #selector(doneBtnPressed), for: .touchUpInside)

        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self

        pickerContainerView.addSubview(doneButton)
        pickerContainerView.addSubview(picker)
        view.addSubview(pickerContainerView)

        guard let season = selectedSeason else {
            return
        }

        picker.selectRow(season - 1, inComponent: 0, animated: false)
        picker.reloadAllComponents()
    }

    @objc private func userDidTapSeasonButton() {
        output?.didTapOnSeasonFiltering()
    }

    @objc private func doneBtnPressed() {
        guard let sortingSeason = selectedSeason else {
            isFiltering = false
            return
        }
        isFiltering = true
        pickerContainerView.removeFromSuperview()
        output?.didSelectSeasonToSortBy(season: sortingSeason, isFiltering: isFiltering)
    }
}

extension CharacterListViewController: CharacterListViewInput {
    func showAllSeasonPicker(data: [Int]) {
        setupPickerContainerWithData(data: data)
    }

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case .viewModels(let viewModels) = characterSection {
            let viewModel = viewModels[indexPath.row]
            output?.didTap(characterViewModel: viewModel)
        }
    }
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

extension CharacterListViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSeason = pickerItems[row]
    }
}

extension CharacterListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerItems.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerItems[row])"
    }
}
