<?php
require 'db.php';
function readUser($id) {
    global $pdo;
    $stmt = $pdo->prepare("CALL sp_read_user(?)");
    $stmt->execute([$id]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
?>
