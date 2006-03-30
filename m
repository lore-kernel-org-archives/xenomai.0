Message-ID: <442C472B.2090300@domain.hid>
Date: Thu, 30 Mar 2006 23:01:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] gigabit rate packet processing with xenomai
References: <2cf1ee820603280009r5adec759h99aa69809f68b457@domain.hid>	
	<44296668.10300@domain.hid>
	<2cf1ee820603300724w1335df09nf4d2abb0755107d5@domain.hid>
In-Reply-To: <2cf1ee820603300724w1335df09nf4d2abb0755107d5@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2C9E9E873C4177F4512E673C"
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
To: emin ak <eminak71@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C9E9E873C4177F4512E673C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

emin ak wrote:
> Dear All;
> Thanks for the answers firstly.
> I'am using linux (and also xenomai ) for a powerpc (PQ3/MPC8540) and
> will use on chip gigabit ethernet controller (tsec) that is not
> supported on rt-net yet (maybe untill I'll write one:)
> In my opinion and my basic tests shows that context switch times and
> system call latecies in linux decrease user space performance
> significally even with highest RT_FIFO priority and this reasons
> prevent my gigabit rate data processing in user space.
> I think I'll firstly choose un-deterministical way, write a realtime
> user space thread that process the data coming from linux ethernet
> driver, if it fails, I'll adapt the driver for rt-net or wait for the
> up-coming realtime-preemptive patch.

If you can live with a certain amount of deadline misses, this is
probably the most reasonable approach. And preempt-rt will further
improve the quality of service but will still not be able to /guarantee/
networking latencies (the network stack is not explicitly included in
the latency improvements under preempt-rt, resource allocation remains
nondeterministic).

Jan


--------------enig2C9E9E873C4177F4512E673C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFELEcrniDOoMHTA+kRAv3oAJ47vAJPwGUwycp1/zrYlsbdglAmGQCfRUw7
p4dyL/JAlZWr9XLPV9GfPPI=
=0Bax
-----END PGP SIGNATURE-----

--------------enig2C9E9E873C4177F4512E673C--

