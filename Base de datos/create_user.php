<?php
require 'db.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['email'], $data['password'], $data['username'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Faltan parámetros']);
    exit;
}

$email = $data['email'];
$password = $data['password'];
$username = $data['username'];

$stmt = $conn->prepare("CALL sp_create_user(?, ?, ?)");
$stmt->bind_param("sss", $username, $email, $password);

if ($stmt->execute()) {
    echo json_encode(['message' => 'Usuario creado correctamente']);
} else {
    echo json_encode(['error' => 'Error al ejecutar procedimiento', 'details' => $stmt->error]);
}

$stmt->close();
$conn->close();
?>