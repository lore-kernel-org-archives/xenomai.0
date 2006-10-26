Message-ID: <4540E89F.9060603@domain.hid>
Date: Thu, 26 Oct 2006 18:55:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid>
	<453FC4C0.5070105@domain.hid>	<453FF6AA.6030406@domain.hid>
	<45406FEF.90806@domain.hid>	<4540D998.2090908@domain.hid>
	<4540DACA.2050406@domain.hid> <4540E5E8.9010608@domain.hid>
In-Reply-To: <4540E5E8.9010608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE017CD06FD22C12CC3657ABC"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE017CD06FD22C12CC3657ABC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Gilles Chanteperdrix wrote:
>> Jeff Webb wrote:
>>> Gilles Chanteperdrix wrote:
>>>
>>>> After the first Ctrl-C that does not work, could you try and attach =
gdb
>>>> to see where the threads are stopped ?
>>>
>>>
>>> I tried to do this, but was unable to determine the stopping point
>>> using gdb.
>>
>> type simply: "info threads"
>> then change thread to the main thread with "thread x", where x is the
>> lowest thread id as listed by "info threads"
>> then type: "backtrace"
>=20
> If I try to connect to the process after I press the ctrl-c one time, I=

> get:
>=20
> # gdb --pid=3D2660
> Attaching to process 2660
> warning: The current VSYSCALL page code requires an existing excuitable=
=2E
> [sic]

Then why not trying to provide it?

# gdb switchtest
(gdb) r

> Use "add-symbol-file-from-memory" to load the VSYSCALL page by hand
>=20
> Then the whole machine locks up, and I am forced to reboot.

That's bad. Is the Xenomai watchdog active (if not, this might be some
RT thread running wild)?

Jan


--------------enigE017CD06FD22C12CC3657ABC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFQOifniDOoMHTA+kRArYAAJ9Jd3NKpVeZvJlsgU5GaDPjHhn7eACeLErh
7JjxoAj23FOl+v5tJqyVBcI=
=25RI
-----END PGP SIGNATURE-----

--------------enigE017CD06FD22C12CC3657ABC--

