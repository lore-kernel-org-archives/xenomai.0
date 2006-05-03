Message-ID: <44589A3E.3020802@domain.hid>
Date: Wed, 03 May 2006 07:55:42 -0400
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060005020100060400030800"
Subject: [Xenomai-help] Which kernel features to enable/disable?
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
--------------060005020100060400030800
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
I am configuring a new PC for Xenomai 2.1 with a 2.6.16 kernel. In the
past I have always used a vanilla kernel in the default configuration.
I was wondering what features are recommended to enable or disable in
the default kernel configuration? For example I know to enable the SMI
workaround if the chipset supports it.<br>
<br>
What about SMP?<br>
Kernel pre-emption?<br>
Power management ACPI/APM/frequency scaling?<br>
<br>
Or, are all these irrelevant because Xenomai sits ahead of the kernel
in the interrupt pipeline?<br>
<br>
I had this thought because my new motherboard supports hyper-threading
and the vanilla kernel build includes SMP support.<br>
<br>
Thanks,<br>
Sean<br>
</font></font>
</body>
</html>

--------------060005020100060400030800
Content-Type: text/x-vcard; charset=utf-8;
 name="smm.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="smm.vcf"

begin:vcard
fn:Sean McGranaghan
n:McGranaghan;Sean
org:Appcon Group
adr;dom:;;97 Ridgeland Rd;Rochester;NY;14623
email;internet:smm@domain.hid
title:Embedded Software Engineer
tel;work:585-472-7830
tel;fax:585-472-2116
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------060005020100060400030800--

