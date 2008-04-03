Message-ID: <47F4D68C.6020208@domain.hid>
Date: Thu, 03 Apr 2008 15:07:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>	<d6c8ef150804030300p3a4c719tca9903aa7663a5d9@domain.hid>
	<7289437c0804030552q79d1bb84jf5f40d1a57a443b5@domain.hid>
In-Reply-To: <7289437c0804030552q79d1bb84jf5f40d1a57a443b5@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB70AADE98D27B02EC49A3BC9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Question about rtdm_mmap_to_user()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB70AADE98D27B02EC49A3BC9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
>> Why don't you try rt_heap_* functions? Quick example:
>>
>> Kernel space:
>>
>> RT_HEAP heap_desc;
>> void *shared;
>>
>> rt_heap_create (&heap_desc, "MySHM", 2048, H_SHARED);
>> rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
>> [.. cleanup ..]
>> rt_heap_delete (&heap_desc);
>> User space:
>>
>> RT_HEAP heap_desc;
>> void *shared;
>>
>> rt_heap_bind (&heap_desc, "MySHM", TM_NONBLOCK);
>> rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
>> [..cleanup..]
>> rt_heap_unbind (&heap_desc);
>=20
> I tried exactly what you wrote. And it doesn't work. I have error -11. =
It
> doesn't find the Heap I created in kernel space.
> I don't understand why. I put exactly the same name.

Mixing up RTDM and native API usage, though technically feasible, isn't=20
a good idea anyway. Better have a look at Hannes' example, and if that=20
one or your own version still doesn't work, post more details (Xenomai=20
version, target architecture, test code, etc.).

Jan


--------------enigB70AADE98D27B02EC49A3BC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH9NaSniDOoMHTA+kRAv0UAJsHQs4FxEBjP5FYHWS9LTGMmiAwqQCdFPpb
6MxivnE19ZTMti0lBcg72SU=
=SeDc
-----END PGP SIGNATURE-----

--------------enigB70AADE98D27B02EC49A3BC9--

