# ACFinalAssessment
Project01: 計算1到100中奇數的總和    
用for迴圈跑1到100，將數值除以2，餘數不為0的數累加起來，即可得到答案

Project02: 製作一個畫面在任何機型直立橫躺的比例一致     
先拉2個UIView上來，給予不同顏色，將這兩個UIView包成一個Stack View，設定間距=10，Distribution = Fill Equally，
然後設定Constraints，Height=50，to Botton Space = 10，Leading Space = (margins = 0)，Tralling Space = (margins = 0)

Project03: Server Request    
1.發Get取值回來  
先建立一個URLSession，使用這個session執行一個dataTask任務，request Method預設為"GET"，從completionHandler可以拿到回傳的data值，用JSONSerialization解析為json格式，拿去Main Queue 非同步執行緒將此jason轉型成[String:Any]的字典，再讀出我們要的"origin"key裡面的資料  
  
2.發POST  
先建立一個URLSession，指定request.httpMethod = "POST"，生出一個Data()並formatter格式為"yyyy-MM-dd HH:mm:ss"然後轉成String，
用JSONSerialization將資料轉為json格式並將時間參數帶入，再設定HTTPHeaderField。建立一個dataTask任務去執行，在completionHandler裡面
利用Calendar的dateComponents判斷傳送到接收的時間差，最後將時間轉成0.幾秒的格式  
  
POST方法參考：http://stackoverflow.com/questions/40676847/sending-json-post-request-in-swift3  
Calendar方法參考：http://stackoverflow.com/questions/38248941/how-to-get-time-hour-minute-second-in-swift-3-using-nsdate  
  
      
Project04: UICollectionView  
將CollectionView的Cell分為6等份，每個cell的寬= view.width / 2，高= view.height / 3，
在collectionView的didSelectItemAtindexPath中指派各個cell相對應的功能。  
1.顯示AlertView：  
製作一個UIAlertController，加入一個UIAlertAction的ok按鈕，再present出來  
2.顯示藍色或紅色cell：  
先將此cell的backgroundColor設為Blue，用一個變數紀錄是否有按下此cell，若有則將backgroundColor設為Red  
3.CoreMotion步數：  
方法參考：Swift自學力第10章 魏巍著  
先import CoreMotion，生出一個變數型別為CMPedometer，使用startUpdates方法來獲取data中的numberOfSteps步數，再顯示於cell的Label中  
4.開啟設定頁面：  
方法參考：http://stackoverflow.com/questions/28152526/how-do-i-open-phone-settings-when-a-button-is-clicked-ios  
利用UIApplication開啟URL的方式"App-Prefs:root=General"來轉到設定頁面，但需要在info裡面新增一個URL Schemes  
5.Google Map導航： 
方法參考：http://stackoverflow.com/questions/32039816/how-to-open-google-maps-to-show-route-using-swift
我是用開啟手機內Google Map App的方式，所以先利用UIApplication開啟URL的方式"comgooglemaps://"來轉到Google MAp頁面，因為要取得使用者位置，所以
要import CoreLocation，產生一個CLLocationManager變數，設定相關參數(desiredAccuracy、activityType、requestWhenInUseAuthorization)，
啟動startUpdatingLocation，就會得到使用者目前經緯度，再URL丟給Google去執行導航  
6.Mail：  
方法參考：http://stackoverflow.com/questions/25981422/how-to-open-mail-app-from-swift  
先import MessageUI，生出一個MFMailComposeViewController，填入相關設定(setToRecipients、setSubject、setMessageBody、mailComposeDelegate)，
然後再寫一個mailComposeController的didFinishWith裡面可以得知使用者的是否有按傳送或取消、儲存的行為  
  
Project05: TableView&Camera  
在NavigationBar上的+按鈕寫開啟相機的方法，拍攝完後順便轉場到下一頁，用prepare for segue的方式將圖片帶過去顯示出來，
使用者將文字填寫完畢後按返回前一頁鈕，利用protocol的方式把值帶回前一頁存在Array中顯示於tableView Cell中。增加一個頁面用於點進cell的detail頁，
拉出一個scrollView，再用程式碼加上imageView，讓class簽UIScrollViewDelegate協定才能使用viewForZooming將圖片放大縮小。製作share Button，
生出一個UIActivityViewController，把圖片與文字加進去，present出來就會有分享的選單。  
儲存資料方式使用CoreData，要先建立好Entity，當開啟程式就先去fetch coredata裡面的資料再顯示於tableView，有增加新資料時，先取得AppDelegate，
就可以利用coredata的persistentContainer得到context，再生出我們的Entity，將資料寫入後saveContext。要刪除tableview Cell資料時要先實作
tableview commit，editingStyle == .delete，要先刪除CoreData裡的資料還有暫存的Array資料，最後再把表格中的資料deleteRows  
方法參考：iOS 10 App 程式設計實力超進化實戰攻略  Simon Ng著










