Message-ID: <45C1D15F.8060107@domain.hid>
Date: Thu, 01 Feb 2007 12:39:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: : [Xenomai-help] Running real time task on one of the cores of
	a Dual
References: <2284653.1170323957613.JavaMail.ngmail@domain.hid>
	<903621.1170329457132.JavaMail.ngmail@domain.hid>
In-Reply-To: <903621.1170329457132.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A9532537628B74A3E09A120"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A9532537628B74A3E09A120
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
>>> I also use rtnet. Unfortunately I am not able to force rtnet (RTDM ba=
sed) to run on CPU core 1
>>> without patching the RTDM code.
>>> A couple of months ago, I already asked for this issue.
>>> Jan, can you tell me the latest news regarding this issue?
>> The global affinity mask is now part of Xenomai 2.3 (though I haven't
>> tested it again after it was merged).=20
>=20
> Ah, I didn't know that! How can I set the affinity mask?

/proc/xenomai/affinity

> Perhaps this is the problem I have...
>=20
>> What part of RTnet precisely is
>> resisting to move to CPU 1, or what do you currently have to patch?
>=20
> Currently I see the rtnet tasks "rtnet-stack" and "rtnet-rtpc" to be as=
signed to CPU 0.
> I have patched xenomai/ksrc/skins/rtdm/drvlib.c in the call
> to xnpod_start_thread(). I replace XNPOD_ALL_CPUS by cpumask_of_cpu(1).=


That should be obsolete when issuing

echo 2 > /proc/xenomai/affinity

before you load RTnet.

Jan


--------------enig8A9532537628B74A3E09A120
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwdFfniDOoMHTA+kRAnr2AJ9tctMVduF2GAwzN+W5p6L/9XLqSwCfcxtD
eGEEqgDNxiapK/8JgpjoJ90=
=J3F6
-----END PGP SIGNATURE-----

--------------enig8A9532537628B74A3E09A120--

