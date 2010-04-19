Message-ID: <4BCCB828.4070506@domain.hid>
Date: Mon, 19 Apr 2010 22:08:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BCC619E.2@domain.hid>
	<4BCC6CEE.70907@domain.hid>		<4BCC6E3C.3090301@domain.hid>
	<4BCC7092.1030809@domain.hid>		<4BCC71AF.4030903@domain.hid>
	<4BCC77BD.9040900@domain.hid>		<4BCC78D5.3010405@domain.hid>
	<4BCC7D88.4070403@domain.hid>	<1271693411.16659.128.camel@domain.hid>	<4BCC814C.6050003@domain.hid>
	<4BCC8484.1020108@domain.hid>	<4BCC9107.1080605@domain.hid>
	<4BCC9247.10709@domain.hid>	<4BCC9628.7030809@domain.hid>
	<4BCC9ADA.2020909@domain.hid> <4BCC9D8D.10906@domain.hid>
	<4BCC9E81.8000209@domain.hid> <4BCC9F49.1010302@domain.hid>
	<4BCCA30A.7050208@domain.hid> <4BCCA3C0.7040209@domain.hid>
	<4BCCAA38.4070000@domain.hid> <4BCCAD4D.9040600@domain.hid>
	<4BCCB107.7090800@domain.hid> <4BCCB34B.8020609@domain.hid>
In-Reply-To: <4BCCB34B.8020609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D326D515AABB48751262409"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC] fix XENO_OPT_DEBUG bugs.
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
--------------enig2D326D515AABB48751262409
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> My compiler still complains about undefined 'y0' in the enabled =
case.
>>>>>>>>
>>>>>>>> I'll try to dig into a different direction now: Automatic genera=
tion
>>>>>>>> during build. This is what the kernel does as well when the prep=
rocessor
>>>>>>>> gives up. Would even save the DECLARE and should make everyone h=
appy.
>>>>>>> No, please nothing like that.
>>>>>> Because ... ?
>>>>>>
>>>>>> BTW, I'll extend the prepare stage. Defining the proper dependenci=
es for
>>>>>> build-time generation gets too hairy.
>>>>>>
>>>>>>> This one works for me:
>>>>>>> #include <stdlib.h>
>>>>>>> #include <stdio.h>
>>>>>>>
>>>>>>> #define __name2(a, b) a ## b
>>>>>>> #define name2(a, b) __name2(a, b)
>>>>>>>
>>>>>>> #define DECLARE_ASSERT_SYMBOL(sym)                               =
       \
>>>>>>>         static const int XENO_OPT_DEBUG_##sym =3D 0; \
>>>>>>>         static const int CONFIG_XENO_OPT_DEBUG_##sym##0 =3D 0
>>>>>>>
>>>>>>> #define XENO_DEBUG(sym) \
>>>>>>>         (name2(CONFIG_XENO_OPT_DEBUG_##sym,0) > XENO_OPT_DEBUG_##=
sym)
>>>>>>>
>>>>>>> #define XENO_ASSERT(subsystem,cond,action)  do { \
>>>>>>>     if (unlikely(XENO_DEBUG(subsystem) && !(cond))) { \
>>>>>>>         xnarch_trace_panic_freeze(); \
>>>>>>>         xnlogerr("assertion failed at %s:%d (%s)\n", __FILE__, __=
LINE__, (#cond)); \
>>>>>>>         xnarch_trace_panic_dump(); \
>>>>>>>         action; \
>>>>>>>     } \
>>>>>>> } while(0)
>>>>>>>
>>>>>>> DECLARE_ASSERT_SYMBOL(NUCLEUS);
>>>>>>>
>>>>>>> int main(void)
>>>>>>> {
>>>>>>>         if (XENO_DEBUG(NUCLEUS))
>>>>>>>                 printf("Hello\n");
>>>>>>> }
>>>>>>>
>>>>>>> Please try and send me the result of pre-processing if
>>>>>>> it does not work for you.
>>>>>>>
>>>>>> Find it attached.
>>>>> It looks like you are defining CONFIG_XENO_OPT_DEBUG_NUCLEUS to be =
y
>>>>> instead of 1.
>>>> Right, my bad.
>>>>
>>>> Works now, just leaving a trace when optimization is off.
>>> I believe the current approach would have the same problem. And in an=
y
>> Nope, it's a pure preprocessor approach.
>=20
> When you use if(XENO_DEBUG(foo)) you are using the compiler, not the
> preprocessor.

Right from that POV. XENO_DEBUG(foo) itself remains preprocessor stuff,
ie. never includes potentially non-static expressions. But this part is
academic if -O0 fails to build the kernel.

>=20
> To see if there is a difference, you should try #if XENO_DEBUG(foo). An=
d
> from what I see, in that case I do not have any trace of anything gener=
ated.
>=20
>>>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>>>> index 24b1f17..d8038e0 100755
>>>> Please let me know what precisely you dislike in this approach.
>>> You have to re-run prepare-kernel when you modify the source.
>> Normally, you have to anyway as you add some header or some other sour=
ce
>> file during this process.
>=20
> Not necessarily.

At worst, you run into a build error and repeat the step. Otherwise, the
next installation will fix it silently. It's much like the missing
DECLARE_ASSERT_SYMBOL detection and resolution, IMO even more convenient.=


>=20
>>> I do not like dynamic sources generation. Especially when we have a
>>> working solution based on C pre-processor macros.
>>>
>> My prepare-kernel approach also detects stall debug stuff: The uitron
>> use of XENO_DEBUG is not backed by any config option.
>=20
> The current candidate would also detect the missing
> DECLARE_ASSERT_SYMBOL in that case.
>=20

But not

#if XENO_DEBUG(DOES_NOT_EXIST)

Jan


--------------enig2D326D515AABB48751262409
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvMuCsACgkQitSsb3rl5xRJ+QCfbHXwYDDVywqal3Yj0WB347h0
RlUAnRD7RGm4yPtSWJefjSwPOUDsNjaX
=Gun8
-----END PGP SIGNATURE-----

--------------enig2D326D515AABB48751262409--

