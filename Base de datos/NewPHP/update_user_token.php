<?php
require 'db.php';
function updateUserToken($id, $token, $login_attempt, $last_login, $modified_by) {
    global $pdo;
    $stmt = $pdo->prepare("CALL sp_update_user_token(?, ?, ?, ?, ?)");
    $stmt->execute([$id, $token, $login_attempt, $last_login, $modified_by]);
}
?>
