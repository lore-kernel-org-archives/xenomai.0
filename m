Message-ID: <467F5CBF.9040108@domain.hid>
Date: Mon, 25 Jun 2007 08:12:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>	
	<467D0684.7030604@domain.hid> <1182623858.6000.139.camel@domain.hid>	
	<467E2E9C.90905@domain.hid> <1182708919.7044.201.camel@domain.hid>
In-Reply-To: <1182708919.7044.201.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5704BFFAF14318EA740435B1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5704BFFAF14318EA740435B1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ok, I think it's time to summarise some results of this thread:

 - xntimers will be of three kinds: real-time absolute, monotonic
   absolute, and monotonic relative ones (ie. all POSIX). I'm currently
   in favour of passing this property on timer start and not pushing
   parts or more of it into timer init.

 - XNTBISOL will be introduced, a flag that, if set, declares a time
   base being isolated from the master base (and associates). In my
   understanding, this flag should be passed to xntbase_alloc and should
   also leave the wallclock offset initially untouched again.

 - On xntbase_adjust_time, first define the set of affected time bases:
   if XNTBISOL is set, only touch the passed base, if it is not set,
   change all bases in the system that have it cleared as well. For this
   set of time bases, modify the offset and adjust all running real-time
   timers.

 - Make all legacy RTOS skins isolated by default again, but offer a
   runtime or compile-time switch to add them individually to the gang
   of synchronised time bases (i.e. POSIX, native, RTDM).

Did I get it correctly?

Jan


--------------enig5704BFFAF14318EA740435B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGf1zIniDOoMHTA+kRArFUAJ4x0T99NkTIpMiy4G/xMzd7cuzQeACfXjr6
+Huin6edw0hsQtr8Z2+itrQ=
=jFI3
-----END PGP SIGNATURE-----

--------------enig5704BFFAF14318EA740435B1--

