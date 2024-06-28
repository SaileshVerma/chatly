const List<String> profilePics = [
  '../assets/images/p1.png',
  '../assets/images/p2.png',
  '../assets/images/p3.png',
  '../assets/images/p4.png',
  '../assets/images/p5.png',
];

// Function to generate profile picture asset based on username
String getProfilePicAsset(String username) {
  int index = username.hashCode % profilePics.length;
  return profilePics[index];
}
