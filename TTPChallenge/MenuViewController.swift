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
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var footerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var headerUsername: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    
    var sectionNames = [String]()
    var menuViewMemberships = [String : [MenuViewMembership]]()
    var moreInformationButtons = [MoreInformationButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Injector.currentInjector.menuPresenter(view: self, menuDelegate: menuDelegate!)
        
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = footerView
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.viewWillDisappear()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
    }
    
    @IBAction func didTapCloseMenuButton(sender: AnyObject?) {
        closeMenu()
    }
    
    @IBAction func didTapLogoutButton(sender: AnyObject?) {
        presenter.logoutButtonTapped()
    }
    
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        guard !flag else {
            super.dismissViewControllerAnimated(flag, completion: completion)
            return
        }
        
        let presentingController = self.presentingViewController!
        
        super.dismissViewControllerAnimated(flag, completion: nil)
        
        presentingController.view.frame = CGRect(origin: CGPoint.zero, size: UIScreen.mainScreen().bounds.size)
        presentingController.view.userInteractionEnabled = true
        presentingController.view.layer.shadowOpacity = 0.0
        
        if let window = UIApplication.sharedApplication().keyWindow {
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
    
    func setMemberships(orderedKeys: [String], menuViewMemberships: [String : [MenuViewMembership]]) {
        sectionNames = orderedKeys
        self.menuViewMemberships = menuViewMemberships
        
        tableView.reloadData()
    }
    
    func setMoreInformationButtons(buttons: [MoreInformationButton]) {
        sectionNames.append("More Information")
        moreInformationButtons = buttons
        
        tableView.reloadData()
    }
    
    func closeMenuForModal() -> Promise<Void> {
        let (promise, fulfill, _) = Promise<Void>.pendingPromise()
        
        dismissViewControllerAnimated(false) {
            fulfill()
        }
        
        return promise
    }
    
    func closeMenu() -> Promise<Void> {
        let (promise, fulfill, _) = Promise<Void>.pendingPromise()
        
        dismissViewControllerAnimated(true) {
            fulfill()
        }
        
        return promise
    }
    
    func setLogoutButtonTitle(title: String) {
        logoutLabel.text = title
    }
    
    func showLoginFlow() {
        self.performSegueWithIdentifier("showLoginFlow", sender: self)
    }
    
    func setSelectedMembershipNumber(mNumber: UInt64) {
        var foundIndexPath: NSIndexPath?
        
        outerLoop: for (sectionIndex, sectionName) in sectionNames.enumerate() {
            for (rowIndex, membership) in menuViewMemberships[sectionName]!.enumerate() {
                if mNumber == membership.membershipNumber {
                    foundIndexPath = NSIndexPath(forRow: rowIndex, inSection: sectionIndex)
                    break outerLoop
                }
            }
        }
        
        guard let indexPath = foundIndexPath else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                self.tableView.deselectRowAtIndexPath(selectedPath, animated: true)
            }
            return
        }
        
        self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
    }
}

//MARK: - Slide Menu
extension MenuViewController {
    @IBAction func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Left)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactiveTransition: interactiveTransition) {
                self.closeMenu()
        }
    }
}

//MARK: Table View
extension MenuViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionCell = tableView.dequeueReusableCellWithIdentifier("MenuSectionHeader") as? MenuSectionHeaderViewCell else {
            return UIView()
        }
        sectionCell.sectionLabel.text = sectionNames[section]
        
        return sectionCell.contentView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard indexPath.section < sectionNames.count - 1 else {
            presenter.didTapMoreInformationButton(moreInformationButtons[indexPath.row])
            
            return
        }
        
        guard let memberships = menuViewMemberships[sectionNames[indexPath.section]] where memberships.count > indexPath.row else {
            return
        }
        
        presenter.didSelectMembership(memberships[indexPath.row])
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < sectionNames.count - 1 && menuViewMemberships.count > 0 else {
            return moreInformationButtons.count
        }
        
        return menuViewMemberships[sectionNames[section]]?.count ?? 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let menuCell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as? MenuTableViewCell else {
            return UITableViewCell()
        }
        
        guard indexPath.section < sectionNames.count - 1 else {
            
            menuCell.buttonLabel.text = moreInformationButtons[indexPath.row].name
            menuCell.alertIcon.hidden = true
            
            return menuCell
        }
        
        guard let memberships = menuViewMemberships[sectionNames[indexPath.section]] where memberships.count > indexPath.row else {
            
            return UITableViewCell()
        }
        
        menuCell.buttonLabel.text = memberships[indexPath.row].planTitle
        menuCell.alertIcon.hidden = memberships[indexPath.row].isAlertIconHidden
        menuCell.accessibilityLabel = "\(sectionNames[indexPath.section]) - \(memberships[indexPath.row].planTitle)"
        return menuCell
    }
}
