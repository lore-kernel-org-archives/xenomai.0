Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Oct 2007 09:41:42 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0999445@domain.hid>
In-Reply-To: <4717D8AC.8000900@domain.hid>
References: <4717D8AC.8000900@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: Re: [Xenomai-core] LTTng for Xenomai - next round
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid, xenomai-core <xenomai@xenomai.org>

> -----Original Message-----
> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
> Sent: vendredi, 19. octobre 2007 00:06
> To: xenomai-core
> Cc: ROSSIER Daniel
> Subject: LTTng for Xenomai - next round
>=20
> Hi,
>=20
> LTTng is becoming interesting again: Mathieu uploaded a back-port to
> 2.6.23.1 yesterday which is already implementing the scheme that is
> intended to be submitted upstream.
>=20
> What changed for us?
>=20
>  - We now have a recent patch basis for the kernel again.
>=20
>  - The instrumentation process was significantly simplified: No more
>    facility registration, no more probe modules, no more XML file
>    hacking - it's all derived from the trace points now! Some example:
>=20
>    trace_mark(kernel_timer_itimer_expired, "pid %d", sig->tsk->pid);
>               ^----^ ^------------------^   ^----^
>              facility     trace point    argument name
>                name          name          and type
>=20
> I rebased the patches over I-pipe for i386 (see attached patches and
> extended series description), and I also started to rework the Xenomai
> patch. The diffstat of the latter is fairly telling:
>=20
>  include/nucleus/ltt.h   |  111 +---------------------------
>  ksrc/nucleus/Config.in  |    9 --
>  ksrc/nucleus/Kconfig    |   36 ---------
>  ksrc/nucleus/Makefile   |    3
>  ksrc/nucleus/intr.c     |   19 ++--
>  ksrc/nucleus/ltt.c      |  186
---------------------------------------
> ---------
>  ksrc/nucleus/module.c   |    7 -
>  ksrc/nucleus/pod.c      |  102 ++++++++++++++++----------
>  ksrc/nucleus/shadow.c   |   43 +++++++----
>  ksrc/nucleus/synch.c    |   19 +++-
>  ksrc/nucleus/timebase.c |    6 -
>  11 files changed, 125 insertions(+), 416 deletions(-)
>=20
> You see, no more ltt.c, i.e. no more probe module!
>=20
> At this point, we are already able to use the services of "lttv -m
> textDump" or lttv-gui to display traces from Xenomai kernels as event
> lists. Yes, I tried this, and it works! (Hint: Don't forget to ltt-
> armall your trace points before trying to collect data...)
>=20
> Yet to be done:
>=20
>  - Finish the xnltt_log_event refactoring (half done, pod.c is missing
>    yet - with ~30 trace point)
>=20
>  - Port and update the Xenomai extension over latest lttv.
>=20
> Well, I'm not looking for work, I'm looking for workers :). Anyone
> interested and available to help with the open topics? Daniel...?

Sounds very good :-) I will see if we can contribute. Jean-Philippe is
working on a comparison between Xenomai and RTOS-32 for=20
a x86 target system (diploma work) and is currently about to install the
pretty old version (2.6.17) of xenoltt. I will see with him if it makes
sense to migrate to the latest version, at this point of his work.

>=20
> Jan


Daniel

