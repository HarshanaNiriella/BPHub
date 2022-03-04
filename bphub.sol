// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BpHubTest {  //This is a Test contract of BP Hub by Dr.Harshana Niriella - 2022.03.04
 uint256 public latestPostId = 0;

 struct Doctor {
   string doctor;
   string bio;
   uint256[] postIds;
 }

 struct Post {
   string title;
   string content;
   address author;
   uint256 created;
 }

 mapping(address => Doctor) public doctors;
 mapping(uint256 => Post) public posts;

 event NewPost(address indexed author, uint256 postId, string title);

 function createPost(string memory title, string memory content) public {
   latestPostId++;

   posts[latestPostId] = Post(title, content, msg.sender, block.timestamp);
   doctors[msg.sender].postIds.push(latestPostId);

   emit NewPost(msg.sender, latestPostId, title);
 }

 function modifyPostTitle(uint256 postId, string memory title) public {
   require(msg.sender == posts[postId].author, "Only the author can modify");

   posts[postId].title = title;
 }

 function modifyPostContent(uint256 postId, string memory content) public {
   require(msg.sender == posts[postId].author, "Only the author can modify");

   posts[postId].content = content;
 }

 function updatedoctorname(string memory doctorname) public {
   doctors[msg.sender].doctor = doctorname;
 }

 function updateBio(string memory bio) public {
   doctors[msg.sender].bio = bio;
 }

 function getPostIdsByAuthor(address author)
   public
   view
   returns (uint256[] memory)
 {
   return doctors[author].postIds;
 }

 function getPostById(uint256 postId)
   public
   view
   returns (string memory title, string memory content)
 {
   title = posts[postId].title;
   content = posts[postId].content;
 }
}
