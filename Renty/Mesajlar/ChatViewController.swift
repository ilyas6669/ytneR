//
//  ChatViewController.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/22/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage



class ChatViewController: MessagesViewController,InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    
    
    var currentUser: User = Auth.auth().currentUser!
    private var docReference: DocumentReference?
    var messages: [Message] = []
    
    var user2Name: String?
    var user2ImgUrl: String?
    var user2UID: String?
    
    //Nicatalibli Clean Code
    var myUID = Auth.auth().currentUser!.uid
    
    public var receiver : String?
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    
    let btnLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "left1"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnLeftAction), for: .touchUpInside)
        return btn
    }()
    
    let imgProfil : UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        img.image = UIImage(named: "user1")
        img.heightAnchor.constraint(equalToConstant: 60).isActive = true
        img.widthAnchor.constraint(equalToConstant: 60).isActive = true
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.white.cgColor
        img.contentMode = .scaleAspectFill
        img.layer.borderWidth = 4
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.rgb(red: 0, green: 90, blue: 63).cgColor
        img.layer.cornerRadius = img.frame.size.height / 2
        img.clipsToBounds = true
        img.backgroundColor = .white
        img.isUserInteractionEnabled = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblIsim : UILabel = {
       let lbl = UILabel()
        lbl.backgroundColor = .white
        return lbl
    }()
    
    let imageProfil = UIImageView()
    
    let leftButton = UIBarButtonItem(image: UIImage(named: "left1"), style: .done, target: self, action: #selector(leftButtonAction))
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageProfil.image = UIImage(named: "ic_account_dark")?.withRenderingMode(.alwaysOriginal)
        imageProfil.contentMode = .scaleAspectFill
        imageProfil.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageProfil.layer.cornerRadius = 0.5 * imageProfil.bounds.size.width
        imageProfil.clipsToBounds = true
        let rightNavBarButton = UIBarButtonItem(customView: imageProfil)
        let currWidth = rightNavBarButton.customView?.widthAnchor.constraint(equalToConstant: 40)
        currWidth?.isActive = true
        let currHeight = rightNavBarButton.customView?.heightAnchor.constraint(equalToConstant: 40)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        
      
        self.navigationController?.navigationBar.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
    
        
    
        

        self.navigationItem.leftBarButtonItem = leftButton
        
        //self.title = myUID
        //navigationItem.largeTitleDisplayMode = .never
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = .rgb(red: 0, green: 90, blue: 63)
        messageInputBar.sendButton.setTitleColor(.rgb(red: 0, green: 90, blue: 63), for: .normal)
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        print("NicatalibliD:\(receiver ?? "")")
        print("NicatalibliD:\(myUID)")

        getreceiverdata()
//                loadChat()
        getmessages()
        
    }
    
    @objc func leftButtonAction() {
       
              dismiss(animated: true, completion: nil)
           
    }
    
    @objc func btnLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadChat() {
        //Fetch all the chats which has current user in it
        let db = Firestore.firestore().collection("Chats").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
        db.getDocuments { (chatQuerySnap, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                //Count the no. of documents returned
                guard let queryCount = chatQuerySnap?.documents.count
                    else {
                        return
                }
                if queryCount == 0 {
                    //If documents count is zero that means there is no chat available and we need to create a new instance
                    self.createNewChat()
                }
                else if queryCount >= 1 {
                    //Chat(s) found for currentUser
                    for doc in chatQuerySnap!.documents {
                        let chat = Chat(dictionary: doc.data())
                        //Get the chat which has user2 id
                        if (chat?.users.contains(self.user2UID!))! {
                            self.docReference = doc.reference
                            //fetch it's thread collection
                            doc.reference.collection("thread")
                                .order(by: "created", descending: false)
                                .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
                                    if let error = error {
                                        print("Error: \(error)")
                                        return
                                    } else {
                                        self.messages.removeAll()
                                        for message in threadQuery!.documents {
                                            let msg = Message(dictionary: message.data())
                                            self.messages.append(msg!)
                                            print("Data: \(msg?.content ?? "No message found")")
                                        }
                                        self.messagesCollectionView.reloadData()
                                        self.messagesCollectionView.scrollToBottom(animated: true)
                                    }
                                })
                            return
                        } //end of if
                    } //end of for
                    self.createNewChat()
                } else {
                    print("Let's hope this error never prints!")
                }}}}
    
    func createNewChat() {
        let users = [self.currentUser.uid, self.user2UID]
        let data: [String: Any] = [
            "users":users
        ]
        let db = Firestore.firestore().collection("Chats")
        db.addDocument(data: data) { (error) in
            if let error = error {
                print("Unable to create chat! \(error)")
                return
            } else {
                self.loadChat()
            }
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        //add the message to the messages array and reload it
        messages.append(message)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    private func save(_ message: Message) {
        //Preparing the data as per our firestore collection
        let data: [String: Any] = [
            "content": message.content,
            "created": message.created,
            "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName
        ]
        //Writing it to the thread using the saved document reference we saved in load chat function
        docReference?.collection("thread").addDocument(data: data, completion: { (error) in
            if let error = error {
                print("Error Sending message: \(error)")
                return
            }
            self.messagesCollectionView.scrollToBottom()
        })
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        //        //When use press send button this method is called.
        //        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: currentUser.uid, senderName: currentUser.displayName!)
        //        //calling function to insert and save message
        //        insertNewMessage(message)
        //        save(message)
        
       
        self.sendmessage(sender: myUID, receiver: receiver!, message: text)
        ///send notification
        let userRef = Database.database().reference().child("user").child(receiver!)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                 // Get user value
                 let value = snapshot.value as? NSDictionary
                 
                 let namesurname = value?["namesurname"] as? String ?? ""
                                  
            self.sendnotification(userid: self.receiver!, title: "Mesajlar", body: "\(namesurname) : \(text)")

             }) { (error) in
                 print(error.localizedDescription)
        }

        
        //clearing input field
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    ///Nicatalibli Function
    func getmessages(){
//        self.messages.removeAll()
//        for message in threadQuery!.documents {
//            let msg = Message(dictionary: message.data())
//            self.messages.append(msg!)
//            print("Data: \(msg?.content ?? "No message found")")
//        }
//        self.messagesCollectionView.reloadData()
//        self.messagesCollectionView.scrollToBottom(animated: true)
        
        let userRef = Database.database().reference().child("Chats")
        userRef.observe(.value, with: { (snapshot) in
            
            self.messages.removeAll(keepingCapacity: false)
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                let chatreceiver = value!["receiver"] as? String ?? ""
                let chatsender   = value!["sender"] as? String ?? ""
                let chatmessage   = value!["message"] as? String ?? ""
                let postid   = value!["postid"] as? String ?? ""
                
                print("nicatalibli:\(chatmessage)")

                if (chatreceiver == self.myUID && chatsender == self.receiver) ||
                    (chatreceiver == self.receiver && chatsender == self.myUID){
                    
//                    let message = Message(
//                    id: UUID().uuidString,
//                    content: text,
//                    created: Timestamp(),
//                    senderID: currentUser.uid,
//                    senderName: currentUser.displayName!)
                    
                    let data: [String: Any] = [
                               "content": chatmessage,
                               "created": Timestamp(),
                               "id": postid,
                               "senderID": chatsender,
                               "senderName": "nicartat"
                           ]
                    let msg = Message(dictionary: data)
                    
                    self.messages.append(msg!)
                
                }
            }
            print("Nicatalibli:\(self.messages.count)")
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom(animated: true)
    })
    }
    //MARK: gett
    func getreceiverdata(){

        let userRef = Database.database().reference().child("user").child(receiver!)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary

            let namesurname = value?["namesurname"] as? String ?? ""
            let profilepicture = value?["profilepicture"] as? String ?? ""

            self.title = namesurname

            if(profilepicture != ""){
                self.imageProfil.sd_setImage(with: URL(string: "\(self.imageProfil)"))
                
               
            }

        }) { (error) in
            print(error.localizedDescription)
        }

    }
    func sendmessage(sender : String,receiver : String, message : String){
        
        let postid = Database.database().reference().child("Chats").childByAutoId().key
        
        var itemmap = [String : Any]()
        
        itemmap["sender"] = sender
        itemmap["receiver"] = receiver
        itemmap["message"] = message
        itemmap["isseen"] = false
        itemmap["time"] = gettime()
        itemmap["date"] = getdate()
        itemmap["postid"] = postid
        
        //database kayit etme
        let ref =  Database.database().reference().child("Chats").child(postid!)
        ref.setValue(itemmap)
        
        let timestamp = NSDate().timeIntervalSince1970
        
        //ad user to chat me
        let chatRef =  Database.database().reference().child("Chatlist").child(myUID).child(receiver)
        chatRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            _ = snapshot.value as? NSDictionary
            
            if(!snapshot.exists()){
                 var chatlisthashmap = [String : Any]()
                 chatlisthashmap["id"] = receiver
                chatRef.setValue(chatlisthashmap)
            }
            chatRef.child("date").setValue("\((Int(timestamp)))")
          
            
        }) { (error) in
            print(error.localizedDescription)
        }
     
        //ad user to chat he
        let chatRef2 =  Database.database().reference().child("Chatlist").child(receiver).child(myUID)
        chatRef2.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            _ = snapshot.value as? NSDictionary
            
            if(!snapshot.exists()){
                var karsichatlisthashmap = [String : Any]()
                print("NicatalibliWW:\(self.myUID)")
                karsichatlisthashmap["id"] = self.myUID
                chatRef2.setValue(karsichatlisthashmap)
            }
            chatRef2.child("date").setValue("\((Int(timestamp)))")
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    //This method return the current sender ID and name
    func currentSender() -> SenderType {
        return Sender(id: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.displayName ?? "Name not found")
    }
    
    //This return the MessageType which we have defined to be text in Messages.swift
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    //Return the total number of messages
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        if messages.count == 0 {
            print("There are no messages")
            return 0
        } else {
            return messages.count
        }
    }
    
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    //Explore this delegate to see more functions that you can implement but for the purpose of this tutorial I've just implemented one function.
    
    //Background colors of the bubbles
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .rgb(red: 0, green: 38, blue: 26): .lightGray
    }
    //THis function shows the avatar
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        let userRef = Database.database().reference().child("user").child(message.sender.senderId)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let profilepicture = value?["profilepicture"] as? String ?? ""
                        
            
            if message.sender.senderId == self.myUID { //gonderen menem ise
                SDWebImageManager.shared.loadImage(with: URL(string: profilepicture), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                    avatarView.image = image
                }
            } else { //gonderen o birisidi
                SDWebImageManager.shared.loadImage(with: URL(string: profilepicture), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                    avatarView.image = image
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    //Styling the bubble to have a tail
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
    
    func getdate() -> String {
        //    "01 Oca 2020"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let result = formatter.string(from: date)
        return result
    }
    func gettime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let result = "\(hour):\(minutes)"
        return result
    }
    func sendnotification(userid:String,title:String,body:String){
          
          let tokenRef = Database.database().reference().child("user").child(userid)
          tokenRef.observeSingleEvent(of: .value, with: { (snapshot) in
                  let value = snapshot.value as? NSDictionary
                  
                  let token = value?["token"] as? String ?? ""
          
                  let sender = PushNotificationSender()
                  sender.sendPushNotification(to: token,title: title,body: body)
              
              }) { (error) in
                  print(error.localizedDescription)
              }
      }
    
}
