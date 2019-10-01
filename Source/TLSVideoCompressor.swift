//
//  TLSVideoCompressor.swift
//  TLSModules
//
//  Created by Justin Ji on 01/10/2019.
//
import Foundation
import AVKit

public class TLSVideoCompressor {
    
    public enum VideoQuality {
        case low, medium, high
        
        var presetName: String {
            switch self {
            case .low: return "AVAssetExportPresetLowQuality"
            case .medium: return "AVAssetExportPresetMediumQuality"
            case .high: return "AVAssetExportPresetHighQuality"
            }
        }
    }
    
    public class func compress(quality: VideoQuality,
                               inputURL : URL,
                               fileName: String,
                               completionHandler completion: ((Error?, URL?) -> ())?) {
        
        let videoFilePath = "\(NSTemporaryDirectory())/\(fileName)"
        let savePathUrl =  URL(fileURLWithPath: videoFilePath)
        let sourceAsset = AVURLAsset(url: inputURL, options: nil)
           
        let assetExport: AVAssetExportSession = AVAssetExportSession(asset: sourceAsset, presetName: quality.presetName)!
        assetExport.outputFileType = AVFileType.mov
        assetExport.outputURL = savePathUrl
        if FileManager.default.fileExists(atPath: videoFilePath) {
            try! FileManager.default.removeItem(at: savePathUrl)
        }
        assetExport.exportAsynchronously { () -> Void in
            DispatchQueue.main.async {
                switch assetExport.status {
                case AVAssetExportSessionStatus.completed: completion?(nil, savePathUrl)
                case  AVAssetExportSessionStatus.failed: completion?(assetExport.error, nil)
                case AVAssetExportSessionStatus.cancelled: completion?(assetExport.error, nil)
                default: completion?(assetExport.error, nil)
                }
            }
        }
    }
}
