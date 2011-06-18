Message-ID: <4DFCAF07.8020607@domain.hid>
Date: Sat, 18 Jun 2011 15:58:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>	<4DFBA305.9000303@domain.hid>
	<4DFC7C0E.1090700@domain.hid>	<4DFC9575.1030904@domain.hid>
	<4DFC95B7.8070703@domain.hid>	<4DFCA09B.20609@domain.hid>
	<4DFCA323.6030704@domain.hid> <4DFCA432.3070203@domain.hid>
In-Reply-To: <4DFCA432.3070203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5EE0AB49914BD6AE19BB7E52"
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
--------------enig5EE0AB49914BD6AE19BB7E52
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-18 15:12, Gilles Chanteperdrix wrote:
> On 06/18/2011 03:07 PM, Jan Kiszka wrote:
>> On 2011-06-18 14:56, Gilles Chanteperdrix wrote:
>>> On 06/18/2011 02:10 PM, Jan Kiszka wrote:
>>>> On 2011-06-18 14:09, Gilles Chanteperdrix wrote:
>>>>> On 06/18/2011 12:21 PM, Jan Kiszka wrote:
>>>>>> On 2011-06-17 20:55, Gilles Chanteperdrix wrote:
>>>>>>> On 06/17/2011 07:03 PM, Jan Kiszka wrote:
>>>>>>>> On 2011-06-17 18:53, Gilles Chanteperdrix wrote:
>>>>>>>>> On 06/17/2011 04:38 PM, GIT version control wrote:
>>>>>>>>>> Module: xenomai-jki
>>>>>>>>>> Branch: for-upstream
>>>>>>>>>> Commit: 7203b1a66ca0825d5bcda1c3abab9ca048177914
>>>>>>>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit=
;h=3D7203b1a66ca0825d5bcda1c3abab9ca048177914
>>>>>>>>>>
>>>>>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>>>>> Date:   Fri Jun 17 09:46:19 2011 +0200
>>>>>>>>>>
>>>>>>>>>> nucleus: Fix interrupt handler tails
>>>>>>>>>>
>>>>>>>>>> Our current interrupt handlers assume that they leave over the=
 same task
>>>>>>>>>> and CPU they entered. But commit f6af9b831c broke this assumpt=
ion:
>>>>>>>>>> xnpod_schedule invoked from the handler tail can now actually =
trigger a
>>>>>>>>>> domain migration, and that can also include a CPU migration. T=
his causes
>>>>>>>>>> subtle corruptions as invalid xnstat_exectime_t objects may be=
 restored
>>>>>>>>>> and - even worse - we may improperly flush XNHTICK of the old =
CPU,
>>>>>>>>>> leaving Linux timer-wise dead there (as happened to us).
>>>>>>>>>>
>>>>>>>>>> Fix this by moving XNHTICK replay and exectime accounting befo=
re the
>>>>>>>>>> scheduling point. Note that this introduces a tiny imprecision=
 in the
>>>>>>>>>> accounting.
>>>>>>>>>
>>>>>>>>> I am not sure I understand why moving the XNHTICK replay is nee=
ded: if
>>>>>>>>> we switch to secondary mode, the HTICK is handled by xnpod_sche=
dule
>>>>>>>>> anyway, or am I missing something?
>>>>>>>>
>>>>>>>> The replay can work on an invalid sched (after CPU migration in
>>>>>>>> secondary mode). We could reload the sched, but just moving the =
replay
>>>>>>>> is simpler.
>>>>>>>
>>>>>>> But does it not remove the purpose of this delayed replay?
>>>>>>
>>>>>> Hmm, yes, in the corner case of coalesced timed RT task wakeup and=
 host
>>>>>> tick over a root thread. Well, then we actually have to reload sch=
ed and
>>>>>> keep the ordering to catch that as well.
>>>>>>
>>>>>>>
>>>>>>> Note that if you want to reload the sched, you also have to shut
>>>>>>> interrupts off, because upon return from xnpod_schedule after mig=
ration,
>>>>>>> interrupts are on.
>>>>>>
>>>>>> That would be another severe bug if we left an interrupt handler w=
ith
>>>>>> hard IRQs enabled - the interrupt tail code of ipipe would break.
>>>>>>
>>>>>> Fortunately, only xnpod_suspend_thread re-enables IRQs and returns=
=2E
>>>>>> xnpod_schedule also re-enables but then terminates the context (in=

>>>>>> xnshadow_exit). So we are safe.
>>>>>
>>>>> I do not think we are, at least on platforms where context switches=

>>>>> happen with irqs on.
>>>>
>>>> Can you sketch a problematic path?
>>>
>>> On platforms with IPIPE_WANT_PREEMPTIBLE_SWITCH on, all context switc=
hes
>>> happens with irqs on. So, in particular, the context switch to a rela=
xed
>>> task happens with irqs on. In __xnpod_schedule, we then return from
>>> xnpod_switch_to with irqs on, and so return from __xnpod_schedule wit=
h
>>> irqs on.
>>
>> "/* We are returning to xnshadow_relax via
>>     xnpod_suspend_thread, do nothing,
>>     xnpod_suspend_thread will re-enable interrupts. */"
>>
>> Looks like this is outdated. I think we best fix this in
>> __xnpod_schedule by disabling irqs there instead of forcing otherwise
>> redundant disabling into all handler return paths.
>=20
> I agree.
>=20

I've queued a corresponding patch, and also one to clean up that special
handshake between xnshadow_relax and xnpod_suspend_thread a bit.
Consider both as RFC.

Jan


--------------enig5EE0AB49914BD6AE19BB7E52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk38rwcACgkQitSsb3rl5xSXHgCgy0gtKnQqlZEaHPEX1+G0H/D1
UwUAoImc6pDXD7S/PAhmnsIfFUVpB3oi
=6aA3
-----END PGP SIGNATURE-----

--------------enig5EE0AB49914BD6AE19BB7E52--

