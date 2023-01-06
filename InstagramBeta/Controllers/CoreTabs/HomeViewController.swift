//
//  ViewController.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 27/12/22.
//

import UIKit
import Firebase
class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var HomeTableView: UITableView!
    let Imgcol = ["https://reqres.in/img/faces/7-image.jpg","https://reqres.in/img/faces/8-image.jpg","https://reqres.in/img/faces/9-image.jpg","https://reqres.in/img/faces/10-image.jpg","https://reqres.in/img/faces/11-image.jpg","https://reqres.in/img/faces/7-image.jpg","https://reqres.in/img/faces/8-image.jpg","https://reqres.in/img/faces/7-image.jpg","https://reqres.in/img/faces/8-image.jpg","https://reqres.in/img/faces/9-image.jpg","https://reqres.in/img/faces/10-image.jpg","https://reqres.in/img/faces/11-image.jpg","https://reqres.in/img/faces/7-image.jpg","https://reqres.in/img/faces/8-image.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlenotauthorised()
    }
    @IBAction func didTapOpenCamera(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .camera
        image.allowsEditing = true
        self.present(image, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Imgcol.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.HomeTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!
            HomeTableViewCell
        
        cell.tag = indexPath.row
        cell.LikeBtn.tag = indexPath.row
        cell.FeedImageView?.image = try? UIImage(data: Data(contentsOf: URL(string: Imgcol[indexPath.row]) ?? URL(string: "http://www.google.com")!))
        return cell
    }
    
    private func handlenotauthorised(){
        if Auth.auth().currentUser == nil{
            let logvc = LoginViewController()
            logvc.modalPresentationStyle = .fullScreen
            present(logvc, animated: false)
        }
    }
}
extension UIImageView{
    func download(from link: URL, contentmode mode: ContentMode = .scaleAspectFill){
        contentMode = mode
        
    }
    func download(from link: String, contentmode mode: ContentMode = .scaleAspectFill){
        
        guard let url = URL(string: link) else  { return }
        download(from: url, contentmode: mode)
    }
}
class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var LikeBtn: UIButton!
    @IBOutlet weak var FeedImageView: UIImageView!
    
    @IBAction func LikeBtnTapped(_ sender: Any) {
        if LikeBtn.tag == 0{
            LikeBtn.tag = 1
            LikeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else{
            LikeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            LikeBtn.tag = 0
        }
    }
}
