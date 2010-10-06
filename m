Message-ID: <4CAC9E63.7090407@domain.hid>
Date: Wed, 06 Oct 2010 18:05:55 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4CAC65FA.70506@domain.hid> <4CAC84CB.7020701@domain.hid>
	<4CAC869E.1010503@domain.hid>
In-Reply-To: <4CAC869E.1010503@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig79371CCC95DD1B2938283D22"
Subject: Re: [Xenomai-core] [announce] Xenomai v2.5.5
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79371CCC95DD1B2938283D22
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06.10.2010 16:24, Gilles Chanteperdrix wrote:
> Stefan Kisdaroczi wrote:
>  =20
>> Hi Gilles,
>>
>> On 06.10.2010 14:05, Gilles Chanteperdrix wrote:
>>    =20
>>> [...]
>>> - the debian patch generation script, which caused invalid patches to=
 be
>>> generated for recent kernel releases
>>>  =20
>>>      =20
>> The file scripts/prepare-patch.sh is missing in the
>> xenomai-2.5.5.tar.bz2 archive.
>>    =20
> I do not see it in scripts/Makefile.am EXTRA_DIST. Did I miss some part=

> of your patch?
>  =20

No. I missed that in the patch, I just moved the file from debian/ to
scripts/.

Sorry, but a stupid guy like me simply does not understand why a script
in a git tree needs to be put in a Makefile.am so that it gets put in a
archive from that tree.

If I do "git archive v2.5.5 | bzip2 > ..." it works. The only difference
between the archives is the inclusion of the 3 pdf's in the doc/nodist
dir and the 3 small scripts in scripts/maint directory (and
prepare-patch.sh). The pdf's could be put out of the tree, but simple
solutions and workflows are probably just for stupid people like me.

Stefan (annoyed)



--------------enig79371CCC95DD1B2938283D22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkysnmkACgkQIPTw9rIdn6rU/ACfWbFzaBavhyUovrp7E1GVMKSn
fPYAn1ir2BfLQqPjv2YdtlTJLTtFfUhZ
=Zdt/
-----END PGP SIGNATURE-----

--------------enig79371CCC95DD1B2938283D22--

