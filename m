Message-ID: <43971F76.4090505@domain.hid>
Date: Wed, 07 Dec 2005 18:44:22 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] don't try this at home...
References: <438DD4E2.9080208@domain.hid>
	<438DE166.5090303@domain.hid>
	<438DE551.7080708@domain.hid>
	<4396DA95.5060001@domain.hid>
	<4396DEC0.5060006@domain.hid>
In-Reply-To: <4396DEC0.5060006@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig773BA8A2A4BE3CCF9D8FD232"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig773BA8A2A4BE3CCF9D8FD232
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Jan Kiszka wrote:
>>>>
>>>>
>>>>> Hi Philippe,
>>>>>
>>>>> I'm afraid this one is serious: let the attached migration stress t=
est
>>>>> run on likely any Xenomai since 2.0, preferably with
>>>>> CONFIG_XENO_OPT_DEBUG on. Will give a nice crash sooner or later (I=
'm
>>>>> trying to set up a serial console now).
>>>>>
>>>
>>> Confirmed here. My test box went through some nifty triple salto out =
of
>>> the window running this frag for 2mn or so. Actually, the semop
>>> handshake is not even needed to cause the crash. At first sight, it
>>> looks like a migration issue taking place during the critical phase w=
hen
>>> a shadow thread switches back to Linux to terminate.
>>>
>>>
>>>>
>>>> As it took some time to persuade my box to not just reboot but to
>>>> give a
>>>> message, I'm posting here the kernel dump of the P-III running
>>>> nat_migration:
>>>>
>>>> [...]
>>>> Xenomai: starting native API services.
>>>> ce649fb4 ce648000 00000b17 00000202 c0139246 cdf2819c cdf28070 0b12d=
310
>>>>       00000037 ce648000 00000000 c02f0700 00009a28 00000000 b7e94a70=

>>>> bfed63c8
>>>>       00000000 ce648000 c0102fcb b7e94a70 bfed63dc b7faf4b0 bfed63c8=

>>>> 00000000
>>>> Call Trace:
>>>> [<c0139246>] __ipipe_dispatch_event+0x96/0x130
>>>> [<c0102fcb>] work_resched+0x6/0x1c
>>>> Xenomai: fatal: blocked thread migration[22175] rescheduled?!
>>>> (status=3D0x300010, sig=3D0, prev=3Dwatchdog/0[3])
>>>
>>> This babe is awaken by Linux while Xeno sees it in a dormant state,
>>> likely after it has terminated. No wonder why things are going wild
>>> after that... Ok, job queued. Thanks.
>>>
>>
>>
>> I think I can explain this warning now: This happens during creation o=
f
>> a new userspace real-time thread. In the context of the newly created
>> Linux pthread that is to become a real-time thread, Xenomai first sets=

>> up the real-time part and then calls xnshadow_map. The latter function=

>> does further init and then signals via xnshadow_signal_completion to t=
he
>> parent Linux thread (the caller of rt_task_create e.g.) that the threa=
d
>> is up. This happens before xnshadow_harden, i.e. still in preemptible
>> linux context.
>>
>> The signalling should normally do not cause a reschedule as the caller=
 -
>> the to-be-mapped linux pthread - has higher prio than the woken up
>> thread.
>=20
> Xeno never assumes this.
>=20
>  And Xenomai implicitly assumes with this fatal-test above that
>> there is no preemption! But it can happen: the watchdog thread of linu=
x
>> does preempt here. So, I think it's a false positive.
>>
>=20
> This is wrong. This check is not related to Linux preemption at all; it=

> makes sure that control over any shadow is shared in a strictly
> _mutually exclusive_ way, so that a thread blocked at Xenomai level may=

> not not be seen as runnable by Linux either. Disabling it only makes
> things worse since the scheduling state is obviously corrupted when it
> triggers, and that's the root bug we are chasing right now. You should
> not draw any conclusion beyond that. Additionally, keep in mind that
> Xeno has already run over some PREEMPT_RT patches, for which an infinit=
e
> number of CPUs is assumed over a fine-grained code base, which induces
> maximum preemption probabilities.
>=20

Ok, may explanation was a quick hack before some meeting here, I should
have elaborated it more thoroughly. Let's try to do it step by step so
that you can say where I go of the right path:

1. We enter xnshadow_map. The linux thread is happily running, the
   shadow thread is in XNDORMANT state and not yet linked to its linux
   mate. Any linux preemption hitting us here and causing a reactivation
   of this particular linux thread later will not cause any activity of
   do_schedule_event related to this thread because [1] is NULL. That's
   important, we will see later why.

2. After some init stuff, xnshadow_map links the shadow to the linux
   thread [2] and then calls xnshadow_signal_completion. This call would
   normally wake up the sleeping parent of our linux thread, performing
   a direct standard linux schedule from the new born thread to the
   parent. Again, nothing here about which do_schedule_event could
   complain.

3. Now let's consider some preemption by a third linux task after [2]
   but before [3]. Scheduling away the new linux thread is no issue. But
   when it comes back again, we will see those nice xnpod_fatal. The
   reason: our shadow thread is now linked to its linux mate, thus [1]
   will evaluate non-NULL, and later also [4] will hit as XNDORMANT is
   part of XNTHREAD_BLOCK_BITS (and the thread is not ptraced).

Ok, this is how I see THIS particular issue so far. For me the question
is now:

 a) I'm right?
 b) If yes, is this preemption uncritical, thus the warning in the
    described context a false positive?
 c) If it is not, can this cause the following crash?

Jan

[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.=
c?v=3DSVN-trunk#L1515
[2]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.=
c?v=3DSVN-trunk#L765
[3]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.=
c?v=3DSVN-trunk#L621
[4]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.=
c?v=3DSVN-trunk#L1555


--------------enig773BA8A2A4BE3CCF9D8FD232
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDlx92ncNeS9Q0k+IRAi33AKCEXxF1tcVgAFMQETUoaIOaJ1lpigCeM1KP
kFw1kP+lY2aFZWwkBgYzPko=
=VqI3
-----END PGP SIGNATURE-----

--------------enig773BA8A2A4BE3CCF9D8FD232--

