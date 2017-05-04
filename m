Date: Thu, 4 May 2017 17:07:05 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170504170705.2165e3f7@md1em3qc>
In-Reply-To: <CANWkrROwkn+Yjb4TYQofsTvdOVf1-r+5H26Owg69LTAduFMnhA@mail.gmail.com>
References: <CANWkrROwkn+Yjb4TYQofsTvdOVf1-r+5H26Owg69LTAduFMnhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe-core-4.4.43-x86-6.patch compiler error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Am Thu, 4 May 2017 15:01:18 +0200
schrieb Michael Smith <2michael.smith@gmail.com>:

> Hi.
> I am compiling for the Cobal Core with Xenomai 3.0.4 on Ubuntu 16.04
> (kernel 4.4.0-77-generic).
> When compiling the Linux kernel 4.4.43 with
> ipipe-core-4.4.43-x86-6.patch I get the following error:
>=20
>   CC      arch/x86/kernel/reboot.o
>   CC      arch/x86/kernel/early-quirks.o
>   CC      arch/x86/kernel/ipipe.o
> arch/x86/kernel/ipipe.c: In function =E2=80=98__ipipe_enable_pipeline=E2=
=80=99:
> arch/x86/kernel/ipipe.c:140:22: error: =E2=80=98smp_deferred_error_interr=
upt=E2=80=99
> undeclared (first use in this function)
>       __ipipe_do_IRQ, smp_deferred_error_interrupt,
>                       ^
> arch/x86/kernel/ipipe.c:140:22: note: each undeclared identifier is
> reported only once for each function it appears in
> arch/x86/kernel/ipipe.c: In function =E2=80=98__ipipe_trap_prologue=E2=80=
=99:
> arch/x86/kernel/ipipe.c:343:50: warning: comparison of constant =E2=80=98=
-1=E2=80=99
> with boolean expression is always true [-Wbool-compare]
>     if (!atomic_read(&kgdb_cpu_doing_single_step) !=3D -1 &&
>                                                   ^
> arch/x86/kernel/ipipe.c:343:50: warning: logical not is only applied
> to the left hand side of comparison [-Wlogical-not-parentheses]
> scripts/Makefile.build:258: recipe for target
> 'arch/x86/kernel/ipipe.o' failed make[3]: ***
> [arch/x86/kernel/ipipe.o] Error 1 scripts/Makefile.build:403: recipe
> for target 'arch/x86/kernel' failed make[2]: *** [arch/x86/kernel]
> Error 2 Makefile:961: recipe for target 'arch/x86' failed
> make[1]: *** [arch/x86] Error 2
>=20
> I've not seen any similar compiler issues on the mailing list and
> since this patch have been out for 2 months, I'm wondering is it maybe
> an Ubuntu specific issue?
> On the same Architechture (Pentium-M) the previous combination worked
> flawlessly nl.
> xenomai-3.0.3
> ipipe-core-4.1.18-x86-7.patch
> linux-4.1.18
>=20
> Any ideas?

That is clearly a 64 vs 32 Bit problem, x86_32 is not as well tested as
its 64Bit counterpart. But with you it seems 32 bit x86 is not dead
yet ;).
Should be easy to fix, i will send a patch and put you on CC.

In the meantime you can take CONFIG_X86_MCE_AMD out of your kernel
config to work around that problem.

Henning

>=20
> Thanks
> Michael
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


