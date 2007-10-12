Message-ID: <470F3B03.1040501@domain.hid>
Date: Fri, 12 Oct 2007 11:14:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470E8BFE.4070804@domain.hid> <1192179524.5149.23.camel@domain.hid>
In-Reply-To: <1192179524.5149.23.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>
Cc: Xenomai-core@domain.hid

Stelian Pop wrote:
> Hi Jan,
>=20
> [taking this on the list after several mails with Philippe...]
>=20
> Le jeudi 11 octobre 2007 =C3=A0 22:47 +0200, Jan Kiszka a =C3=A9crit :
>> This patch for SVN trunk fixes most of the current bugs around hardwar=
e
>> timer takeover and release from/to Linux.
> [...]
>=20
> I have a problem with the timer on my MacBook Pro (Core2Duo, used in
> _32_ bit mode)(*): when Xenomai takes over the timer (at 'modprobe
> xeno_native' time), the Linux timer stops.

Hmm, that's not too different from my own test setup.

>=20
> Looking into /proc/xenomai/irq shows that Xenomai does receive the
> hardware interrupts, and /proc/interrupts shows that they are no longer
> forwarded to Linux. Before loading xeno_native, everything is ok.
>=20
> Linux userspace continues to somewhat work: I can issue commands, and
> depending on the syscalls they made I suppose (no, strace doesn't work)=
,
> sometimes they end correctly sometimes they hang (and I cannot interrup=
t
> them by ^C or other signals.).
>=20
> I tried several .config variations, without any change in behaviour: my
> current test config has SMP, NO_HZ, APIC, PREEMPT, HIRES all disabled).
>=20
> This happens with a 2.6.22.9 kernel, adeos-ipipe-2.6.22-i386-1.10-07,
> xenomai svn HEAD (rev 3050), with or without your current patch. It is
> quite possible that this is not a new problem, since I have this laptop
> since a few weeks only and I never ran Xenomai on it.=20
>=20
> I'll happily provide any further information or test results if you
> need.

/proc/xenomai/timerstat/master may provide further hints about the state
of the host timer (please keep my patch applied for this). Also, you
could take an I-pipe trace around the timer takeover and the following
few milliseconds, using the new trigger feature:

echo rthal_timer_request > /proc/ipipe/trace/trigger

BTW, does the latency test of Xenomai work?

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

