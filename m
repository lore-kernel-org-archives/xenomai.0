Message-ID: <44FEF99B.5000900@domain.hid>
Date: Wed, 06 Sep 2006 18:38:51 +0200
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Segfault inb
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

Hi,

There must be something very obvious I'm missing, yet I don't know why 
and I'm stuck.

I've got a very simple program that starts a simple periodic task that 
reads from port 0x281 at 2KHz. When the inb(0x281) is executed my 
program segfaults. If I comment that code, everything works fine (the 
periodic task executes as expected).

In my initialization code, I've remembered to:

iopl(3)
mlockall(MCL_CURRENT | MCL_FUTURE)
rt_misc_get_io_region

Even tried to issue the iopl(3) again from the periodic task itself. No way.

I'm using kernel 2.6.17.11 and Xenomai v2.2.2.



Regards.

