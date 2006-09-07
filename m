Message-ID: <45007B5B.9010000@domain.hid>
Date: Thu, 07 Sep 2006 16:04:43 -0400
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010007080307040502060207"
Subject: [Xenomai-help] Low-level isr in ADEOS/RTDM
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

This is a multi-part message in MIME format.
--------------010007080307040502060207
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1"><font face="Helvetica, Arial, sans-serif">Hello all,<br>
<br>
I am having an issue with a "lost" interrupt in an RTDM driver. </font></font><font
 size="-1"><font face="Helvetica, Arial, sans-serif">This is a long
story so I will try to summarize:</font></font><br>
<font size="-1"><font face="Helvetica, Arial, sans-serif"><br>
Hardware description -<br>
I have a Geode2 based PC/104 stack with CAN and ADC/DAC cards. The
motherboard implements a standard XT-PIC in its super io. The system is
running Xenomai 2.2.1 with a Gentoo&nbsp; Linux 2.6.17 kernel. There are
several external devices on the CAN bus to load the bus with traffic.<br>
<br>
Software description -<br>
I have two RTDM drivers that provide simple ioctl() interfaces to the
application. One driver supports two CAN controllers. (PCAN/SJA1000. I
implemented this driver many months before RTCAN was available. Sorry I
couldn't wait, paying customer and all. ;-) The other driver supports a
ADC/DAQ card. The application runs several Xenomai tasks using message
queues for communication.<br>
<br>
Failure Description -<br>
The application starts. I can see IRQ lines being raised and lowered as
interrupts are handled. The application runs normally. After about one
or two minutes depending on the bus load,</font></font><font size="-1"><font
 face="Helvetica, Arial, sans-serif"> I "lose" the IRQ15 interrupt.
My interrupt service routine is never called and the interrupt chain is
broken for that device. I have traced the IRQ lines from the devices on
the oscilloscope and see that the
IRQ goes high, but is never acknowledged. (See attached. I added labels
to each trace.) This failure is sporadic and seems to depend on all
three devices generating interrupts in the system.<br>
</font></font><br>
<font size="-1"><font face="Helvetica, Arial, sans-serif">Theory -<br>
The interrupt is never acknowledged because the PIC did not notify the
processor or software never acknowledged the PIC.<br>
<br>
Testing approach -<br>
I need to determine if the hardware or software has lost the interrupt.
I would tend to suspect software first so I decided to start there. I
am using the parallel port pins as GPIO output and trying to instrument
the low-level ADEOS/Xenomai interrupt handling. If I catch the
interrupt soon enough in the interrupt pipeline I can determine that
some software issue is preventing my isr from running. If no interrupt
ever occurs then I can suspect the hardware.<br>
<br>
Assumptions -<br>
ADEOS/Xenomai/RTDM catches the interrupt and propagates it to my isr.
If my isr is the first level interrupt handler I am out of luck.<br>
<br>
Any thoughts or suggestions are appreciated.<br>
<br>
Thanks,<br>
Sean<br>
<br>
<br>
<br>
</font></font>
</body>
</html>

--------------010007080307040502060207
Content-Type: image/png;
 name="TEK00001.PNG"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="TEK00001.PNG"

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
--------------010007080307040502060207
Content-Type: text/x-vcard; charset=utf-8;
 name="smm.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="smm.vcf"

begin:vcard
fn:Sean McGranaghan
n:McGranaghan;Sean
org:The Appcon Group, Inc.
adr;dom:;;97 Ridgeland Rd;Rochester;NY;14623
email;internet:smm@domain.hid
title:Embedded Software Engineer
tel;work:585-427-7830
tel;fax:585-427-2116
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------010007080307040502060207--

