Message-ID: <46D59084.20205@domain.hid>
Date: Wed, 29 Aug 2007 17:28:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F1@domain.hid>	
	<46D58382.5020201@domain.hid> <1188400027.6009.147.camel@domain.hid>
In-Reply-To: <1188400027.6009.147.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5CA15694F5F2494D586370AA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM timeout value
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
Cc: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5CA15694F5F2494D586370AA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2007-08-29 at 16:32 +0200, Jan Kiszka wrote:
>> Markus Osterried (BA/EDD) wrote:
>>> Hi,
>>>
>>> it seems that in the RTDM API, all the timeout functions which use
>>> nanosecs_rel_t have a strange behaviour.
>>> The timeout in nanoseconds is converted to ticks and the number of ti=
cks
>>> is rounded down. So when we want to wait e.g. 500000 nanoseconds and =
the
>>> timertick is 1 ms, xnpod_ns2ticks() rounds down to 0. But 0 is the
>>> special value RTDM_TIMEOUT_INFINITE, so we wait forever. I use Xenoma=
i
>>> 2.3.1, but I think it's basically the same in trunk.
>> It should even impact other skins as well when in tick-based timing
>> mode. I would bet more users of xnpod_ns2ticks() may have overseen thi=
s
>> rounding issue - like RTDM did.
>>
>=20
> Other skins may only mean POSIX and native, since the other ones only
> deal with ticks.

Ah, yeah, of course.

POSIX is safe because it does well-defined rounding on its own. Native
itself has no problem, just the user may get informed about the rounding
behaviour of rt_timer_ns2ticks. Otherwise, things like rt_sem_p(sem,
rt_timer_ns2ticks(some_nanos)) may unexpectedly behave like RTDM does now=
=2E

>=20
>>> Wouldn't it be better to round up the ticks instead of round it down?=

>> Hmm, probably. Mind to work out a patch for xnpod_ticks2ns()?
>>
>> What do others think about this issue? Can/should we change the roundi=
ng
>> behaviour at nucleus level?
>>
>=20
> Clearly not. You don't change the core rounding policy for fixing
> shortcomings in the higher levels, especially to fix invalid applicatio=
n
> requests. I do want to be able to round down at nucleus level, which I
> would not be able to do anymore with a rounding up policy at core level=
=2E
> This change belongs to the skin which wants this behaviour.

Agreed, we primarily need to fix RTDM here.

But what about introducing generic xnpod/xntbase_ns2ticks_floor/ceil()
for this? Would avoid more re-inventions of this common service.

Jan


--------------enig5CA15694F5F2494D586370AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1ZCEniDOoMHTA+kRAgKCAJ0dfeQnpmXYkmY2faqoipv/jUFnvgCfWGDO
dPQGlWaY34M01Le3OFrMFzs=
=MWPg
-----END PGP SIGNATURE-----

--------------enig5CA15694F5F2494D586370AA--

