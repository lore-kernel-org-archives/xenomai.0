Message-ID: <499B4CC0.9000803@domain.hid>
Date: Wed, 18 Feb 2009 00:48:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20090217170418.1425.56126.stgit@domain.hid>	<20090217170419.1425.15313.stgit@domain.hid>	<499AF09F.8040402@domain.hid>
	<499AF3C9.2040502@domain.hid>	<499AF5DC.6010602@domain.hid>
	<499AF82A.20406@domain.hid>	<499AF8E7.5000304@domain.hid>
	<499AFA8D.3080302@domain.hid>	<499AFF38.5030509@domain.hid>
	<499AFFC6.1030207@domain.hid>	<499B0028.2090402@domain.hid>
	<499B04CA.3020509@domain.hid>
In-Reply-To: <499B04CA.3020509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigADD375F0B99708099DD23376"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH v2 1/4] POSIX: Fix SCHED_RR thread
	creation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigADD375F0B99708099DD23376
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>>> @@ -192,6 +192,9 @@ static void *__pthread_trampoline(void *a=
rg)
>>>>>>>>>>> =20
>>>>>>>>>>>  	param.sched_priority =3D iargs->prio;
>>>>>>>>>>>  	policy =3D iargs->policy;
>>>>>>>>>>> +	if (policy =3D=3D SCHED_RR)
>>>>>>>>>>> +		/* Restrict round-robin scheduling to the Xenomai domain. =
*/
>>>>>>>>>>> +		policy =3D SCHED_FIFO;
>>>>>>>>>> Should not there be the same thing in __wrap_pthread_setschedp=
aram ?
>>>>>>>>> Yes, and setschedparam_ex, here we go:
>>>>>>>> Actually, I am wondering if we can not get rid of these calls to=

>>>>>>>> __real_pthread_setschedparam, now that propagating kernel-space =
priority
>>>>>>>> to user-space is done by a signal ?
>>>>>>> Not with the existing code, as that only forwards prio changes, b=
ut no
>>>>>>> policy changes.
>>>>>> If we map SCHED_RR to SCHED_FIFO, are there any policy changes?
>>>>> Yes, the initial one. Keep in mind that not all pthread implementat=
ions
>>>>> may respect the pthread_attr or have problems assigning SCHED_FIFO =
to
>>>>> threads of non-root users.
>>>> Ok. What about calling xnshadow_renice in xnshadow_map ?
>>> Sorry, I can't follow. xnshadow_renice does not help user space to fi=
nd
>>> the right policy, or what do you mean?
>> xnshadow_renice sends a signal to the user-space thread which in turn
>> calls __real_pthread_setschedparam.
>=20
> Ah, and user space derives the policy from the prio. That's what I miss=
ed.
>=20
>> The advantage of this solution is that it avoids calling
>> __real_pthread_setschedparam in many places in the user-space skins.
>=20
> We would save the call in the trampolines at least (my other changes in=

> the second revision were nonsense BTW - those paths belong to the
> non-Xenomai case). We would just have to pass the priority down on
> pthread_create as well.
>=20
> Will look into this and come up with a new version for this patch. But
> that need not delay merging the others.

I played with it, but raising a signal from xnshadow_map is no good
idea: If we inject the signal before the migration, xnshadow_map fails
due to the pending signal, we exit to user space, run the signal,
restart the call, raise the signal, and so on. If we raise after
migration, we immediately force the new thread into secondary mode
again, definitely causing problems when the mode switch warning is
active, but also risking other regressions for xnshadow_map users that
expect to find themselves in primary mode on return.

In short: I think it is better to stick with my original version of this
patch.

Jan


--------------enigADD375F0B99708099DD23376
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmbTMoACgkQniDOoMHTA+nmowCfUQgs042ONWsCu54Z73kyZTGf
qYgAoIT9mqxjjOiMxZVbC296lnOnuF6v
=Yz14
-----END PGP SIGNATURE-----

--------------enigADD375F0B99708099DD23376--

