Message-ID: <46C559F5.8040605@domain.hid>
Date: Fri, 17 Aug 2007 10:19:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <001301c7dfe6$90a60520$c124a986@domain.hid>
In-Reply-To: <001301c7dfe6$90a60520$c124a986@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA8F63635D2C789A952EB074"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
 threads in other processes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA8F63635D2C789A952EB074
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Torsten Kr=F6ger wrote:
> Jan Kiszka wrote:
>> As I said, it doesn't take experts here, just someone to start and
>> collect the pieces (which might include asking for expert knowledge
> here
>> and there).
>>
>> And someone being able to write such long and detailed essays - for me=

>> even too long to read completely yet - should as well be able to play =
a
>> bit with code. Or motivate some talented student of yours (I know they=

>> can be rare). ;)
>>
>=20
> The reason for my long postings is that I just wanted the developers to=

> understand my concerns - and to see that it is a serious problem of the=

> Xenomai RTOS.

As pointed out: How "serious" this is heavily depends on the application
design.

> I cannot imagine that adding new task context data structures and
> changing algorithms for CPU time counting (important for RR scheduling)=

> is an easy or small thing.

Well, you picked an even more complicated approach to solve your
problem. So far we were only talking about PI for message passing based
on existing infrastructure, using clear semantics. Let's make smaller
steps and see how far it takes us to solve your requirements.

Jan


--------------enigFA8F63635D2C789A952EB074
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGxVn1niDOoMHTA+kRAkNAAJ9sEFwJWTkjLnghHFDlhnjkQz5vqACcCCnH
gIYtK49TyORyv9CyPjLDh8Y=
=SFkr
-----END PGP SIGNATURE-----

--------------enigFA8F63635D2C789A952EB074--

