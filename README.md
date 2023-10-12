# streamer

Spotify API Streamer App!

This project calls on the spotify API and stores the genre & artist information on the local sqflite database

SCOPE OF WORK 

- Spotify API - initially will call a list of genres that are available in SA. Thereafter once the user has selected their preference and entered their name it will then get the top 100 artists in that specific genre. The implementation was rather straight forward, I encountered an issue when it came to calling the artists based on the genre. After hours spent on StackOverflow as well as the developer portal on spotify is when it clicked that I needed to use the search api. This came with its own set of challenges, i.e - you can only make a call that is limited to 50 items max. Perhaps recursion could have been a solution to this issue. 

- Local Database - using sqflite package in flutter we are able to locally store the data we retrieve from the API and call it back into the app via the local database call. My forte is not in SQL but rather NoSQL, I have working knowledge and understanding of it from studies and basic implemenations. This section gave me a rather rough time however I enjoyed it pushed me towards working harder! I faced issues with the "Songs" & "SongsDatabase" classes not working properly even though the code was identical to the other classes - very odd. I ended up using FutureBuilder -- not the most efficient way to run it however it runs. 

- Provider - handles the inital check to see whether whether the genre has been selected as well as the user's name. 

- .env for secure storage of key values -- did not have sufficient time to check why the app would crash on start up when the .env file was being implemented. The current implementation is not the safest.

- Authentication service was very quick to implement as I am very familiar with Firebase. 

- The log out button is located in the top left corner as in order to utilize all the useful screen real estate.

- Navigation works accordingly. 

- Could not get the database to clear on genre change, it simply adds to it. Tried a recursion to clear out the entire database but it did not take. 

- UI was inspired from a few medium articles & dribble.

- Pop up on login works but it is not the normal showDialog - I used a stack and the AlertDialog(). 


- a very interesting project 😀 



