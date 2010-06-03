Message-ID: <4C0751FC.8050009@domain.hid>
Date: Thu, 03 Jun 2010 08:55:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C0692A9.2080806@domain.hid> <4C06953D.90003@domain.hid>
In-Reply-To: <4C06953D.90003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1871C4AFA831D2F2ED9B6423"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC] Break out of endless user space loops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1871C4AFA831D2F2ED9B6423
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi all,
>>
>> here is the first apparently working prototype for getting hold of
>> endless user space loops in RT threads. A simple test case of mine now=

>> receive a SIGDEBUG even if it does "while (1);".
>>
>> The design follows Gilles' suggestion to force a SEGV on victim thread=

>> but restore the patched PC before migrating the thread after this faul=
t.
>> The only drawback of this approach: We need to keep track of the
>> preempted register set at I-pipe level. I basically replicated what
>> Linux does these days as well and exported it as ipipe_get_irq_regs()
>> (the second patch).
>=20
> You already have the regs in xnarch_fault_info.
>=20

We only pass this around for exceptions.

Jan


--------------enig1871C4AFA831D2F2ED9B6423
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwHUgEACgkQitSsb3rl5xR+WACgw7Tho4R25Oxjpg4KC0lfH2RN
wOoAnitgzD/k6plRzUCd+ao3nkXWETZD
=fZao
-----END PGP SIGNATURE-----

--------------enig1871C4AFA831D2F2ED9B6423--

