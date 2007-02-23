Message-ID: <45DEA9BB.50805@domain.hid>
Date: Fri, 23 Feb 2007 09:45:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [Xenomai-help] hello xenomai world?]
References: <45DE006F.5000400@domain.hid> <45DE33BF.7090601@domain.hid>
In-Reply-To: <45DE33BF.7090601@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig507F51AD4EBD2BA51C75DB49"
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
To: rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig507F51AD4EBD2BA51C75DB49
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>>> Invoke make like this: make /path to xeno-config/. Which is why I was=

>>> going on about the config variables. I wil now try and find
>>> xeno-config if it exists and see how that works. On the other hand I
>>> don;t doubt that the application will compile. I need to find out wha=
t
>>> libraries to include for this particular one for the next steps. See
>>> later.
>>
>> Ack, my bad. The example makefiles do not assume /usr/xenomai (or,
>> alternatively, /usr/xenomai/bin/xeno-config) as default for XENO. Will=

>> fix.
>>
>> Meanwhile try "make XENO=3D/usr/xenomai".
> Ok this does compile. however when running the resulting sigxcpu there
> is an error while loading the shared libraries. cannot find
> libnative.so.0. This may be a result of the library installation. From
> long ago I remember that to install a library ldsomethingorother must b=
e
> run to amend a certain library file. Due to the live nature of my
> installation this file whatever it is called might get overwritten.
> What is strange is that the other applications don't seem to have this
> problem. Latency testsuitapp runs for example.
>=20

Yeah, yet another beginners trap. The testsuite apps are built by
autotools stuff that automatically adds the lib folder as search path to
generated binaries. That currently doesn't happen to the examples,
although Xenomai libs are installed to a non-standard folder by default.
OK, I'll commit an enhanced version to SVN. Thanks for pointing out.

Jan


--------------enig507F51AD4EBD2BA51C75DB49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3qm7niDOoMHTA+kRAjnoAJ9PFAjx9rxeBH1amoS71OhDq3/IzACfWOBE
weEEkwGnsqXkC8W61PF5qv8=
=VcwW
-----END PGP SIGNATURE-----

--------------enig507F51AD4EBD2BA51C75DB49--

