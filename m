Message-ID: <4ADDA299.1020505@domain.hid>
Date: Tue, 20 Oct 2009 13:44:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20091019171611.3332.24615.stgit@domain.hid>	
	<20091019171612.3332.48569.stgit@domain.hid>	
	<4ADCAD4C.2000504@domain.hid> <4ADCB96B.2040703@domain.hid>
	<1256034733.2862.118.camel@domain.hid>
In-Reply-To: <1256034733.2862.118.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8DB5009C560E28FF8B722C1C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH v2 2/3] nucleus: Include all heaps in
	statistics
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DB5009C560E28FF8B722C1C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2009-10-19 at 21:09 +0200, Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> @@ -234,12 +239,65 @@ int xnheap_init(xnheap_t *heap,
>>>> =20
>>>>  	appendq(&heap->extents, &extent->link);
>>>> =20
>>>> +	vsnprintf(heap->name, sizeof(heap->name), name, args);
>>>> +
>>>> +	spin_lock(&heapq_lock);
>>>> +	appendq(&heapq, &heap->stat_link);
>>>> +	spin_unlock(&heapq_lock);
>>> You can not use a Linux spinlock in xnheap_init and xnheap_destroy:
>>> - this breaks the build for the simulator;
>>> - callers of xnheap_init and xnheap_destroy are not guaranteed to run=
 on
>>> the root domain.
>> Oh, yes, unfortunately. That callers appear to be fixable, but that's
>> probably not worth it at this point.
>=20
> There is nothing to fix here. It's part of the service definition to be=

> able to call it from primary mode.

Strictly spoken not. But given that xnheap_init_mapped does not fulfill
this promise and that quite a few users have an either-or use of this
tuple, it doesn't buy us much to allow primary mode.

Jan


--------------enig8DB5009C560E28FF8B722C1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrdop4ACgkQitSsb3rl5xTOwACfVdPMBGwVU7czriWYk3Rn/s7e
dHgAn1CyUA37G0VTQG3xal+q50ts+3ep
=hAim
-----END PGP SIGNATURE-----

--------------enig8DB5009C560E28FF8B722C1C--

