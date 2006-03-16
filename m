Message-ID: <44194E3E.6040905@domain.hid>
Date: Thu, 16 Mar 2006 12:38:38 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] newbie question
References: <0915ad1443edb7af745736fe4aaf3551@domain.hid>
	<441949A0.8060100@domain.hid>
In-Reply-To: <441949A0.8060100@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0AE0406A3E3B84D785F7DC6C"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Lugli <daniele.lugli@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0AE0406A3E3B84D785F7DC6C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Daniele Lugli wrote:
>> Hello all,
>> I am new to xenomai although I have already used rtai.
>> I see that xenomai has a user mode which looks equivalent to rtai's lx=
rt.
>> What about calling real-time functions implemented in a module
>> (rtai_lxrt call, rt_fun_entry table and so on)?
>> Thank you,
>> Daniele Lugli
>>
>>
>=20
> Have a look at the way a simple skin does it, e.g. ksrc/skins/uvm.
> [...]

But before going this way, first consider what kind of functions you
exported so far via rt_fun_entry. If it was a driver API, you should
better have a look at RTDM now.

Actually, most additional APIs exported via that LXRT interface were
driver-related. But this led to rather chaotic API situation with
incompatible driver interfaces. Moreover, the often used automatic LXRT
mapping of arguments that describe large buffers was quite inefficient
(additional copy step). That is now different with both the skin and the
RTDM way under Xenomai (no automatic copying, the skin or the driver has
to take care natively).

Jan


--------------enig0AE0406A3E3B84D785F7DC6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGU4+ncNeS9Q0k+IRArWxAKCG7e2RaruoF97eD8vm2LjUF2KTOQCfcO3Z
FaJxrRe3f2kKjyTqGc5MaMM=
=XntA
-----END PGP SIGNATURE-----

--------------enig0AE0406A3E3B84D785F7DC6C--

