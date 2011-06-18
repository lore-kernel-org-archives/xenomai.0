Message-ID: <4DFC95B7.8070703@domain.hid>
Date: Sat, 18 Jun 2011 14:10:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>
	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>
	<4DFBA305.9000303@domain.hid> <4DFC7C0E.1090700@domain.hid>
	<4DFC9575.1030904@domain.hid>
In-Reply-To: <4DFC9575.1030904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3C95C5D75703D41C26DC76CA"
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
--------------enig3C95C5D75703D41C26DC76CA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-06-18 14:09, Gilles Chanteperdrix wrote:
> On 06/18/2011 12:21 PM, Jan Kiszka wrote:
>> On 2011-06-17 20:55, Gilles Chanteperdrix wrote:
>>> On 06/17/2011 07:03 PM, Jan Kiszka wrote:
>>>> On 2011-06-17 18:53, Gilles Chanteperdrix wrote:
>>>>> On 06/17/2011 04:38 PM, GIT version control wrote:
>>>>>> Module: xenomai-jki
>>>>>> Branch: for-upstream
>>>>>> Commit: 7203b1a66ca0825d5bcda1c3abab9ca048177914
>>>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D=
7203b1a66ca0825d5bcda1c3abab9ca048177914
>>>>>>
>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>> Date:   Fri Jun 17 09:46:19 2011 +0200
>>>>>>
>>>>>> nucleus: Fix interrupt handler tails
>>>>>>
>>>>>> Our current interrupt handlers assume that they leave over the sam=
e task
>>>>>> and CPU they entered. But commit f6af9b831c broke this assumption:=

>>>>>> xnpod_schedule invoked from the handler tail can now actually trig=
ger a
>>>>>> domain migration, and that can also include a CPU migration. This =
causes
>>>>>> subtle corruptions as invalid xnstat_exectime_t objects may be res=
tored
>>>>>> and - even worse - we may improperly flush XNHTICK of the old CPU,=

>>>>>> leaving Linux timer-wise dead there (as happened to us).
>>>>>>
>>>>>> Fix this by moving XNHTICK replay and exectime accounting before t=
he
>>>>>> scheduling point. Note that this introduces a tiny imprecision in =
the
>>>>>> accounting.
>>>>>
>>>>> I am not sure I understand why moving the XNHTICK replay is needed:=
 if
>>>>> we switch to secondary mode, the HTICK is handled by xnpod_schedule=

>>>>> anyway, or am I missing something?
>>>>
>>>> The replay can work on an invalid sched (after CPU migration in
>>>> secondary mode). We could reload the sched, but just moving the repl=
ay
>>>> is simpler.
>>>
>>> But does it not remove the purpose of this delayed replay?
>>
>> Hmm, yes, in the corner case of coalesced timed RT task wakeup and hos=
t
>> tick over a root thread. Well, then we actually have to reload sched a=
nd
>> keep the ordering to catch that as well.
>>
>>>
>>> Note that if you want to reload the sched, you also have to shut
>>> interrupts off, because upon return from xnpod_schedule after migrati=
on,
>>> interrupts are on.
>>
>> That would be another severe bug if we left an interrupt handler with
>> hard IRQs enabled - the interrupt tail code of ipipe would break.
>>
>> Fortunately, only xnpod_suspend_thread re-enables IRQs and returns.
>> xnpod_schedule also re-enables but then terminates the context (in
>> xnshadow_exit). So we are safe.
>=20
> I do not think we are, at least on platforms where context switches
> happen with irqs on.

Can you sketch a problematic path?

Jan


--------------enig3C95C5D75703D41C26DC76CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk38lboACgkQitSsb3rl5xRDFwCgkC8vfUHI9DyfPWOBu8lMgsC2
WqEAoOAkSWLMHlGmHqfvE7QIT3zvC7Mm
=X+vf
-----END PGP SIGNATURE-----

--------------enig3C95C5D75703D41C26DC76CA--

