-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 24, 2021 alle 23:32
-- Versione del server: 10.4.14-MariaDB
-- Versione PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fantacalcio2`
--

DELIMITER $$
--
-- Procedure
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `p1` (IN `edizione` INTEGER, OUT `squad` VARCHAR(20))  BEGIN
	select c.Squadra into squad
	from classifica_corrente c
	where c.Edizione_Fantacalcio=edizione
	order by c.Punti desc LIMIT 1;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p2` (IN `giornata_passata` INTEGER)  BEGIN
select c1.Squadra
from classifica_corrente c1 join (select Squadra,Punti from classifica_passata where giornata=giornata_passata) c2 on c1.Squadra=c2.Squadra
where c1.Punti>c2.Punti;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p3` (IN `cod` INTEGER, IN `nome` VARCHAR(20), IN `edizione` INTEGER)  BEGIN
	case 
	when nome like 'bbbb' then signal sqlstate '45000' SET MESSAGE_TEXT = "Errore nome 	errato";
	when nome like 'aaaa' then signal SQLSTATE '45000' SET MESSAGE_TEXT = "Errore nome errato";
	else insert into squadra values(cod,'nome',edizione);
	end case;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p4` (IN `edizione` INTEGER)  BEGIN
	select età,count(*)
	from vista1
	where Edizione_Fanta=edizione
	group by età;
	END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `classifica_corrente`
--

CREATE TABLE `classifica_corrente` (
  `Giornata` int(11) NOT NULL,
  `Punti` int(11) DEFAULT NULL,
  `Squadra` int(11) NOT NULL,
  `Edizione_Fantacalcio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `classifica_passata`
--

CREATE TABLE `classifica_passata` (
  `Giornata` int(11) NOT NULL,
  `Punti` int(11) DEFAULT NULL,
  `Squadra` int(11) NOT NULL,
  `Edizione_Fantacalcio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `commenti`
--

CREATE TABLE `commenti` (
  `Id` int(11) NOT NULL,
  `commento` varchar(255) DEFAULT NULL,
  `cod_news` int(11) DEFAULT NULL,
  `cod_fantallenatore` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `commenti`
--

INSERT INTO `commenti` (`Id`, `commento`, `cod_news`, `cod_fantallenatore`) VALUES
(21, 'Ottimo articolo', 1, 1),
(22, 'si', 1, 1),
(23, 'ertertr tertret rertrr tyry  yy retr t twt4t 4ttwt4t4 tw4tdgdgt4 wreg gwt4twdt twtw4ttert wt4', 1, 1),
(24, 'aaaaaa', 1, 1),
(25, 'aaaa', 1, 1),
(26, 'aaa aa a a a  aa a aa a a a a a aaaa a a a a a a a aaaa aa a a aaa a a a a a  a a aaa a a a a a a aaaaa aa a a  a  aaaaaaa a a aa a aaa a  aa aa a a aa a', 1, 1),
(27, 'aaaaaaaaaaaaaaaaaaaaa', 2, 1),
(28, 'vvvvvvvvvvvvvvvvvvvv', 2, 1),
(30, 'ciao agata', 3, 1),
(31, 'piuuuuuuuuuuuuuu po', 1, 1),
(32, 'si', 1, 1),
(33, 'asd sad dssf egewg egweg geg', 3, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `edizione_fantacalcio`
--

CREATE TABLE `edizione_fantacalcio` (
  `Tipo` varchar(20) DEFAULT NULL,
  `Anno` int(11) DEFAULT NULL,
  `Quota_Iscrizione` int(11) DEFAULT NULL,
  `Id` int(11) NOT NULL,
  `Fantacalcio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `edizione_fantacalcio`
--

INSERT INTO `edizione_fantacalcio` (`Tipo`, `Anno`, `Quota_Iscrizione`, `Id`, `Fantacalcio`) VALUES
('coppa', 2021, 50, 1, 1),
('coppa', 2021, 50, 2, 2),
('campionato', 2021, 60, 3, 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `fantacalcio`
--

CREATE TABLE `fantacalcio` (
  `Nome` varchar(20) DEFAULT NULL,
  `Regolamento` varchar(20) DEFAULT NULL,
  `Modalità` varchar(20) DEFAULT NULL,
  `Cod` int(11) NOT NULL,
  `Num_Max_Partecipanti` int(11) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `fantacalcio`
--

INSERT INTO `fantacalcio` (`Nome`, `Regolamento`, `Modalità`, `Cod`, `Num_Max_Partecipanti`, `img`) VALUES
('Chiamarsi Bomber', 'regolamento1', 'mantra', 1, 8, 'img/lega1.jpg'),
('FantaFootball', 'regolamento1', 'classic', 2, 8, 'img/lega2.png'),
('Superligue', 'regolamento1', 'classic', 3, 10, 'img/lega3.png');

-- --------------------------------------------------------

--
-- Struttura della tabella `fantallenatore`
--

CREATE TABLE `fantallenatore` (
  `Id` int(11) NOT NULL,
  `Cognome` varchar(20) DEFAULT NULL,
  `Nome` varchar(20) DEFAULT NULL,
  `Età` int(11) DEFAULT NULL,
  `Data` date NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `fantallenatore`
--

INSERT INTO `fantallenatore` (`Id`, `Cognome`, `Nome`, `Età`, `Data`, `username`, `password`) VALUES
(1, 'Salamone', 'Giovanni', 2021, '0000-00-00', 'straiker', '$2y$10$3Typ/ERK3x7Y4Ef42qhEaeQbh7h4J3p224mad/aQvHzLPSGx5K.JK'),
(2, 'torre', 'riccardo', 2021, '0000-00-00', 'rickytr99', '$2y$10$h/ptkCNNnKwI87BPkxSpEu3zcUaRVbkIS4TdQQPBA0XVuVl9hBIeS'),
(3, 'Sinatra', 'Gabriele', 2021, '0000-00-00', 'Gabri123', '$2y$10$Em2LZtxZVn6.hwxrxaarAuOTqmfDm3vu1nMu76PFQUO77ASex1N5G'),
(4, 'dipaola', 'andrea', 2021, '0000-00-00', 'triodp', '$2y$10$pvbNqPUOFGYGDgJFIO9hWOoTmJRiUrperQbUJzP85ph.hfNqdVy/O'),
(5, 'Frisenna', 'Gianluca', 2021, '0000-00-00', 'Comix909', '$2y$10$WXQH.TqwVtAwR8dTCQaipelrX7UvFR6kTUds5K4/z2skXQBBPLr1S'),
(17, 'Ciccarelli', 'Davide', 2021, '0000-00-00', 'davide11', '$2y$10$Bm6OL20wDd74VGv2NvAZXOjfV9g6yn0yFYoOWHUVgM8aoOkMiFlgO'),
(18, 'San Giorgio', 'Fabio', 2021, '0000-00-00', 'Homer2999', '$2y$10$9T/o6z6CNlclBFnHkT0S9un7RraWn67e2DiMv51Yt5iXs.ZtBRWYS');

--
-- Trigger `fantallenatore`
--
DELIMITER $$
CREATE TRIGGER `allineamento_età` BEFORE INSERT ON `fantallenatore` FOR EACH ROW BEGIN
	set new.età=year(current_date())-year(new.data);
	END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `giocatori`
--

CREATE TABLE `giocatori` (
  `Id` int(11) NOT NULL,
  `Nome` varchar(20) DEFAULT NULL,
  `Ruolo` varchar(20) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `giocatori`
--

INSERT INTO `giocatori` (`Id`, `Nome`, `Ruolo`, `url`) VALUES
(1, 'Ronaldo', 'ATT', 'https://content.fantacalcio.it/web/campioncini/card/RONALDO.jpg'),
(2, 'Ibra', 'ATT', 'https://content.fantacalcio.it/web/campioncini/card/IBRAHIMOVIC.jpg'),
(3, 'Immobile', 'ATT', 'https://content.fantacalcio.it/web/campioncini/card/IMMOBILE.jpg'),
(4, 'Donnarumma', 'POR', 'https://content.fantacalcio.it/web/campioncini/card/DONNARUMMA-G.jpg'),
(5, 'Handanovic', 'POR', 'https://content.fantacalcio.it/web/campioncini/card/HANDANOVIC.jpg'),
(6, 'Mirante', 'POR', 'https://content.fantacalcio.it/web/campioncini/card/MIRANTE.jpg'),
(7, 'Chiellini', 'DEF', 'https://content.fantacalcio.it/web/campioncini/card/CHIELLINI.jpg'),
(8, 'Tomori', 'DEF', 'https://content.fantacalcio.it/web/campioncini/card/TOMORI.jpg'),
(9, 'De Vrij', 'DEF', 'https://content.fantacalcio.it/web/campioncini/card/DE-VRIJ.jpg'),
(10, 'Kessie', 'CC', 'https://content.fantacalcio.it/web/campioncini/card/KESSIE.jpg'),
(11, 'Barella', 'CC', 'https://content.fantacalcio.it/web/campioncini/card/BARELLA.jpg'),
(12, 'Rabiot', 'CC', 'https://content.fantacalcio.it/web/campioncini/card/RABIOT.jpg'),
(13, 'Mertens', 'ATT', 'https://content.fantacalcio.it/web/campioncini/card/MERTENS.jpg');

-- --------------------------------------------------------

--
-- Struttura della tabella `giocatori_appartenenti`
--

CREATE TABLE `giocatori_appartenenti` (
  `Id` int(11) NOT NULL,
  `squadra` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `giocatori_appartenenti`
--

INSERT INTO `giocatori_appartenenti` (`Id`, `squadra`) VALUES
(1, 45),
(3, 45),
(4, 45),
(7, 45),
(10, 45),
(2, 53),
(7, 53),
(2, 54),
(3, 54),
(4, 54),
(7, 54),
(11, 54),
(13, 57),
(2, 58),
(4, 58),
(8, 58),
(10, 58),
(3, 62),
(5, 62),
(1, 67),
(2, 67),
(1, 68),
(2, 68),
(3, 68);

-- --------------------------------------------------------

--
-- Struttura della tabella `news`
--

CREATE TABLE `news` (
  `Id` int(11) NOT NULL,
  `titolo` varchar(30) DEFAULT NULL,
  `descrizione` varchar(3000) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `news`
--

INSERT INTO `news` (`Id`, `titolo`, `descrizione`, `img`, `url`) VALUES
(1, 'Il Milan vince fuori casa', 'Grande prova di carattere del Milan. I rossoneri passano in vantaggio al Franchi contro la Fiorentina grazie a Ibra al 9’. La formazione di Prandelli pareggia con Pulgar al 17’ e a inizio ripresa rimonta con Ribery. Il Milan reagisce di rabbia e fa 2-2 grazie a un tap-in sottoporta di Brahim Diaz. La formazione di Pioli ci crede e trova il vantaggio con una gran conclusione di Calhanoglu. I rossoneri allungano a +4 sulla Juve e accorciano sull’Inter a -6 ma entrambe hanno una gara in meno. Le insidie di un contraccolpo psicologico dopo un\'eliminazione immeritata dall\'Europa League, erano dietro l\'angolo. Lo aveva detto Zlatan Ibrahimovic dopo il match con il Manchester United: occorreva reagire, perché il campionato resta lungo e avvincente. E il Milan ha vissuto, all\'interno della sfida del Franchi, almeno un paio di partite. L\'euforia per il vantaggio a inizio gara, la delusione per la rimonta con il 2-1 segnato dalla Fiorentina, la capacità di reazione grazie alle reti di Brahim Diaz e Calhanoglu. Tutti sintomi di una squadra che, nonostante le difficoltà, sembra tenere botta e non voler mollare niente e che si giocherà ogni chance fino all\'ultima giornata di campionato. Al contrario c\'è grande delusione da parte della Fiorentina per aver disputato un\'ottima partita ma essere rimasta a mani vuote al termine dei 90\'. Il Milan vince e accorcia momentaneamente sull\'Inter, allunga sulla Juve e soprattutto tiene lontano il quinto posto.\nPioli ritrova Ibrahimovic nonostante lo svedese non abbia i 90\', promuove Brahim Diaz a titolare e tiene Bennacer come asso nella manica in panchina. Prandelli si schiera con un 4-4-1-1 per schermare il Milan con il solito Ribery ad agire dietro il pericoloso Vlahovic. La Fiorentina parte bene ma il Milan risponde colpo su colpo. Sono proprio i rossoneri a passare in vantaggio con Ibra pescato da Kjaer in profondità: per lo svedese troppo semplice battere Dragowski. La Fiorentina non si scoraggia e reagisce, Pulgar sorprende Donnarumma con un bel calcio di punizione. La squadra di Prandelli prende coraggio, mette in difficoltà il Milan e colpisce un incrocio dei pali con Pezzella. La risposta rossonera è affidata al solito Ibra che tutto solo davanti a Dragowski colpisce la traversa.', 'img/notizia1.jpg', ''),
(2, 'L\'inter prova la fuga', 'Prova di maturità dell\'Inter, che non abbassa la guardia dopo le vittorie pesanti contro Lazio e Milan, batte un Genoa con la testa al derby grazie a Lukaku, Darmian e Sanchez. La squadra di Conte allunga a +10 sulla Juve, che deve recuperare il match col Napoli, mentre il Milan vincendo a Roma resta a -4. Per i nerazzurri si tratta del quinto successo di fila, il quattordicesimo nelle ultime 17 giornate. Conte sceglie Darmian per sostituire lo squalificato Hakimi. Per il resto, avanti con i soliti noti che hanno piegato Lazio e Milan, con Eriksen preferito a Vidal e Perisic a lasciare di nuovo in panchina Young. Cambia, e parecchio, invece Ballardini, con un occhio al derby nell\'infrasettimanale. Il rientrante Zapata prende il posto di Criscito, Ghiglione quello di Zappacosta, mentre i baby Melegoni e Rovella subentrano a Badelj e Zaic. In attacco soprattutto tocca a Pjaca e Scamacca, ultimamente poco utilizzati. La foto del rullo contiano sta nell’azione che dopo 32 secondi indirizza la gara. Il Genoa ha il primo possesso e palleggia, Bastoni intercetta, Barella verticalizza per Lukaku, che scambia con Lautaro, si porta a spasso Radovanovic e col destro trova l\'angolino malgrado il ritorno di Zapata. L\'istantanea appunto di una filosofia che invita il rivale a scoprirsi, per poi freddarlo con azioni spesso stupende. Perché alla fase \'attesa\' i nerazzurri alternano quella \'aggressione\' e il Genoa, costretto a difendere anche con le punte, poi non riesce a ripartire. Ci prova Rovella su un errore in uscita di Eriksen, se no è un\'onda lunga interista. Vanno vicini al raddoppio Lautaro (2 volte, Darmian, Barella (traversa) e Lukaku, con un paio di sassate mancine che Perin tiene in due tempi. La capolista sa che deve chiuderla perché l\'imprevisto è sempre dietro l\'angolo. Vedi uscita con tempi e presa giusti al 31\' di Handanovic, cui però Bastoni fa un ponte involontario, palla persa e Scamacca che però tira addosso al portiere. Poi riprendono le azioni rugbistiche, con Lautaro a stimolare Perin altre due volte. Nell\'intervallo Ballardini effettua due sostituzioni: dentro Onguene e Behrami per Radovanovic (Zapata scala al centro della difesa) e Strootman. Asfissiato nelle fonti di gioco, il Genoa nei primi 45\' non è mai riuscito ad accompagnare l\'azione con gli esterni. Pjaca quindi era costretto ad abbassarsi per ricevere qualche pallone, lasciando solo Scamacca. A inizio ripresa però il Grifone ha un altro piglio e alza il baricentro. Anche perché l\'Inter - come peraltro successo nel derby - torna dagli spogliatoi meno cattiva di prima, quasi che voglia gestire. Ballardini al 17\' azzarda con Pandev e Shomurodov per Ghiglione e Scamacca, con Pjaca sulla trequarti. Peccato che al 24\' Onguene sbagli l\'anticipo su Lukaku. Il Massiccio sgomma di nuovo, ne porta a spasso tre e poi scarta un cioccolatino per Darmian, che non sbaglia.', 'img/inter2.jpg', ''),
(3, 'Incredibile Juve, brutto stop.', 'Altro che rincorsa scudetto, la Juve esce con le ossa rotte dalla sfida in casa con il neopromosso Benevento e forse più che del titolo - ormai avviatosi verso Milano - deve preoccuparsi di blindare il posto in Champions per la prossima stagione. Impresa sportiva quella della squadra di Inzaghi, che con tenacia e determinazione e ordine tattico riesce a centrare una vittoria importantissima che fa salire i campani a quota 29 e aggiunge un altro pezzo a quel miracolo che significherebbe salvezza.Pirlo ritrova Bonucci e Arthur da titolari in campionato dopo quasi due mesi, Danilo a destra vista la squalifica di Cuadrado e Bernardeschi sull\'out opposto a fare le veci di Alex Sandro. Inzaghi replica con uno schieramento tatticamente difensivo ma con Viola, Lapadula e Gaich pronti a sfruttare gli spazi lasciati dalla manovra bianconera. Due ammoniti nei primi venti minuti, Tuia da una parte e Bernardeschi dall\'altra, un tentativo di Ronaldo di poco a lato e un altro più velleitario di Lapadula. Benevento compatto e attento, che sotto il sole di Torino mostra per mezz\'ora un\'intensità che spegne la Juve e che per poco non porta anche al vantaggio: 28\' leggerezza di Danilo che regala palla al Benevento in posizione centrale, splendida la manovra giallorossa che porta al cross Hetemaj. Lapadula e Ionita non arrivano per un soffio a toccare il pallone del possibile vantaggio. Alla mezz\'ora l\'intensità ospite rallenta e esce fuori la Juve con una serie di occasioni: la prima se la procura Morata che salta Barba e Tuia con un gran movimento in diagonale e incrocia il sinistro, basso ma debole, Montipò in uscita si allunga e ci arriva salvando il risultato. Poi è Kulusevski a prendersi la scena, un suo cross viene deviato da Foulon con Abisso che prima assegna un rigore per tocco di mano del difensore, poi grazie all\'on field review corregge la sua decisione. Corner, De Ligt schiaccia, Montipò respinge e Morata si divora mandando altissimo il sinistro da ottima posizione. Ancora Juve, Kulusevski pesca Ronaldo che in area non perdona ma CR7 è in posizione di fuorigioco: nulla di fatto. Finale di tempo con il portoghese a provarci ancora e Montipò ancora a respingere, ma di qualche minuto prima l\'episodio con protagonista il portiere dei campani che scatena le proteste Juve: Chiesa è lanciato a rete, Montipò esce basso e prende il pallone ma sullo slancio esce fuori dall\'area continuando a tenere bloccato il pallone con le mani, i bianconeri chiedono il rosso, l\'arbitro assegna solo la punizione. ', 'img/juve3.jpg', '');

-- --------------------------------------------------------

--
-- Struttura della tabella `preferiti`
--

CREATE TABLE `preferiti` (
  `id` int(11) NOT NULL,
  `titolo` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `fantallenatore` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `premiazione`
--

CREATE TABLE `premiazione` (
  `Premio` int(11) DEFAULT NULL,
  `Edizione_Fantacalcio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `premio`
--

CREATE TABLE `premio` (
  `Tipo` varchar(20) DEFAULT NULL,
  `Codice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `squadra`
--

CREATE TABLE `squadra` (
  `Cod_S` int(11) NOT NULL,
  `Nome_Squadra` varchar(20) NOT NULL,
  `Edizione_Fantacalcio` int(11) DEFAULT NULL,
  `fantallenatore` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `squadra`
--

INSERT INTO `squadra` (`Cod_S`, `Nome_Squadra`, `Edizione_Fantacalcio`, `fantallenatore`) VALUES
(45, 'milan', 1, 1),
(53, 'milan', NULL, 2),
(54, 'Artanis Squad', 2, 3),
(55, 'Zucumba', NULL, 3),
(56, 'Fabio FC', NULL, 3),
(57, 'Real di Paola', 1, 4),
(58, 'Bagegio Team', NULL, 5),
(62, 'juve', 2, 2),
(67, 'FC PeScaraManzia', NULL, 1),
(68, 'Homer FC', 1, 18);

--
-- Trigger `squadra`
--
DELIMITER $$
CREATE TRIGGER `max_partecipanti` BEFORE INSERT ON `squadra` FOR EACH ROW BEGIN
	if (
	( select count(*) as num_p from squadra where Edizione_Fantacalcio=new.Edizione_Fantacalcio) =
          	( select Num_Max_Partecipanti from fantacalcio where Cod=new.Edizione_Fantacalcio )  
	) 
	then	signal SQLSTATE '45000' SET MESSAGE_TEXT = "Numero massimo di squadre inserite";
	end if;
	END
$$
DELIMITER ;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `classifica_corrente`
--
ALTER TABLE `classifica_corrente`
  ADD PRIMARY KEY (`Squadra`,`Edizione_Fantacalcio`,`Giornata`),
  ADD KEY `squad4` (`Squadra`),
  ADD KEY `fanta3` (`Edizione_Fantacalcio`);

--
-- Indici per le tabelle `classifica_passata`
--
ALTER TABLE `classifica_passata`
  ADD PRIMARY KEY (`Squadra`,`Edizione_Fantacalcio`,`Giornata`),
  ADD KEY `squad3` (`Squadra`),
  ADD KEY `fanta2` (`Edizione_Fantacalcio`);

--
-- Indici per le tabelle `commenti`
--
ALTER TABLE `commenti`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `cdn` (`cod_news`),
  ADD KEY `cdf` (`cod_fantallenatore`);

--
-- Indici per le tabelle `edizione_fantacalcio`
--
ALTER TABLE `edizione_fantacalcio`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fanta4` (`Fantacalcio`);

--
-- Indici per le tabelle `fantacalcio`
--
ALTER TABLE `fantacalcio`
  ADD PRIMARY KEY (`Cod`),
  ADD UNIQUE KEY `Nome` (`Nome`);

--
-- Indici per le tabelle `fantallenatore`
--
ALTER TABLE `fantallenatore`
  ADD PRIMARY KEY (`Id`);

--
-- Indici per le tabelle `giocatori`
--
ALTER TABLE `giocatori`
  ADD PRIMARY KEY (`Id`);

--
-- Indici per le tabelle `giocatori_appartenenti`
--
ALTER TABLE `giocatori_appartenenti`
  ADD PRIMARY KEY (`squadra`,`Id`),
  ADD KEY `squad2` (`squadra`),
  ADD KEY `Ids` (`Id`);

--
-- Indici per le tabelle `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`Id`);

--
-- Indici per le tabelle `preferiti`
--
ALTER TABLE `preferiti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idPrefFanta` (`fantallenatore`);

--
-- Indici per le tabelle `premiazione`
--
ALTER TABLE `premiazione`
  ADD PRIMARY KEY (`Edizione_Fantacalcio`),
  ADD KEY `prenio2` (`Premio`),
  ADD KEY `fanta4` (`Edizione_Fantacalcio`);

--
-- Indici per le tabelle `premio`
--
ALTER TABLE `premio`
  ADD PRIMARY KEY (`Codice`);

--
-- Indici per le tabelle `squadra`
--
ALTER TABLE `squadra`
  ADD PRIMARY KEY (`Cod_S`),
  ADD UNIQUE KEY `Nome_Squadra` (`Nome_Squadra`,`Edizione_Fantacalcio`),
  ADD KEY `fanta` (`Edizione_Fantacalcio`),
  ADD KEY `fallen` (`fantallenatore`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `commenti`
--
ALTER TABLE `commenti`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT per la tabella `edizione_fantacalcio`
--
ALTER TABLE `edizione_fantacalcio`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `fantacalcio`
--
ALTER TABLE `fantacalcio`
  MODIFY `Cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `fantallenatore`
--
ALTER TABLE `fantallenatore`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT per la tabella `giocatori`
--
ALTER TABLE `giocatori`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT per la tabella `news`
--
ALTER TABLE `news`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `preferiti`
--
ALTER TABLE `preferiti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT per la tabella `premio`
--
ALTER TABLE `premio`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `squadra`
--
ALTER TABLE `squadra`
  MODIFY `Cod_S` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `classifica_corrente`
--
ALTER TABLE `classifica_corrente`
  ADD CONSTRAINT `classifica_corrente_ibfk_1` FOREIGN KEY (`Squadra`) REFERENCES `squadra` (`Cod_S`),
  ADD CONSTRAINT `classifica_corrente_ibfk_2` FOREIGN KEY (`Edizione_Fantacalcio`) REFERENCES `edizione_fantacalcio` (`Id`);

--
-- Limiti per la tabella `classifica_passata`
--
ALTER TABLE `classifica_passata`
  ADD CONSTRAINT `classifica_passata_ibfk_1` FOREIGN KEY (`Squadra`) REFERENCES `squadra` (`Cod_S`),
  ADD CONSTRAINT `classifica_passata_ibfk_2` FOREIGN KEY (`Edizione_Fantacalcio`) REFERENCES `edizione_fantacalcio` (`Id`);

--
-- Limiti per la tabella `commenti`
--
ALTER TABLE `commenti`
  ADD CONSTRAINT `commenti_ibfk_1` FOREIGN KEY (`cod_news`) REFERENCES `news` (`Id`),
  ADD CONSTRAINT `commenti_ibfk_2` FOREIGN KEY (`cod_fantallenatore`) REFERENCES `fantallenatore` (`Id`);

--
-- Limiti per la tabella `edizione_fantacalcio`
--
ALTER TABLE `edizione_fantacalcio`
  ADD CONSTRAINT `edizione_fantacalcio_ibfk_1` FOREIGN KEY (`Fantacalcio`) REFERENCES `fantacalcio` (`Cod`);

--
-- Limiti per la tabella `giocatori_appartenenti`
--
ALTER TABLE `giocatori_appartenenti`
  ADD CONSTRAINT `giocatori_appartenenti_ibfk_1` FOREIGN KEY (`squadra`) REFERENCES `squadra` (`Cod_S`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `giocatori_appartenenti_ibfk_2` FOREIGN KEY (`Id`) REFERENCES `giocatori` (`Id`);

--
-- Limiti per la tabella `preferiti`
--
ALTER TABLE `preferiti`
  ADD CONSTRAINT `preferiti_ibfk_1` FOREIGN KEY (`fantallenatore`) REFERENCES `fantallenatore` (`Id`);

--
-- Limiti per la tabella `premiazione`
--
ALTER TABLE `premiazione`
  ADD CONSTRAINT `premiazione_ibfk_1` FOREIGN KEY (`Premio`) REFERENCES `premio` (`Codice`),
  ADD CONSTRAINT `premiazione_ibfk_2` FOREIGN KEY (`Edizione_Fantacalcio`) REFERENCES `edizione_fantacalcio` (`Id`);

--
-- Limiti per la tabella `squadra`
--
ALTER TABLE `squadra`
  ADD CONSTRAINT `squadra_ibfk_2` FOREIGN KEY (`fantallenatore`) REFERENCES `fantallenatore` (`Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
