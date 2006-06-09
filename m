Message-ID: <44897763.5080902@domain.hid>
Date: Fri, 09 Jun 2006 15:28:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai: binding failed: Operation not permitted.
References: 446C264A.7040206@domain.hid>	<200605181426.8240@domain.hid>	<446C6C1C.2010902@domain.hid>	<200605190943.31667@domain.hid>	<446D7DE6.10402@domain.hid>	<44859D3F.50800@domain.hid>
	<44858228.40508@domain.hid>	<448696E8.10405@domain.hid>
	<44869F86.4090106@domain.hid>
In-Reply-To: <44869F86.4090106@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5D998C6C8F0D4D1323FACD00"
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
To: "s.a." <sancelot@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5D998C6C8F0D4D1323FACD00
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> s.a. wrote:
>> Hi,
>>
>> In my mind , one or more rt process manages everything critical, need
>> root access for resources reasons , other processes are things like gu=
i
>> to interact with realtime world, including  X11 applications (I know ,=
 I
>> will hurt some people, but this is the truth : X11 !) .....
>>
>=20
> My point is: what do you gain by separating the RT core from the loggin=
g
> or gui application? Not much as long as the interface is not robust.
> This means that your uncritical part must not be able to interfere with=

> the critical one, e.g. by acquiring some common lock or messing up a
> shared memory which is used blindly by the RT code. If your application=

> design can guarantee this, ok.
>=20
> But then note that Xenomai heaps are unsuited for being shared with not=

> fully trusted parties: management structures reside next to the data,
> write permission is always acquired (and is required for
> allocation/release operations), access control beyond go/no-go is not
> supported. Better use "standard" (Linux) shared memory for this: Invoke=

> shm_open("myshm", ...), adapt the access rights of the newly created
> /dev/shm/myshm, and let the unprivileged process attach to it.
>=20

I haven't looked at this module so far in details, but from the first
quick glance I just took it looks like a simple way to open realtime
access to specific groups:

http://sourceforge.net/projects/realtime-lsm/

This still provides no privilege separation with respect to realtime
(note the comments in the README), but it doesn't enforce you to run all
RT-apps under root. So you keep at least the file system secure...

Given that this module plays with capabilities, it should work fine with
Xenomai as well (untested...).

Jan


--------------enig5D998C6C8F0D4D1323FACD00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEiXdjniDOoMHTA+kRAlmnAJsEF/ycwpIAwwzCrRWdHhlNsWlZkACdEtvP
9/YWEbNpkHEkA4HL6yQJxsA=
=T0KA
-----END PGP SIGNATURE-----

--------------enig5D998C6C8F0D4D1323FACD00--

