<?php
require 'db.php';

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';

    if ($email && $password) {
        try {
            $stmt = $pdo->prepare("CALL sp_login_user(?, ?)");
            $stmt->execute([$email, $password]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($user) {
                echo json_encode(["success" => true, "message" => "Se inició sesión correctamente", "user" => $user]);
            } else {
                echo json_encode(["success" => false, "message" => "ERROR: Credenciales incorrectas o usuario inactivo"]);
            }
        } catch (Exception $e) {
            echo json_encode(["success" => false, "message" => "ERROR en el servidor", "error" => $e->getMessage()]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "Faltan parámetros"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Método no permitido"]);
}
?>
