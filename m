References: <62e8601b-3066-959a-5436-5063ea61efe8@rambler.ru>
 <bf181341-b4ec-8137-9afa-1a4f1abab247@rambler.ru>
 <87a6auz0s0.fsf@xenomai.org>
 <e2dc3015-625b-8639-65c4-a7b4133bc3b5@rambler.ru>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: linux-evl: 5.18.1: build error for arch/arm
Date: Sat, 04 Jun 2022 15:24:53 +0200
In-reply-to: <e2dc3015-625b-8639-65c4-a7b4133bc3b5@rambler.ru>
Message-ID: <875ylgzh6d.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leonid Gasheev via Xenomai <feedcom@rambler.ru>
Cc: xenomai@xenomai.org


Leonid Gasheev via Xenomai via Xenomai <xenomai@xenomai.org> writes:

> 03.06.2022 10:01, Philippe Gerum =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Leonid Gasheev via Xenomai via Xenomai <xenomai@xenomai.org> writes:
>>=20
>>> 02.06.2022 18:44, Leonid Gasheev via Xenomai =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>>>> A series of patches extracted from v5.18-evl-rebase has been applied
>>>> to the kernel version v5.18.1
>>>> toolchain/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin
>>>> Build for the arm64 architecture is completed successfully.
>>>> But for arm:
>>>> arch/arm/kernel/irq.c: In function =E2=80=98handle_arch_irq_pipelined=
=E2=80=99:
>>>> arch/arm/kernel/irq.c:167:19: warning: cast between incompatible
>>>> function types from =E2=80=98int (*)(struct pt_regs *)=E2=80=99 to =E2=
=80=98void (*)(void
>>>> *)=E2=80=99 [-Wcast-function-type]
>>>>   =C2=A0=C2=A0 call_with_stack((void (*)(void *))handle_irq_pipelined,=
 regs,
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>>> arch/arm/kernel/entry-armv.S: Assembler messages:
>>>> arch/arm/kernel/entry-armv.S:496: Error: instruction not allowed in
>>>> IT block -- `tst r0,r0'
>>>> arch/arm/kernel/entry-armv.S:785: Error: instruction not allowed in
>>>> IT block -- `tst r1,#0x0001'
>>>> make[2]: *** [scripts/Makefile.build:389:
>>>> arch/arm/kernel/entry-armv.o] Error 1
>>>
>>> A similar situation with the 5.15.43 kernel.
>>> The build for the arm fails:
>>>
>>> arch/arm/kernel/entry-armv.S: Assembler messages:
>>> arch/arm/kernel/entry-armv.S:470: Error: instruction not allowed in IT
>>> block -- `tst r0,r0'
>>> arch/arm/kernel/entry-armv.S:760: Error: instruction not allowed in IT
>>> block -- `tst r1,#0x0001'
>>> make[2]: *** [scripts/Makefile.build:390:
>>> arch/arm/kernel/entry-armv.o] Error 1
>>> make[1]: *** [scripts/Makefile.build:551: arch/arm/kernel] Error 2
>>> make[1]: *** Waiting for unfinished jobs....
>>> make: *** [Makefile:1870: arch/arm] Error 2
>>> make: *** Waiting for unfinished jobs....
>>> kernel/audit_tree.c:33:9: error: redefinition of =E2=80=98struct node=
=E2=80=99
>>>    struct node {
>>>           ^~~~
>>> In file included from ./include/linux/cpu.h:17,
>>>                   from ./arch/arm/include/asm/cpu.h:11,
>>>                   from ./arch/arm/include/asm/smp_plat.h:12,
>>>                   from ./arch/arm/include/asm/irq_work.h:5,
>>>                   from ./include/linux/irq_work.h:56,
>>>                   from ./include/linux/irq.h:19,
>>>                   from ./include/asm-generic/hardirq.h:17,
>>>                   from ./arch/arm/include/asm/hardirq.h:10,
>>>                   from ./include/linux/hardirq.h:12,
>>>                   from ./include/linux/highmem.h:10,
>>>                   from ./include/linux/bvec.h:10,
>>>                   from ./include/linux/skbuff.h:17,
>>>                   from kernel/audit.h:14,
>>>                   from kernel/audit_tree.c:2:
>>> ./include/linux/node.h:84:8: note: originally defined here
>>>   struct node {
>>>          ^~~~
>>> make[1]: *** [scripts/Makefile.build:288: kernel/audit_tree.o] Error 1
>>>
>>>
>>> Any thoughts. I am grateful in advance.
>> v5.15.44/arm builds fine here, so this could be a toolchain
>> issue. The
>> oldest toolchain I tested with is:
>> arm-linux-gnueabihf-gcc (Linaro GCC 7.5-2019.12) 7.5.0
>>=20
> Good afternoon.
> I found the problem, but it seems strange to me.
> If the CONFIG_THUMB2_KERNEL=3Dy parameter is in the kernel
> configuration, I get an error:
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:496: Error: instruction not allowed in IT
> block -- `tst r0,r0'
> arch/arm/kernel/entry-armv.S:785: Error: instruction not allowed in IT
> block -- `tst r1,#0x0001'
>
> If the CONFIG_THUMB2_KERNEL parameter is not set, then compilation is
> successful.
>
> I looked at the history of my work with this architecture. The last
> time it was the 5.1 kernel, and there is no such error in my records.=20
> Unfortunately I can't fix it. I know assembly code very poorly.
>
> P.S. test board: bananapi-m3, cpu a83t, allwinner

Ok, confirmed. I can reproduce this now building for a nanopi. I'll have
a look asap and follow up.

--=20
Philippe.

