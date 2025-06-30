<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

$input = json_decode(file_get_contents("php://input"), true);

$email = $input['email'] ?? '';
$password = $input['password'] ?? '';

$conexion = new mysqli("localhost", "root", "", "cloud");

if ($conexion->connect_error) {
    echo json_encode(["error" => "Error en la conexión"]);
    exit;
}

$sql = "SELECT * FROM user WHERE email = '$email' AND password = '$password' AND state = 1";
$resultado = $conexion->query($sql);

if ($resultado->num_rows === 1) {
    $usuario = $resultado->fetch_assoc();
    echo json_encode(["message" => "Login exitoso", "username" => $usuario['username']]);
} else {
    echo json_encode(["error" => "Correo o contraseña incorrectos"]);
}

$conexion->close();
?>