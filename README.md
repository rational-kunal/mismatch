# mismatch  

A budget-friendly **Facemash**-like clone using the **RandomUser API**.  

> [!NOTE]  
> Designed using [NeoBrutalism](https://github.com/rational-kunal/NeoBrutalism). Check it out!  

<p float="left">
  <img src="https://github.com/user-attachments/assets/841680db-008a-4e47-a298-c1ab931c1269" width="300px" />
  <img src="https://github.com/user-attachments/assets/e9c65989-6605-4afe-b84c-391785b7e30b" width="300px" /> 
</p>


- Multi-tab Support:  
  - *Explore:* Displays new profiles.  
  - *Liked:* Shows profiles you’ve accepted.  

- API Integration: Fetches profiles infinitely via [randomuser.me](https://randomuser.me/api).  

- Card Design: Displays basic details (name, address) with two actions:  
  - *Accept:* Saves to local storage and appears in the *Liked* tab.  
  - *Reject:* Removes from local storage.  

- Offline Mode: Liked profiles persist via local storage.  

- Design Architecture: Based on [swift-composable-architecture](https://github.com/pointfreeco/swift-composable-architecture):  
  - [`Mismatch` (Reducer)](https://github.com/rational-kunal/mismatch/blob/main/mismatch/Feature/Mismatch.swift): Manages app state and actions.  
  - [`DataLayer`](https://github.com/rational-kunal/mismatch/tree/main/mismatch/DataLayer): Handles data fetching and transformation.  
  - [`ViewLayer`](https://github.com/rational-kunal/mismatch/tree/main/mismatch/ViewLayer): Renders views dynamically.  

- Tech Stack:
  - SwiftUI – UI framework  
  - SwiftData – Local storage  
  - 🌟 [NeoBrutalism](https://github.com/rational-kunal/NeoBrutalism) – Design system  
  - swift-composable-architecture – State management and architecture  
  - Alamofire – Network requests  
  - SwiftyJSON – JSON parsing  
  - SDWebImage – Cached image loading  

- UI: Clean, minimal, and dark mode supported.  

