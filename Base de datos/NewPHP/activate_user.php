<?php
require 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    $modified_by = $_POST['modified_by'];

    if (!isset($id) || !isset($modified_by)) {
        http_response_code(400);
        echo json_encode(['error' => 'Faltan parámetros']);
        exit;
    }

    $stmt = $pdo->prepare("CALL sp_activate_user(?, ?)");
    $stmt->execute([$id, $modified_by]);

    echo json_encode(['message' => 'Usuario activado correctamente']);
}
?>