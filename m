Message-ID: <4580381E.4060501@domain.hid>
Date: Wed, 13 Dec 2006 18:27:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4576842B.1090203@domain.hid> <1165398116.7218.31.camel@domain.hid>	
	<458032AC.4060707@domain.hid> <1166030688.5360.171.camel@domain.hid>
In-Reply-To: <1166030688.5360.171.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C1F463E7FF1F02463C23A45"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Adeos-main] [RFC] type-based spinlock op
	selection
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C1F463E7FF1F02463C23A45
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-12-13 at 18:04 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2006-12-06 at 09:49 +0100, Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> reading through the I-pipe patch I noticed that there are quite a fe=
w
>>>> spin_lock->spin_lock_hw and similar conversions. Having the conversi=
on
>>>> mechanism of the -rt patch in mind, I wrote the attached I-pipe clea=
nup
>>>> that applies a similar pattern on this issue. Gives more than 10k pa=
tch
>>>> size reduction for x86 and a bit more safety against minor variation=
s of
>>>> the patched code. Still, review of the lock usages keeps on being
>>>> required as the lock user could assume running IRQs off while I-pipe=
 may
>>>> not guarantee this.
>>>>
>>>> The required patch for Xenomai is attached as well.
>>>>
>>> I definitely like this. Queued for testing, thanks.
>>>
>> Small update of the ipipe part: typecasts were missing for the
>> SMP||DEBUG_SPINLOCK case.
>=20
> I saw this recently, thanks. I'm currently working on 1.6-02, which
> includes the spinlock op selection, and yet-another-rework of the
> interrupt flow. Did anything changed regarding the tracer in the
> attached patch?
>=20

Nope, only the linux/spinlock.h should be different (unless I messed
something up). Do you get rejects?

I'm currently preparing to post a few cleanup patches for I-pipe (and
Xenomai). Not a must for -02, but maybe worth a glance. Just a minute...


--------------enig6C1F463E7FF1F02463C23A45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgDgeniDOoMHTA+kRAiLQAJ9xSTaKWkiM1iRvcqI/ZSa89XITswCfVumB
QwHZcvznVBG21wKsswE3WtI=
=3V6l
-----END PGP SIGNATURE-----

--------------enig6C1F463E7FF1F02463C23A45--

