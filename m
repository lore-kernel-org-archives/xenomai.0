Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 1 Feb 2011 10:23:48 +0100
Message-ID: <3FF315C710820E47A04E55C6F7D9B0AD5F32DD@AREXCH02.mra.roland-man.biz>
In-Reply-To: <4D46CB77.5000004@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD5F3244@domain.hid>
	<4D46CB77.5000004@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] CONFIG_XENO_OPT_SELECT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

> This looks strange. Each call to select should result in a call to
> Xenomai "select" syscall, if you are using the POSIX skin, which =
should
> return -ENOSYS, then select should call the glibc select. Since
> obviously what you want is to call glibc select directly, you can try
> calling __real_select instead.

Indeed we replaced the "select"-call by a "poll"-call and the problem =
astonishingly disappeared (or it just shifted).
Perhaps this is a hint what=C2=B4s going wrong? Perhaps a __real_select =
would work too. I will try this, as soon as we can reproduce the effect =
in office (at the moment problem occurs only at customer).
Just to understand things right: Xenomai-select returns ENOSYS as the =
option  CONFIG_XENO_OPT_RTDM_SELECT isn=C2=B4t set? =
(CONFIG_XENO_OPT_POSIX_SELECT isn=C2=B4t available in 2.4.9, at least in =
my config-file).  What would happen when CONFIG_XENO_OPT_RTDM_SELECT was =
set?

>=20
> Note that the issue with priorities you observe show that you have a
> task with a priority higher than 0 using a glibc syscall, thereby
> causing it to switch to secondary mode. The fact that lower priority
> threads do not run is the effect of the "priority coupling", but the
> real issue here is that a task with real-time priority is using a =
linux
> syscall, which is something you should normally avoid.
>=20

But isn=C2=B4t this  the idea with "priority coupling", that the kernel =
is executed with realtime task priority? What should "priority coupling" =
be good for, when I have to avoid linux sys-calls? And, as Philippe =
wrote, the realtime task blocks as soon as the linux sys-call blocks and =
so the other realtime tasks get CPU again.
Did I misunderstood something?

Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

