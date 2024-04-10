//
//  InfoView.swift
//
//
//  Created by Ferry Dwianta P on 24/02/24.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .bold()
                }
            }
            .padding(.top)
            .padding(.trailing)
            
            Form {
                Section ("Tinnitus", content: {
                    ExpandableText(title: "What is Tinnitus?", description:"""
                    Tinnitus, commonly described as ringing in the ears, affects about **749 million** people worldwide, according to research in the journal JAMA Neurology and based on about five decades of data. Tinnitus is sound in the head with no external source. For many, it's a ringing sound, while for others, it's whistling, buzzing, chirping, hissing, humming, roaring, or even shrieking. The sound may seem to come from one ear or both, from inside the head, or from a distance. It may be constant or intermittent, steady or pulsating.
                                   
                    _Source: health.harvard.edu_
                    """)
                    ExpandableText(title: "How does it affect individuals?", description: """
                    Tinnitus is only rarely associated with a serious medical problem and is usually not severe enough to interfere with daily life. However, some people find that tinnitus is more than just an auditory annoyance, it’s a source of significant emotional distress. Some of the psychological effects include:
                    
                    **Anxiety and Stress:** The constant noise can lead to heightened anxiety, especially in quiet environments where the tinnitus is more noticeable.
                    **Sleep Disturbances:** Falling and staying asleep can be challenging, leading to fatigue and further stress.
                    **Depression:** Chronic tinnitus can lead to feelings of hopelessness, especially if the individual feels there’s no relief in sight.
                    **Concentration Issues:** The persistent noise can make it hard to focus on tasks, affecting work or school performance.
                    
                    _Source: sonikhearing.com_
                    """)
                    ExpandableText(title: "Can tinnitus be cured?", description: "Currently, there is no cure for tinnitus, but there are ways to reduce symptoms. Common approaches include the use of sound therapy devices (including hearing aids), behavioral therapies, and medications.\n\n_Source: nidcd.nih.gov_")
                    ExpandableText(title: "How to manage it?", description: """
                    The most effective approaches are behavioral strategies and sound-generating devices, often used in combination. They include the following:
                    
                    **Cognitive behavioral therapy (CBT):**  CBT uses techniques such as cognitive restructuring and relaxation to change the way patients think about and respond to tinnitus.
                    
                    **Tinnitus retraining therapy (TRT):** This technique is based on the assumption that tinnitus results from abnormal neuronal activity. The aim is to habituate the auditory system to the tinnitus signals, making them less noticeable or less bothersome.
                    
                    **Masking:** Masking devices, worn like hearing aids, generate low-level white noise (a high-pitched hiss, for example) that can reduce the perception of tinnitus.  A specialized device isn't always necessary for masking; often, playing music or having a radio, fan, or white-noise machine on in the background is enough.
                    
                    **Biofeedback and stress management:**  Tinnitus is stressful, and stress can worsen tinnitus. Biofeedback is a relaxation technique that helps control stress by changing bodily responses.
                    
                    _Source: health.harvard.edu_
                    """)
                })
                
                Section ("TinniPal App", content: {
                    ExpandableText(title: "How can this app help?", description: """
                    **TinniPal** is a sound mask app to help tinnitus sufferers get distracted from their tinnitus and make it less noticeable. **TinniPal** offers a variety of natural sounds to help ease that annoying ringing in your ears. With **TinniPal**, you can personalized and create your own custom soundscape by mixing and matching different sounds to suit your preferences. Adjust the volume of each sound to create the perfect blend just for you. There are also left-right stereo output feature that you may can adjust, as we know that not every tinnitus sufferers hear tinnitus in both ears. Worried about falling asleep with the sounds on? TinniPal includes a convenient timer feature to ensure peaceful rest without overexposure of the sounds. 
                    """)
                    ExpandableText(title: "Disclaimer", description: """
                    It's important to note that TinniPal **is not a treatment or therapy** for tinnitus that claiming can reduce or overcoming your tinnitus problem. TinniPal only helps you with a temporary solution to get distracted or divert your attention from the ringing sound that you experiencing through relaxation and distraction. Additionally, remember to use caution with volume levels and avoid prolonged headphone use to prevent potential hearing damage. Prioritize to seek guidance from a doctor for comprehensive tinnitus consultation.
                    """)
                    ExpandableText(title: "Copyrights", description: """
                    **Sounds Copyrights**
                    - Rain Sound Effect by **Maksym Dudchyk** from **Pixabay**
                    - Thunder Sound Effect by **Peace,love,happiness** from **Pixabay**
                    - Waves Sound Effect by **solarmusic** from **Pixabay**
                    - Fire Sound Effect by **Mikhail** from **Pixabay**
                    - Wind Sound Effect by **Ghostie Ghost** from **Pixabay**
                    - Water Sound Effect by **Julius H.** from **Pixabay**
                    - Jungle Sound Effect by **Peace,love,happiness** from **Pixabay**
                    - Birds Sound Effect by **Maksym Dudchyk** from **Pixabay**
                    - Leaves Sound Effect from **Pixabay**
                    - Owl Sound Effect from **Pixabay**
                    - Frog Sound Effect from **Pixabay**
                    - Cricket Sound Effect from **Pixabay**
                    - Cicadas Sound Effect by sarvegu from **Pixabay**
                    - Squirrel Sound Effect from **Pixabay**
                    - Music 1 Music by **Sergei Chetvertnykh** from **Pixabay**
                    - Music 2 Music by **Oleksii Kaplunskyi** from **Pixabay**
                    - Music 3 Music by **Dubush Miaw** from **Pixabay**
                    """)
                })
                
                
                HStack {
                    Spacer()
                    Text("TinniPal - v1.0.0")
                        .font(.caption)
                        .foregroundStyle(.secondaryText)
                    Spacer()
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
            }
            .formStyle(.grouped)
            Spacer()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .ignoresSafeArea(edges: .bottom)
    }
}

struct ExpandableText: View {
    let title: String
    let description: String
    
    var body: some View {
        DisclosureGroup {
            Text(.init(description))
                .multilineTextAlignment(.leading)
        } label: {
            Text(title)
                .bold()
        }
        .listRowSeparator(.hidden)
    }
}

#Preview {
    InfoView()
}
