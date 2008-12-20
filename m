Message-ID: <494D658A.9030705@domain.hid>
Date: Sat, 20 Dec 2008 22:37:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081219084446.8148.89319.stgit@domain.hid>
	<494D1ED5.2090300@domain.hid> <494D5A00.6070809@domain.hid>
	<494D5CFE.8020406@domain.hid> <494D5E35.2010208@domain.hid>
In-Reply-To: <494D5E35.2010208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3AB2BFD820F291CB47F8A589"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH  0/3] NMI watchdog fixes / enhancements
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3AB2BFD820F291CB47F8A589
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> This is basically a repost of the NNI watchdog series I sent out a =
few
>>>>> weeks ago. I just rebased things over latest trunk and fixed some
>>>>> warnings.
>>>>>
>>>>> All patches are also available at
>>>>> git://git.kiszka.org/xenomai.git nmi-wd-queue
>>>> That is a lot of stuff to review. I am afraid it is impossible to re=
view
>>>> everything, so the only thing we can rely on is testing, hence the n=
ext
>>>> question: have these patches been tested in every configuration
>>>> (enabled, disabled, built-in, module, voluntary overrun)?
>>> In most configurations, but definitely not in all (they are too many)=
=2E
>>>
>>> This is a debugging tool, so first of all the disabled case must not
>>> cause harm, and I'm quite sure I haven't changed anything regarding
>>> this. Moreover, the enabled case was not working for many recent
>>> platforms anymore as we were lacking P6 support. So there shouldn't b=
e
>>> much to loose.
>> I disagree: the current version compiles in all configurations tested
>> until now, and happened to work when enabled at some point in the past=
=2E
>> I find it annoying, to say the least, when I want to test something on=

>> trunk, that some previous unrelated commit breaks a configuration
>> because it was not tested. So, please test your patch. The
>> configurations to test are not so numerous: disabled, enabled built-in=

>> with an overrun check, enabled in module with an overrun check, repeat=

>> for x86_64. That makes 6 configurations, not that much.
>=20
> The trivial ones have been tested, of course. But keep in mind that
> there are more variables (CPU types , kernel versions, interfering
> config settings, etc.) that create much more that 6 variants to be buil=
t
> and run.

To give an example of untested scenarios: Current trunk does not build
against 2.6.27 for x86-32 with NMI watchdog enabled (die_nmi gained
another argument doe to unification with x86-64). Well, my patch does
not change this picture yet (I once tested against 2.6.26 for 32-bit
support). Will fix this as well.

Jan


--------------enig3AB2BFD820F291CB47F8A589
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklNZY8ACgkQniDOoMHTA+mHjQCeLkHB8AqNdaODFaLCRpMyd8i/
oyQAmgMBbBxWcEZMRRc9HPBibEWq0Z+1
=T2OU
-----END PGP SIGNATURE-----

--------------enig3AB2BFD820F291CB47F8A589--

