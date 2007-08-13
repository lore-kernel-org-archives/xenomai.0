Message-ID: <46C0195E.8040309@domain.hid>
Date: Mon, 13 Aug 2007 10:42:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <41f748550708122250yd388c4ehe9992464579d5924@domain.hid>	<2ff1a98a0708130059h29c8d5f1xc4f27133f5b06c6c@domain.hid>
	<41f748550708130119o40345de2r9d5547f0a7d5fdbe@domain.hid>
In-Reply-To: <41f748550708130119o40345de2r9d5547f0a7d5fdbe@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig62DF50B21B2377A15E69B7F1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Kernel Space support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Iwan Budi Kusnanto <iwanbk@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig62DF50B21B2377A15E69B7F1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Iwan Budi Kusnanto wrote:
> On 8/13/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote=
:
>=20
>>> What about hard realtime support to kernel space ?
>> Xenomai supports hard real-time in kernel space but... Are you sure
>> you really want to develop an application in the discomfort of
>> kernel-space ? It makes little sense on high-end platforms. Did you
>> consider the legal issues? The linux kernel is licensed under GPL, so
>> Xenomai kernel-space support is also licensed under GPL, and your
>> application has to be licensed under GPL, which means that you should
>> distribute the sources to anyone to which you distribute your
>> application.
>=20
> GPL is not problem.
> We want to porting our data link layer (part of network driver) kernel
> module to RTOS.

So we are discussing driver development here? That often happens in
kernel space even under Xenomai. Already studied RTDM for your purposes?
It will even leave the door open to put your applications into the
kernel - though we would surely not recommend this as first choice.

>=20
> What type of hard real time support ? is it _seriously_ support or
> _just_ support ?  Because as far as i can see, xenomai main goal is
> for user space .

It is very serious because most of the user-space services are
internally built upon the same functions that are available to kernel
space as well. And if you ever happen to hit a corner case that was
untested and buggy, we are awaiting your report and will work hard to
fix any remaining issue (of course, we will be even more happy when
receiving patches ;) ).

>=20
> [sorry for my bad english ]

No need to excuse, it isn't bad.

Jan


--------------enig62DF50B21B2377A15E69B7F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwBleniDOoMHTA+kRAma2AJ0bcHXSc5qtctAggTxAr9owz11kNACcDaGL
1MM7Qt43lno6BFvoQdU1jII=
=iIfC
-----END PGP SIGNATURE-----

--------------enig62DF50B21B2377A15E69B7F1--

