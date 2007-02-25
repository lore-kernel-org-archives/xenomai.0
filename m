Message-ID: <45E1E028.2000803@domain.hid>
Date: Sun, 25 Feb 2007 20:14:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] x86_64 - Initial results.
References: <200702241526.22786.paul_c@domain.hid>
	<200702251557.19205.paul_c@domain.hid> <45E1B345.4050304@domain.hid>
	<200702251842.25248.paul_c@domain.hid>
In-Reply-To: <200702251842.25248.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig395D1D85BE703392EF18CF49"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig395D1D85BE703392EF18CF49
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> On Sunday 25 February 2007 16:03, Jan Kiszka wrote:
>>>  The attached trace logs provide little information - Also included d=
mesg
>> One more try please: we also need CONFIG_IPIPE_TRACE_MCOUNT.
>=20
> With both CONFIG_IPIPE_TRACE_MCOUNT and CONFIG_IPIPE_TRACE_VMALLOC enab=
led,=20
> the system auto-reboots as soon as the kernel starts to uncompress. Dis=
abling=20
> the latter restores normal service.

Are we still tracing too early during boot? Probably worth a qemu/gdb
session.

>=20
> On Sunday 25 February 2007 16:09, Gilles Chanteperdrix wrote:
>> Option "NoAccel"
>=20
> Results are still the same - Latency goes to pot and hangs as soon as X=
 starts=20
> up. Quite likely the offending trace isn't getting logged..
>=20
>=20

=2E..

> -----------------------------------------------------------------------=
-
>=20
> I-pipe frozen back-tracing service on 2.6.19.3-xenomai/ipipe-1.0-04
> ------------------------------------------------------------
> Freeze: 434598593698 cycles, Trace Points: 30 (+100)
> Calibrated minimum trace-point overhead: 0.037 us
>=20
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- <unused>
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)=

>  |||||                        +---------- Delay flag ('+': > 1 us, '!':=
 > 10 us)
>  |||||                        |        +- NMI noise ('N')
>  |||||                        |        |
>       Type    User Val.   Time    Delay  Function (Parent)
> :|  +*func                -244+   6.981  __ipipe_handle_irq+0x21 (commo=
n_interrupt+0x78)
> :|  +*func                -238+   6.956  __ipipe_ack_apic+0x9 (__ipipe_=
handle_irq+0x87)
> :|  +*func                -231+   7.615  __ipipe_dispatch_wired+0xc (__=
ipipe_handle_irq+0x91)
> :|  #*func                -223+   6.951  xnintr_clock_handler+0x9 (__ip=
ipe_dispatch_wired+0x94)
> :|  #*func                -216+   7.210  xnintr_irq_handler+0x21 (xnint=
r_clock_handler+0x1b)

Given these *huge* latencies for that simple functions, we are may face
some CPU frequency screw (though scaling is switched off?). Something
must disturb the tsc->ns conversion. Maybe this is actually no latency
real issue...

Jan


--------------enig395D1D85BE703392EF18CF49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4eApniDOoMHTA+kRAqwjAJ9nIYXyk09LrkIsxSBEverd+sWxvQCeM1lV
xkrLtipBKdjS8PDuR49EQPg=
=FHLl
-----END PGP SIGNATURE-----

--------------enig395D1D85BE703392EF18CF49--

