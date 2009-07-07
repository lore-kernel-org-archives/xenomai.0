Message-ID: <4A5397B7.70100@domain.hid>
Date: Tue, 07 Jul 2009 20:45:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A48FB71.6070506@domain.hid>
	<4A4CEB11.6020608@domain.hid>	<4A4E1BC2.7080707@domain.hid>
	<4A4E1E5E.1090405@domain.hid> <4A4F85AF.2050705@domain.hid>
	<4A509637.7070300@domain.hid> <4A50BF29.4000007@domain.hid>
	<4A50DF0E.3070800@domain.hid> <4A51AD9B.6070803@domain.hid>
In-Reply-To: <4A51AD9B.6070803@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC4C4E2C19EFEF3CE8D9D0C50"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] x86: Endless minor faults
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
--------------enigC4C4E2C19EFEF3CE8D9D0C50
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
>>>>>>>> Hi again,
>>>>>>>>
>>>>>>>> this is now basically the patch which seems to stabilized x86 /w=
rt mmu
>>>>>>>> switches again:
>>>>>>>>
>>>>>>>> There were 3 race windows between setting active_mm of the curre=
nt task
>>>>>>>> and actually switching it (that's a noarch issue), there were se=
veral
>>>>>>>> calls into switch_mm without proper hard interrupt protection (o=
n archs
>>>>>>>> that have no preemptible switch_mm, like x86) and there was a ra=
ce in
>>>>>>>> x86's leave_mm (as Gilles already remarked earlier in this threa=
d -
>>>>>>>> while I was looking at an old tree where smp_invalidate_interrup=
t took
>>>>>>>> care of this).
>>>>>>>>
>>>>>>>> The patch is thought as a basis for further discussions about
>>>>>>>>
>>>>>>>>  o how to solve all the issues for all archs technically (ideall=
y
>>>>>>>>    without the need to patch noarch parts in an arch-specific wa=
y...)
>>>>>>>>
>>>>>>>>  o if anyone thinks there could be more spots like these (I've c=
hecked
>>>>>>>>    the code only for x86 so far)
>>>>>>>> diff --git a/fs/aio.c b/fs/aio.c
>>>>>>>> index 76da125..0286f0f 100644
>>>>>>>> --- a/fs/aio.c
>>>>>>>> +++ b/fs/aio.c
>>>>>>>> @@ -618,13 +618,16 @@ static void use_mm(struct mm_struct *mm)
>>>>>>>>  {
>>>>>>>>  	struct mm_struct *active_mm;
>>>>>>>>  	struct task_struct *tsk =3D current;
>>>>>>>> +	unsigned long flags;
>>>>>>>> =20
>>>>>>>>  	task_lock(tsk);
>>>>>>>>  	active_mm =3D tsk->active_mm;
>>>>>>>>  	atomic_inc(&mm->mm_count);
>>>>>>>>  	tsk->mm =3D mm;
>>>>>>>> +	local_irq_save_hw_cond(flags);
>>>>>>>>  	tsk->active_mm =3D mm;
>>>>>>>> -	switch_mm(active_mm, mm, tsk);
>>>>>>>> +	__switch_mm(active_mm, mm, tsk);
>>>>>>>> +	local_irq_restore_hw_cond(flags);
>>>>>>>>  	task_unlock(tsk);
>>>>>>>> =20
>>>>>>>>  	mmdrop(active_mm);
>>>>>>>> diff --git a/fs/exec.c b/fs/exec.c
>>>>>>>> index 3b36c69..06591ac 100644
>>>>>>>> --- a/fs/exec.c
>>>>>>>> +++ b/fs/exec.c
>>>>>>>> @@ -718,6 +718,7 @@ static int exec_mmap(struct mm_struct *mm)
>>>>>>>>  {
>>>>>>>>  	struct task_struct *tsk;
>>>>>>>>  	struct mm_struct * old_mm, *active_mm;
>>>>>>>> +	unsigned long flags;
>>>>>>>> =20
>>>>>>>>  	/* Notify parent that we're no longer interested in the old VM=
 */
>>>>>>>>  	tsk =3D current;
>>>>>>>> @@ -740,8 +741,10 @@ static int exec_mmap(struct mm_struct *mm)
>>>>>>>>  	task_lock(tsk);
>>>>>>>>  	active_mm =3D tsk->active_mm;
>>>>>>>>  	tsk->mm =3D mm;
>>>>>>>> +	local_irq_save_hw_cond(flags);
>>>>>>>>  	tsk->active_mm =3D mm;
>>>>>>>>  	activate_mm(active_mm, mm);
>>>>>>>> +	local_irq_restore_hw_cond(flags);
>>>>>>>>  	task_unlock(tsk);
>>>>>>>>  	arch_pick_mmap_layout(mm);
>>>>>>>>  	if (old_mm) {
>>>>>>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>>>>>>> index 01a836b..cf3b68a 100644
>>>>>>>> --- a/kernel/fork.c
>>>>>>>> +++ b/kernel/fork.c
>>>>>>>> @@ -1665,11 +1665,14 @@ SYSCALL_DEFINE1(unshare, unsigned long, =
unshare_flags)
>>>>>>>>  		}
>>>>>>>> =20
>>>>>>>>  		if (new_mm) {
>>>>>>>> +			unsigned long flags;
>>>>>>>>  			mm =3D current->mm;
>>>>>>>>  			active_mm =3D current->active_mm;
>>>>>>>>  			current->mm =3D new_mm;
>>>>>>>> +			local_irq_save_hw_cond(flags);
>>>>>>>>  			current->active_mm =3D new_mm;
>>>>>>>>  			activate_mm(active_mm, new_mm);
>>>>>>>> +			local_irq_restore_hw_cond(flags);
>>>>>>>>  			new_mm =3D mm;
>>>>>>>>  		}
>>>>>>> Ok. These are patches of the noarch code which are dependent on x=
86
>>>>>>> implementation.
>>>>>>>
>>>>>>> I think we need something like
>>>>>>>
>>>>>>> mm_change_enter(flags);
>>>>>>> mm_change_leave(flags);
>>>>>>>
>>>>>>> which would resolve to ipipe_active_mm =3D NULL on architectures =
with
>>>>>>> unlocked context switches, and to local_irq_save_hw/local_irq_res=
tore on
>>>>>>> x86?
>>>>>> + we have to change switch_mm in the lockless case, and maybe also=
 its
>>>>>> caller (if I look at the arm code), to use ipipe_active_mm in orde=
r to
>>>>>> decide if to switch or not - see my explanation of the possible ra=
ce in
>>>>>> aio.c.
>>>>> This is already the way it is currently working. the "prev" passed =
to
>>>>> switch_mm is always ipipe_active_mm.
>>>>>
>>>> Ah, I missed the difference in arm's xnarch_leave_root. Now I got it=
=2E
>>>>
>>>> OK, but this needs to be thought through in details again, specifica=
lly
>>>> also the enter-root scenarios. I have no safe feeling about it yet,
>>>> partly because switch_mm fiddles with ipipe_active_mm as well, but m=
ore
>>>> generally because we used to have such critical races in this area f=
or a
>>>> "fairly" long time.
>>> When reentering root with ipipe_active_mm NULL, the TIF_MMSWTICH_INT =
bit
>>> is set, in which case the switch_mm preempted by Xenomai is restarted=
=2E
>>>
>> Right. But now we are also dealing with preemptions outside that loop.=

>> And we are dealing with archs that have atomic switch_mm, thus no such=

>> loops.
>>
>> The goal should be to find a solution against the races outside
>> switch_mm that is applicable to all archs. But the question is still
>> unanswered to me if we can simply reuse existing ipipe_active_mm witho=
ut
>> disturbing its current use in non-atomic switch_mm.
>>
>> Moreover, part of the problems on x86 was the non-atomic update of
>> cpu_vm_mask vs. actually switching the hardware. How do you deal with
>> cpu_vm_mask on ARM? Why can you call switch_mm without IRQ protection?=

>> My impression is that only the (costly) cpu_switch_mm should be allowe=
d
>> to be preemptible to have a safe state around it. I'm also asking as w=
e
>> would have to address this on x86 & co. once switch_mm could be called=

>> with undefined prev_mm.
>=20
> when ipipe_active_mm is set to NULL, switch_mm does not touch the
> current mm cpu_vm_mask, since it does not know what the current mm is.
> However, we have a problem when switching back to root: we do not clear=

> the previous mm cpu_vm_mask since we do not call switch_mm in
> xnarch_switch_to, we should fix this. So, I think we can extend the zon=
e
> where ipipe_active_mm is set to NULL, to protect this area from the
> effects of preemption by Xenomai.
>=20
> So, IMO, what we need is something like ipipe_mm_switch_protect which
> sets ipipe_active_mm to NULL on ARM, and results in local_irq_save_hw o=
n
> x86.

That sounds like a good step forward. I will split up my patch into a
non-arch part that instruments the code and an x86 part that installs
the required protection for that arch.

Jan


--------------enigC4C4E2C19EFEF3CE8D9D0C50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpTl7cACgkQniDOoMHTA+lx8ACeJZUQMkxRbiYWiErhSNLA2eY2
m1MAnjQSxOr8JYtOT8G7la/h9NNV4jA+
=Kfhw
-----END PGP SIGNATURE-----

--------------enigC4C4E2C19EFEF3CE8D9D0C50--

