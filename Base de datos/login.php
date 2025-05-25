<?php
include 'db.php';

header("Content-Type: application/json");

$data = json_decode(file_get_contents("php://input"));

$username = $data->username ?? '';
$password = $data->password ?? '';

$sql = "SELECT id, password FROM User WHERE username = ? AND state = 'active'";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    if ($password === $row["password"]) {
        echo json_encode([
            "status" => "success",
            "message" => "Login exitoso",
            "user_id" => $row["id"]
        ]);
    } else {
        echo json_encode(["status" => "fail", "message" => "Contraseña incorrecta"]);
    }
} else {
    echo json_encode(["status" => "fail", "message" => "Usuario no encontrado o inactivo"]);
}

$conn->close();
?>