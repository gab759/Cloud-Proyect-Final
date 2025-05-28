<?php
require 'db.php';

header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);

$email = $data['email'] ?? null;
$password = $data['password'] ?? null;
$username = $data['username'] ?? null;

if (!$email || !$password || !$username) {
    http_response_code(400);
    echo json_encode(['error' => 'Faltan parámetros']);
    exit;
}

$stmt = $conn->prepare("CALL sp_create_user(?, ?, ?)");

if (!$stmt) {
    echo json_encode(['error' => 'Error al preparar statement', 'details' => $conn->error]);
    exit;
}

$stmt->bind_param("sss", $username, $email, $password);

if ($stmt->execute()) {
    echo json_encode(['message' => 'Usuario creado correctamente']);
} else {
    echo json_encode(['error' => 'Error al ejecutar procedimiento', 'details' => $stmt->error]);
}

$stmt->close();
$conn->close();
?>