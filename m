From: Tim Niemeyer <tim.niemeyer@corscience.de>
In-Reply-To: <50CC6730.6060308@xenomai.org>
References: <1355499196.2190.23.camel@herbert.er.corscience.de>
	<50CC6730.6060308@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 Dec 2012 09:14:13 +0100
Message-ID: <1355732053.2205.38.camel@herbert.er.corscience.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Question about IPIPE_IRQF_NOSYNC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

Am Samstag, den 15.12.2012, 13:04 +0100 schrieb Gilles Chanteperdrix:
> The latest Adeos is the core-3.4 branch from the git.denx.de/ipipe.git
> repository, not the 'for-core-3.4' branch from the
> git.xenomai.org/ipipe-gch.git.
Ah, thanks for clearing up.

> Anyway, you can not use Xenomai 2.6.1 with linux 3.4, you also have to
> use xenomai from its git repository git.xenomai.og/xenomai-2.6.git
It's working here fine. Why do you expect, that Xenomai 2.6.1 and linux
3.4 won't work together?

I'm using 'for-core-3.4' branch from git.xenomai.org/ipipe-gch.git with
Linux 3.4.14. I just build a big diff from 'for-core-3.4' against 3.4.6
and applied this on my 3.4.14. Then i took all the kernel-src files and
Kconfig changes from xenomai-2.6.1.tar.bz2 and build again a patch.
I use simple patches as they are easier for me to maintain in ptxdist.

> > While hunting a gpio-irq latency i tried to understand the adeos chai=
ned
>=20
> How high a latency are we talking about?
The latency was about ~11=C2=B5s. I then found out, that the cpu clock wa=
sn't
the full 600MHz. I changed this and now the gpio-irq latency is about
~7=C2=B5s. In contrast, the timer-irq latency is less than 3=C2=B5s.
But when i use IPIPE_IRQF_NOSYNC the gpio-irq latency rises to ~14=C2=B5s=
.
But on the other hand the switch between gpio-irq and timer-irq is
faster with IRQF_NOSYNC. It takes ~3=C2=B5s and without IRQF_NOSYNC is ta=
kes
~7=C2=B5s.

> Anyway, the way we track down this kind of issues is the I-pipe tracer.
> http://www.xenomai.org/index.php/I-pipe:Tracer
>=20
> You will have to trigger the freeze yourself if you find a too high lat=
ency.
It's a great tool. I played a bit with the tracer, but 11=C2=B5s is very
short, so it's difficult.

--=20
Tim Niemeyer

Corscience GmbH & Co. KG
Henkestr. 91
D-91052 Erlangen
Germany

e-mail: tim.niemeyer@corscience.de
Internet: www.corscience.de


