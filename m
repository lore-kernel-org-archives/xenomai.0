Message-ID: <43E07559.6000003@domain.hid>
Date: Wed, 01 Feb 2006 09:46:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Shared irqs v.6
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>	
	<43DFB5F9.50406@domain.hid>
	<b647ffbd0601311150t6092a758w@domain.hid>	
	<43DFC50B.1090707@domain.hid>
	<fd6a47a90602010032u3776fd8n@domain.hid>
In-Reply-To: <fd6a47a90602010032u3776fd8n@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6CB3C7044E2281040BF13AA1"
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6CB3C7044E2281040BF13AA1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
>>> I mean that the support of shared interrupts for ISA boards
>> (edge-triggered
>>> stuff) is a kind of emulation to overcome the shortcommings of the
>> initial
>>> design on the hardware level. The hardware was just not supposed to
>> support
>>> shared interrupt channels. So, let's keep it a bit aside from another=

>> code
>>> :o)
>> Unfortunately, this crappy hardware is still quite common in the
>> embedded domain.
>=20
>=20
> If I've understood correctly, the only reason for having this support i=
s to
> avoid - after discovering an interrupting UART - that the IRQ line rema=
ins
> high upon exit, which would cause the 8259 not to issue the CPU IRQ for=
 that
> line anymore ?

Yep.

>=20
> The proposed solution is therefore to traverse the entire list of
> UARTs connected to that IRQ line and make sure none of them was interru=
pting
> in two consecutive passes (by checking their status registers). That wo=
uld
> mean the IRQ line must be deasserted and the 8259 will properly detect =
any
> newly arriving interrupts, since the 8259 has been acknowledged before
> handling the interrupt.

Yep.

>=20
> 1. Wouldn't it be more efficient to make this a compile-time option, in=
stead
> of burdening the nucleus with it ?

You need this feature per-IRQ as there will always be also usual
level-triggered IRQs on your system. What Dmitry is now heading for is a
runtime selection of the fitting IRQ trampoline at nucleus level.

> 2. Would it be an option, in the embedded boards Jan is speaking of, to=
 put
> the 8259 in level sensitive mode ? Some of the boards I know don't actu=
ally
> have this selection logic for the built-in interrupt sources such as th=
e
> timer and the IDE I/F and it therefore only applies to the ISA bus.

Might be an option, but I'm not THAT deep into it to asses all possible
pitfalls of such an approach. Has anyone ever tried this in reality?

> 3. Beware of UARTs that cause interrupts and have a problem that causes=
 them
> to spuriously return 'all green' upon reading of the IIR register. I ha=
ve
> dealt with an integrated ('Super I/O') card with that problem before. T=
he
> only solution was to look at LSR and check THRE as well, even when no T=
X
> interrupt was seemingly present. Must be a logic race.

Yes, there is always the risk of running onto such hardware. Luckily, we
haven't "found" any of it on our systems so far (once you picked
reasonable hardware, you should stay with it - just like we do :) ).

Jan


--------------enig6CB3C7044E2281040BF13AA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4HVaniDOoMHTA+kRAqhkAJ4gCBUDjuoeMKWoddMzx0cbVPI+1wCbBN64
th64lZNYsImrRSfi66SXTtY=
=YIwc
-----END PGP SIGNATURE-----

--------------enig6CB3C7044E2281040BF13AA1--

