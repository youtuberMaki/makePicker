//
//  albumViewController.swift
//  UNKO_Library
//
//  Created by 牧 良樹 on 2018/06/27.
//  Copyright © 2018年 牧 良樹. All rights reserved.
//

import UIKit
import MediaPlayer

class artistAlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var list: UITableView!
  
  var passTitle:[String] = []
  var passList:[String] = []
  var keyList:[String] = []
  var selectUrl:[MPMediaItemCollection] = []
  var albumList:[String:Any] = [:]
  var chosenUrl:[MPMediaItemCollection] = []
  
  var albumArtist = "Artist"
  var albumSong = "Song"
  var albumTitle = "Title"
  var _count = 0
  var songList: [String] = []
  var titleList: [String] = []
  var passUrl : [MPMediaItemCollection] = []
  
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
    
    let albumsQuery = MPMediaQuery.albums()
    
    let artistName = selectUrl[0].items[0].value(forProperty: MPMediaItemPropertyArtist) as? String
    
    let predicate = MPMediaPropertyPredicate(value: artistName, forProperty: MPMediaItemPropertyArtist, comparisonType: MPMediaPredicateComparison.contains)
    albumsQuery.addFilterPredicate(predicate)

    
    if let albums = albumsQuery.collections {
      passUrl = albums
      for album in albums {
        for song in album.items {
          
          _count += 1
          
          //player.setQueue(with: albums[0])
          //player.play()
          
          // アーティスト名
          guard let artist = song.value(forProperty: MPMediaItemPropertyArtist) else {
            continue
          }
          
          // 楽曲のタイトル
          guard let title = song.value(forProperty: MPMediaItemPropertyTitle) else {
            continue
          }
          
          // 楽曲のタイトル
          guard let aTitle = song.value(forProperty: MPMediaItemPropertyAlbumTitle) else {
            continue
          }
          
          albumArtist = artist as! String
          albumSong = title as! String
          albumTitle = aTitle as! String
          
          songList.append(albumSong)
          
          
        }
        
        albumList[albumTitle] = songList
        titleList.append(albumTitle)
        songList = []
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
    chosenUrl = [passUrl[indexPath.row]]
    segueToThirdViewController()
  }
  
  func segueToThirdViewController() {
    self.performSegue(withIdentifier: "artistSongViewController", sender: chosenUrl)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "artistSongViewController" {
      let _artistSongViewController = segue.destination as! artistSongViewController
      _artistSongViewController.chosenUrl = sender as! [MPMediaItemCollection]
    }
  }
  
}
