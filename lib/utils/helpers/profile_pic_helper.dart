const List<String> profilePics = [
  'https://raw.githubusercontent.com/SaileshVerma/chatly/base/assets/images/p1.png',
  'https://raw.githubusercontent.com/SaileshVerma/chatly/base/assets/images/p2.png',
  'https://raw.githubusercontent.com/SaileshVerma/chatly/base/assets/images/p3.png',
  'https://raw.githubusercontent.com/SaileshVerma/chatly/base/assets/images/p4.png',
  'https://raw.githubusercontent.com/SaileshVerma/chatly/base/assets/images/p5.png',
  'https://raw.githubusercontent.com/SaileshVerma/chatly/base/assets/images/p6.png',
];

// Function to generate profile picture asset based on username
String getProfilePicAsset(String username) {
  int index = username.hashCode % profilePics.length;
  return profilePics[index];
}
