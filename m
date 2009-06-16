From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01A87AC3@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A01A87AC3@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Jun 2009 15:45:53 +0200
Message-Id: <1245159953.3949.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2009-06-16 at 15:20 +0200, roderik.wildenburg@domain.hid
wrote:
> Hi,
>=20
> I applied your ipipe-patch to our 2.4.25 ppc kernel, but unfortunatelly=
 I now can=C2=B4t compile the kernel any more.
> I get following error messages :
>=20
> ipipe.c:393: error: `__switch_to' undeclared here (not in a function)
> ipipe.c:393: error: initializer element is not constant
> ipipe.c:393: error: (near initialization for `__ksymtab___switch_to.val=
ue')
> ipipe.c:394: error: `show_stack' undeclared here (not in a function)
> ipipe.c:394: error: initializer element is not constant
> ipipe.c:394: error: (near initialization for `__ksymtab_show_stack.valu=
e')
> ipipe.c:393: error: __ksymtab___switch_to causes a section type conflic=
t
> ipipe.c:394: error: __ksymtab_show_stack causes a section type conflict
> make[1]: *** [ipipe.o] Fehler 1
>=20
>=20
> The first error I could elimnate by deleting one '_'.
> =20
> "`show_stack' undeclared here" I eliminated by simply commenting out "E=
XPORT_SYMBOL_GPL(show_stack);" in ipipe.c
> (just to see what will happen).=20
> But even after commenting out the most of the tail of ipipe.c :
>=20
> EXPORT_SYMBOL_GPL(__switch_to);
> //EXPORT_SYMBOL_GPL(show_stack);
> EXPORT_SYMBOL_GPL(_switch);
> EXPORT_SYMBOL_GPL(tasklist_lock);
> //void atomic_set_mask(unsigned long mask, unsigned long *ptr);
> //void atomic_clear_mask(unsigned long mask, unsigned long *ptr);
> #ifdef FEW_CONTEXTS
> EXPORT_SYMBOL_GPL(nr_free_contexts);
> EXPORT_SYMBOL_GPL(context_mm);
> EXPORT_SYMBOL_GPL(steal_context);
> #endif	/* !FEW_CONTEXTS */
> //EXPORT_SYMBOL_GPL(atomic_set_mask);
> //EXPORT_SYMBOL_GPL(atomic_clear_mask);
> EXPORT_SYMBOL_GPL(last_task_used_math);
>=20
> the linker complains about multiple definitions of symbols :
>=20
> ppc_6xx-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/=
kernel/head.o arch/ppc/kernel/idle_6xx.o init/main.o init/version.o init/=
do_mounts.o \
>                 --start-group \
>                 arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o =
arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/i=
pc.o \
>                  drivers/char/char.o drivers/block/block.o drivers/misc=
/misc.o drivers/net/net.o drivers/ide/idedriver.o drivers/mtd/mtdlink.o d=
rivers/macintosh/macintosh.o drivers/video/video.o drivers/media/media.o =
drivers/i2c/i2c.o kernel/xenomai/nucleus/xeno_nucleus.o kernel/xenomai/sk=
ins/native/xeno_native.o kernel/xenomai/skins/posix/xeno_posix.o kernel/x=
enomai/skins/rtdm/xeno_rtdm.o arch/ppc/5xxx_io/5xxx_io.o arch/ppc/xenomai=
/built-in.o \
>                 net/network.o \
>                 /home/arowil/mc45/svn/kernel_withoutadeos/source/lib/li=
b.a \
>                 --end-group \
>                 -o vmlinux
> kernel/kernel.o(__ksymtab+0xfb0): In function `wait_for_completion':
> /home/arowil/mc45/svn/kernel_withoutadeos/source/kernel/sched.c:851: mu=
ltiple definition of `__ksymtab_tasklist_lock'
> arch/ppc/kernel/kernel.o(__ksymtab+0x18):/home/arowil/mc45/svn/kernel_w=
ithoutadeos/source/arch/ppc/kernel/irq.c:575: first defined here
> kernel/kernel.o(.kstrtab+0x2064): In function `ipipe_reenter_root':
> /home/arowil/mc45/svn/kernel_withoutadeos/source/kernel/sched.c:536: mu=
ltiple definition of `__kstrtab_tasklist_lock'
> arch/ppc/kernel/kernel.o(.kstrtab+0x30):/home/arowil/mc45/svn/kernel_wi=
thoutadeos/source/arch/ppc/kernel/irq.c:578: first defined here
> ppc_6xx-ld: Warning: size of symbol `__kstrtab_tasklist_lock' changed f=
rom 22 in arch/ppc/kernel/kernel.o to 14 in kernel/kernel.o
>=20
>=20
> So, I stuck here a little bit. Do you have an idea what went wrong, or =
can you give me a hint where I have to look (I couldn=C2=B4t even find th=
e symbol  "tasklist_lock" in irq.c).
> (Next problem will be, that Stefano Babic=C2=B4s LTT-Patch for Xenomai/=
Linux won=C2=B4t work any more with your new adeos patch, but this is an =
other story).
>=20
> Our hardware is based on a freescale 5200B, so, as far as I understand =
your question about PICs, your patch should work for our hardware (I hope=
).

This patch is based on the current HEAD of
git://www.denx.de/git/linuxppc_2_4_devel.git
(commit 5bab6d641ff5ba139f9f41869502cb7c96d785bc)

The patched kernel builds and runs fine using lite5200b_defconfig.

--=20
Philippe.



