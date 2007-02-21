Message-ID: <45DC8F03.4020703@domain.hid>
Date: Wed, 21 Feb 2007 19:27:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] latency results for ppc and x86
References: <725115.56324.qm@domain.hid>
	<Pine.LNX.4.60.0702211019590.2291@domain.hid>
	<45DC23D4.5090000@domain.hid>
	<Pine.LNX.4.60.0702211116020.2526@domain.hid>
	<45DC3B13.5090200@domain.hid>
	<Pine.LNX.4.60.0702211302290.2780@domain.hid>
	<45DC4E6A.6090708@domain.hid> <45DC5CAC.8020901@domain.hid>
	<Pine.LNX.4.60.0702211552170.3327@domain.hid>
In-Reply-To: <Pine.LNX.4.60.0702211552170.3327@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC2F4524C50DA2E4ADED77BD8"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Nicholas Mc Guire <der.herr@domain.hid>
Cc: adeos-main@gna.org, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2F4524C50DA2E4ADED77BD8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicholas Mc Guire wrote:
>>>> well thats true for ADEOS/RTAI/RTLinux as well - we are also only
>>>> black-box testing the RT-kernel - there currently is absolutley NO
>>>> prof for worst-case timing in any of the flavours of RT-Linux.
>>>
>>> Nope, it isn't. There are neither sleeping not spinning lock nesting
>>> depths of that kind in Xenomai or Adeos/I-pipe (or older RT extension=
s,
>>> AFAIK) - ok, except for one spot in a driver we have scheduled for
>>> re-design already.
>=20
> that might be so - never the less there is no formal-proof that the wor=
st
> case of ADEOS/I-pipe is X-microseconds, the latency/jitter numbers are
> based on black-box testing. In fact one problem is that there are not e=
ven
> code-coverage tools (or I just did not find them) that can provide
> coverage data for ADEOS - thus how can one guarantee worst-case ?

The fact that tool support is "improvable" doesn't mean that such an
analysis is impossible. You may over-estimate, but you can derive
numbers for a given system (consisting of real-time core + RT
applications) based on a combined offline system analysis and runtime
measurements. But hardly anyone is doing this "for fun".

>>>> The essence for me is that with
>>>> the work in 2.6.X I don't see the big performance jump provided by t=
eh
>>>> hard-RT variants around - especially with respect to guaranteed wors=
t
>>>> case (and not only "black-box" results).
>>>
>>> Could it be a bit too enthusiastic to base such an assessment on a
>>> corner-case demonstration?
>=20
> its not a corener case demonstration, Ive been doing benchmarks on rt
> preempt now for quite some time, there is still an advantage if you run=

> simple comparisons (jitter measurements) - but it is clearly going down=
,
> The problem I have with RT-preempt being 50us and ADEOS is 15us is
> simply that the sector that does need those numbers that RT-preempt wil=
l
> most likely
> never reach is generally interested in guaranteed times, and thats wher=
e
> it becomes tough to argue any of the hard-realtime extensions at this
> point - that is not saying RT-preempt can replace ADEOS/RTAI/RTLinux-gp=
l
> Im just saying that the numbers are no longer 2/3 orders of
> magnitude,which they were in 2.2.X/2.4.X and where arguing the use was
> simple.

Granted, arguing becomes more hairy when you have to pull out low-level
system details like I posted (and not discussing individual issues of
certain patches). There are scenarios where I would recommend -rt as
well, but so far only few where RT extensions are fitting too.

>=20
> Don't get me wrong Im not trying to argue away ADEOS/RTAI or I would
> have given up RTLinux/GPL quite some time ago - but I belive if these
> low-jitter/latency systems want to keep there acceptance in industry a
> key issue will be to improve the tools for verification/validation -

Ack, and I'm sure they will emerge over the time. I don't expect this to
happen just because someone enjoys it (adding features is always
funnier), but because users will at some point really need them. It's a
process that will derive from the steadily growing professional user
base in both industry and academia.

> just take this discussion - it started out with:
>=20
> <snip>
>> RTD|      -1.585|       7.556|      16.275|       0|
>>    -1.585|      16.275
>=20
> Latencies are mainly due to cache refills on the P4. Have you already
> put load onto your system? If not, worst case latencies will be even
> longer.

As pointed out earlier in this thread, those numbers doesn't tell much
without appropriate load and a significant runtime. We are maintaining
documentation on this in Xenomai, but it may be too tricky to find. And
as always, such a test only represents one simple snapshot. At least you
have to redo this on the target hardware with all peripheral devices in u=
se.

>=20
> <snip>
>=20
>  THAT is a problem in arguing for ADEOS/I-pipe - WHAT is the worst case=

> now ? what is the cause of the worst case ? and can I really demonstrat=
e
> by strong evidence that the worst case on this system is actually XXXX
> microseconds under arbitrary load and will not be higher in some strang=
e
> corner cases ?

Leaving the completely formal proof aside (that's something even
microkernels still cannot provide), you may go to the drawing board,
develop a model of your _specific_ system, derive worst-case
constellations, and trace the real system for those events (probably
also stimulating them) while measuring latencies. Then add some safety
margin ;), and you have worst-case numbers of a far higher quality then
by just experimenting with benchmarks. This process can become complex
(ie. costly), but it is doable.

The point about co-scheduling approaches is here, that they already come
with a simpler base model (for the RT part), and they allow to "tune"
your system to simplify this model even further - without giving up an
integrated non-RT execution environment and its optimisations. We will
see the effect better on upcoming multi-core systems (not claiming that
Xenomai is already in /the/ perfect shape for them).


However, if you have suggestions on how to improve the current tool
situation, /me and likely others are all ears. And such improvements do
not have to be I-pipe/Xenomai-specific...

Jan


--------------enigC2F4524C50DA2E4ADED77BD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3I8DniDOoMHTA+kRAqRiAJ9/sJCr45+Lgd1hMtG6Dx/Rw8ykhgCfa9Vk
B+ShdsQSN03XGSelf1L+7CE=
=TaaZ
-----END PGP SIGNATURE-----

--------------enigC2F4524C50DA2E4ADED77BD8--

