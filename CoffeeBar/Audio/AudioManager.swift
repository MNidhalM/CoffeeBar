//
//  AudioManager.swift
//  CoffeeBar
//
//  Created by Nidhal on 9/10/2021.
//

import Foundation
import AVFoundation

/// The device audio instruction API's has been supplied here.
final class AudioManager: NSObject {
    
    // MARK: - Instance Variable.
    
    /// Shared instance of `AudioManager`.
    static let sharedInstance = AudioManager()
    
    /// `AVSpeechSynthesizer` reprensenting speech synthesize.
    let synthesizer = AVSpeechSynthesizer()
    
    /// `AVSpeechUtterance` representing to read the given text.
    var theUtterance: AVSpeechUtterance!
    
    var completion: (() -> Void)?
    
    // MARK: - Initializer.
    
    /// Private initializer, avoids instance creation in application level.
    private override init() {
        super.init()
        do {
            try AVAudioSession
                .sharedInstance()
                .setCategory(
                    .playback,
                    mode: .voicePrompt,
                    options: [.mixWithOthers, .duckOthers]
                )
        } catch {
            debugPrint("AudioSetup is failed: \(error)")
        }
        synthesizer.delegate = self
    }
    
    // MARK: - Custom methods.
    /// Offers the service about to read the given text
    /// - Parameter givenText: `String` representing the instruction text.
    func startToInstruct(with givenText: String) {
        do {
            try AVAudioSession
                .sharedInstance()
                .setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            debugPrint("AudioSetup is failed: \(error)")
        }
        
        debugPrint("SpeechText ====>", givenText)
        if synthesizer.isSpeaking { return }
        theUtterance = AVSpeechUtterance(string: givenText)
        let speechVoice = AVSpeechSynthesisVoice.currentLanguageCode()
        let voiceConfiguration = AVSpeechSynthesisVoice(language: speechVoice)
        theUtterance.voice = voiceConfiguration
        theUtterance.volume = 1.0
        synthesizer.speak(theUtterance)
    }
}


// MARK: - AVSpeechDeleagate
extension AudioManager: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        debugPrint("SpeechCompleted..!")
        do {
            try AVAudioSession
                .sharedInstance()
                .setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            debugPrint("AudioCoachSetup is failed: \(error)")
        }
        completion?()
    }
}
