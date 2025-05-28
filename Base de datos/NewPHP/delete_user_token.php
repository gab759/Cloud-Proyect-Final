<?php
require 'db.php';
function deleteUserToken($id, $new_state, $modified_by) {
    global $pdo;
    $stmt = $pdo->prepare("CALL sp_delete_user_token(?, ?, ?)");
    $stmt->execute([$id, $new_state, $modified_by]);
}
?>
