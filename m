Message-ID: <485BC0D4.5040204@domain.hid>
Date: Fri, 20 Jun 2008 16:38:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4859299A.2010802@domain.hid>
	<48592D6D.2010104@domain.hid> <485A1CEC.404@domain.hid>
In-Reply-To: <485A1CEC.404@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PowerPC] Registers Corruption at Context Switch
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin ZORES <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Benjamin ZORES wrote:
> Philippe Gerum a =E9crit :
>>> FYI, I'm running on PowerPC 603e core with Linux 2.6.23, Adeos 2.0-09
>>> (latest) and Xenomai 2.3.4 (latest).
>>>    =20
> read Xenomai 2.4.4 here, of course ...
>>
>> See arch/powerpc/switch_32.S, rthal_switch_threads(), for the part
>> that does the
>> actual stack switching.
>>
>> Note that this code is obfuscated by the fact that we have to handle
>> so-called
>> "hybrid" switching, between Xenomai kernel threads (which do not rely
>> on a
>> task_struct), and Linux tasks (Xenomai userland, Linux kthreads, or
>> regular
>> userland Linux). Fortunately, what is saved on the stack in any case
>> is easy to
>> find out.
>>  =20
> Ok, I've dig a bit more at sources and found out something strange.
>=20
> In xenomai arch/powerpc/xenomai/switch_32.S in rthal_thread_switch() we
> have:
>=20
> ********
> #ifdef CONFIG_SMP
>    sync
> #endif /* CONFIG_SMP */
>=20
>    lwz    r1,KSP(r4)    /* Load new stack pointer */
>=20
>    mr    r3,r2
>    lwz    r0,PGDIR(r4)
>        cmpwi   r0, 0
>        beq-    same_current
>=20
>    tophys(r0,r4)
>    CLR_TOP32(r0)
>    mtspr    SPRN_SPRG3,r0    /* Update current THREAD phys addr */
>    addi    r2,r4,-THREAD    /* Update current */
>=20
> same_current:
> **********
>=20
> While, in arch/powerpc/kernel/entry_32.S in _switch() we have:
>=20
> **********
> #ifdef CONFIG_SMP
>    /* We need a sync somewhere here to make sure that if the
>     * previous task gets rescheduled on another CPU, it sees all
>     * stores it has performed on this one.
>     */
>    sync
> #endif /* CONFIG_SMP */
>=20
>    tophys(r0,r4)
>    CLR_TOP32(r0)
>    mtspr    SPRN_SPRG3,r0    /* Update current THREAD phys addr */
>    lwz    r1,KSP(r4)    /* Load new stack pointer */
>=20
>    /* save the old current 'last' for return value */
>    mr    r3,r2
>    addi    r2,r4,-THREAD    /* Update current */
> ************
>=20
> As we can see, the code differs from kernel, as
>=20
>    tophys(r0,r4)
>    CLR_TOP32(r0)
>    mtspr    SPRN_SPRG3,r0    /* Update current THREAD phys addr */
>=20
> is done _before_ loading new stack pointer in kernel and _after_ doing
> so in xenomai.
>=20
> Is there a good reason for that or is this unintended ??
>=20

It's just code placement to avoid additional branches depending on whether =
we
want to update SPRG3 upon switch or not (when switching to a Xenomai kernel
thread, we don't). I see no dependency from that code on the stack pointer =
and
conversely. Do you see any?

--=20
Philippe.

