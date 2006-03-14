Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Mar 2006 16:50:35 -0500
Message-ID: <067C9A1F6AFEB643895EA4513E116884178FBD@exfp1.Railpowertech.local>
From: "Moser, Dan" <DMoser@domain.hid>
Subject: [Xenomai-help] xenoami task pids
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

I am a Linux and Xenomai newbie.

I have two separate Xenomai 2.1-rc4 environments, one I built with
Gentoo running under VMware (WindowsXP Host) and another (that somebody
else built sometime in the recent past) with Gentoo running native on a
PC.

I have identical code (and Makefile) that simply executes an
rt_task_create(), rt_task_set_periodic(), and rt_task_start() and runs
(seemingly) proper on both boxes.

But:

On one box, the main thread and the Xenomai task thread have DIFFERENT
pids (reported via a call to getpid()).  On the other box, the main
thread and the Xenomai task thread have the SAME pid (again, reported
via a call to getpid()).

Is there some sort of Xenomai and/or application config/build option
that controls this behavior?

Thanks in advance,
Dan

