<?php

$conn = new mysqli("mysql", "root", "your_root_password", "blog") or die("Connection failed: " . $conn->connect_error);

$sql = "SELECT posts.id, posts.title, posts.body, users.name AS author 
  FROM posts 
  JOIN users ON posts.author = users.id";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
  echo "<table border='1'>
    <tr>
      <th>ID</th>
      <th>Title</th>
      <th>Body</th>
      <th>Author</th>
    </tr>";
  while($row = $result->fetch_assoc()) {
    echo "<tr>
      <td>" . $row["id"]. "</td>
      <td>" . $row["title"]. "</td>
      <td>" . $row["body"]. "</td>
      <td>" . $row["author"]. "</td>
    </tr>";
  }
  echo "</table>";
} else {
  echo "0 results";
}

$conn->close();

?>