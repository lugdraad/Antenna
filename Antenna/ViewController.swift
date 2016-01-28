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
    
    let streamQuality = Quality.Maximum
    // Auto, Low, Medium, High, Maximum
    
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
        case Auto, Low, Medium, High, Maximum
    }
    
    func createURL() -> String {
        #if ABCNEWS24
            switch streamQuality {
            case .Maximum:
                return "http://iphonestreaming.abc.net.au/news24/news24_hi.m3u8" // 709 Kbps - 512x288
            case .High:
                return "http://iphonestreaming.abc.net.au/news24/news24_med.m3u8" // 554 Kbps - 512x288
            case .Medium:
                return "http://iphonestreaming.abc.net.au/news24/news24_lo.m3u8" // 399 Kbps - 400x224
            case .Low:
                return "http://iphonestreaming.abc.net.au/news24/news24_vlo.m3u8" // 296 Kbps - 320x180
            default:
                return "http://www.abc.net.au/res/streaming/video/hls/news24.m3u8" // Self-adjusting
            }

        #elseif CHANNELSEVENSUITE
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
            #elseif CHANNELSEVENHD
                result += "224838/MISC2"
                switch streamQuality {
                case .Maximum:
                    result += "/master_vhigh.m3u8" // 3,335 Kbps - 1920x1080
                case .High:
                    result += "/master_high.m3u8" // 1,830 Kbps - 1024x576
                case .Medium:
                    result += "/master_med.m3u8" // 950 Kbps - 640x360
                case .Low:
                    result += "/master_low.m3u8" // 475 Kbps - 320x180
                default:
                    result += "/master.m3u8" // Self-adjusting
                }
                return result
            #elseif RACINGDOTCOM
                result += "224825/MISC1"
            #endif
            
            switch streamQuality {
            case .Maximum:
                result += "/master_high.m3u8" // 1,720 Kbps - 896x504
            case .High:
                result += "/master_medh.m3u8" // 1,170 Kbps - 640x360
            case .Medium:
                result += "/master_medl.m3u8" // 730 Kbps - 512x288
            case .Low:
                result += "/master_low.m3u8" // 510 Kbps - 320x180
                //result += "/master_lowl.m3u8" // 290 Kbps - 256x144
            default:
                result += "/master.m3u8" // Self-adjusting
            }
            
            return result
            
        #elseif CHANNELNINESUITE
            var result = "https://9nowlivehls-i.akamaihd.net/hls/live/"
            #if CHANNELNINE
                switch nearestCity {
                case .Adelaide:
                    result += "226647/ch9adlprd"
                case .Brisbane, .Cairns, .Mackay, .Maroochydore, .Maryborough, .Rockhampton, .Toowoomba, .Townsville:
                    result += "226646/ch9bneprd"
                case .Melbourne:
                    result += "226644/ch9melprd"
                case .Perth:
                    result += "226645/ch9perprd"
                case .Sydney:
                    result += "226554/ch9sydprd"
                }
            #endif
            
            switch streamQuality {
            case .Maximum:
                result += "/master5000.m3u8" // 5,000 Kbps - 1280x720
            case .High:
                result += "/master3000.m3u8" // 3,000 Kbps - 854x480
            case .Medium:
                // result += "/master1800.m3u8" // 1,800 Kbps - 640x360
                result += "/master700.m3u8" // 700 Kbps - 426x240
            case .Low:
                result += "/master192.m3u8" // 192 Kbps - 416x234
            default:
                result += "/master.m3u8" // Self-adjusting
            }
            
            return result
            
        #else
            return ""
        #endif
    }
    
}
