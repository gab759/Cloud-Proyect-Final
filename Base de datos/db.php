<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "proyecto_final";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}
?>