<?php
require 'db.php';
function deleteUser($id, $new_state, $modified_by) {
    global $pdo;
    $stmt = $pdo->prepare("CALL sp_delete_user(?, ?, ?)");
    $stmt->execute([$id, $new_state, $modified_by]);
}
?>
