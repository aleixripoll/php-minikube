<?php
// env var from dockerfile, which in turn comes from k8s resource
$conn = new mysqli('mysql-service', 'root', $_ENV['DB_PW'], 'testdb');

$sql = "SELECT id, name FROM user";
$result = $conn->query($sql) or die($conn->error);;

print "<pre>";
while($user = $result->fetch_assoc()) {
    print_r($user);
}
print "</pre>";

?>
