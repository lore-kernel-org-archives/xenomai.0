Message-ID: <485A1CEC.404@domain.hid>
Date: Thu, 19 Jun 2008 10:46:36 +0200
From: Benjamin ZORES <benjamin.zores@domain.hid>
MIME-Version: 1.0
References: <4859299A.2010802@domain.hid> <48592D6D.2010104@domain.hid>
In-Reply-To: <48592D6D.2010104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PowerPC] Registers Corruption at Context Switch
Reply-To: xenomai-core <xenomai@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Philippe Gerum a =E9crit :
>> FYI, I'm running on PowerPC 603e core with Linux 2.6.23, Adeos 2.0-09=20
>> (latest) and Xenomai 2.3.4 (latest).
>>    =20
read Xenomai 2.4.4 here, of course ...
>
> See arch/powerpc/switch_32.S, rthal_switch_threads(), for the part that=
 does the
> actual stack switching.
>
> Note that this code is obfuscated by the fact that we have to handle so=
-called
> "hybrid" switching, between Xenomai kernel threads (which do not rely o=
n a
> task_struct), and Linux tasks (Xenomai userland, Linux kthreads, or reg=
ular
> userland Linux). Fortunately, what is saved on the stack in any case is=
 easy to
> find out.
>  =20
Ok, I've dig a bit more at sources and found out something strange.

In xenomai arch/powerpc/xenomai/switch_32.S in rthal_thread_switch() we=20
have:

********
#ifdef CONFIG_SMP
    sync
#endif /* CONFIG_SMP */

    lwz    r1,KSP(r4)    /* Load new stack pointer */

    mr    r3,r2
    lwz    r0,PGDIR(r4)
        cmpwi   r0, 0
        beq-    same_current

    tophys(r0,r4)
    CLR_TOP32(r0)
    mtspr    SPRN_SPRG3,r0    /* Update current THREAD phys addr */
    addi    r2,r4,-THREAD    /* Update current */

same_current:
**********

While, in arch/powerpc/kernel/entry_32.S in _switch() we have:

**********
#ifdef CONFIG_SMP
    /* We need a sync somewhere here to make sure that if the
     * previous task gets rescheduled on another CPU, it sees all
     * stores it has performed on this one.
     */
    sync
#endif /* CONFIG_SMP */

    tophys(r0,r4)
    CLR_TOP32(r0)
    mtspr    SPRN_SPRG3,r0    /* Update current THREAD phys addr */
    lwz    r1,KSP(r4)    /* Load new stack pointer */

    /* save the old current 'last' for return value */
    mr    r3,r2
    addi    r2,r4,-THREAD    /* Update current */
************

As we can see, the code differs from kernel, as

    tophys(r0,r4)
    CLR_TOP32(r0)
    mtspr    SPRN_SPRG3,r0    /* Update current THREAD phys addr */

is done _before_ loading new stack pointer in kernel and _after_ doing=20
so in xenomai.

Is there a good reason for that or is this unintended ??

Ben


