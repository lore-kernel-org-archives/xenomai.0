Message-ID: <469FA616.9040900@domain.hid>
Date: Thu, 19 Jul 2007 19:57:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>	
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>
	<469345EB.6060302@domain.hid>	
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<4693A702.1010604@domain.hid>	
	<913919.1184311634860.JavaMail.ngmail@domain.hid>	
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>	
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>	
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>	
	<469F5BA5.1030407@domain.hid> <1184858093.28303.85.camel@domain.hid>	
	<469F84B3.6070104@domain.hid> <1184861035.28303.108.camel@domain.hid>
In-Reply-To: <1184861035.28303.108.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig27C0674C7B06131407F8BBE2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC freeze after
	rt_task_start
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27C0674C7B06131407F8BBE2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Ok, the rpilock is local, the nesting level is bearable, let's focus on=

> putting this thingy straight.

Well, redesigning things may not necessarily improve the situation, but
reducing the amount of special RPI code might be worth a thought:

What is so special about RPI compared to standard prio inheritance? What
about [wild idea ahead!] modelling RPI as a virtual mutex that is
permanently held by the ROOT thread and which relaxed threads try to
acquire? They would never get it, rather drop the request (and thus the
inheritance) once they are to be hardened again or Linux starts to
schedule around.

*If* that is possible, we would
 A) reuse existing code heavily,
 B) lack any argument for separate locking,
 C) make things far easier to understand and review.

Sounds too beautiful to work, I'm afraid...

Jan


--------------enig27C0674C7B06131407F8BBE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGn6YWniDOoMHTA+kRAmT1AJ0cGD8sTZuk+UoDYN3PEzMflFT37wCeJL/E
JVU1wDVv6t6TnknKQb7QAM0=
=frK0
-----END PGP SIGNATURE-----

--------------enig27C0674C7B06131407F8BBE2--

