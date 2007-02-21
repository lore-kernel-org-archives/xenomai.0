Message-ID: <45DC0CAA.2050001@domain.hid>
Date: Wed, 21 Feb 2007 10:11:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Enhanced RTDM device closure
References: <45DC0623.3080706@domain.hid> <45DC0939.6070207@domain.hid>
In-Reply-To: <45DC0939.6070207@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B2AD316C5C1669AC07C710A"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B2AD316C5C1669AC07C710A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> a few changes of the RTDM layer were committed to trunk recently. They=

>> make handling of RTDM file descriptors more handy:
>>
>>  o rt_dev_close/POSIX-close now polls as long as the underlying device=

>>    reports -EAGAIN. No more looping inside the application is required=
=2E
>>    This applies to the usual non-RT invocation of close, the corner
>>    case "close from RT context" can still return EAGAIN.
>>
>>  o Automatic cleanup of open file descriptors has been implemented. Th=
is
>>    is not yet the perfect design (*), but a straightforward approach t=
o
>>    ease the cleanup after application crashes or other unexpected
>>    terminations.
>>
>> The code is still young, so testers are welcome.
>>
>> Jan
>>
>>
>> (*) Actually, I would like to see generic per-process file descriptor
>> tables one day, used by both the POSIX and the RTDM skin. The FD table=

>> should be obtained via xnshadow_ppd_get().
>=20
> I agree for the file descriptor table, but I do not see why it should b=
e
> bound to xnshadow_ppd_get. The file descriptor table could be
> implemented in an object like fashion, where the caller is responsible
> to pass the same pointer to the creation, use and desctruction routines=
=2E

But where to get this pointer from when I enter, say, rtdm_ioctl on
behalf of some process? The caller just passes an integer, the file
descriptor.

> This would allow, for example, to have a descriptor table for
> kernel-space threads. Another feature that would be interesting for the=


I don't see the need to offer kernel threads private fd tables. They can
perfectly continue to use a common, then kernel-only table. There are
too few of those threads, and there is no clear concept of a process
boundary in kernel space.

> posix skin would be to have a callback called at process fork time in
> order to duplicate the fd table.

Ack. IIRC, this callback could also serve to solve the only consistency
issue of the ipipe_get_ptd() approach.

>=20
>=20
>  But first this requires
>> lock-less xnshadow_ppd_get() based on ipipe_get_ptd() to keep the
>> overhead limited. Yet another story.
>=20
> xnshadow_ppd_get is already lockless, usual callers have to hold the
> nklock for other reasons anyway.
>=20

OK, depends on the POV :). Mine is that the related RTDM services do not
hold nklock and will never have to. Moreover, there is no need for
locking design-wise, because per-process data cannot vanish under the
caller unless the caller vanishes. The need currently only comes from
the hashing-based lookup (reminds me of the WCET issues kernel futexes
have...).

Jan


--------------enig6B2AD316C5C1669AC07C710A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3AyqniDOoMHTA+kRAkjWAJ46+sjTEUyQZY/QA+mo8OAf9tO/FgCfVZ4O
O35Dcye4Gz4V2pO03tWPtrM=
=xpKb
-----END PGP SIGNATURE-----

--------------enig6B2AD316C5C1669AC07C710A--

