Message-ID: <444F9F39.6080606@domain.hid>
Date: Wed, 26 Apr 2006 18:26:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1FYmA5-0003S9-00@domain.hid> <444F9BDB.200@domain.hid>
	<444F9DA7.2060402@domain.hid>
In-Reply-To: <444F9DA7.2060402@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFAA28ECCFCDE5453237A90AB"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] Re: Adeos-cvs Digest, Vol 10, Issue 11
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFAA28ECCFCDE5453237A90AB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> adeos-cvs-request@domain.hid wrote:
>>
>>> ...
>>> Commit from rpm (2006-04-26 17:41 CEST)
>>> ---------------
>>>
>>> Make IPIPE_TRACE_PATHS configurable
>>>
>>>  ipipe  v2.6/common/kernel/ipipe/tracer.c       1.10
>>>  ipipe  v2.6/common/kernel/ipipe/Kconfig.trace  1.4
>>
>>
>> From a quick glance it appears to me you provided a nice interface to
>> break some stuff :). At least the explanation is not correct.
>>
>> Those four paths are required to 1) always have an active path at hand=

>> for recording, 2+3) keep the latest max or frozen path, and 4) escape
>> with to an alternative slot during max/frozen updates in case the
>> previous one is currently locked for output or whatever and cannot
>> become the new active path.
>>
>> So, the absolute minimum is 3 when there is definitely no concurrent
>> usage of ipipe_trace_begin/end vs. ipipe_trace_freeze (remember that
>> users may want to define their own begin/end points if
>> IPIPE_TRACE_IRQSOFF is not set). Raising it above 4 is of no practical=

>> use so far.
>>
>> What is your idea behind it?
>>
>=20
> My idea is that 4 paths consume way too much memory and causes my
> embedded ppc setup to choke at boot. The usual culprits like a bad
> download address passed to u-boot and friends are not involved this
> time, so until I figure out what on earth is causing this havoc, I'd
> like to be able to lower this value to 2 by configuration.
>=20

Then better make IPIPE_TRACE_POINTS configurable. Also the whole
ipipe_trace_begin/end interface could be made optional so that the
number of paths could be reduced by _1_ (not more...).

Jan


--------------enigFAA28ECCFCDE5453237A90AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFET585niDOoMHTA+kRAs+oAJ99dEVqOIXjUqCmMStHoNCY1bRM7gCfSOhh
5voZSViTDwjgZN5ULUO5iQc=
=ESLj
-----END PGP SIGNATURE-----

--------------enigFAA28ECCFCDE5453237A90AB--

