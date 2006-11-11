From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] timer-handling adeos/xenomai on arm
Date: Sat, 11 Nov 2006 12:52:13 +0100
References: <1162810995.5144.20.camel@domain.hid>
	<17749.44672.200334.645300@domain.hid>
In-Reply-To: <17749.44672.200334.645300@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200611111252.13782.Sebastian.Smolorz@domain.hid>
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

Gilles Chanteperdrix wrote:
> Schl=E4gl "Manfred jun." wrote:
>  > Hi again!
>  >
>  > I've the presumption, there is something wrong with my timer-handling.
>  > Could you please take a look at my handling.
>  >
>  > Thanks in advance!
>
> The problem I see with your code is that you are updating
> ns_timer_lxlost in __ipipe_mach_acktimer, the integrator architecture =20
> code, which also uses a decrementer does not do that. Apart from that, I
> see nothing wrong.

I see another one which has to do with the fact that __ipipe_mach_tsc is=20
updated both in __ipipe_mach_get_tsc and __ipipe_mach_set_dec. This leads t=
o=20
double-added ticks because the latter funcion is called only once a period=
=20
and the former even more than once. So Xenomai counts jiffies=20
in /proc/xenomai/timer to fast. Manfred, can you confirm this?

Sebastian

