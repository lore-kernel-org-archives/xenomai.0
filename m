Message-ID: <4390470F.8040503@domain.hid>
Date: Fri, 02 Dec 2005 14:07:27 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] i386 2.4 backport performing (too?) well
References: <Pine.LNX.4.63.0512021139500.2791@domain.hid>
In-Reply-To: <Pine.LNX.4.63.0512021139500.2791@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigED7B517878CCCA12E51C553E"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED7B517878CCCA12E51C553E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Klaas Gadeyne wrote:
> With the arrival of the 2.4 i386 adeos ipipe patch for xenomai [1], I
> decided to try to compile xenomai-trunk for a 2.4 kernel. This worked
> flawlessly, and moreover, I got excellent latency results:
>=20
> I used the "same" kernel config as for our 2.4.31 rtai3.0r5 kernel,
> which is based on Takis Issaris' liveCD config.
>=20
> This resulted in a maximal latency of 30 usec after a run of over 100
> minutes under heavy load (tar and dd loops, compiling, keyboard
> interrupts and ping flood) [2].
>=20
> For comparison, on the same hardware platform: - the RTAI lxrt-latency
> on rtai 3.0r5 (adeos oldgen r18c1
>   patch for 2.4.31 also) test reports 38 usec
> - the latency test of xenomai 2.01 running on a 2.6.14-ipipe-1.0-10
>   kernel resulted in a latency of 80 usec.
>=20
> This seems too good to be true?  Can one simply compare the results of
> the former RTAI lxrt-latency test with the xenomai latency test?

Mmh, I tend to be sceptical as well, also remembering the results
Wolfgang posted about 2.6 vs. 2.4 on low-end PPC
(https://mail.gna.org/public/xenomai-core/2005-11/msg00131.html).

Well, such worst-case improvement may be real if and only if there is
less *kernel* code in hard-irq-off sections with 2.4. The complexity of
adeos/ipipe and xenomai isn't changed between both scenarios.

But I rather think that 2.4 just stresses the caches less than 2.6, thus
is may be more tricky to trigger the real worst-case path. So, what we
already saw with PPC: 2.4 and 2.6 may likely show similar RT
performances under Xenomai, but the overall system performance is much
better on low-end! However, I would be happy if this theory is too
pessimistic.

Jan


--------------enigED7B517878CCCA12E51C553E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDkEcPncNeS9Q0k+IRAkaFAJ9iOnRRTV2k4GByHV2rNyO02fHoEQCg3L6c
QQcq/Xs53lRseaMHb/4izIQ=
=ZUC+
-----END PGP SIGNATURE-----

--------------enigED7B517878CCCA12E51C553E--

