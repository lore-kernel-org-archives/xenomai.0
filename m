Message-ID: <4A50DF0E.3070800@domain.hid>
Date: Sun, 05 Jul 2009 19:12:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A48FB71.6070506@domain.hid>
	<4A4CEB11.6020608@domain.hid>	<4A4E1BC2.7080707@domain.hid>
	<4A4E1E5E.1090405@domain.hid> <4A4F85AF.2050705@domain.hid>
	<4A509637.7070300@domain.hid> <4A50BF29.4000007@domain.hid>
In-Reply-To: <4A50BF29.4000007@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig193269F36741C42E3C204F3D"
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
--------------enig193269F36741C42E3C204F3D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi again,
>>>>>>
>>>>>> this is now basically the patch which seems to stabilized x86 /wrt=
 mmu
>>>>>> switches again:
>>>>>>
>>>>>> There were 3 race windows between setting active_mm of the current=
 task
>>>>>> and actually switching it (that's a noarch issue), there were seve=
ral
>>>>>> calls into switch_mm without proper hard interrupt protection (on =
archs
>>>>>> that have no preemptible switch_mm, like x86) and there was a race=
 in
>>>>>> x86's leave_mm (as Gilles already remarked earlier in this thread =
-
>>>>>> while I was looking at an old tree where smp_invalidate_interrupt =
took
>>>>>> care of this).
>>>>>>
>>>>>> The patch is thought as a basis for further discussions about
>>>>>>
>>>>>>  o how to solve all the issues for all archs technically (ideally
>>>>>>    without the need to patch noarch parts in an arch-specific way.=
=2E.)
>>>>>>
>>>>>>  o if anyone thinks there could be more spots like these (I've che=
cked
>>>>>>    the code only for x86 so far)
>>>>>> diff --git a/fs/aio.c b/fs/aio.c
>>>>>> index 76da125..0286f0f 100644
>>>>>> --- a/fs/aio.c
>>>>>> +++ b/fs/aio.c
>>>>>> @@ -618,13 +618,16 @@ static void use_mm(struct mm_struct *mm)
>>>>>>  {
>>>>>>  	struct mm_struct *active_mm;
>>>>>>  	struct task_struct *tsk =3D current;
>>>>>> +	unsigned long flags;
>>>>>> =20
>>>>>>  	task_lock(tsk);
>>>>>>  	active_mm =3D tsk->active_mm;
>>>>>>  	atomic_inc(&mm->mm_count);
>>>>>>  	tsk->mm =3D mm;
>>>>>> +	local_irq_save_hw_cond(flags);
>>>>>>  	tsk->active_mm =3D mm;
>>>>>> -	switch_mm(active_mm, mm, tsk);
>>>>>> +	__switch_mm(active_mm, mm, tsk);
>>>>>> +	local_irq_restore_hw_cond(flags);
>>>>>>  	task_unlock(tsk);
>>>>>> =20
>>>>>>  	mmdrop(active_mm);
>>>>>> diff --git a/fs/exec.c b/fs/exec.c
>>>>>> index 3b36c69..06591ac 100644
>>>>>> --- a/fs/exec.c
>>>>>> +++ b/fs/exec.c
>>>>>> @@ -718,6 +718,7 @@ static int exec_mmap(struct mm_struct *mm)
>>>>>>  {
>>>>>>  	struct task_struct *tsk;
>>>>>>  	struct mm_struct * old_mm, *active_mm;
>>>>>> +	unsigned long flags;
>>>>>> =20
>>>>>>  	/* Notify parent that we're no longer interested in the old VM *=
/
>>>>>>  	tsk =3D current;
>>>>>> @@ -740,8 +741,10 @@ static int exec_mmap(struct mm_struct *mm)
>>>>>>  	task_lock(tsk);
>>>>>>  	active_mm =3D tsk->active_mm;
>>>>>>  	tsk->mm =3D mm;
>>>>>> +	local_irq_save_hw_cond(flags);
>>>>>>  	tsk->active_mm =3D mm;
>>>>>>  	activate_mm(active_mm, mm);
>>>>>> +	local_irq_restore_hw_cond(flags);
>>>>>>  	task_unlock(tsk);
>>>>>>  	arch_pick_mmap_layout(mm);
>>>>>>  	if (old_mm) {
>>>>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>>>>> index 01a836b..cf3b68a 100644
>>>>>> --- a/kernel/fork.c
>>>>>> +++ b/kernel/fork.c
>>>>>> @@ -1665,11 +1665,14 @@ SYSCALL_DEFINE1(unshare, unsigned long, un=
share_flags)
>>>>>>  		}
>>>>>> =20
>>>>>>  		if (new_mm) {
>>>>>> +			unsigned long flags;
>>>>>>  			mm =3D current->mm;
>>>>>>  			active_mm =3D current->active_mm;
>>>>>>  			current->mm =3D new_mm;
>>>>>> +			local_irq_save_hw_cond(flags);
>>>>>>  			current->active_mm =3D new_mm;
>>>>>>  			activate_mm(active_mm, new_mm);
>>>>>> +			local_irq_restore_hw_cond(flags);
>>>>>>  			new_mm =3D mm;
>>>>>>  		}
>>>>> Ok. These are patches of the noarch code which are dependent on x86=

>>>>> implementation.
>>>>>
>>>>> I think we need something like
>>>>>
>>>>> mm_change_enter(flags);
>>>>> mm_change_leave(flags);
>>>>>
>>>>> which would resolve to ipipe_active_mm =3D NULL on architectures wi=
th
>>>>> unlocked context switches, and to local_irq_save_hw/local_irq_resto=
re on
>>>>> x86?
>>>> + we have to change switch_mm in the lockless case, and maybe also i=
ts
>>>> caller (if I look at the arm code), to use ipipe_active_mm in order =
to
>>>> decide if to switch or not - see my explanation of the possible race=
 in
>>>> aio.c.
>>> This is already the way it is currently working. the "prev" passed to=

>>> switch_mm is always ipipe_active_mm.
>>>
>> Ah, I missed the difference in arm's xnarch_leave_root. Now I got it.
>>
>> OK, but this needs to be thought through in details again, specificall=
y
>> also the enter-root scenarios. I have no safe feeling about it yet,
>> partly because switch_mm fiddles with ipipe_active_mm as well, but mor=
e
>> generally because we used to have such critical races in this area for=
 a
>> "fairly" long time.
>=20
> When reentering root with ipipe_active_mm NULL, the TIF_MMSWTICH_INT bi=
t
> is set, in which case the switch_mm preempted by Xenomai is restarted.
>=20

Right. But now we are also dealing with preemptions outside that loop.
And we are dealing with archs that have atomic switch_mm, thus no such
loops.

The goal should be to find a solution against the races outside
switch_mm that is applicable to all archs. But the question is still
unanswered to me if we can simply reuse existing ipipe_active_mm without
disturbing its current use in non-atomic switch_mm.

Moreover, part of the problems on x86 was the non-atomic update of
cpu_vm_mask vs. actually switching the hardware. How do you deal with
cpu_vm_mask on ARM? Why can you call switch_mm without IRQ protection?
My impression is that only the (costly) cpu_switch_mm should be allowed
to be preemptible to have a safe state around it. I'm also asking as we
would have to address this on x86 & co. once switch_mm could be called
with undefined prev_mm.

Jan


--------------enig193269F36741C42E3C204F3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpQ3xIACgkQniDOoMHTA+lsLACfUpT/r4Rl+PEX5ybst0MyR4G3
3MsAn3ZbtD6QznqF1P30dLGQKclWahP+
=tGWf
-----END PGP SIGNATURE-----

--------------enig193269F36741C42E3C204F3D--

