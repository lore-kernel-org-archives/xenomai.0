Message-ID: <49B5AA5A.80608@domain.hid>
Date: Tue, 10 Mar 2009 00:46:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49B3A126.6000602@domain.hid>
	<49B53AC3.10707@domain.hid>	<49B54780.6040504@domain.hid>
	<49B54D2C.5080001@domain.hid>	<49B55175.2070205@domain.hid>
	<49B55407.9000700@domain.hid>
In-Reply-To: <49B55407.9000700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4361F3C6CCA03004F0600BB9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Watchdog / immediate Linux signal delivery
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
--------------enig4361F3C6CCA03004F0600BB9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Meanwhile I played with some light-weight approach to relax a thread=

>>>> that received a signal (according to do_sigwake_event). Worked, but =
only
>>>> once due to a limitation (if not bug) of I-pipe x86: in __ipipe_run_=
isr,
>>>> it does not handle the case that a non-root handler may alter the
>>>> current domain, causing corruptions to the IPIPE_SYNC_FLAG states of=
 the
>>>> involved domains.
>>> It is not a bug, this is wanted. ISR must neither change the current
>>> domain nor migrate CPU; allowing this would open Pandora's box.
>> And if there is no way to migrate from within an ISR, we can bury any
>> attempt to deliver signals to spinning Xenomai threads - or what other=

>> context would remain to Xenomai for triggering migration?
>>
>=20
> The two-phase solution I have mentioned would work.

I think you can only handle lethal signals that way, not non-lethal like
SIGSTOP.

Jan


--------------enig4361F3C6CCA03004F0600BB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkm1ql8ACgkQniDOoMHTA+mVlgCfQRWvaDimDVCebs4yObvbc1fU
VNUAnRbWLDZlfPkGhR3NJSFnlvAi4QNv
=1D53
-----END PGP SIGNATURE-----

--------------enig4361F3C6CCA03004F0600BB9--

