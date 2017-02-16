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
    
    @IBOutlet weak var tableView: UITableView!
    
    var sectionNames = [String]()
    var moreInformationButtons = [MoreInformationButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Injector.currentInjector.menuPresenter(view: self, menuDelegate: menuDelegate!)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
    
    func setMoreInformationButtons(buttons: [MoreInformationButton]) {
        sectionNames.append("More Information")
        moreInformationButtons = buttons
        
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
        self.performSegue(withIdentifier: "showLoginFlow", sender: self)
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
    
    private func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard indexPath.section < sectionNames.count - 1 else {
            presenter.didTapMoreInformationButton(button: moreInformationButtons[indexPath.row])
            
            return
        }
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < sectionNames.count - 1 else {
            return moreInformationButtons.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuTableViewCell else {
            return UITableViewCell()
        }
        
        guard indexPath.section < sectionNames.count - 1 else {
            
            menuCell.buttonLabel.text = moreInformationButtons[indexPath.row].name
            
            return menuCell
        }
            
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard indexPath.section < sectionNames.count - 1 else {
            presenter.didTapMoreInformationButton(button: moreInformationButtons[indexPath.row])
            
            return
        }
    }
}