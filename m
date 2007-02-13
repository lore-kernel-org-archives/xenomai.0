Message-ID: <45D171F9.7000705@domain.hid>
Date: Tue, 13 Feb 2007 09:08:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Make error
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>	
	<45D029B8.1030805@domain.hid>	
	<e45fe62b0702120448i7b23bd24o4fa88a05237a69a@domain.hid>	
	<45D0666C.8070409@domain.hid>
	<e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>
In-Reply-To: <e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4D88D370CC0D7FFDB4E777BD"
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
To: Preetam Joshi <j.preetam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D88D370CC0D7FFDB4E777BD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Preetam Joshi wrote:
> Hi the libnative error is solved but know when i make it gives me error=

> stating:
>=20
> Makefile:312: .deps/mytask-mytask.Po: No such file or directory
> make: *** No rule to make target `.deps/mytask-mytask.Po'.  Stop.
>=20

Using which makefile? Those under examples/ are far shorter than 312
lines...

>=20
> On 2/12/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> Preetam Joshi wrote:
>> > hi,
>>
>> Please keep the CC when replying (reply-to-all).
>>
>> >
>> > Itried adding the options as shown in the example latency in the SVN=

>> > repository but the latency example as well as my example both gve th=
e
>> same
>> > error stating
>> >
>> > make: *** No rule to make target `../../skins/native/libnative.la',
>> needed
>> > by `latency'.  Stop.
>> > make: *** No rule to make target `../../skins/native/libnative.la',
>> needed
>> > by `mytask'.  Stop.
>> >
>>
>> You are doing something wrong. Does the user space part build AND
>> install cleanly? If yes, check out the examples repository next:
>>
>> svn co svn://svn.gna.org/svn/xenomai/branches/v2.3.x/examples
>>
>> Then try to build the native examples:
>>
>> # cd examples/native
>> # make XENO=3D<path-to-xenomai-installation>
>>
>> This should work out-of-the-box. You can then add your own example her=
e,
>> only extending APPLICATIONS in examples/native/Makefile.
>>
>> Jan
>>
>>
>>
>=20



--------------enig4D88D370CC0D7FFDB4E777BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0XIAniDOoMHTA+kRAjskAJ9vnYOZRiZUprpIf7vdCirxZVjtCACfQ46b
kqsUhVZO0qfVrv0BXxX1MJ4=
=NlN2
-----END PGP SIGNATURE-----

--------------enig4D88D370CC0D7FFDB4E777BD--

