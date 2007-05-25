Message-ID: <4656EE0C.8090301@domain.hid>
Date: Fri, 25 May 2007 16:09:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4656E62F.3090603@domain.hid> <4656E887.7040406@domain.hid>
	<4656EABD.60601@domain.hid>
In-Reply-To: <4656EABD.60601@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig75702BA61F233D2F8A10298D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] recursive fault on cyclictest termination
 --	scalable sched?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75702BA61F233D2F8A10298D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> People, we have some new troubles:
>>>
>>> I'm reproducibly getting recursive faults on termination of cyclictes=
t
>>> via ^C. It's all standard here: ipipe 1.8-02, Xenomai trunk #2469, no=

>>> weird patches of mine.
>>>
>>> Something goes utterly wrong, the debugger currently points into
>>> xnshadow_relax->rpi_push, and there into some queuing operation. Note=

>>> that I have XENO_OPT_SCALABLE_SCHED on in my config, also
>>> XENO_OPT_PRIOCPL. Without XENO_OPT_SCALABLE_SCHED, things seems to wo=
rk
>>> find. Who did last work on this? What was fixed?
>> Looking at svn log, you did the last modification. What about activati=
ng
>> queue debugging ?
>>
>=20
> Well, I remember that 64-bit issue now, but it was my patch IIRC.
                                                   ^^^not
(hell, I need the weekend)


--------------enig75702BA61F233D2F8A10298D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVu4MniDOoMHTA+kRAv7UAJ95hBy5Qe17icE1v8zJKCfsNVOniACfXh6p
yL+c88dLTjC516r0zVy3x9U=
=FSHA
-----END PGP SIGNATURE-----

--------------enig75702BA61F233D2F8A10298D--

