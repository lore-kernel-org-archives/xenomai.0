Subject: Re: [Xenomai-help] timer-handling adeos/xenomai on arm
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17749.44672.200334.645300@domain.hid>
References: <1162810995.5144.20.camel@domain.hid>
	<17749.44672.200334.645300@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 11 Nov 2006 12:39:35 +0100
Message-Id: <1163245175.5765.218.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Sat, 2006-11-11 at 12:05 +0100, Gilles Chanteperdrix wrote:
> Schl=E4gl "Manfred jun." wrote:
>  > Hi again!
>  >=20
>  > I've the presumption, there is something wrong with my timer-handlin=
g.
>  > Could you please take a look at my handling.
>  >=20
>  > Thanks in advance!
>=20
> The problem I see with your code is that you are updating
> ns_timer_lxlost in __ipipe_mach_acktimer, the integrator architecture
> code, which also uses a decrementer does not do that. Apart from that, =
I
> see nothing wrong.
>=20
> If there is a problem with using ipipe_trigger_irq on your architecture=
,
> maybe we could let rthal_timer_program_shot pass null delays to
> __ipipe_mach_set_dec.


Maybe the issue is not with ipipe_trigger_irq, which looks ok for ARM
too, but rather with the internal latency/timings of the Xenomai port
over this arch? The very difference between calling ipipe_trigger_irq
and programming the decrementer for a close shot, is that interrupt
delivery would happen immediately after the interrupt mask is enabled
again with the former method. OTOH, the latter would likely leave some
time left to the nucleus to get out of the current IRQ, thus preventing
recursion-induced lockups.

--=20
Philippe.



