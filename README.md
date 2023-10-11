# streamer

Spotify API Streamer App!

This project calls on the spotify API and stores the genre & artist information on the local sqflite database


- Spotify API - initially will call a list of genres that are available in SA. Thereafter once the user has selected their preference and entered their name it will then get the top 100 artists in that specific genre.
- Local Database - using sqflite package in flutter we able to locally store the data we retrieve from the API and call it back into the app via the local database call. 
- Provider
- .env for secure storage of key values