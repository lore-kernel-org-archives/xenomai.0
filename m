Message-ID: <45757B28.50009@domain.hid>
Date: Tue, 05 Dec 2006 14:59:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<4566C5AF.7030107@domain.hid>	<20061124113009.08c0a490.benjamin.zores@domain.hid>	<4569E699.6050003@domain.hid>	<20061127092143.e633cd91.benjamin.zores@domain.hid>	<456ACA35.8030206@domain.hid>	<20061127125419.3852edd9.benjamin.zores@domain.hid>	<456AD5EB.5040901@domain.hid>	<20061130133745.272ab4b1.benjamin.zores@domain.hid>	<45754723.6050503@domain.hid>	<20061205133516.b3b9ae85.benjamin.zores@domain.hid>
	<45756F92.6060001@domain.hid>
In-Reply-To: <45756F92.6060001@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB67FD629D7C73B8469706ABA"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB67FD629D7C73B8469706ABA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Benjamin Zores wrote:
>> On Tue, 05 Dec 2006 11:17:07 +0100
>> Wolfgang Grandegger <wg@domain.hid> wrote:
>>
>>> I have now a preliminary patch for adeos-ipipe-2.6.19-ppc-1.5-00. The=

>>> porting was rather straight-forward, as the ppc tree does not use the=

>>> new "genirq" interface, in contrast to the powerpc tree (that's what
>>> you have realized as well).
>>
>> Well, i guess the old "ppc" arch is bound to die sooner or later.
>> New developments should always be done against "powerpc" arch imho.
>=20
> Well, the powerpc tree is still highly experimental and only a few
> embedded boards are already supported. I guess it will take a long time=

> before the ppc tree finally gets buried, especially because porting is
> not really trivial (due to OF, IRQ layer, etc.),
>=20
>>> Therefore the port of the powerpc tree should be based on Philippe's
>>> new adeos-ipipe-2.6.19-i386-1.6-00. Unfortunately, I still do not
>>> have a board by hand supported by the powerpc tree.
>>
>> I haven't had much much time investigating the problem till now.
>> But from what i've seen from Philippe's splitted patches, many of them=

>> that were supposed to be generic (i.e. don't have i386 in their name)
>> still have references to x86 changes.
>> Is it a normal behavior ?
>=20
> Unfortunately, "generic" applies only to the Linux part. I realized,
> that the new IPIPE support for the genirqs requires even more
> arch-specific modifications than the old interface :-( on PowerPC.

How comes? I haven't found time to analyse this for the latest x86
patch, but there it should be "more generic" than before. Do you think
this is a genirq issue or an I-pipe problem?

Jan


--------------enigB67FD629D7C73B8469706ABA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdXsoniDOoMHTA+kRAolrAJ9nzyqgFhDTtPjd9/JN/J0jlGQsAwCggK/u
DFfJl0hWrrGcpHMHXfelXo4=
=+xCA
-----END PGP SIGNATURE-----

--------------enigB67FD629D7C73B8469706ABA--

