Message-ID: <47090C01.4000506@domain.hid>
Date: Sun, 07 Oct 2007 18:40:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4708FAC4.1010306@domain.hid> <1191772542.22917.9.camel@domain.hid>
In-Reply-To: <1191772542.22917.9.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF4EBD74ECE268A4577DA8118"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] Fix __ipipe_pin_range_globally
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
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF4EBD74ECE268A4577DA8118
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2007-10-07 at 17:27 +0200, Jan Kiszka wrote:
>> This patch fixes another bug of I-pipe for 2.6.22:
>>
>> Due to the introduction of a pgd page cache (quicklist) into that
>> kernel,  __ipipe_pin_range_globally no longer addressed all spots that=

>> need to be updated after vmalloc'ed memory was mapped into the kernel
>> address range. The result was that, after inserting modular Xenomai, n=
ew
>> application sometimes received an outdated pgd from the quicklist, and=

>> the next timer IRQ triggered a minor fault over xeno_nucleus. As
>> handling faults inside non-root domains with the Linux handler doesn't=

>> fly, the box blew up sooner or later.
>>
>=20
> Good spot. This said, the page cache is fairly old stuff, introduced a
> long time ago and already present in 2.6.10, so this means that all
> patches featuring the on-demand mapping disable support do have the sam=
e
> problem.

Indeed. But somehow the switch to quicklist or some other pieces of
2.6.22 must have changed the preconditions of this issue. I'm using
Xenomai in modular form since ages on my notebook but only got that
lockups over 2.6.22. Anyway, so we should back-port my patch and also
spread it to the other archs.

>=20
>> So I've reworked __ipipe_pin_range_globally, basing it on pgd_list, th=
e
>> list of all pgd pages (in use or cached) in the system, and folding
>> __ipipe_pin_range_mapping into it. That makes __ipipe_pin_range_global=
ly
>> an arch-specific thing from now on.
>>
>> So far the quicklist is only biting us on i386, but I would suggest to=

>> check if/how we can apply this new pattern on other archs as well.
>>
>> Jan
>>
>> PS: UP is now stable with latest Xenomai here, but SMP unfortunately
>> still misbehaves (I suspect host timer issues).
>>
>=20
> I still have a problem with UP here, but this one is due to a Xenomai
> bug -- host timer is no more forwarded when the nucleus timer starts.
> Does disabling NOHZ & HIRES get things working on your setup?
>=20

Yes, I have HIRES on, and I guess that's the point: My current
impression is that there are some bits in Xenomai missing to migrate
running hires timers from Linux's lapic clockevent device over xntimers. =

The effect here is that CPU0 continues (probably due to higher timer
load) while CPU1 stops scheduling timers:

CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
0    2729        2727        31168      -          NULL         [host-tim=
er/0]
0    11          10          305103844  1000000000  xnpod_watch  [watchdo=
g]
1    11          10          309365472  1000000000  xnpod_watch  [watchdo=
g]

Jan


--------------enigF4EBD74ECE268A4577DA8118
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHCQwBniDOoMHTA+kRAlV+AJ4w99DwdnqhdFdXZGhzFyYE5+T7LwCdH9LG
wuDWBh0PAGkL0Ci2Cne0b+4=
=eDdr
-----END PGP SIGNATURE-----

--------------enigF4EBD74ECE268A4577DA8118--

