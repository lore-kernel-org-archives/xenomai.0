Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 May 2010 17:48:25 -0500
Message-ID: <181804936ABC2349BE503168465576460EBD6778@domain.hid>
In-Reply-To: <4BF1794A.6050207@domain.hid>
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
	<4BF1794A.6050207@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, "Mauerer, Wolfgang" <wolfgang.mauerer@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>

> Yes, that's expected: If gettimeofday runs syscall-less, it=20
> tries to read the time offset from a page which the Linux=20
> kernel updates regularly. When user-space detects an ongoing=20
> update, it spins until that has completed. But as Xenomai=20
> runs the task with higher priority than the Linux update=20
> handler, you just ran into a live-lock.
>=20
> Switching on the Xenomai watchdog will confirm this: It will=20
> shoot that task, and the system will recover.
>=20
> Jan
>=20
> --
> Siemens AG, Corporate Technology, CT T DE IT 1 Corporate=20
> Competence Center Embedded Linux
>=20

I'm not all too familiar with the time handling in the kernel.  If you
have any refernces that help me better follow your explanation that
would be appreciated.

If you linked against the POSIX skin it would then seem there is no safe
way of calling gettimeofday.  Even starting from main in this case is a
real time task.  In this case I would think that gettimeofday should be
either wrapped to force a mode change before calling
__real_gettimeofday, or should somehow be expressly forbidden.

Even more of a problem is how I am supposed to know which calls are
similar to this.  I would expect I could call any Linux service without
causing a deadlock/livelock situation, although in a nondeterministic
manner.  If I understood your explanation correctly, this is hanging
whenever the Xenomai task tries to spin on the same lock as the kernel.
However, I don't see how this is not a problem in general for acquiring
any spinlock from a Xenomai task.  I would expect once you introduce a
priority based scheduler any spinlock becomes unsafe.


