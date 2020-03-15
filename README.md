# Bookmark Manager
## User Stories
```
As a user,
So I can find sites quickly
I would like to see bookmarks list
```
go to /bookmarks
```
As a user
So I can store bookmark data for later retrieval
I want to add a bookmark to Bookmark Manager
```
go to /bookmarks/new
```
As a user
So I can remove my bookmark from Bookmark Manager
I want to delete a bookmark
```
Click Delete button
```
As a user
So I can change a bookmark in Bookmark Manager
I want to update a bookmark
```
Click Update button

```
As a user
So that I can find relevant bookmarks
I want to filter Bookmarks by a Tag
```

## How to setup database
1. Connect to psql\
2. Create the database using the psql command CREATE DATABASE bookmark_manager;\
3. Connect to the database using the pqsl command \c bookmark_manager;\
4. Run the query we have saved in the file 01_create_bookmarks_table.sql\