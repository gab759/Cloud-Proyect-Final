-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-05-2025 a las 07:12:56
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cloud`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_activate_user` (IN `p_id` INT, IN `p_modified_by` VARCHAR(100))   BEGIN
  UPDATE user
  SET state = 1,
      modified_at = NOW(),
      modified_by = p_modified_by
  WHERE id = p_id AND state IN (0, 2, 3);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_game` (IN `p_game_name` VARCHAR(255))   BEGIN
  INSERT INTO games (game_name, state, created_at, created_by)
  VALUES (p_game_name, 0, NOW(), 'system');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_game_score` (IN `p_game_id` INT, IN `p_user_id` INT, IN `p_time` INT, IN `p_score` INT)   BEGIN
  INSERT INTO game_scores (game_id, user_id, time, score, state, created_at, created_by)
  VALUES (p_game_id, p_user_id, p_time, p_score, 0, NOW(), 'system');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_state_type` (IN `p_id` TINYINT, IN `p_description` VARCHAR(100))   BEGIN
  INSERT INTO state_type (id, description, state, created_at, created_by)
  VALUES (p_id, p_description, 0, NOW(), 'system');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_user` (IN `p_username` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255))   BEGIN
  INSERT INTO user (username, email, password, state, created_at, created_by)
  VALUES (p_username, p_email, p_password, 0, NOW(), 'system');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_user_token` (IN `p_user_id` INT, IN `p_token` VARCHAR(255), IN `p_login_attempt` INT, IN `p_last_login` DATETIME)   BEGIN
  INSERT INTO user_tokens (user_id, token, login_attempt, last_login, state, created_at, created_by)
  VALUES (p_user_id, p_token, p_login_attempt, p_last_login, 0, NOW(), 'system');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_game` (IN `p_id` INT, IN `p_new_state` TINYINT, IN `p_modified_by` VARCHAR(100))   BEGIN
  IF p_new_state IN (0, 2, 3) THEN
    UPDATE games
    SET state = p_new_state,
        modified_at = NOW(),
        modified_by = p_modified_by
    WHERE id = p_id;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_game_score` (IN `p_id` INT, IN `p_new_state` TINYINT, IN `p_modified_by` VARCHAR(100))   BEGIN
  IF p_new_state IN (0, 2, 3) THEN
    UPDATE game_scores
    SET state = p_new_state,
        modified_at = NOW(),
        modified_by = p_modified_by
    WHERE id = p_id;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_state_type` (IN `p_id` TINYINT, IN `p_new_state` TINYINT, IN `p_modified_by` VARCHAR(100))   BEGIN
  IF p_new_state IN (0, 2, 3) THEN
    UPDATE state_type
    SET state = p_new_state,
        modified_at = NOW(),
        modified_by = p_modified_by
    WHERE id = p_id;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_user` (IN `p_id` INT, IN `p_new_state` TINYINT, IN `p_modified_by` VARCHAR(100))   BEGIN
  IF p_new_state IN (0, 2, 3) THEN
    UPDATE user
    SET state = p_new_state,
        modified_at = NOW(),
        modified_by = p_modified_by
    WHERE id = p_id;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_user_token` (IN `p_id` INT, IN `p_new_state` TINYINT, IN `p_modified_by` VARCHAR(100))   BEGIN
  IF p_new_state IN (0, 2, 3) THEN
    UPDATE user_tokens
    SET state = p_new_state,
        modified_at = NOW(),
        modified_by = p_modified_by
    WHERE id = p_id;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_user` (IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255))   BEGIN
  SELECT * FROM user
  WHERE email = p_email
    AND password = p_password
    AND state = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_game` (IN `p_id` INT)   BEGIN
  SELECT * FROM games WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_game_score` (IN `p_id` INT)   BEGIN
  SELECT * FROM game_scores WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_state_type` (IN `p_id` TINYINT)   BEGIN
  SELECT * FROM state_type WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_user` (IN `p_id` INT)   BEGIN
  SELECT * FROM user WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_user_token` (IN `p_id` INT)   BEGIN
  SELECT * FROM user_tokens WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_game` (IN `p_id` INT, IN `p_game_name` VARCHAR(255), IN `p_modified_by` VARCHAR(100))   BEGIN
  UPDATE games
  SET game_name = p_game_name,
      modified_at = NOW(),
      modified_by = p_modified_by
  WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_game_score` (IN `p_id` INT, IN `p_game_id` INT, IN `p_user_id` INT, IN `p_time` INT, IN `p_score` INT, IN `p_modified_by` VARCHAR(100))   BEGIN
  UPDATE game_scores
  SET game_id = p_game_id,
      user_id = p_user_id,
      time = p_time,
      score = p_score,
      modified_at = NOW(),
      modified_by = p_modified_by
  WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_state_type` (IN `p_id` TINYINT, IN `p_description` VARCHAR(100), IN `p_modified_by` VARCHAR(100))   BEGIN
  UPDATE state_type
  SET description = p_description,
      modified_at = NOW(),
      modified_by = p_modified_by
  WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_user` (IN `p_id` INT, IN `p_username` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), IN `p_modified_by` VARCHAR(100))   BEGIN
  UPDATE user
  SET username = p_username,
      email = p_email,
      password = p_password,
      modified_at = NOW(),
      modified_by = p_modified_by
  WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_user_token` (IN `p_id` INT, IN `p_token` VARCHAR(255), IN `p_login_attempt` INT, IN `p_last_login` DATETIME, IN `p_modified_by` VARCHAR(100))   BEGIN
  UPDATE user_tokens
  SET token = p_token,
      login_attempt = p_login_attempt,
      last_login = p_last_login,
      modified_at = NOW(),
      modified_by = p_modified_by
  WHERE id = p_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `games`
--

CREATE TABLE `games` (
  `id` int(11) NOT NULL,
  `game_name` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(100) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game_scores`
--

CREATE TABLE `game_scores` (
  `id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(100) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `state_type`
--

CREATE TABLE `state_type` (
  `id` tinyint(4) NOT NULL,
  `description` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(100) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `state_type`
--

INSERT INTO `state_type` (`id`, `description`, `created_at`, `created_by`, `modified_at`, `modified_by`) VALUES
(0, 'Inactivo', '2025-05-26 15:08:52', NULL, '2025-05-26 15:08:52', NULL),
(1, 'Activo', '2025-05-26 15:08:52', NULL, '2025-05-26 15:08:52', NULL),
(2, 'Bloqueado', '2025-05-26 15:08:52', NULL, '2025-05-26 15:08:52', NULL),
(3, 'Eliminado', '2025-05-26 15:08:52', NULL, '2025-05-26 15:08:52', NULL),
(4, 'Suspendido temporalmente', '2025-05-26 15:08:52', NULL, '2025-05-26 15:08:52', NULL),
(5, 'Suspendido permanentemente', '2025-05-26 15:08:52', NULL, '2025-05-26 15:08:52', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(100) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(100) DEFAULT NULL,
  `state` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `username`, `created_at`, `created_by`, `modified_at`, `modified_by`, `state`) VALUES
(1, 'ejemplo@mail.com', '123456', 'usuarioPrueba', '2025-05-29 23:32:29', 'system', '2025-05-29 23:56:17', 'admin', 1),
(2, 'ejemplo@ail.com', '123466', 'usuaioPrueba', '2025-05-29 23:44:04', 'system', '2025-05-29 23:44:04', NULL, 0),
(3, 'elpapu@gmail.com', 'vaen1234', 'Vaen', '2025-05-29 23:47:44', 'system', '2025-05-29 23:56:36', 'admin', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_tokens`
--

CREATE TABLE `user_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `login_attempts` int(11) DEFAULT 0,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(100) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `game_scores`
--
ALTER TABLE `game_scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `game_id` (`game_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `state_type`
--
ALTER TABLE `state_type`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `state` (`state`);

--
-- Indices de la tabla `user_tokens`
--
ALTER TABLE `user_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `games`
--
ALTER TABLE `games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `game_scores`
--
ALTER TABLE `game_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `user_tokens`
--
ALTER TABLE `user_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `game_scores`
--
ALTER TABLE `game_scores`
  ADD CONSTRAINT `game_scores_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`),
  ADD CONSTRAINT `game_scores_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`state`) REFERENCES `state_type` (`id`);

--
-- Filtros para la tabla `user_tokens`
--
ALTER TABLE `user_tokens`
  ADD CONSTRAINT `user_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
