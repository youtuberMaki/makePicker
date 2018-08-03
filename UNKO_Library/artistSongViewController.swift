//
//  artistSongViewController.swift
//  UNKO_Library
//
//  Created by 牧 良樹 on 2018/06/28.
//  Copyright © 2018年 牧 良樹. All rights reserved.
//

import UIKit
import MediaPlayer

class artistSongViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var passTitle:[String] = []
  var passList:[String] = []
  var chosenUrl:[MPMediaItemCollection] = []
  var titleList:[String] = []
  var sendUrl:[MPMediaItem] = []
  
  @IBOutlet weak var list: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    list.dataSource = self    //追加
    list.delegate = self // 追加
    
    checkTitle()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func checkTitle(){
    for song in chosenUrl[0].items {
      guard let title = song.value(forProperty: MPMediaItemPropertyTitle) else {
        continue
      }
      titleList.append(title as! String)
    }
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titleList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "td")
    cell.textLabel?.text = titleList[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    sendUrl = []
    
    for i in indexPath.row..<chosenUrl[0].items.count{
      sendUrl.append(chosenUrl[0].items[i])
    }
    segueToThirdViewController()
  }
  
  func segueToThirdViewController() {
    self.performSegue(withIdentifier: "artistPlayerViewController", sender: sendUrl)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "artistPlayerViewController" {
      let _artistPlayerViewController = segue.destination as! artistPlayerViewController
      _artistPlayerViewController.sendUrl = sender as! [MPMediaItem]
    }
  }
  
}
