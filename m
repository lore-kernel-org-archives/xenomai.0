Message-ID: <4CD1DE12.5010309@domain.hid>
Date: Wed, 03 Nov 2010 23:11:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>	<4CCEF104.7050409@domain.hid>	<4CD11AB1.8090407@domain.hid>	<4CD13A70.8040702@domain.hid>	<4CD14B1E.4000707@domain.hid>	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>	<4CD16654.6080704@domain.hid>	<4CD18782.7090607@domain.hid>
	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>
	<4CD1BA29.9000303@domain.hid>
	<1288816871.1842.84.camel@domain.hid> <4CD1DC1B.8060407@domain.hid>
In-Reply-To: <4CD1DC1B.8060407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD01EBFBB77264DB0C671C193"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD01EBFBB77264DB0C671C193
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 03.11.2010 23:03, Jan Kiszka wrote:
> Am 03.11.2010 21:41, Philippe Gerum wrote:
>> On Wed, 2010-11-03 at 20:38 +0100, Anders Blomdell wrote:
>>> Jan Kiszka wrote:
>>>> Am 03.11.2010 17:46, Anders Blomdell wrote:
>>>>> Anders Blomdell wrote:
>>>>>> Anders Blomdell wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> additional barrier. Can you check this?
>>>>>>>>
>>>>>>>> diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
>>>>>>>> index df56417..66b52ad 100644
>>>>>>>> --- a/include/nucleus/sched.h
>>>>>>>> +++ b/include/nucleus/sched.h
>>>>>>>> @@ -187,6 +187,7 @@ static inline int xnsched_self_resched_p(str=
uct=20
>>>>>>>> xnsched *sched)
>>>>>>>>    if (current_sched !=3D (__sched__))    {                \
>>>>>>>>        xnarch_cpu_set(xnsched_cpu(__sched__),=20
>>>>>>>> current_sched->resched);    \
>>>>>>>>        setbits((__sched__)->status, XNRESCHED);                \=

>>>>>>>> +      xnarch_memory_barrier();                        \
>>>>>>>>    }                                    \
>>>>>>>>  } while (0)
>>>>>>> In progress, if nothing breaks before, I'll report status tomorro=
w=20
>>>>>>> morning.
>>>>>> It still breaks (in approximately the same way). I'm currently put=
ting a=20
>>>>>> barrier in the other macro doing a RESCHED, also adding some traci=
ng to=20
>>>>>> see if a read barrier is needed.
>>>>> Nope, no luck there either. Will start interesting tracepoint=20
>>>>> adding/conversion :-(
>>>>
>>>> Strange. But it was too easy anyway...
>>>>
>>>>> Any reason why xn_nucleus_sched_remote should ever report status =3D=
 0?
>>>>
>>>> Really don't know yet. You could trigger on this state and call
>>>> ftrace_stop() then. Provided you had the functions tracer enabled, t=
hat
>>>> should give a nice pictures of what happened before.
>>>
>>> Isn't there a race betweeen these two (still waiting for compilation =
to=20
>>> be finished)?
>>
>> We always hold the nklock in both contexts.
>>
>=20
> But we not not always use atomic ops for manipulating status bits (but
> we do in other cases where this is no need - different story). This may=

> fix the race:

Err, nonsense. As we manipulate xnsched::status also outside of nklock
protection, we must _always_ use atomic ops.

This screams for a cleanup: local-only bits like XNHTICK or XNINIRQ
should be pushed in a separate status word that can then be safely
modified non-atomically.

Jan


--------------enigD01EBFBB77264DB0C671C193
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzR3hYACgkQitSsb3rl5xT2VQCfXmAnCLv41Q6E7qfkxpnz0Tw1
mWYAoII+RvXmFqhvAEW9m3OJPj3Ek9SO
=rTkS
-----END PGP SIGNATURE-----

--------------enigD01EBFBB77264DB0C671C193--

