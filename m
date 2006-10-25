From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <E1GcJqn-0000Eo-Lv@domain.hid>
References: <E1Gapzw-0005RB-Ob@domain.hid>
	<E1GcJqn-0000Eo-Lv@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ELq+YiB6Sc7cE/k5ZM9S"
Date: Wed, 25 Oct 2006 15:41:24 +0200
Message-Id: <1161783684.5114.16.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] Re: [Xenomai-core] I-pipe patch for ARM S3C24xx
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


--=-ELq+YiB6Sc7cE/k5ZM9S
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-24 at 12:49 +0200, Sebastian Smolorz wrote:
> > Hi all,
> >
> > I'm currently working on porting I-pipe to the ARM S3C24xx. The patch i=
s
> > attached, it must be applied after the shipped
> > adeos-ipipe-2.6.15-arm-1.5-01.patch. Unfortunately, there is still a se=
vere
> > bug somewhere. I built Xenomai as modules. When I try to modprobe
> > xeno_native, the system hangs. No reaction at all, inlcuding serial con=
sole
> > and network access. I guess that interrupts are not handled any more. F=
rom
> > what I see if I spread some debug printk() into my code, the timer star=
ts
> > working under the control of the Xenomai domain and one or two calls to=
 the
> > Linux timer interrupt handler are made. But after that nothing happens =
any
> > more.
> >
> > As I try to find the bug for some days now but wasn't successful maybe =
the
> > experts have any hints where to continue searching. Or perhaps there is
> > someone who can test it and confirm or disprove my observation? It woul=
d be
> > great to support one more ARM model.
>=20
> Small update with new infos: After Xenomai has (re)started the system tim=
er=20
> the Linux timer interrupt handler ist called only once, but=20
> xnintr_clock_handler() is called several thousand times. So it seems that=
 the=20
> timer interrupt handler of Linux is not properly called or Xenomai is=20
> starving Linux.
>=20
> Sebastian
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

Hi. I had the same Problem on my Netsilicon board.

I changed my timer-clock from CPU_CLK/64 to CPU_CLK so Xenomai is able
to use it with a higher granularity (set_dec/get_dec). So my machine has
1769472 ticks per jiffy instead of 27648. (works only with 32bit timers)

Further I had to set CLOCK_TICK_RATE (/include/asm/arch-xxxx/timex.h) to
real cpu frequency (im my case around 176000000).

Now I'm able to run latency with periods > 200us

	- Manfred

--=-ELq+YiB6Sc7cE/k5ZM9S
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFP2mEbMvu5jIEpfsRAqDwAJ0SbmL+mjvp2l1cccciw/ZwfAa24gCeNrnV
VZvJycuuDcq9lUPy/QCUj/s=
=DsDH
-----END PGP SIGNATURE-----

--=-ELq+YiB6Sc7cE/k5ZM9S--


