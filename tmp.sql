-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июл 09 2018 г., 16:42
-- Версия сервера: 10.1.33-MariaDB
-- Версия PHP: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `tmp`
--
CREATE DATABASE IF NOT EXISTS `tmp` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `tmp`;

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_model` (IN `_id` INT)  NO SQL
select ml.name, ml.color
FROM model as ml
WHERE ml.id = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_lab0201decision` (IN `SLAU` VARCHAR(128) CHARSET utf8, IN `Result` VARCHAR(128) CHARSET utf8)  NO SQL
INSERT INTO lab0201decision(`SLAU`, `Result`) Values(Slau, Result)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_lab0201Log` (IN `Log` LONGTEXT CHARSET utf8, IN `time` DATETIME)  NO SQL
INSERT INTO lab0201log(`Log`, `time`) Values(Log, time)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `lab0201decision`
--

CREATE TABLE `lab0201decision` (
  `id` int(10) NOT NULL,
  `SLAU` varchar(128) DEFAULT NULL,
  `Result` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `lab0201decision`
--

INSERT INTO `lab0201decision` (`id`, `SLAU`, `Result`) VALUES
(32, '[[10.0, 24.0], [47.0, 55.0]][374.0, 64.0]', '[-32.93079585  29.30449827]'),
(33, '[[10.0, 2.0], [47.0, 5.0]][34.0, 64.0]', '[-0.95454545 21.77272727]');

-- --------------------------------------------------------

--
-- Структура таблицы `lab0201log`
--

CREATE TABLE `lab0201log` (
  `id` int(10) NOT NULL,
  `Log` longtext,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `lab0201log`
--

INSERT INTO `lab0201log` (`id`, `Log`, `time`) VALUES
(32, 'time: 2018-07-09 17:19:51.052210, message: CoeffOfX: [[10.0, 24.0], [47.0, 55.0]], freeCoeff: [374.0, 64.0], result: [-32.93079585  29.30449827]', '0000-00-00 00:00:00'),
(33, 'time: 2018-07-09 17:23:28.759280, message: CoeffOfX: [[10.0, 2.0], [47.0, 5.0]], freeCoeff: [34.0, 64.0], result: [-0.95454545 21.77272727]', '0000-00-00 00:00:00');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `lab0201decision`
--
ALTER TABLE `lab0201decision`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `SLAU` (`SLAU`);

--
-- Индексы таблицы `lab0201log`
--
ALTER TABLE `lab0201log`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `lab0201decision`
--
ALTER TABLE `lab0201decision`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT для таблицы `lab0201log`
--
ALTER TABLE `lab0201log`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `lab0201log`
--
ALTER TABLE `lab0201log`
  ADD CONSTRAINT `lab0201decision` FOREIGN KEY (`id`) REFERENCES `lab0201decision` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
