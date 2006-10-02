Message-ID: <4520D095.9090903@domain.hid>
Date: Mon, 02 Oct 2006 10:40:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] SH4 port
References: <001f01c6e491$c384f7e0$1501a8c0@domain.hid> <451D1DAB.8040803@domain.hid>
In-Reply-To: <451D1DAB.8040803@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFE677852D19F006EA3F3EA44"
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
To: Kiichi Kameda <k-kameda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE677852D19F006EA3F3EA44
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Kiichi Kameda wrote:
>> ...
>> After tough investigation, I think I found some clues such as:
>> While in.ftpd runs hard, a "write" system call was issued and Linux
>> kernel was processing its request.
>>  But weird __ipipe_dispatch_event and __ipipe_sync_stage was recorded.=

>>
>> I think the problem originates from a Xenomai context switch(which
>> overwrites "current"), while Linux is processing  system call.
>=20
> If I interpret linux/include/asm-sh/current.h correctly, current is
> derived from the stack on your platform (like on most archs) and cannot=


That's nonsense as I realised later by following the code down to
include/asm-sh/thread_info.h: current_thread_info seems to get
referenced by some register.

Still the question remains for me why this should be a general Xenomai
problem. Xenomai may overwrite the content on switch_to (but I don't
know your patch, how you realised context switches between RT tasks on
SH4), but then it should definitely also restore it again on returning
to Linux.

Jan


--------------enigFE677852D19F006EA3F3EA44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFINCVniDOoMHTA+kRAvNvAJ4ybIUZ64JsZKc17Ej6BkCuCQuO0gCdEqGS
bNGg8LUN2bCld1Eu+1WgeF4=
=/Sw7
-----END PGP SIGNATURE-----

--------------enigFE677852D19F006EA3F3EA44--

