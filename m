Message-ID: <454613C5.2090100@domain.hid>
Date: Mon, 30 Oct 2006 16:01:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai revision 1772 on arm
References: <1162218640.4993.5.camel@domain.hid>
In-Reply-To: <1162218640.4993.5.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?=22Schl=E4gl_=5C=22Manfred_jun=2E=5C=22=22?= <manfred.schlaegl@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Schl=E4gl Manfred jun. wrote:
> Hi!
>=20
> Should be a hint, if anyone has similar Problems:
>=20
> Xenomai (rev. 1772) was not running on my platform. (no
> timer_tick-calls; timer stopped)
>=20
> I had to do following downgrade:
>=20
> Index: include/asm-arm/hal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/asm-arm/hal.h       (revision 1772)
> +++ include/asm-arm/hal.h       (working copy)
> @@ -103,10 +103,13 @@
> =20
>  static inline void rthal_timer_program_shot (unsigned long delay)
>  {
> +    if(!delay)
> +        delay =3D 10;
> +    __ipipe_mach_set_dec(delay);
> -    if(!delay)
> -        rthal_trigger_irq(RTHAL_TIMER_IRQ);
> -     else
> -       __ipipe_mach_set_dec(delay);
>  }
> =20
>      /* Private interface -- Internal use only */
>=20
>=20
> It's simply a workaround yet. I'll try to find the error in my
> timer-handling.

You probably have the same problem as PXA, you can not program
the timer for a too short delay, you should handle this in the
implementation of __ipipe_mach_set_dec for your platform, not
in the platform independent code.

--=20
                                                  Gilles Chanteperdrix

