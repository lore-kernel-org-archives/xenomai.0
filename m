Message-ID: <4570047A.6070109@domain.hid>
Date: Fri, 01 Dec 2006 11:31:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<20061130133745.272ab4b1.benjamin.zores@domain.hid>	<456EDA4B.3060809@domain.hid>
	<200611301806.51699.paul_c@domain.hid>
In-Reply-To: <200611301806.51699.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C3030DA8C51A04A35ADCD3F"
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
To: Paul <paul_c@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C3030DA8C51A04A35ADCD3F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> On Thursday 30 November 2006 13:19, Jan Kiszka wrote:
>> Philippe, I know you are very busy, but shouldn't we make a pre-releas=
e
>> available already, also to discuss further how to deal best with genir=
q
>> on other platforms beyond x86?
>=20
> I have an x86_64 box waiting for a Xenomai port - I don't see much poin=
t in=20
> hacking 2.6.17 and earlier when 2.6.19 is going to be a major change in=
 key=20
> areas.. It also looks like there is a closer integration of x86_64 and =
plain=20
> old ix86 code in the 2.6.19 tree, so this may simplify the task of=20
> maintaining a 64bit patch.

For sure, there is not much point in starting on old code (the "stable"
2.6.16 series /may/ turn out to be an exception one day).

An x86_64 port will be highly welcome! Feel invited to post I-pipe
related topics also to adeos-main@gna.org.

One hint that may ease testing/debugging: Have a look at qemu for
x86_64. At least on x86, it already helped me a lot to debug weird
kernel issues without long run-instrument-build-rerun cycles. All it
takes is a minimal system image for a target. You can easily attach a
debugger to the kernel, and you can even emulate SMP (though debugging
is not perfect in that case). Of course, you cannot identify latency
issues this way, but you will likely already be happy when things don't
crash anymore. :)

Jan


--------------enig8C3030DA8C51A04A35ADCD3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFcAR6niDOoMHTA+kRAgnvAKCAd7Xrof9/BOUx6MLSovRwPtiYygCfd51/
G9OhN3Vvh9eUFwv7gWfGl9w=
=oVM+
-----END PGP SIGNATURE-----

--------------enig8C3030DA8C51A04A35ADCD3F--

