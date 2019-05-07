//
//  ViewController.swift
//  VoIPDemo
//
//  Created by Jayesh on 24/01/19.
//  Copyright © 2019 Logistic Infotech Pvt. Ltd. All rights reserved.
//

import UIKit

@objcMembers class ViewController: UIViewController {

    @IBOutlet weak var tableNotifications: UITableView!
    
    var arrNotifications: [Notifications] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNotification), name: .reloadNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadNotification()
    }
    func reloadNotification() {
        arrNotifications = CoreDataManager.sharedInstance.getObjectsforEntity(strEntity: CoreDataEntity.kEntity_Notifications, ShortBy: "createdTime", isAscending: false, predicate: nil, groupBy: "") as! [Notifications]
        self.tableNotifications.reloadData()
    }
    
    @IBAction func onClickClear(_ sender: UIBarButtonItem) {
        CoreDataManager.sharedInstance.deleteEntity(name: CoreDataEntity.kEntity_Notifications)
        arrNotifications.removeAll()
        self.tableNotifications.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        print(arrNotifications[indexPath.row])
        let payload = arrNotifications[indexPath.row].payload! as! Dictionary<String, Any>
        let payloadDict = payload["aps"] as! Dictionary<String, Any>
        cell?.textLabel?.text = payloadDict["alert"] as? String
        cell?.detailTextLabel?.text = DateFormatter.localizedString(from: arrNotifications[indexPath.row].createdTime! as Date, dateStyle: .medium, timeStyle: .medium)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

