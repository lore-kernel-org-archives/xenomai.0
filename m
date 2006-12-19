Message-ID: <4587B287.2060603@domain.hid>
Date: Tue, 19 Dec 2006 10:36:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native leads...
References: <358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
In-Reply-To: <2579704.1166520394117.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFE1293853D9C594AECD6160D"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE1293853D9C594AECD6160D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi!
>=20
> It was the compiler!!! Using gcc-3.3 solved the issue.
> That means, that somehow gcc-4.1.2 must not be used with Xenomai curren=
tly...

OK, this needs some examination then. Can anyone reproduce this issue?
/me is currently lacking the compiler.

> =20
> This allowed me to catch the system hang I was hunting for since yester=
day...
> And I got it.
> I write the information I found on the console (I have not tried with c=
onsole redirection yet...).
> CPU 0, eip c010122d
> EIP 0060:[<c010122d>]
> EFLAGS 00000246
> EIP is at mwait_idle_with_hints+0x2c/0x2e
> eax:0 ebx:c0498000 ecx:0 edx:0
>=20
> Call Trace
> mwait_idle+0x0/0x2e
> mwait_idle+0x1d/0x2e
> cpu_idle+0x44/0x86
> start_kernel+0x1f1/0x1f5
> unknown_bootoption+0x0/0x191

Well, this caught your box in the idle loop - not that informative yet.
We must probably look beyond the last context switch. Please switch on
the I-pipe tracer (kernel hacking -> I-pipe debugging) and configure
back_trace_points to, hmm, say 200. On NMI alarm, we should then see a
function call trace.

>=20
> I'll try to reproduce the same with console redirection, however, I hop=
e this could help already!
>=20
> Regards
>=20
> Mathias

Thanks for your effort,

Jan


--------------enigFE1293853D9C594AECD6160D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFh7KHniDOoMHTA+kRAokAAJwILigoTD2Gcapa6qClobGPEdgwdwCdHP89
x+cIDZhIclFFuJ7KPbtkhrg=
=AnZv
-----END PGP SIGNATURE-----

--------------enigFE1293853D9C594AECD6160D--

