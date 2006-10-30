Date: Mon, 30 Oct 2006 16:12:36 +0100 (MET)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] xenomai revision 1772 on arm
In-Reply-To: <1162218640.4993.5.camel@domain.hid>
Message-ID: <Pine.GSO.4.64.0610301611060.6748@domain.hid>
References: <1162218640.4993.5.camel@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1162221156=:6748"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "=?ISO-8859-1?Q?Schl=E4gl?= Manfred jun." <manfred.schlaegl@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-851401618-1162221156=:6748
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	studserv.stud.uni-hannover.de id k9UFCcMF009130

On Mon, 30 Oct 2006, Schl=E4gl Manfred jun. wrote:

> Should be a hint, if anyone has similar Problems:
>
> Xenomai (rev. 1772) was not running on my platform. (no
> timer_tick-calls; timer stopped)
>
> I had to do following downgrade:
>
> Index: include/asm-arm/hal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/asm-arm/hal.h       (revision 1772)
> +++ include/asm-arm/hal.h       (working copy)
> @@ -103,10 +103,13 @@
>
> static inline void rthal_timer_program_shot (unsigned long delay)
> {
> +    if(!delay)
> +        delay =3D 10;
> +    __ipipe_mach_set_dec(delay);
> -    if(!delay)
> -        rthal_trigger_irq(RTHAL_TIMER_IRQ);
> -     else
> -       __ipipe_mach_set_dec(delay);
> }
>
>     /* Private interface -- Internal use only */
>
>
> It's simply a workaround yet. I'll try to find the error in my
> timer-handling.

What is your timer operation mode? Free-running or counting down and=20
aperiodic?

Sebastian
---559023410-851401618-1162221156=:6748--

