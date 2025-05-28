<?php
require 'db.php';
function loginUser($email, $password) {
    global $pdo;
    $stmt = $pdo->prepare("CALL sp_login_user(?, ?)");
    $stmt->execute([$email, $password]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
?>
