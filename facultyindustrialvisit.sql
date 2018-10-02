-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 02, 2018 at 07:29 AM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `facultyindustrialvisit`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_AddLeaveDetails` (IN `paramStaffId` VARCHAR(10), IN `paramFromdate` DATETIME, IN `paramTodate` DATETIME, IN `paramLeavetype` INT, IN `paramDuration` FLOAT(5,1), IN `paramLeaveremarks` VARCHAR(100), IN `paramIsapproved` INT, OUT `status` INT)  BEGIN 
DECLARE available int; 
DECLARE odAvailed int;
	CASE 
       	WHEN paramLeavetype = 1 THEN 
	      		SET available = (SELECT CL FROM LeaveLimit where StaffID = paramStaffId);       	
		WHEN paramLeavetype = 2 THEN 
      			SET available = (SELECT SL FROM LeaveLimit where StaffID = paramStaffId);       	          
        WHEN paramLeavetype = 3 THEN 
      			SET available = (SELECT ML FROM LeaveLimit where StaffID = paramStaffId);       	          
        WHEN paramLeavetype = 4 THEN 
      			SET available = (SELECT VL FROM LeaveLimit where StaffID = paramStaffId);       	          
        WHEN paramLeavetype = 5 THEN 
      			SET odAvailed = (select count(leaveid) from leaveentries where month(todate) = month(now()) and StaffID = paramStaffId and leavetype = 5);       	          
      			CASE 
					WHEN odAvailed > 2 THEN 
						SET available = 0;
					WHEN odAvailed = 2 THEN 
						SET available = 0;
					WHEN odAvailed = 1 THEN 
						SET available = 1;
					WHEN odAvailed = 0 THEN 
						SET available = 2;
				END CASE;	
        WHEN paramLeavetype = 6 THEN 
      			SET available = (SELECT LOP FROM LeaveLimit where StaffID = paramStaffId);       	          
        WHEN paramLeavetype = 7 THEN 
      			SET available = (SELECT COMP FROM LeaveLimit where StaffID = paramStaffId);       	          
        WHEN paramLeavetype = 8 THEN 
      			SET available = (SELECT SCL FROM LeaveLimit where StaffID = paramStaffId);
		WHEN paramLeavetype = 9 THEN 
			SET available = (SELECT STYL FROM LeaveLimit where StaffID = paramStaffId);
		WHEN paramLeavetype = 10 THEN 
      			SET available = (SELECT OD FROM LeaveLimit where StaffID = paramStaffId);
      	ELSE
			BEGIN 
				SET available = -1;
			END;
	END CASE;

        CASE 
        	WHEN (available - paramDuration) >= 0 THEN 
		          	CASE 
							WHEN paramLeavetype = 1 THEN 
                           
                               UPDATE LeaveLimit SET CL = CL - paramDuration WHERE StaffID =   paramStaffId;   
                               INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
                               SET status = 1;
                            WHEN paramLeavetype = 2 THEN 
                            
                            	UPDATE LeaveLimit SET SL = SL - paramDuration WHERE StaffID =   paramStaffId;   
                            	INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
								SET status = 1;
                                   	          
							WHEN paramLeavetype = 3 THEN 
								
								UPDATE LeaveLimit SET ML = ML - paramDuration WHERE StaffID =   paramStaffId;   
								INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
								SET status = 1; 	          
							WHEN paramLeavetype = 4 THEN 
								
								UPDATE LeaveLimit SET VL = VL - paramDuration WHERE StaffID =   paramStaffId;   
								INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
								SET status = 1;
												  
							WHEN paramLeavetype = 5 THEN 
								
								UPDATE LeaveLimit SET PER = PER - paramDuration WHERE StaffID =   paramStaffId;   
								INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
								SET status = 1;
													  
							WHEN paramLeavetype = 6 THEN 
								
								UPDATE LeaveLimit SET LOP = LOP - paramDuration WHERE StaffID =   paramStaffId;   
								INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
								SET status = 1;
								   
												  
							WHEN paramLeavetype = 7 THEN 
								
								UPDATE LeaveLimit SET COMP = COMP - paramDuration WHERE StaffID =   paramStaffId; 
								INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
								SET status = 1;
													  
							WHEN paramLeavetype = 8 THEN
								
								UPDATE LeaveLimit SET SCL = SCL - paramDuration WHERE StaffID =   paramStaffId;
								INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
								SET status = 1;
							WHEN paramLeaveType = 9 THEN 
								
									UPDATE LeaveLimit SET STYL = STYL - paramDuration WHERE StaffID =   paramStaffId;
								INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
								SET status = 1;
							WHEN paramLeaveType = 10 THEN 
								 
									UPDATE LeaveLimit SET OD = OD - paramDuration WHERE StaffID =   paramStaffId;
								INSERT INTO leaveentries(StaffID,FromDate,ToDate,LeaveType,Duration,LeaveRemarks,IsApproved) values(paramStaffId,paramFromdate,paramTodate,paramLeavetype,paramDuration,paramLeaveremarks,paramIsapproved);
								SET status = 1;
							ELSE 
								BEGIN 
								END;
                              	          
					END CASE;	
               WHEN available < 0 THEN 
				   	SET status = -1;
				ELSE 
					BEGIN 
						SET status = -1;
					END;
                	
        END CASE;        	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_UpdateLeaveLimit` (IN `paramStaffId` VARCHAR(10), IN `paramCL` FLOAT(4,1), IN `paramSL` FLOAT(4,1), IN `paramML` FLOAT(4,1), IN `paramVL` FLOAT(4,1), IN `paramPER` FLOAT(4,1), IN `paramLOP` FLOAT(4,1), IN `paramCOMP` FLOAT(4,1), IN `paramSCL` FLOAT(4,1), IN `paramSTYL` FLOAT(4,1), IN `paramOD` FLOAT(4,1), OUT `status` INT)  BEGIN 
	SET status = 0;
	IF(SELECT count(staffid) from leavelimit where StaffID = paramStaffId) > 0 THEN 
	BEGIN 
		Update leavelimit 
			set CL = paramCL,
				SL = paramSL, 
				ML = paramML, 
				VL = paramVL, 
				PER = paramPER, 
				LOP = paramLOP, 
				COMP = paramCOMP, 
				SCL = paramSCL, 
				STYL = paramSTYL, 
				OD = paramOD
			where 
				StaffID = paramStaffId ; 
		SET status = 1;
	END ;
	ELSE 
		BEGIN 
			INSERT INTO leavelimit(StaffID, CL, SL, ML, VL, PER, LOP, COMP, SCL, STYL, UpdatedOn, OD) 
			VALUES 
			(paramStaffId,paramCL,paramSL, paramML,paramVL, paramPER, paramLOP, paramCOMP, paramSCL, paramSTYL, NOW(), paramOD);
			SET status = 2;
		END; 
	END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `deptdetails`
--

CREATE TABLE `deptdetails` (
  `DeptId` int(255) NOT NULL,
  `EmailId` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deptdetails`
--

INSERT INTO `deptdetails` (`DeptId`, `EmailId`) VALUES
(1, 'username@gmail.com'),
(2, 'username@gmail.com'),
(3, 'username@gmail.com'),
(4, 'username@gmail.com'),
(5, 'username@gmail.com'),
(6, 'username@gmail.com'),
(7, 'username@gmail.com'),
(8, 'username@gmail.com'),
(9, 'username@gmail.com'),
(10, 'username@gmail.com'),
(11, 'username@gmail.com'),
(12, 'username@gmail.com'),
(13, 'username@gmail.com'),
(14, 'username@gmail.com'),
(15, 'username@gmail.com'),
(16, 'username@gmail.com'),
(17, 'username@gmail.com'),
(18, 'username@gmail.com'),
(19, 'username@gmail.com'),
(20, 'username@gmail.com'),
(21, 'username@gmail.com'),
(22, 'username@gmail.com'),
(23, 'username@gmail.com'),
(24, 'username@gmail.com'),
(25, 'username@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `deptmaster`
--

CREATE TABLE `deptmaster` (
  `id` int(2) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deptmaster`
--

INSERT INTO `deptmaster` (`id`, `name`) VALUES
(1, 'CSE'),
(2, 'ECE'),
(3, 'EIE'),
(4, 'PT'),
(5, 'IT'),
(6, 'BT'),
(7, 'EEE'),
(8, 'MECH'),
(9, 'CIVIL'),
(10, 'MTR'),
(11, 'SS'),
(12, 'Maths'),
(13, 'Physics'),
(14, 'Chemistry'),
(15, 'English'),
(16, 'Placement'),
(17, 'Fine Arts'),
(18, 'Tech Beats'),
(19, 'Tech Band'),
(20, 'NSS'),
(21, 'NCC'),
(22, 'YRC'),
(23, 'RRC'),
(24, 'Rotract'),
(25, 'Sports'),
(26, 'III Cell'),
(27, 'IBM'),
(28, 'CCNA'),
(29, 'Campus Connect'),
(30, 'Programmers Club');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int(255) NOT NULL,
  `StaffID` varchar(255) NOT NULL,
  `department` varchar(10) NOT NULL,
  `dateofapply` date NOT NULL,
  `dateofvisit` date NOT NULL,
  `noofdays` int(255) NOT NULL,
  `ivremark` varchar(1000) NOT NULL,
  `security` int(255) NOT NULL,
  `hodrecommend` varchar(100) NOT NULL,
  `deanapproval` varchar(100) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `reportstatus` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `industry`
--

CREATE TABLE `industry` (
  `id` int(255) NOT NULL,
  `industryname` varchar(255) NOT NULL,
  `industrynature` varchar(255) NOT NULL,
  `industryaddress` varchar(500) NOT NULL,
  `location` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `cpname` varchar(255) NOT NULL,
  `cpmobileno` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `opportunity`
--

CREATE TABLE `opportunity` (
  `id` int(255) NOT NULL,
  `industrial_visit_possibility` varchar(255) NOT NULL,
  `iv_noofstudent` int(255) NOT NULL,
  `iv_noofdays` int(255) NOT NULL,
  `iv_department` varchar(255) NOT NULL,
  `iv_contactperson` varchar(255) NOT NULL,
  `inplant_training_possibilitiy` varchar(255) NOT NULL,
  `ipt_noofstudent` int(255) NOT NULL,
  `ipt_noofdays` int(255) NOT NULL,
  `ipt_department` varchar(255) NOT NULL,
  `ipt_contactperson` varchar(255) NOT NULL,
  `projectwork` varchar(255) NOT NULL,
  `pw_noofstudent` int(255) NOT NULL,
  `pw_noofdays` int(255) NOT NULL,
  `pw_department` varchar(255) NOT NULL,
  `pw_contactperson` varchar(255) NOT NULL,
  `guestlecture` varchar(255) NOT NULL,
  `gl_noofstudent` int(255) NOT NULL,
  `gl_noofdays` int(255) NOT NULL,
  `gl_department` varchar(255) NOT NULL,
  `gl_contactperson` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `id` int(255) NOT NULL,
  `staffname` varchar(255) NOT NULL,
  `industryphoneno` int(255) NOT NULL,
  `emailid_website` varchar(255) NOT NULL,
  `nameof_MD_others` varchar(255) NOT NULL,
  `MD_others_phoneno` int(255) NOT NULL,
  `branches` varchar(255) NOT NULL,
  `productionrate` varchar(255) NOT NULL,
  `turnover` varchar(255) NOT NULL,
  `customers` varchar(255) NOT NULL,
  `deportments` varchar(255) NOT NULL,
  `noofemployees` varchar(255) NOT NULL,
  `typeofproduct` varchar(255) NOT NULL,
  `applicationoftheproduct` varchar(255) NOT NULL,
  `enduser` varchar(255) NOT NULL,
  `facilities` varchar(255) NOT NULL,
  `detailsofconsultant` varchar(255) NOT NULL,
  `placement_opportunity` varchar(255) NOT NULL,
  `campus_interview` varchar(255) NOT NULL,
  `interview_contactperson` varchar(255) NOT NULL,
  `purposeofvisit` varchar(255) NOT NULL,
  `industry_experience` varchar(255) NOT NULL,
  `actualdateofvisit` date NOT NULL,
  `industry_distance` varchar(255) NOT NULL,
  `person_met_name` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `noofvisitinsemester` int(255) NOT NULL,
  `noofvisitinyear` int(255) NOT NULL,
  `dateofpresent` date NOT NULL,
  `anyother` varchar(255) NOT NULL,
  `dateofsubmit` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `staffdetails`
--

CREATE TABLE `staffdetails` (
  `StaffId` varchar(10) NOT NULL,
  `StaffName` varchar(50) NOT NULL,
  `DepartmentId` int(11) NOT NULL,
  `Designation` varchar(50) DEFAULT NULL,
  `StaffStatus` int(11) NOT NULL,
  `EmailId` varchar(255) NOT NULL,
  `ContactNo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staffdetails`
--

INSERT INTO `staffdetails` (`StaffId`, `StaffName`, `DepartmentId`, `Designation`, `StaffStatus`, `EmailId`, `ContactNo`) VALUES
('user', 'name', 1, 'des', 1, 'username@domain.com', '1234567890'),
('admin', 'name', 1, 'des', 1, 'username@domain.com', '1234567890');

-- --------------------------------------------------------

--
-- Table structure for table `stafflogin`
--

CREATE TABLE `stafflogin` (
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `StaffID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stafflogin`
--

INSERT INTO `stafflogin` (`username`, `password`, `StaffID`) VALUES
('admin', '97f7cf243618d2a6ae065e8367bf309e', 'admin'),
('user', 'EE11CBB19052E40B07AAC0CA060C23EE', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `industry`
--
ALTER TABLE `industry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `opportunity`
--
ALTER TABLE `opportunity`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `stafflogin`
--
ALTER TABLE `stafflogin`
  ADD UNIQUE KEY `username` (`username`,`password`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `industry`
--
ALTER TABLE `industry`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
