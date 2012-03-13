Message-ID: <4F5EF2ED.5050001@domain.hid>
Date: Tue, 13 Mar 2012 08:10:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001501ccfcd9$67d9ede0$378dc9a0$@q@domain.hid>
	<4F58788F.5070103@domain.hid>
	<000601ccfdba$c36b8650$4a4292f0$@q@domain.hid>
	<4F59C92B.5080705@domain.hid>
	<001001cd00e3$03565c60$0a031520$@q@domain.hid>
In-Reply-To: <001001cd00e3$03565c60$0a031520$@q@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai stop working
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?6ams5by6?= <ma.q@domain.hid>
Cc: xenomai@xenomai.org

On 03/13/2012 07:32 AM, =E9=A9=AC=E5=BC=BA wrote:
> Hi, Gilles.
>=20
> I could not find "mxc_min_delay =3D 0xff" in linux source tree=20
> and xenomai directory. mxc_min_delay comes from ipipe,=20
> there is also no such statement in latest patch downloaded=20
> from website.
>=20
> If mxc_min_delay is 0xff, in my system this means 32us for 8MHz=20
> ipipe tsc. For a real time system, It seems a little bit longer.
>=20
> I used mxc_min_delay=3D16(2us) to do a test during last weekend,=20
> until now and no stall have happened again. So mxc_min_delay =3D 0x10=20
> maybe enough for my test CPU, I can't decide which value should be used=
=2E

Linux uses a similar mechanism for its clock_event_device named
min_delta_ns. In latest releases min_delta_ns is set such that it
corresponds to 0xff ticks. But you are right: this value is too large
for xenomai.

>=20
> The following code copy from the time.c file that patched by xenomai.
> void __ipipe_mach_set_dec(unsigned long delay)
> {
> 	if (delay > mxc_min_delay) {
> 		unsigned long tcmp;
>=20
> 		if (!timer_is_v2()) {
> 			tcmp =3D __raw_readl(timer_base + MX1_2_TCN) + delay;
> 			__raw_writel(tcmp, timer_base + MX1_2_TCMP);
> 		} else {
> 			tcmp =3D __raw_readl(timer_base + V2_TCN) + delay;
> 			__raw_writel(tcmp, timer_base + V2_TCMP);
> 		}
> 	} else
> 		ipipe_trigger_irq(__ipipe_mach_timerint);
> }
>=20
> My question is whether this function will be interrupted by other high =
priority interrupts.

No, this function is called with hardware irqs off.

--=20
                                                                Gilles.


