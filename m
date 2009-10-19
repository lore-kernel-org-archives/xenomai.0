Message-ID: <4ADCB96B.2040703@domain.hid>
Date: Mon, 19 Oct 2009 21:09:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20091019171611.3332.24615.stgit@domain.hid>	<20091019171612.3332.48569.stgit@domain.hid>
	<4ADCAD4C.2000504@domain.hid>
In-Reply-To: <4ADCAD4C.2000504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig204B4E863B911F3FE2280922"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig204B4E863B911F3FE2280922
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> @@ -234,12 +239,65 @@ int xnheap_init(xnheap_t *heap,
>> =20
>>  	appendq(&heap->extents, &extent->link);
>> =20
>> +	vsnprintf(heap->name, sizeof(heap->name), name, args);
>> +
>> +	spin_lock(&heapq_lock);
>> +	appendq(&heapq, &heap->stat_link);
>> +	spin_unlock(&heapq_lock);
>=20
> You can not use a Linux spinlock in xnheap_init and xnheap_destroy:
> - this breaks the build for the simulator;
> - callers of xnheap_init and xnheap_destroy are not guaranteed to run o=
n
> the root domain.

Oh, yes, unfortunately. That callers appear to be fixable, but that's
probably not worth it at this point. I will have to rewrite
heap_read_proc to break out of nklock frequently. Also not nice, but
less invasive.

Jan


--------------enig204B4E863B911F3FE2280922
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrcuW8ACgkQitSsb3rl5xQAUQCbBo/vXRlTfYpyAKB6di076blx
sT4AoLxkHrp2obZaKkmIq1LmXwnaVL2I
=Lzza
-----END PGP SIGNATURE-----

--------------enig204B4E863B911F3FE2280922--

