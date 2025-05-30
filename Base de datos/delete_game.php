<?php
require 'db.php';
function deleteGame($id, $new_state, $modified_by) {
    global $pdo;
    $stmt = $pdo->prepare("CALL sp_delete_game(?, ?, ?)");
    $stmt->execute([$id, $new_state, $modified_by]);
}
?>
