Message-ID: <465337AC.8030003@domain.hid>
Date: Tue, 22 May 2007 20:34:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46180AB8.3000905@domain.hid>	<46516A6A.9030007@domain.hid>	<200705211456.12330.paul_c@domain.hid>	<200705221803.51512.paul_c@domain.hid>
	<46532428.9010404@domain.hid>
In-Reply-To: <46532428.9010404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig00E68FF54C9DD90B7719B2DA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai Live CD
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig00E68FF54C9DD90B7719B2DA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Paul wrote:
>> [a few days later]... One minimal Live CD based on Morphix is now avai=
lable.=20
>=20
> Cool!
>=20
>> It uses a 2.6.20.11 kernel patched with Xenomai trunk (r2456) and comp=
iled=20
>> for a generic 586..
>=20
> Nice, the bleeding edge. :)
>=20
>>  At a little under 46Meg, it includes a minimal Linux install along wi=
th the=20
>> Xenomai test utilities - Can be used as a basis for a full blown live =
CD.
>=20
> Your internet link is sloooow (60KByte/s at best), guess we should
> mirror the final version on a faster server then.
>=20
>> Available from http://zathras.tuxcnc.org/xenomai-live.iso
>=20
> Currently downloading, will then give it a try under some VM, expect
> feedback later.

 o less: command not found -- mhm, I personally like this tool a lot.

 o killall: command not found -- mhmmmm.

 o Kernel is configured with SMP and comes with the I-pipe tracer. Hope,
   no one does benchmarks :). Having separate kernels would be nice on
   the long term (e.g. a debugging kernel with all stuff on).

 o The SMI work-around is off -- same as above, might be a benchmark
   killer. That makes me wonder if we shouldn't export this knob as a
   module parameter for xeno_nucleus...

 o Benchmarks: please include the cache calibrator as non-RT load.

 o No dhcpcd, thus only manual network setup. I would fire up dhcp by
   default.

 o No ssh(d), thus no remote login.

[o What about stuffing RTnet on the CD as well? Default off, the user
   may tweak the setup manually then once the system is running. We had
   such a request recently on the RTnet list.]

 o We need the Xenomai logo somewhere. :)

I would surely find more, but I better stop playing for now.

Thanks for your effort!
Jan


--------------enig00E68FF54C9DD90B7719B2DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGUzesniDOoMHTA+kRAqfJAJ4p2Qa7B3C/T2SUKi4esSkpZLBT/QCeMS2d
1RKXfehCy0Nq9KtdM5CY/b8=
=xbEc
-----END PGP SIGNATURE-----

--------------enig00E68FF54C9DD90B7719B2DA--

