Message-ID: <45362AE0.60301@domain.hid>
Date: Wed, 18 Oct 2006 15:23:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-15?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-15?Q?collection__of_example?=
References: <s5363968.059@domain.hid>
In-Reply-To: <s5363968.059@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE90C2250A76C6F5FD8FD8FC6"
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
To: Marc LE DOUARAIN <m.ledouarain@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, =?ISO-8859-15?Q?Christoph_Andr?=, =?ISO-8859-15?Q?=E9_M=FCller?= <kritop@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE90C2250A76C6F5FD8FD8FC6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marc LE DOUARAIN wrote:
>=20
>>>> "Marc LE DOUARAIN" <m.ledouarain@domain.hid> 12.10 14:25 >>>
>=20
>=20
>>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> 11.10
> 10:31
>>> Pavel Pirkl wrote:
>>>> Hello,
>>>> I am a novice in using of RTOS Xenomai.
>>>>
>>>>
>>>> 2.
>>>> Now I am using Linux distribution Slackware and Xenomai.
>>>> But I need to find some minidistribution for booting from
> CompactFlash=20
>>>> disk.
>>>> And I need to stop written to this CompactFlash so all programs
> must
> to=20
>>>> run from RAM memory.
>>>> Can you help me? I hear about ELinOS and free licence?
>>> There are several distributions for embedded systems, see
>>> http://www.linuxdevices.com/articles/AT2760742655.html=20
>>>
>>> --=20
>=20
>> Another mini-distribution (White Dwarf Linux) is available here :=20
>> http://www.blast.com/index.php?id=3D35=20
>=20
>=20
> Another one here, that seems very interesting :
>=20
> http://www.rts.uni-hannover.de/lire/
>=20
> " LiRE V0.6.1 released / 18.08.2006
> This release contains the Linux Kernel 2.6.17.8, Xenomai 2.2.0, RTnet
> 0.9.4, RACK 0.3.0, BusyBox 1.2.1, bugfixes and some new features like
> QEMU Image Support. "
>=20

Thanks for the AD ;). I always hesitate to announce this to loudly as it
is still in a rough state /wrt generic usability. BUT -- it does what it
should do in a very straight way: install a mini Linux/Xenomai system
for x86 + some arbitrary tools (for us of course not arbitrary) on a
flash card. In fact, most of my tests run on LiRE, either netbooted on
some PC that happen to be in reach (Etherboot is your friend) or in
qemu. And of course all our robots run on LiRE.

We are now working on the next generation of LiRE which will likely be
based on some smarter third-party build system, specifically to ease the
pain of adding and maintaining more and more packages.

If there is interest here in joining our effort, let us know. There is
no real community around LiRE yet, just a few users at another
university institute in Hannover and at the R&D department of an
automotive manufacturer (and those guys are typically _very_ silent) -
that's at least what we are aware of. But I could imagine that providing
such a cross-compilable (todo...) distro with Xenomai included may be
helpful for quite some users.

Jan


--------------enigE90C2250A76C6F5FD8FD8FC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNirgniDOoMHTA+kRAup/AJ938j+q+kkYaavuFJ/pTFlML2YVIACfQD2E
JxxRhjkNr6o4oanF5qIhPB8=
=JVcH
-----END PGP SIGNATURE-----

--------------enigE90C2250A76C6F5FD8FD8FC6--

