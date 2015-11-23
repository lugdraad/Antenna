import UIKit
import AVKit

class ViewController: UIViewController {
    
    ///////////////////////////////////////////////////////////////
    /// Set your options here /////////////////////////////////////
    
    let nearestCity = City.Sydney
    // Capitals: Adelaide, Brisbane, Melbourne, Perth, Sydney
    // QLD Regional: Cairns, Mackay, Maroochydore (Sunshine Coast),
    //               Maryborough (Wide Bay), Rockhampton (Central),
    //               Toowoomba, Townsville
    
    let streamQuality = Quality.High
    // Auto, Low, Medium, High
    
    /// That is all ///////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////
    
    
    var videoPlayer: AVPlayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register for background notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleEnteredBackground", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        // Play the stream
        let videoURL = NSURL(string: createURL())
        videoPlayer = AVPlayer(URL: videoURL!)
        let videoLayer = AVPlayerLayer(player: videoPlayer)
        videoLayer.frame = self.view.bounds
        self.view.layer.addSublayer(videoLayer)
        videoPlayer!.play()
    }
    
    // Handle a background notification
    func handleEnteredBackground() {
        videoPlayer!.pause() //counter audio fade out
        // app will proceed to exit on suspend due to plist setting
    }
    
    enum City {
        case Adelaide, Brisbane, Cairns, Mackay, Maroochydore, Maryborough, Melbourne, Perth, Rockhampton, Sydney, Toowoomba, Townsville
    }
    
    enum Quality {
        case Auto, Low, Medium, High
    }
    
    func createURL() -> String {
        #if ABCNEWS24
            switch streamQuality {
            case .High:
                return "http://iphonestreaming.abc.net.au/news24/news24_hi.m3u8"
            case .Medium:
                return "http://iphonestreaming.abc.net.au/news24/news24_med.m3u8"
            case .Low:
                return "http://iphonestreaming.abc.net.au/news24/news24_lo.m3u8"
            default:
                return "http://www.abc.net.au/res/streaming/video/hls/news24.m3u8"
            }

        #else
            var result = "https://sevenwestmedia01-i.akamaihd.net/hls/live/"
            #if CHANNELSEVEN
                switch nearestCity {
                case .Adelaide:
                    result += "224816/ADE1"
                case .Brisbane:
                    result += "224815/BRI1"
                case .Cairns:
                    result += "224818/CNS1"
                case .Mackay:
                    result += "224820/MKY1"
                case .Maroochydore:
                    result += "224823/SSC1"
                case .Maryborough:
                    result += "224822/WBY1"
                case .Melbourne:
                    result += "224813/MEL1"
                case .Perth:
                    result += "224817/PER1"
                case .Rockhampton:
                    result += "224821/RKY1"
                case .Sydney:
                    result += "224814/SYD1"
                case .Toowoomba:
                    result += "224824/TWB1"
                case .Townsville:
                    result += "224819/TSV1"
                }
            #elseif CHANNELSEVENTWO
                switch nearestCity {
                case .Adelaide:
                    result += "224829/ADE2"
                case .Brisbane:
                    result += "224828/BRI2"
                case .Cairns:
                    result += "224831/CNS2"
                case .Mackay:
                    result += "224833/MKY2"
                case .Maroochydore:
                    result += "224836/SSC2"
                case .Maryborough:
                    result += "224835/WBY2"
                case .Melbourne:
                    result += "224826/MEL2"
                case .Perth:
                    result += "224830/PER2"
                case .Rockhampton:
                    result += "224834/RKY2"
                case .Sydney:
                    result += "224827/SYD2"
                case .Toowoomba:
                    result += "224837/TWB2"
                case .Townsville:
                    result += "224832/TSV2"
                }
            #elseif CHANNELSEVENMATE
                switch nearestCity {
                case .Adelaide:
                    result += "224842/ADE3"
                case .Brisbane:
                    result += "224841/BRI3"
                case .Cairns:
                    result += "224844/CNS3"
                case .Mackay:
                    result += "224846/MKY3"
                case .Maroochydore:
                    result += "224849/SSC3"
                case .Maryborough:
                    result += "224848/WBY3"
                case .Melbourne:
                    result += "224839/MEL3"
                case .Perth:
                    result += "224843/PER3"
                case .Rockhampton:
                    result += "224847/RKY3"
                case .Sydney:
                    result += "224840/SYD3"
                case .Toowoomba:
                    result += "224850/TWB3"
                case .Townsville:
                    result += "224845/TSV3"
                }
            #elseif RACINGDOTCOM
                result += "224825/MISC1"
            #endif
            
            switch streamQuality {
            case .High:
                result += "/master_high.m3u8"
            case .Medium:
                result += "/master_med.m3u8"
            case .Low:
                result += "/master_low.m3u8"
            default:
                result += "/master.m3u8"
            }
            
            return result
        #endif
    }
    
}
