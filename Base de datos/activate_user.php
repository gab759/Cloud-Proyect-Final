<?php
require 'db.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);
$id = $data['id'] ?? null;
$modified_by = $data['modified_by'] ?? null;

if (!$id || !$modified_by) {
    http_response_code(400);
    echo json_encode(['error' => 'Faltan parámetros']);
    exit;
}

$stmt = $conn->prepare("CALL sp_activate_user(?, ?)");
$stmt->bind_param("is", $id, $modified_by);

if ($stmt->execute()) {
    echo json_encode(['message' => 'Usuario activado correctamente']);
} else {
    echo json_encode(['error' => 'Error al ejecutar procedimiento', 'details' => $stmt->error]);
}

$stmt->close();
$conn->close();
?>