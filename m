Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 24 Jan 2008 10:32:06 -0500
Message-ID: <BF58A8AFB316514587D61EADBFBF4C4101746780@domain.hid>
In-Reply-To: <47985F53.8010603@domain.hid>
From: "Kyle Howell" <khowell@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] x86_64 user/system process accounting
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
Cc: xenomai-help <xenomai@xenomai.org>

> Jan Kiszka wrote:
> >>>>>> Kyle Howell wrote:
> >>>>>> I'm running Xenomai 2.4.1 against Linux 2.6.23.12 on an
> >>>>>> x86_64 (Core2)
> >>>>>> system. I'm finding that all of my CPU cycles are being=20
> >>>>>> accounted as kernel time rather than user time. The correct=20
> >>>>>> processes are still billed, but the system is always 0% user.=20
>=20
> And here comes a fix:
>=20
> In rthal_timer_set_oneshot() we assume that the hijacked APIC=20
> timer will also be used to for emulating host ticks, thus=20
> __ipipe_tick_irq is set accordingly. But this is not true for=20
> x86-64 over non-clockevent kernels (2.6.23...), so we have to=20
> fixup __ipipe_tick_irq with the correct number (first patch).

cat /proc/stat
cpu  9562 0 418 166028 12 0 2 0
cpu0 1208 0 118 20706 0 0 0 0=20

Ahh... That feels much better. Thanks a lot, Jan. I think that would
have taken me a long, long time to find on my own. BTW, I hope that you
didn't stay up until 5 in the morning on my account.

--
Kyle Howell

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
This email and any files transmitted with it are
confidential and intended solely for the use of the
named recipient or recipients.  If you have received
this email in error please notify the sender
immediately. =20

