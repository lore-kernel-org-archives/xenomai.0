Message-ID: <43C12CEC.8070403@domain.hid>
Date: Sun, 08 Jan 2006 16:17:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
References: <43C12304.4040802@domain.hid>
In-Reply-To: <43C12304.4040802@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3DD2C3CE47809508CC989E3D"
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3DD2C3CE47809508CC989E3D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Heikki Lindholm wrote:
> Hi,
> 
> Some recent changes (*cough* RTDM benchmark driver *cough*) broke kernel
> mode benchmarking for ppc64. Previously klatency worked fine, but now
> latency -t 1 crashes somewhere in xnpod_schedule. Jan, any pending
> patches a comin'?

Nope, it should work as it is. But as Stelian also reported problems on
his fresh ARM port with the in-kernel test, I cannot exclude that there
/might/ be a problem in the benchmark.

As I don't have any ppc64 hanging around somewhere, we will have to go
through this together. Things I would like to know:

 o When and how does it crash? At start-up immediately? Or after a
   while?
 o Are there any details / backtraces available with the crash?
 o Does -t2 work?
 o What happens if your disable "rtdm_event_pulse(&ctx->result_event);"
   in eval_outer_loop (thus no signalling of intermediate results during
   the test)? Does it still crash, maybe later during cleanup now?

Jan

--------------enig3DD2C3CE47809508CC989E3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwSzsniDOoMHTA+kRAvtrAJ9vbPIJQPYSfrrNLYHUA4zyiGStigCfeMNj
ZaU8oqz4exYW05WLxSMUZlU=
=Vx7d
-----END PGP SIGNATURE-----

--------------enig3DD2C3CE47809508CC989E3D--

