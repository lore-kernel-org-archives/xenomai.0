Message-ID: <4DFCA323.6030704@domain.hid>
Date: Sat, 18 Jun 2011 15:07:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>
	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>
	<4DFBA305.9000303@domain.hid> <4DFC7C0E.1090700@domain.hid>
	<4DFC9575.1030904@domain.hid> <4DFC95B7.8070703@domain.hid>
	<4DFCA09B.20609@domain.hid>
In-Reply-To: <4DFCA09B.20609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig622CF189BDCE0E00F9A32C45"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
	interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig622CF189BDCE0E00F9A32C45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-06-18 14:56, Gilles Chanteperdrix wrote:
> On 06/18/2011 02:10 PM, Jan Kiszka wrote:
>> On 2011-06-18 14:09, Gilles Chanteperdrix wrote:
>>> On 06/18/2011 12:21 PM, Jan Kiszka wrote:
>>>> On 2011-06-17 20:55, Gilles Chanteperdrix wrote:
>>>>> On 06/17/2011 07:03 PM, Jan Kiszka wrote:
>>>>>> On 2011-06-17 18:53, Gilles Chanteperdrix wrote:
>>>>>>> On 06/17/2011 04:38 PM, GIT version control wrote:
>>>>>>>> Module: xenomai-jki
>>>>>>>> Branch: for-upstream
>>>>>>>> Commit: 7203b1a66ca0825d5bcda1c3abab9ca048177914
>>>>>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=
=3D7203b1a66ca0825d5bcda1c3abab9ca048177914
>>>>>>>>
>>>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>>> Date:   Fri Jun 17 09:46:19 2011 +0200
>>>>>>>>
>>>>>>>> nucleus: Fix interrupt handler tails
>>>>>>>>
>>>>>>>> Our current interrupt handlers assume that they leave over the s=
ame task
>>>>>>>> and CPU they entered. But commit f6af9b831c broke this assumptio=
n:
>>>>>>>> xnpod_schedule invoked from the handler tail can now actually tr=
igger a
>>>>>>>> domain migration, and that can also include a CPU migration. Thi=
s causes
>>>>>>>> subtle corruptions as invalid xnstat_exectime_t objects may be r=
estored
>>>>>>>> and - even worse - we may improperly flush XNHTICK of the old CP=
U,
>>>>>>>> leaving Linux timer-wise dead there (as happened to us).
>>>>>>>>
>>>>>>>> Fix this by moving XNHTICK replay and exectime accounting before=
 the
>>>>>>>> scheduling point. Note that this introduces a tiny imprecision i=
n the
>>>>>>>> accounting.
>>>>>>>
>>>>>>> I am not sure I understand why moving the XNHTICK replay is neede=
d: if
>>>>>>> we switch to secondary mode, the HTICK is handled by xnpod_schedu=
le
>>>>>>> anyway, or am I missing something?
>>>>>>
>>>>>> The replay can work on an invalid sched (after CPU migration in
>>>>>> secondary mode). We could reload the sched, but just moving the re=
play
>>>>>> is simpler.
>>>>>
>>>>> But does it not remove the purpose of this delayed replay?
>>>>
>>>> Hmm, yes, in the corner case of coalesced timed RT task wakeup and h=
ost
>>>> tick over a root thread. Well, then we actually have to reload sched=
 and
>>>> keep the ordering to catch that as well.
>>>>
>>>>>
>>>>> Note that if you want to reload the sched, you also have to shut
>>>>> interrupts off, because upon return from xnpod_schedule after migra=
tion,
>>>>> interrupts are on.
>>>>
>>>> That would be another severe bug if we left an interrupt handler wit=
h
>>>> hard IRQs enabled - the interrupt tail code of ipipe would break.
>>>>
>>>> Fortunately, only xnpod_suspend_thread re-enables IRQs and returns.
>>>> xnpod_schedule also re-enables but then terminates the context (in
>>>> xnshadow_exit). So we are safe.
>>>
>>> I do not think we are, at least on platforms where context switches
>>> happen with irqs on.
>>
>> Can you sketch a problematic path?
>=20
> On platforms with IPIPE_WANT_PREEMPTIBLE_SWITCH on, all context switche=
s
> happens with irqs on. So, in particular, the context switch to a relaxe=
d
> task happens with irqs on. In __xnpod_schedule, we then return from
> xnpod_switch_to with irqs on, and so return from __xnpod_schedule with
> irqs on.

"/* We are returning to xnshadow_relax via
    xnpod_suspend_thread, do nothing,
    xnpod_suspend_thread will re-enable interrupts. */"

Looks like this is outdated. I think we best fix this in
__xnpod_schedule by disabling irqs there instead of forcing otherwise
redundant disabling into all handler return paths.

>=20
> Maybe in the irq handlers, we should skip the XNHTICK replay, when
> current_domain is root_domain.
>=20

That would be against the purpose of the XNTICK replay (it only targets
that particular case). And it would still leave us with broken ipipe due
to enabled IRQs on return from the Xenomai handlers.

Jan


--------------enig622CF189BDCE0E00F9A32C45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk38oyMACgkQitSsb3rl5xTZRQCgtgFcuMbHq/cjWI3G/uA0miFw
MxsAn3GeEfOx/bOV0srMgGfNxWEhHoEJ
=sgBQ
-----END PGP SIGNATURE-----

--------------enig622CF189BDCE0E00F9A32C45--

