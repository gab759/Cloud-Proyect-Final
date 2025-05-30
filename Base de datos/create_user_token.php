<?php
require 'db.php';
function createUserToken($user_id, $token, $login_attempt, $last_login) {
    global $pdo;
    $stmt = $pdo->prepare("CALL sp_create_user_token(?, ?, ?, ?)");
    $stmt->execute([$user_id, $token, $login_attempt, $last_login]);
}
?>
