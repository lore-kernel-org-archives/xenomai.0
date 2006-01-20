Message-ID: <43D0A13C.10603@domain.hid>
Date: Fri, 20 Jan 2006 09:37:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Meassage Queue c++
References: <43CFC6B5.8080308@domain.hid>
	<200601200914.37506.s.zimmermann@domain.hid>
In-Reply-To: <200601200914.37506.s.zimmermann@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCC09B780EA35EFAEA7D099BF"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCC09B780EA35EFAEA7D099BF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Am Donnerstag, 19. Januar 2006 18:04 schrieb Nathaniel Villaume:
>> Hi Stephan,
>>
>> I don't know if it is related, but I wouldn't return a pointer to a
>> local variable:
>>
>> void *data;
>> ...
>> return data;
>>
>> Maybe something is happening where when the queue is empty the size is=
 0
>> --so malloc returns who-knows-what?
>=20
> Hi,=20
> thanks for the hint, but I don't think this is the Problem, because the=
=20
> Program crashes befor the read function returns. I think it is related =
with=20
> the way I create/bind the queue in the constructor, but I am not sure.
>=20
> Please don't think too much about it, I decided to stop my c++=20
> realtime-experiments anyway, will code plain c instead.

Some further things to try before giving C++ up - and maybe stumbling
over the same issue with C:

 o Did you mlockall() your program? If not, lazy-mapped pages may cause
   SEGFAULTS in the RT domain which will kill your program.

 o Does your kernel log contain any hints of Xenomai about what's going
   on?

 o Try running your program inside a debugger to catch the fault and its
   location. When your system is head-less, use gdbserver.

Jan


--------------enigCC09B780EA35EFAEA7D099BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD0KE8niDOoMHTA+kRAn/WAJwKgs8t+Hf5rrbLvOy3byu3MZFzuQCdFBHZ
IVnUkwS9gjGyp1W+jghcqZA=
=VinX
-----END PGP SIGNATURE-----

--------------enigCC09B780EA35EFAEA7D099BF--

