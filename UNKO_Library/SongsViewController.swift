//
//  AlbumsViewController.swift
//  UNKO_Library
//
//  Created by 牧 良樹 on 2017/10/09.
//  Copyright © 2017年 牧 良樹. All rights reserved.
//

import UIKit
import MediaPlayer

class SongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  @IBOutlet weak var list: UITableView!
  
  var titleList: [String] = []
  var albumSong = "Song"
  var passTitle = "渡したい値"
  var count = 0
  var _count = 0
  var player : MPMusicPlayerController?
  var passUrl : [MPMediaItem] = []
  var selectUrl: [MPMediaItemCollection] = []
  
  var chosenUrl:[MPMediaItem] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    list.delegate = self
    
    player = MPMusicPlayerController.applicationMusicPlayer()
    
    test()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func test(){
    let songsQuery = MPMediaQuery.songs()
    
    if let songs = songsQuery.items {
      
      passUrl = songs
      
      for song in songs {
          
          _count += 1
        
          // 楽曲のタイトル
          guard let title = song.value(forProperty: MPMediaItemPropertyTitle) else {
            continue
            
          }
          
          albumSong = title as! String
          
          titleList.append(albumSong)
        }
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
    
    chosenUrl = []
    
    for i in indexPath.row..<passUrl.count{
      chosenUrl.append(passUrl[i])
    }
    segueToThirdViewController()
  }
  
  func segueToThirdViewController() {
    self.performSegue(withIdentifier: "songPlayerViewController", sender: chosenUrl)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "songPlayerViewController" {
      let _SongViewController = segue.destination as! songPlayerViewController
      _SongViewController.chosenUrl = sender as! [MPMediaItem]
    }
  }
  
}
