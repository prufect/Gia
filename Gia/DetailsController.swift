//
//  DetailsController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

struct Detail {
    let name: String
    let content: String
}

class DetailsController: UITableViewController {
    var account: AccountsData
    var updateImage: ((UIImage) -> ())? = nil
    
    var detailsData: [Detail] = []
    var disputesData: [Detail] = []
    var invoicesData: [Detail] = []
    var paymentsData: [Detail] = []
    
    var selectedIndex = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        l.text = account.customerName
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var icon = UIImageView(image: UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .headline))?.withTintColor(.label, renderingMode: .alwaysOriginal))
    
    private lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .secondarySystemBackground
        
        iv.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: iv.centerXAnchor)
        ])
        
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 45
        iv.clipsToBounds = true
                
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageTapped)))
        
        return iv
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Disputes", "Invoices", "Payments"])
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(onSegmentChange), for: .valueChanged)
        return sc
    }()
    
    private lazy var headerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    init(account: AccountsData) {
        self.account = account
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        if let image = account.image {
            profileImage.image = UIImage(data: image)
            icon.isHidden = true
        }
        
        print(account)
        getDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNav()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfileImage()
        setupName()
        setupSegmentedController()
        navigationItem.largeTitleDisplayMode = .never
//        setupHeaderView()
        setupTableView()
    }
    
    @objc func onSegmentChange(sender: UISegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
    }
    
    @objc func onBackTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleImageTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func setupNav() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
    }
    
    private func setupProfileImage() {
        headerView.addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setupName() {
        headerView.addSubview(name)
        name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8).isActive = true
        name.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
    }
    
    private func setupSegmentedController() {
        headerView.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 32).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -32).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func setupHeaderView() {
        headerView.heightAnchor.constraint(equalToConstant: 400).isActive = false
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "InfoCell")
//        tableView.tableHeaderView = headerView
    }
}

extension DetailsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedIndex {
        case 0:
            return detailsData.count
        case 1:
            return disputesData.count
        case 2:
            return invoicesData.count
        case 3:
            return paymentsData.count
        default:
            break
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath)
        var detail: Detail?
        
        switch selectedIndex {
        case 0:
            detail = detailsData[indexPath.row]
        case 1:
            detail = disputesData[indexPath.row]
        case 2:
            detail = invoicesData[indexPath.row]
        case 3:
            detail = paymentsData[indexPath.row]
        default:
            break
        }
        
        cell.textLabel?.text = detail!.content
        cell.detailTextLabel?.text = detail!.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        
        headerView.addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        headerView.addSubview(name)
        name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8).isActive = true
        name.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        
        headerView.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 32).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -32).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
    
        return headerView
    }
    
    @objc func handleTest() {
        print("Tapped")
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}

extension DetailsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        account.image = image.pngData()
        profileImage.image = image
        updateImage?(image)
        icon.isHidden = true
        dismiss(animated: true)
    }
}
