Message-ID: <43908B71.9070805@domain.hid>
Date: Fri, 02 Dec 2005 18:59:13 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xeno-trunk on 2.4.32 - rt_timer_start/rt_task_sleep
	problem
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

Hi all!

I've checked out Xeno trunk a few hours ago and compiled it
with 2.4.32 (ipipe for 2.4.31 applies fine).

Testsuite runs fine, but one of my basic examples
http://www.captain.at/rtai-fusion-timer-task.php
( timer.c =~ s/#include <rtai/#include <native/g; )
does not behave like it should.

It compiles fine, but there is something fishy in either
rt_timer_start or rt_task_sleep, cause the messages from
the "testtask" are flooding my screen, instead of printing
one every second.
That example worked fine in 2.1 as of NOV, 6th, 2.0 and
fusion 0.8.2, so I don't assume it's a bug in my code ?

Thanks & best regards,
Hannes.

