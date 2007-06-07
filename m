Message-ID: <466818F2.3010908@domain.hid>
Date: Thu, 07 Jun 2007 16:40:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid>
	<46651F7D.9090702@domain.hid>	<18021.58231.177931.286548@domain.hid>	<46668CC3.8050002@domain.hid>
	<4666ACE5.7030200@domain.hid>	<4666AFB3.6040602@domain.hid>
	<4666B4C7.6020308@domain.hid>	<4666B716.6010909@domain.hid>
	<18022.64424.836736.431121@domain.hid>
	<46670109.7070408@domain.hid> <4667FF8E.2000207@domain.hid>
	<466801CD.8010909@domain.hid> <466810EC.3030707@domain.hid>
	<46681512.7060102@domain.hid>
In-Reply-To: <46681512.7060102@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig44CB078D3BA3834CA5B0BACF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Updates, timerstats, rtdm-timers
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
--------------enig44CB078D3BA3834CA5B0BACF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Jan Kiszka wrote:
>>>>
>>>>
>>>>> Gilles Chanteperdrix wrote:
>>>>>
>>>>>
>>>>>> So, Ok, I will try to do something for x86 (either reduce the numb=
ers of
>>>>>> registers used by the C code, or reduce the assembly to the bare
>>>>>> minimum). But, please, pick my generic implementation of llmulshft=
, it
>>>>>> was carefully written.
>>>>> Yes, it is the better choice for 32 bit archs (my previous tests di=
dn't
>>>>> reflect the usage in Xenomai truely, redoing them made my generic
>>>>> version fall behind yours). Will include it.
>>>> Done, see -v6. Then I added that two-liner for x86_64 rthal_llmulshf=
t,
>>>> fixed the BITS_PER_LONG bug, and enabled generic-based support for A=
RM
>>>> (testing welcome!).
>>>>
>>>> At this chance: My series now also includes rthal_llimd for x86_64,
>>>> another two-liner.
>>> v6 is not in the download area.
>>>
>>
>> Mpf, forgot to press "update". Done.
>=20
> Ok, I agree with the fast-tsc-to-ns patch: I could not get gcc to
> generate code with less moves on x86 (which is, for me, if it was still=

> needed, yet another proof that these register moves are harmless).

No question -- from the average performance POV.

>=20
> However, I do not agree with the x86_64 llimd: it will not work if m is=

> greater than 2G, that is why we implement llimd in terms of ullimd on
> other architectures.
>=20

Please help me, I don't see it yet:

m is 32 bit and gets extended to 64 bit without considering any sign (as
it should be). Then we multiply 64x64 bit signed, but we know for sure
that the second multiplier is always positive. Same for division. Basic
tests ((-1*1000000000)/2 vs. (-1*3000000000)/2) confirmed this on the
target.

Jan


--------------enig44CB078D3BA3834CA5B0BACF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaBjyniDOoMHTA+kRAhi2AJ48YTs4ohZY+P1nQ/bztGaZ+6XYaACfQX0m
4dugltEljtsEgblWVhJKrWo=
=Cinn
-----END PGP SIGNATURE-----

--------------enig44CB078D3BA3834CA5B0BACF--

