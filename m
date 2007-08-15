Message-ID: <46C33764.5090905@domain.hid>
Date: Wed, 15 Aug 2007 19:27:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <000001c7deba$7c6fbf10$c124a986@domain.hid>
In-Reply-To: <000001c7deba$7c6fbf10$c124a986@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig82E3246505AD0A27A270348B"
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
--------------enig82E3246505AD0A27A270348B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

<snippin a lot, sorry>

Torsten Kr=F6ger wrote:
>> Jan Kiszka wrote:
>> If you are seriously interested in prio-inheritance for the native
>> message passing API, the best you can do is to work actively on a patc=
h
>> proposal. This would
>>
>> - demonstrate how unintrusive this addition could be (preferably, PI
>>   will be optional and use existing low-level services), while being
>>   so useful for certain scenarios
>>
>> - accelerate the testing cycle (_you_ have the scenario at hand)
>>
>> - raise the chances that Xenomai gains this feature soon (core
>>   developers are generally busy with many things)
>>
>> Posting patches early will allow you gain concrete feedback on the
>> design. And we will not sit there and watch you pulling hairs while
>> you're stuck. But hacking some Xenomai skin is also no black magic,
>> given the well defined nucleus API. Give it a try!
>=20
> I am seriously interested in priority inheritance for the message
> passing API, but I don't consider myself as an expert in this field and=

> nor as an operating system developer. My employer/my client does not
> give me time for such kind of system engineering, hence I will remain a=
s
> a user - all I can do is to tell about my desires and experiences.

As I said, it doesn't take experts here, just someone to start and
collect the pieces (which might include asking for expert knowledge here
and there).

And someone being able to write such long and detailed essays - for me
even too long to read completely yet - should as well be able to play a
bit with code. Or motivate some talented student of yours (I know they
can be rare). ;)

>=20
> Ok, now I'm coming to the end. I hope this posting was a bit interestin=
g
> for any reader and that someone goes for further words on this...
>=20
> ...any comment and further discussion is highly appreciated again! :-)
>=20

Better let some code speak now...

Jan


--------------enig82E3246505AD0A27A270348B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwzdkniDOoMHTA+kRAuSHAJ4wTknAolzTU1oyCTIMeydLg8qr9gCeMIaQ
3ggEPwLvR1GUxXlNKpQBSEU=
=RJk8
-----END PGP SIGNATURE-----

--------------enig82E3246505AD0A27A270348B--

