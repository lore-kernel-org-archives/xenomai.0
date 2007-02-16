Message-ID: <45D5746C.1090003@domain.hid>
Date: Fri, 16 Feb 2007 10:07:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D45AEA.50404@domain.hid> <1171547803.24117.8.camel@domain.hid>	
	<45D46704.9050109@domain.hid> <1171560346.24117.77.camel@domain.hid>
In-Reply-To: <1171560346.24117.77.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC69D89203A7E693327823969"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC69D89203A7E693327823969
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-02-15 at 14:58 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2007-02-15 at 14:06 +0100, Jan Kiszka wrote:
>>>> Hi all,
>>>>
>>>> I think I found another unwanted side-effect of the no-cow changes:
>>>>
>>>> With the I-pipe 1.7 patch series the test for missing mlockall no lo=
nger
>>>> works. I just - once again - wrote a test program that was lacking t=
his
>>>> call, but only with I-pipe 1.6-06 (same Xenomai version: latest trun=
k) I
>>>> get the usual error message on startup.
>>>>
>>> I can't reproduce this with 1.7-01 here. Which Xenomai codebase are y=
ou
>>> currently using (trunk/, 2.3.x maintenance or stock 2.3)?
>> Specifically trunk, but the first observation was over 2.3.x
>> maintenance. The test code is using the posix skin.
>=20
> I still don't find any explanation for that behaviour, only trivially
> testing with and without mlockall() in a bare main routine though.
>=20
> In relation to this, I've rolled out 1.7-02/x86, so that we could close=

> the last pending issue(s) holding v2.3.1 wrt the interrupt pipeline
> support. Specifically, the -nocow related changes have been amended, an=
d
> we are now back to the implementation that prevailed in the 1.6 series
> wrt vmalloc and ioremap memory, while still retaining the ability to
> break COW eagerly for the RT threads.
>=20
> Feedback welcome on this.
>=20

=46rom first tests it looks like the BUGs on RTnet startup are resolved
with 1.7-02. I will have a look at the mlockall issue again to
understand what happens precisely there (I'm still lacking the warning).

Jan


--------------enigC69D89203A7E693327823969
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1XRsniDOoMHTA+kRAoAGAJ9sdLhRsiiiipY2FbOlwLlaeGpWaACfWwdE
0L9lnm1+eEk236Polhm4q+M=
=8Z/n
-----END PGP SIGNATURE-----

--------------enigC69D89203A7E693327823969--

