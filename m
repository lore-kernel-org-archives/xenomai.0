Message-ID: <4BCC9628.7030809@domain.hid>
Date: Mon, 19 Apr 2010 19:43:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BCC619E.2@domain.hid> <4BCC6CEE.70907@domain.hid>	
	<4BCC6E3C.3090301@domain.hid> <4BCC7092.1030809@domain.hid>	
	<4BCC71AF.4030903@domain.hid> <4BCC77BD.9040900@domain.hid>	
	<4BCC78D5.3010405@domain.hid> <4BCC7D88.4070403@domain.hid>
	<1271693411.16659.128.camel@domain.hid>
	<4BCC814C.6050003@domain.hid> <4BCC8484.1020108@domain.hid>
	<4BCC9107.1080605@domain.hid> <4BCC9247.10709@domain.hid>
In-Reply-To: <4BCC9247.10709@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD50406E43F7F2ECE845628B5"
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
--------------enigD50406E43F7F2ECE845628B5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>>>>> config XENO_OPT_DEBUG_FOO
>>>>>>>> 	bool "..."
>>>>>>>>
>>>>>>>> config XENO_OPT_DEBUG_FOO_P
>>>>>>>> 	int
>>>>>>>> 	default "1" if XENO_OPT_DEBUG_FOO
>>>>>>>> 	default "0"
>>>>>>>>
>>>>>>>> and XENO_DEBUG() could be extended to test for
>>>>>>>> CONFIG_XENO_OPT_DEBUG_FOO_P when given "FOO". I'm just not sure =
if this
>>>>>>>> can be expressed for legacy 2.4 kernels, so it might have to wai=
t for
>>>>>>>> Xenomai 3.
>>>>> Well, actually, I would not merge this in Xenomai 3. I find this ra=
ther
>>>>> overkill; mainline first I mean, and mainline, i.e. the Xenomai cod=
e
>>>>> base only requires a simple and straightforward way to get debug
>>>>> switches right. Having to make Kconfig a kitchen sink for some unkn=
own
>>>>> out of tree modules to be happy is not really my preferred approach=
 in
>>>>> this particular case.
>>>>>
>>>>> Don't get me wrong, I'm not opposed to a more decentralized approac=
h on
>>>>> the paper, it's just that I only care about the mainline tree here.=

>>>> The point is not out-of-tree but robustness. Neither the current
>>>> decentralized #ifdef-#define nor its centralized brother meet this
>>>> criteria. An approach like the above which forces you to provide all=

>>>> required bits before any of the cases (disabled/enabled) starts to w=
ork
>>>> does so.
>>> Ok. What about:
>>>
>>> #define __name2(a, b) a ## b
>>> #define name2(a, b) __name2(a, b)
>>>
>>> #define DECLARE_ASSERT_SYMBOL(sym)					\
>>> 	static const int CONFIG_XENO_OPT_DEBUG_##sym##0 =3D 0,		\
>>> 		__CONFIG_XENO_OPT_DEBUG_##sym =3D name2(CONFIG_XENO_OPT_DEBUG_##sym=
, 0)
>>>
>>> #define XENO_ASSERT(subsystem,cond,action)  do { \
>>>     if (unlikely(__CONFIG_XENO_OPT_DEBUG_##subsystem > 0 && !(cond)))=
 { \
>>>         xnarch_trace_panic_freeze(); \
>>>         xnlogerr("assertion failed at %s:%d (%s)\n", __FILE__, __LINE=
__, (#cond)); \
>>>         xnarch_trace_panic_dump(); \
>>>         action; \
>>>     } \
>>> } while(0)
>>>
>>> DECLARE_ASSERT_SYMBOL(NUCLEUS);
>>>
>>> It fails to compile when the debug symbol is set and
>>> DECLARE_ASSERT_SYMBOL is missing, which plugs the failure of my previ=
ous
>>> attempt.
>> I'm still wrapping my head around this. What would be the usage,
>>
>> #ifndef CONFIG_XENO_OPT_DEBUG_FOO
>> #define CONFIG_XENO_OPT_DEBUG_FOO 0
>> #endif
>>
>> DECLARE_ASSERT_SYMBOL(FOO);
>>
>> ? If the compiler is smart enough to still drop the asserts based on
>> static const, I'm fine as this is an improvement.
>=20
> No, you just use DECLARE_ASSERT_SYMBOL(FOO)

Would be nice - if it worked.

>=20
>> Still, IMHO, this solution would not even win the second league beauty=

>> contest (now it comes with as many additional lines as the
>> Kconfig-approach).
>=20
> Yes, it is not pretty but to add a config option you just add the usual=

> Kconfig stuff, then DECLARE_ASSERT_SYMBOL in the code instead of the
> #ifndef #define foo 0 #endif.
>=20
> If you do not do it, you get a compilation error whether the option is
> enabled or not.
>=20
> It can be decentralized, the find | grep mentioned earlier will still w=
ork.

If we can make it work like that, I'm all for it. But:

error: initializer element is not constant
(when disabled)

or

error: =E2=80=98y0=E2=80=99 undeclared here (not in a function)
(when enabled)

I'm afraid the preprocessor is not powerful enough for this task (we
would need macros that include preprocessor conditionals).

Jan


--------------enigD50406E43F7F2ECE845628B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvMljUACgkQitSsb3rl5xRD+QCfcUJ/9x29R8ITmsnPFKPCbo+N
7s4An18/lizSSspQxd9GXEi61JJyFqo/
=MW5i
-----END PGP SIGNATURE-----

--------------enigD50406E43F7F2ECE845628B5--

