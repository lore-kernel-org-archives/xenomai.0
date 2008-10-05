Message-ID: <48E8C406.2040104@domain.hid>
Date: Sun, 05 Oct 2008 15:41:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1KmEP8-0003wS-5y@domain.hid>
	<48E8AFB4.4040208@domain.hid>	<48E8B29D.5040705@domain.hid>
	<48E8B704.8030403@domain.hid> <48E8B91B.1060502@domain.hid>
	<48E8BF4A.2030409@domain.hid> <48E8C1BC.3050800@domain.hid>
	<48E8C270.4080208@domain.hid>
In-Reply-To: <48E8C270.4080208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F5D48CEE34A0859FA7A1A37"
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
--------------enig4F5D48CEE34A0859FA7A1A37
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Author: gch
>>>>>>>> Date: Sat Oct  4 23:11:09 2008
>>>>>>>> New Revision: 4210
>>>>>>>>
>>>>>>>> URL: http://svn.gna.org/viewcvs/xenomai?rev=3D4210&view=3Drev
>>>>>>>> Log:
>>>>>>>> Call __real_pthread_setschedparam in order to inform the libc of=
 the scheduling parameters change.
>>>>>>> Well, I dropped this idea after realizing that it will kick us ou=
t of
>>>>>>> primary mode in all cases. This change is an improvement (/wrt Li=
nux
>>>>>>> scheduling accuracy) for borderline threads, but it will cause
>>>>>>> regressions for primary-only threads. I have no idea right now ho=
w to
>>>>>>> make both happy, at least without explicit pthread_setschedparam
>>>>>>> invocations by the user application.
>>>>>> Well, we discussed this on the xenomai mailing list, you did not a=
nswer,
>>>>>> so we assumed you agreed.
>>>>> I do not find any hint in that thread that we agreed on changing th=
e
>>>>> implementation. Rather I took back my suggestion to do it like #421=
0.
>>>>> And you proposed to install some signal for syncing glibc /wrt
>>>>> priorities. When changing something, then I would say explore this =
path
>>>>> first.
>>>> We are used to hear you when you do disagree... So, since you did no=
t
>>>> answer Philippe mail who said "it is certainly debatable", we assume=
d
>>>> you agreed. But we certainly were wrong.
>> I may have misunderstood that this early statement in the discussion w=
as
>> still valid after we dug deeper into the topic.
>>
>>>>> Turning rt_task_set_priority into secondary-mode service is a criti=
cal
>>>>> change, and only the last resort if we consider its current
>>>>> implementation as totally broken - I wouldn't say it is like that. =
It's
>>>>> partially and, unfortunately, silently broken, ie. lacking document=
ation
>>>>> about its limitations. But its perfectly OK for primary-only users.=

>>>> No, an important invariant of Xenomai is that the priority scales ar=
e
>>>> synchronized between Xenomai and Linux. So, if Linux does not see th=
e
>>>> same priority as Xenomai, the implementation is broken. Imagine for
>>>> instance that your primary-only thread posts an NPTL semaphore, know=
ing
>>>> that a switch will not occur so that it will not leave primary mode.=
 If
>>>> the glibc does not see the correct priority, then a mode switch may
>>>> occur whereas it should not. This is a bit far-fetched, but who know=
s
>>>> what else may happen if the priorities are not synchronized. We
>>>> absolutely want the priorities to be synchronized.
>> I understand the deep desire to keep the priorities in sync for those
>> threads that go to secondary mode (or at least accept occasional switc=
hes).
>>
>> But no one will (OK: should) seriously build a primary-only design bas=
ed
>> on assumptions about the glibc locking and syscall behavior. Practice
>> teaches that this is doomed to break - at latest on next glibc update
>> (or what other standard third-party lib). Primary-only means only safe=

>> Xenomai services or well-audited library calls. So turning some Xenoma=
i
>> service into an unsafe one remains a critical step, even if it fixes
>> other use cases.
>>
>>> Ok. I am looking at the SIGWINCH change.
>>>
>> Great, TiA.
>=20
> I am not optimistic. I see no way for now to change this without
> breaking the ABI.

Well, both the current change as well as a potential signal-based prio
update would be 2.5 material IMHO. So ABI breakage is not an issue. I
wouldn't touch 2.4 unless there is a transparent fix feasible (which I
doubt as well).

Jan


--------------enig4F5D48CEE34A0859FA7A1A37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjoxAYACgkQniDOoMHTA+ktYACfTsTsaap7HvlkxfeFpKnzmbwA
AvoAn0wSIaNSyCVkj8dlk+TumLi246Jh
=cQQu
-----END PGP SIGNATURE-----

--------------enig4F5D48CEE34A0859FA7A1A37--

