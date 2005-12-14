Message-ID: <43A0701F.5090205@domain.hid>
Date: Wed, 14 Dec 2005 14:18:55 -0500
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Moving from 2.0 to 2.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1"><font face="Helvetica, Arial, sans-serif">Hello all,<br>
<br>
I have recently updated my source tree from 2.0.1 to the latest from
trunk. I have run the prepare scripts and xconfig. (I am building a
vanilla 2.6.12 kernel) I can see the new options in the kernel .config
file. I can make and install my new kernel no problem. I then run
configure and rebuild Xenomai, again no problem. After installing
Xenomai I try to build my test application. Here I get link errors.<br>
<br>
I am using the rt_task_send() / rt_task_receive() functions. </font></font><font
 size="-1"><font face="Helvetica, Arial, sans-serif">I see that I need
the CONFIG_XENO_OPT_NATIVE_MPS options in the Xenomai build to include
the task send/recv function. After looking through the source </font></font><font
 size="-1"><font face="Helvetica, Arial, sans-serif">I see that none of
my NATIVE options appear in the xeno_config.h file. These options are
enabled in the kernel .config file.<br>
<br>
What am I missing? I am not an autoconf expert so any advice is
appreciated.<br>
<br>
Sean<br>
<br>
</font></font>
</body>
</html>

