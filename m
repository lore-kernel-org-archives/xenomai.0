Message-ID: <48CE3096.7040502@domain.hid>
Date: Mon, 15 Sep 2008 11:53:26 +0200
From: Harco Kuppens <h.kuppens@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------050800000900050101000500"
Subject: [Xenomai-help] probably error in api document
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
Cc: "hooman >> \"Hooman, J.\"" <Jozef.Hooman@domain.hid>

This is a multi-part message in MIME format.
--------------050800000900050101000500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I noticed in the Xenomai native API that  the longer rt_create_intr :

    int rt_intr_create 
<http://www.xenomai.org/documentation/trunk/html/api/group__interrupt.html#ga0a9d98556ec838008f408a56e79d304> 
(RT_INTR *intr, const char *name, unsigned irq, rt_isr_t isr, rt_iack_t 
iack, int mode)

says in its documentation :

    This service can be called from:

        * Kernel module initialization/cleanup code
        * Kernel-based task
        * *User-space task*

I find it strange that it could be called from a user-space task.
I looked in /usr/xenomai/include/native/intr.h but there it really is 
defined when __KERNEL__ is defined.

So I guess this is an error in the  API documention?

Best Regards,
Harco Kuppens


--------------050800000900050101000500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
I noticed in the Xenomai native API that&nbsp; the longer rt_create_intr :<br>
<br>
&nbsp;&nbsp;&nbsp; int&nbsp;<a class="el"
 href="http://www.xenomai.org/documentation/trunk/html/api/group__interrupt.html#ga0a9d98556ec838008f408a56e79d304">rt_intr_create</a>
(RT_INTR *intr, const char *name, unsigned irq, rt_isr_t isr, rt_iack_t
iack, int mode)<br>
<br>
says in its documentation :<br>
<blockquote>
  <p>This service can be called from:</p>
  <p></p>
  <ul>
    <li>Kernel module initialization/cleanup code</li>
    <li>Kernel-based task</li>
    <li><b>User-space task</b></li>
  </ul>
</blockquote>
I find it strange that it could be called from a user-space task.<br>
I looked in /usr/xenomai/include/native/intr.h but there it really is
defined when __KERNEL__ is defined.<br>
<br>
So I guess this is an error in the&nbsp; API documention?<br>
<br>
Best Regards,<br>
Harco Kuppens<br>
<br>
</body>
</html>

--------------050800000900050101000500--

