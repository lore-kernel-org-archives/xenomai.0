Message-ID: <455E058C.1010404@domain.hid>
Date: Fri, 17 Nov 2006 19:55:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] VM killer
References: <DD39B5C3F4963040ADC9768BE7E430CB015D4828@domain.hid>
	<455E025B.7060708@domain.hid>
In-Reply-To: <455E025B.7060708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9B7D6825E08ED731F5E16244"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B7D6825E08ED731F5E16244
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Daniel Schnell wrote:
>> Hi,
>> =20
>> I know this is somewhat not related to Xenomai. But as I encountered
>> this while actually testing the memory allocation with Xenomai, maybe
>> there is some common sense here, as there are many people having to do=

>> with embedded systems, where something like that matters.
>> =20
>> Everytime the system comes to its limits and some process uses up all
>> the memory the vm systems kills (more or less randomly) one or more
>> processes. Even system processes. I would really like to get rid of th=
is
>> behaviour, but having disabled CONFIG_OOM_KILLER inside the linux kern=
el
>> doesn't help.
>> =20
>> I use ELDK4.0 with 2.4.25 Denx Kernel.
>> =20
>> Any hints ?
>=20
> There is no way the system can run properly if there is not enough RAM.=

> Add some RAM to your board, or decrease the memory used by applications=
=2E

Having a means to avoid that your critical process gets killed
accidentally because some uncritical one decided to suck up all system
resources is, IMO, a very legitimate use case. On 2.6, where there is no
CONFIG_OOM_KILLER, you can play with /proc/<pid>/oom_adj and make your
process "unattractive" to the OOM killer (set to -17). On older kernels
you also had to include any parent processes in this protection. I think
this was fixed meanwhile.

But I wonder why there should be no effect of CONFIG_OOM_KILLER on 2.4.
Forgot to replay the updated kernel binaries?

Jan


--------------enig9B7D6825E08ED731F5E16244
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXgWMniDOoMHTA+kRAs48AJ47TWBQwp4096Q7FCpS9re5H5jU5QCdEAac
kdnafH4rt8H2CHxeoCsB92A=
=NCvm
-----END PGP SIGNATURE-----

--------------enig9B7D6825E08ED731F5E16244--

