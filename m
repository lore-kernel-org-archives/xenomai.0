Message-ID: <18326.22441.591044.659440@domain.hid>
Date: Tue, 22 Jan 2008 21:52:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <BAY108-W34CAB388B56804A1404032AF4A0@domain.hid>
References: <BAY108-W34CAB388B56804A1404032AF4A0@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] a propos de xenomai et du skin POSIX
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: valentin brehier <valentinbrehier@domain.hid>
Cc: xenomai@xenomai.org

valentin brehier wrote:
 >=20
 > bonjour,
 >=20
 > (...)
 >=20
 > mon probleme porte sur la m=E9thode clock_settime(). J'ai du mal =E0 bie=
n saisir son comportement et la documentation en ligne n'est pas tr=E8s pr=
=E9cise.
 >=20
 > Mon probl=E8me est donc le suivant: lorsque j'appel cette m=E9thode, l'h=
orloge syst=E8me Xenomai est bien modifi=E9, mais pas l'horloge syst=E8me L=
inux. De ce fait je ne peut pas utiliser hwclock pour mettre =E0 jour l'heu=
re de la RTC. je dois rester compatible POSIX, il me faut donc une solution=
 pour mettre =E0 jour la RTC =E0 l'aide du skin POSIX, ce que je n'ai pas t=
rouv=E9.
 >=20
 > Pour information j'utilise une carte ETX qui ne poss=E8de pas le support=
 LAPIC, le timer Xenomai utilise donc la m=EAme IRQ (0) que Linux.
 >=20
 > dans l'attente de votre r=E9ponse, cordialement,

For other readers on this list who do not read french, your problem is
that clock_settime sets Xenomai clock but does not set Linux clock. Then
you talk about setting the RTC.

First, you need to understand that the RTC and Linux system clock are
two different things: the RTC may be used to set Linux system clock
when running hwclock or the NTP daemon. But once it is done, Linux clock
continues its own course.

Xenomai has yet another clock, it is synchronized with Linux clock when
starting Xenomai. This scheme works when Xenomai is compiled as a
module, because loading Xenomai modules usually happens once Linux
system clock is set (using hwclock or ntp) by some boot scripts. But this
scheme does not work when Xenomai is built in Linux kernel, because
Xenomai startup occurs way before Linux clock is set.

So, what I would advise is to write a little tool (actually, I think
this tool could even be part of the tools installed with Xenomai) to
set-up Xenomai clock from Linux clock, this is as simple as running
__real_clock_gettime and clock_settime. You would then run this tool in
a boot script after Linux clock is set by hwclock or ntpd.

Regards.

--=20


					    Gilles Chanteperdrix.

