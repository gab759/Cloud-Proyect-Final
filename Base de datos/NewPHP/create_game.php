<?php
require 'db.php';
function createGame($game_name) {
    global $pdo;
    $stmt = $pdo->prepare("CALL sp_create_game(?)");
    $stmt->execute([$game_name]);
}
?>