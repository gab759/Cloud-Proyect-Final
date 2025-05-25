<?php
include 'db.php';

$sql = "CALL sp_ListarUsuarios()";
$result = $conn->query($sql);

$usuarios = [];

while ($row = $result->fetch_assoc()) {
    $usuarios[] = $row;
}

echo json_encode($usuarios);
?>