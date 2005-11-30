Message-ID: <438DC8F4.9070409@domain.hid>
Date: Wed, 30 Nov 2005 16:44:52 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] using mq_receive and mq_send
References: <02AA386EB831044F8537A696BA785C78076489@domain.hid>
In-Reply-To: <02AA386EB831044F8537A696BA785C78076489@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF3A38AA1E99671EC421D64BA"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF3A38AA1E99671EC421D64BA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Landau, Bracha wrote:
> it says:
>          U __wrap_mq_close
>          U __wrap_mq_open
>          U __wrap_mq_receive
>          U __wrap_mq_send
>          U __wrap_mq_unlink

Are you calling send and receive from a xenomai thread? EPERM (1) is
typically related to non-RT invocations.

Jan

>=20
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Wednesday, November 30, 2005 4:37 PM
> To: Landau, Bracha
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] using mq_receive and mq_send
>=20
>=20
> Landau, Bracha wrote:
>> I do link that way. The linking is fine, only the mq_receive and mq_se=
nd don't work. I don't even "own" the regular libmqueue library.
>>
>=20
> What does "nm <your_app>|grep wrap_mq_" says?
>=20
>> -----Original Message-----
>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>> Sent: Wednesday, November 30, 2005 4:01 PM
>> To: Landau, Bracha
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] using mq_receive and mq_send
>>
>>
>> Landau, Bracha wrote:
>>
>>> I am using Xenomai on the MPC8272ADS board with kernel 2.6.14.3.
>>>
>>> I've created an application that uses posix message queuing from xeno=
mai.
>>>
>>> When I call mq_open, mq_close, mq_setattr, mq_getattr, mq_unlink - th=
e calls succeed.
>>>
>>> When I call mq_receive or mq_send, the call fails (returns -1) and er=
rno is set to 1 (Operation not permited).
>>>
>>> I put some debugging printk's into the xenomai code and it seems it d=
oesn't even get to the call to __mq_receive or __mq_send from syscall.c (=
it does get to printk's that I put in  the other __mq_* functions).
>>>
>>> Can anyone help?
>>>
>>
>> You must link your app with the flags output by "xeno-config=20
>> --posix-ldflags". Have a look at skins/posix/demos/Makefile for a=20
>> working example.
>>
>=20
>=20


--=20
Dipl.-Ing. Jan Kiszka

Institute for Systems Engineering, Real-Time Systems Group (RTS)
Appelstra=DFe 9A, D-30167 Hannover
phone +49 511 762-3974 / fax +49 511 762-4012
http://www.rts.uni-hannover.de


--------------enigF3A38AA1E99671EC421D64BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDjcj0ncNeS9Q0k+IRAoCKAJoCTx/Rke898l5dx086zkcGb/X54QCfaZ2J
snU7+Ii067JYujkRuASOVnQ=
=EjhS
-----END PGP SIGNATURE-----

--------------enigF3A38AA1E99671EC421D64BA--

