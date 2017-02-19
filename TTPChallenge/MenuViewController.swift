//
//  MenuViewController.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit
import PromiseKit


class MenuViewController: BaseViewController {
    var presenter: MenuPresenting!
    
    weak var menuDelegate: MenuDelegate?
    var interactiveTransition: SlideMenuInteractiveTransition? = nil
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuSections = [MenuSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Injector.currentInjector.menuPresenter(view: self, menuDelegate: menuDelegate!)
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    @IBAction func didTapCloseMenuButton(sender: AnyObject?) {
        closeMenu()
    }
    
    @IBAction func didTapLogoutButton(sender: AnyObject?) {
        presenter.logoutButtonTapped()
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        guard !flag else {
            super.dismiss(animated: flag, completion: completion)
            return
        }
        
        let presentingController = self.presentingViewController!
        
        super.dismiss(animated: flag, completion: nil)
        
        presentingController.view.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
        presentingController.view.isUserInteractionEnabled = true
        presentingController.view.layer.shadowOpacity = 0.0
        
        if let window = UIApplication.shared.keyWindow {
            if let vc = window.rootViewController {
                window.addSubview(vc.view)
            }
        }
        completion?()
    }
}

extension MenuViewController: MenuViewable {
    func setName(name: String) {
        headerName.text = name
    }
    
    func setMenuSections(sections: [MenuSection]) {
        menuSections = sections
        tableView.reloadData()
    }
    
    func closeMenuForModal() -> Promise<Void> {
        let (promise, fulfill, _) = Promise<Void>.pending()
        
        dismiss(animated: false) {
            fulfill()
        }
        return promise
    }
    
    func closeMenu() -> Promise<Void> {
        let (promise, fulfill, _) = Promise<Void>.pending()
        
        dismiss(animated: true) {
            fulfill()
        }
        return promise
    }
    
    func showLoginFlow() {
        performSegue(withIdentifier: "showLoginFlow", sender: self)
    }
}

//MARK: - Slide Menu
extension MenuViewController {
    @IBAction func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Left)
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactiveTransition: interactiveTransition) {
                self.closeMenu()
        }
    }
}

//MARK: Table View
extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionCell = tableView.dequeueReusableCell(withIdentifier: "MenuSectionHeader") as? MenuSectionHeaderViewCell else {
            return UIView()
        }
        sectionCell.sectionLabel.text = menuSections[section].name
        
        return sectionCell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapMoreInformationButton(button: menuSections[indexPath.section].buttons[indexPath.row])
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSections[section].buttons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuTableViewCell else {
            return UITableViewCell()
        }
        menuCell.buttonLabel.text = menuSections[indexPath.section].buttons[indexPath.row].name
        return menuCell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        presenter.didTapMoreInformationButton(button: menuSections[indexPath.section].buttons[indexPath.row])
    }
}
