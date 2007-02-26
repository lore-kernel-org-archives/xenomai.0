Message-ID: <45E3116E.70402@domain.hid>
Date: Mon, 26 Feb 2007 17:57:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Scheduling of different domains in Adeos
References: <45E15BC1.2000303@domain.hid>
	<45E161AA.9070005@domain.hid>
	<45E2FAB3.2000305@domain.hid>
In-Reply-To: <45E2FAB3.2000305@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3838AC66A97873BAF2118EF9"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Markus.Franke@domain.hid
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3838AC66A97873BAF2118EF9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Jan Kiszka wrote:
>> Scheduling takes place only based on the domain priority, each time a
>> new asynchronous event (interrupt) arrives or a domain reports to be
>> idle. There is no explicit source file or function called "scheduler",=

>> you will find its logic in the dispatching code of pipelined interrupt=
s
>> and in ipipe_suspend_domain().
>=20
> As far as I understood, it is possible to run more than operating syste=
m
> on top of Adeos, at a time. Adeos is said to be a resource
> virtualization layer and the CPU is also a resource, which has to be
> shared. But if there are more than one operating system, who decides
> which one get's the CPU?

See above: each domain (which may contain an OS) has a certain priority,
and the one with the highest priority which has events pending gets the
CPU. That's what the Adeos/I-pipe patch does on event arrival or domain
suspension.

> The question is out of scope of the interrupt virtualization. It's just=

> a question about CPU virtualization.
>=20
> Please correct me if I missunderstood something totally. :-)
>=20

Adeos doesn't do full CPU virtualisation. Therefore, the domains must
cooperate on those resources (memory management, FPU, etc.) that aren't
switched by the nano-kernel. Adeos is not qemu or kvm, if this is what
you have in mind.

Jan


--------------enig3838AC66A97873BAF2118EF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4xFuniDOoMHTA+kRAtArAJ4upNaZJ/9hvNwIRMaWeeJAuggZ5ACeJBdb
sPZZ8+oJc/KEBSevsrwUMDs=
=lBLj
-----END PGP SIGNATURE-----

--------------enig3838AC66A97873BAF2118EF9--

