# Features

- Uses the MVVM Architecture
- Completely written using programmatically UI
- Written in swift 5
- Proper use of dependency injection wherever required
- Use of design pattern wherever needed.
- Follows Ray Wenderlich coding standards
- Enterprise grade git strategy with master, devlopment, test and branches for each main feature
- Sopisticated network error handling when displays error from server in a readable way
- Can chat with chatbot and responses are displayed in realtime.
- Can create concurrent chats and it is handled on a simple multi tenancy model.
- The screen to select chats shows the last line of the chat to offer some context. 
- Core Data for saving chats and offline usage with modern and robust methods which is readable, easily modifiable.
- Able to save messages offline and upload it once the app is back online for multiple concurreny chats.
- Loosely coupled modules makes modifying very easy without problems.

### Version 1
- Completed chat UI with message bubbles and textfield and send button.
- Able to make network requests and the response is added to the chat interface.
- Performed multiple UI enhancements like adjusted message bubbles to automatically to content size, to make it suitable for long text and very short text.
- Made self adjusting cells to account for long text.
- Added insets to the text and label borders.
- Added support for the textfield view to move up and down based on keyboard status. 

### Version 2
- The app now saves the chat history using Core Data and displays it organically sorted by timeStamps. 
- Also the app now adds a default hello text.
- The app now supports multi-tenancy, so its able to support multiple chats with the chatbot simultaneously.
- Able to create new instances of chats. 
- Extensively validated to make sure proper messages apear in proper chats in the proper order. 
- Added support for showing last chat message for context.

### Version 3
- The app is now capable of working offline.
- The user input is stored locally on CoreData and when network is back online, All the chats are processed in order. 
- Fixed bugs that allows offline syncronization with multiple conncurrent chats.
- Deletes offline message once they have been processed.
- Can now handle multple offline stored messages.
- The chats have been designed to simulate a real conversation, so as soon as chats as uploaded it, appears in a natural order. 

### Version 3+
- The input is validated wherever needed.
- Local and network Error handling. 
- App is optimized and validated with instruments for memory leaks, allocations, battery and coreData usage.

![](https://github.com/vishwas513/ChatBot/blob/master/screenshots/pic1.png)
![](https://github.com/vishwas513/ChatBot/blob/master/screenshots/pic2.png)
![](https://github.com/vishwas513/ChatBot/blob/master/screenshots/pic3.png)
![](https://github.com/vishwas513/ChatBot/blob/master/screenshots/pic4.png)