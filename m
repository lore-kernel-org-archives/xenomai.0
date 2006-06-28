Message-ID: <44A23B66.7070202@domain.hid>
Date: Wed, 28 Jun 2006 10:18:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 2/6] Improve fault report
References: <20060626172116.019532000@domain.hid>	
	<20060626172118.347530000@domain.hid>
	<1151480559.5154.2.camel@domain.hid>	 <44A234F9.9010705@domain.hid>
	<1151481889.5154.14.camel@domain.hid>
In-Reply-To: <1151481889.5154.14.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D4DDBE0EE57EF709294667A"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D4DDBE0EE57EF709294667A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-06-28 at 09:51 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2006-06-26 at 19:21 +0200, jan.kiszka@domain.hid wrote:
>>>> plain text document attachment (enhance-kernel-fault-report.patch)
>>>> Introduce xnarch_fault_um() to test if a fault happened in user-mode=
 and applies the new feature to report core and driver crashes more verbo=
sely.=20
>>>> 	if (xnpod_shadow_p()) {
>>>>  #ifdef CONFIG_XENO_OPT_DEBUG
>>>> -		if (xnarch_fault_notify(fltinfo))	/* Don't report debug traps */
>>>> +		if (!xnarch_fault_um(fltinfo)) {
>>>> +			xnarch_trace_panic_freeze();
>>> KGDB breakpoint issue?
>> Sorry, please switch on verbose mode, didn't get yet what you mean.
>=20
> Oops, sorry. I meant: what if a KGDB breakpoint is hit from kernel spac=
e
> while running a shadow thread? The way I read the modified test sequenc=
e
> above, such bp trap is going to trigger a panic, instead of being
> silently passed to Linux.

I would say: KGDB will not come along here with a breakpoint. It should
already got involved in __ipipe_divert_exception().

Jan


--------------enig2D4DDBE0EE57EF709294667A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEojtmniDOoMHTA+kRAjz0AJ9Um2wDhMZTXi1BLzfEr6Z7fmiJpgCdFJ8v
wHM3wU7Y6teCgxQOK2QHYbA=
=SbCo
-----END PGP SIGNATURE-----

--------------enig2D4DDBE0EE57EF709294667A--

