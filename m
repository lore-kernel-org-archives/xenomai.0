Message-ID: <48E8C1BC.3050800@domain.hid>
Date: Sun, 05 Oct 2008 15:31:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1KmEP8-0003wS-5y@domain.hid>
	<48E8AFB4.4040208@domain.hid>	<48E8B29D.5040705@domain.hid>
	<48E8B704.8030403@domain.hid> <48E8B91B.1060502@domain.hid>
	<48E8BF4A.2030409@domain.hid>
In-Reply-To: <48E8BF4A.2030409@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5B07AE697670C2EC93D06595"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-commits] r4210 - in /trunk:	ChangeLog
 src/skins/native/task.c
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
--------------enig5B07AE697670C2EC93D06595
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Author: gch
>>>>>> Date: Sat Oct  4 23:11:09 2008
>>>>>> New Revision: 4210
>>>>>>
>>>>>> URL: http://svn.gna.org/viewcvs/xenomai?rev=3D4210&view=3Drev
>>>>>> Log:
>>>>>> Call __real_pthread_setschedparam in order to inform the libc of t=
he scheduling parameters change.
>>>>> Well, I dropped this idea after realizing that it will kick us out =
of
>>>>> primary mode in all cases. This change is an improvement (/wrt Linu=
x
>>>>> scheduling accuracy) for borderline threads, but it will cause
>>>>> regressions for primary-only threads. I have no idea right now how =
to
>>>>> make both happy, at least without explicit pthread_setschedparam
>>>>> invocations by the user application.
>>>> Well, we discussed this on the xenomai mailing list, you did not ans=
wer,
>>>> so we assumed you agreed.
>>> I do not find any hint in that thread that we agreed on changing the
>>> implementation. Rather I took back my suggestion to do it like #4210.=

>>> And you proposed to install some signal for syncing glibc /wrt
>>> priorities. When changing something, then I would say explore this pa=
th
>>> first.
>> We are used to hear you when you do disagree... So, since you did not
>> answer Philippe mail who said "it is certainly debatable", we assumed
>> you agreed. But we certainly were wrong.

I may have misunderstood that this early statement in the discussion was
still valid after we dug deeper into the topic.

>>
>>> Turning rt_task_set_priority into secondary-mode service is a critica=
l
>>> change, and only the last resort if we consider its current
>>> implementation as totally broken - I wouldn't say it is like that. It=
's
>>> partially and, unfortunately, silently broken, ie. lacking documentat=
ion
>>> about its limitations. But its perfectly OK for primary-only users.
>> No, an important invariant of Xenomai is that the priority scales are
>> synchronized between Xenomai and Linux. So, if Linux does not see the
>> same priority as Xenomai, the implementation is broken. Imagine for
>> instance that your primary-only thread posts an NPTL semaphore, knowin=
g
>> that a switch will not occur so that it will not leave primary mode. I=
f
>> the glibc does not see the correct priority, then a mode switch may
>> occur whereas it should not. This is a bit far-fetched, but who knows
>> what else may happen if the priorities are not synchronized. We
>> absolutely want the priorities to be synchronized.

I understand the deep desire to keep the priorities in sync for those
threads that go to secondary mode (or at least accept occasional switches=
).

But no one will (OK: should) seriously build a primary-only design based
on assumptions about the glibc locking and syscall behavior. Practice
teaches that this is doomed to break - at latest on next glibc update
(or what other standard third-party lib). Primary-only means only safe
Xenomai services or well-audited library calls. So turning some Xenomai
service into an unsafe one remains a critical step, even if it fixes
other use cases.

>=20
> Ok. I am looking at the SIGWINCH change.
>=20

Great, TiA.

Jan


--------------enig5B07AE697670C2EC93D06595
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjowb8ACgkQniDOoMHTA+nOIgCeK0tNAm6SkQaLokLzaD0j+kTo
2/4An05ikVF8lscpQHU2dvNfO6CvHUqT
=m/qn
-----END PGP SIGNATURE-----

--------------enig5B07AE697670C2EC93D06595--

