<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

header('Content-Type: application/json');
$input = json_decode(file_get_contents("php://input"), true);

$username = $input['username'] ?? '';
$email = $input['email'] ?? '';
$password = $input['password'] ?? '';

$conexion = new mysqli("localhost", "root", "", "cloud");

if ($conexion->connect_error) {
    echo json_encode(["error" => "Error en la conexión"]);
    exit;
}

$sql_check = "SELECT * FROM user WHERE email = '$email'";
$result_check = $conexion->query($sql_check);

if ($result_check->num_rows > 0) {
    echo json_encode(["error" => "El usuario ya existe"]);
} else {
    $sql = "INSERT INTO user (email, password, username, created_at, created_by, state)
            VALUES ('$email', '$password', '$username', NOW(), 'system', 1)";
    
    if ($conexion->query($sql) === TRUE) {
        echo json_encode(["message" => "Registro exitoso"]);
    } else {
        echo json_encode(["error" => "Error al registrar: " . $conexion->error]);
    }
}

$conexion->close();
?>