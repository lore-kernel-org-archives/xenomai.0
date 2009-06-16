Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2009 15:20:10 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01A87AC3@domain.hid>
In-Reply-To: <1244815576.7890.193.camel@domain.hid>
From: <roderik.wildenburg@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi,


> -----Urspr=FCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org
> Gesendet: Freitag, 12. Juni 2009 16:06
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: gilles.chanteperdrix@xenomai.org; xenomai@xenomai.org
> Betreff: Re: AW: [Xenomai-help] Some problems with shared memory
>=20
> On Wed, 2009-06-10 at 13:47 +0200, roderik.wildenburg@domain.hid
> wrote:
> > > -----Urspr=FCngliche Nachricht-----
> > > Von: Philippe Gerum [mailto:rpm@xenomai.org
> > > Gesendet: Dienstag, 9. Juni 2009 15:28
> > > An: Wildenburg, Roderik RAEK3 MRA
> > > Cc: gilles.chanteperdrix@xenomai.org; xenomai@xenomai.org
> > > Betreff: Re: [Xenomai-help] Some problems with shared memory
> > >=20
> > > On Mon, 2009-06-08 at 10:25 +0200,=20
> roderik.wildenburg@domain.hid
> > > wrote:
> > > > >=20
> > > > > roderik.wildenburg@domain.hid wrote:
> > > > > >> All I want to hear is "yes, we ran the shm test=20
> > > without Xenomai, on
> > > > > >> exactly the same kernel, on the same platform, and the shm=20
> > > > > >> test worked".
> > > > > >> Because Xenomai runs plain Linux mmap under the=20
> hood and do no
> > > > > >> particular check on the mmap length. So, the problem=20
> > > is either that
> > > > > >> Linux mmap on that particular machine with that particular=20
> > > > > >> kernel does a
> > > > > >> check on length, or that there is a subtle bug somewhere=20
> > > > > that I do not
> > > > > >> want to investigate until I am usre that it is real.
> > > > > >=20
> > > > > >=20
> > > > > > yes, we ran the shm test without Xenomai, on
> > > > > > exactly the same kernel, on the same platform, and the shm=20
> > > > > > test worked.
> > > > > >=20
> > > > > > This means :=20
> > > > > > I took a plain 2.4.25 PPC-Kernel and started killtest=20
> > > > > without pagealigned shm size and got the error message :
> > > > > > shm_open fails. errno=3D38 SHM:/testshm
> > > > > > shm_open: Function not implemented
> > > > > >=20
> > > > > > Therefore I mounted a tmpfs on /dev/shm and killtest ran=20
> > > > > without any errormessage.
> > > > > > To make shure the missing /dev/shm isn=B4t the reason for =
the=20
> > > > > mmap-error I took a xenomai-enhanced kernel, mounted /dev/shm=20
> > > > > and run (a xenomai-linked) killtest, but I still got=20
> the error :
> > > > > > killtest2 # ./killtest -c
> > > > > > createshm mmap: No such device or address
> > > > > > shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : =
-3
> > > > > > killtest user exit !
> > > > > >=20
> > > > > > This I tried with Xenomai 2.3.5 and 2.4.7 (and got the=20
> > > same error).
> > > > > > Even on a Xenomai-enhanced kernel a killtest, which was=20
> > > > > linked without Xenomai-libraries, run without error.
> > > > > >=20
> > > > > > Sorry for not having better news
> > > > > > Roderik
> > > >=20
> > > >=20
> > > >=20
> > > > > Hi,
> > > > >=20
> > > > > this should have been fixed in the 2.4.8 release, so please=20
> > > > > test it and
> > > > > tell us whether it works for you.
> > > > >=20
> > > >=20
> > > > Hello,
> > > >=20
> > > > sorry for the delayed answer.
> > > > Yes and no: The restriction of a page aligned SHM-size=20
> > > seems to be abolished (I didn=B4t get the error message "No=20
> > > such device or address" any more).
> > > > But my target still stalls, when I kill my test=20
> > > applications in the wrong order.
> > > > For your convenience I appended the test again (start=20
> > > "killtest -c &" then "killtest &" and then kill the last one=20
> > > before the first).
> > > >=20
> > >=20
> > > By "stalls", do you mean a lockup, or does your shell hang=20
> > > upon ^C while
> > > the rest of the system keeps running fine?
> > >=20
> >=20
> > In fact, my system reboots because a high priority (no=20
> other Xenomai task has higher priority) Xenomai watchdog=20
> trigger task isn=B4t executed any more (the hardware watchdog=20
> resets the system if it is not triggered for more than 0,5 seconds).=20
> > When I deactivate the watchdog, the console is dead=20
> immediatelly (after the kill) but the system seems to work =20
> (ping works) for a while. Even a telnet login is sometimes=20
> (sometimes the system stalls with the login sometimes not)=20
> possible. Sometimes the system stalls only after a minute,=20
> sometimes not at all.
> > Sorry that I can=B4t give you a better description, but the=20
> behaviour is pretty strange.
> >=20
> > Here is the output of /proc/xenomai/irq when I had access=20
> to the system via telnet :
> > fer1_rw:/ # cat /proc/xenomai/irq
> > IRQ         CPU0
> >   6:           0         pciibm0
> > 256:       14619         [virtual]
> > 259:           9         [virtual]
> > fer1_rw:/ # cat /proc/xenomai/irq
> > IRQ         CPU0
> >   6:           0         pciibm0
> > 256:       14619         [virtual]
> > 259:           9         [virtual]
> > fer1_rw:/ # cat /proc/xenomai/irq
> > IRQ         CPU0
> >   6:           0         pciibm0
> > 256:       14619         [virtual]
> > 259:           9         [virtual]
>=20
> We have a stuck timer interrupt. Ok, the I-pipe 1.2 series=20
> for Linux 2.4
> is so old that I have probably handwritten that code on some parchment
> first, so please try the following patch. It is basically the most
> recent I-pipe core available for the 2.6/powerpc series backported to
> your venerable 2.4/ppc kernel. Let me know if the issue is gone; it
> seems to be fixed here, but that's no proof unfortunately, given the
> randomness of it.
>=20
> http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4
> .25-ppc-DENX-2.0-00.patch
>=20
> PS: this patch handles mpc5xxx, UIC and AIC (i.e. 4xx) PICs, so if you
> are still based on an Icecube, this should do the trick; at least it
> works on mine. Otherwise, just let me know which kind of hw=20
> you actually
> run.
>=20

I applied your ipipe-patch to our 2.4.25 ppc kernel, but unfortunatelly =
I now can=B4t compile the kernel any more.
I get following error messages :

ipipe.c:393: error: `__switch_to' undeclared here (not in a function)
ipipe.c:393: error: initializer element is not constant
ipipe.c:393: error: (near initialization for =
`__ksymtab___switch_to.value')
ipipe.c:394: error: `show_stack' undeclared here (not in a function)
ipipe.c:394: error: initializer element is not constant
ipipe.c:394: error: (near initialization for =
`__ksymtab_show_stack.value')
ipipe.c:393: error: __ksymtab___switch_to causes a section type conflict
ipipe.c:394: error: __ksymtab_show_stack causes a section type conflict
make[1]: *** [ipipe.o] Fehler 1


The first error I could elimnate by deleting one '_'.=20
"`show_stack' undeclared here" I eliminated by simply commenting out =
"EXPORT_SYMBOL_GPL(show_stack);" in ipipe.c
(just to see what will happen).=20
But even after commenting out the most of the tail of ipipe.c :

EXPORT_SYMBOL_GPL(__switch_to);
//EXPORT_SYMBOL_GPL(show_stack);
EXPORT_SYMBOL_GPL(_switch);
EXPORT_SYMBOL_GPL(tasklist_lock);
//void atomic_set_mask(unsigned long mask, unsigned long *ptr);
//void atomic_clear_mask(unsigned long mask, unsigned long *ptr);
#ifdef FEW_CONTEXTS
EXPORT_SYMBOL_GPL(nr_free_contexts);
EXPORT_SYMBOL_GPL(context_mm);
EXPORT_SYMBOL_GPL(steal_context);
#endif	/* !FEW_CONTEXTS */
//EXPORT_SYMBOL_GPL(atomic_set_mask);
//EXPORT_SYMBOL_GPL(atomic_clear_mask);
EXPORT_SYMBOL_GPL(last_task_used_math);

the linker complains about multiple definitions of symbols :

ppc_6xx-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic =
arch/ppc/kernel/head.o arch/ppc/kernel/idle_6xx.o init/main.o =
init/version.o init/do_mounts.o \
                --start-group \
                arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o =
arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o =
ipc/ipc.o \
                 drivers/char/char.o drivers/block/block.o =
drivers/misc/misc.o drivers/net/net.o drivers/ide/idedriver.o =
drivers/mtd/mtdlink.o drivers/macintosh/macintosh.o =
drivers/video/video.o drivers/media/media.o drivers/i2c/i2c.o =
kernel/xenomai/nucleus/xeno_nucleus.o =
kernel/xenomai/skins/native/xeno_native.o =
kernel/xenomai/skins/posix/xeno_posix.o =
kernel/xenomai/skins/rtdm/xeno_rtdm.o arch/ppc/5xxx_io/5xxx_io.o =
arch/ppc/xenomai/built-in.o \
                net/network.o \
                =
/home/arowil/mc45/svn/kernel_withoutadeos/source/lib/lib.a \
                --end-group \
                -o vmlinux
kernel/kernel.o(__ksymtab+0xfb0): In function `wait_for_completion':
/home/arowil/mc45/svn/kernel_withoutadeos/source/kernel/sched.c:851: =
multiple definition of `__ksymtab_tasklist_lock'
arch/ppc/kernel/kernel.o(__ksymtab+0x18):/home/arowil/mc45/svn/kernel_wit=
houtadeos/source/arch/ppc/kernel/irq.c:575: first defined here
kernel/kernel.o(.kstrtab+0x2064): In function `ipipe_reenter_root':
/home/arowil/mc45/svn/kernel_withoutadeos/source/kernel/sched.c:536: =
multiple definition of `__kstrtab_tasklist_lock'
arch/ppc/kernel/kernel.o(.kstrtab+0x30):/home/arowil/mc45/svn/kernel_with=
outadeos/source/arch/ppc/kernel/irq.c:578: first defined here
ppc_6xx-ld: Warning: size of symbol `__kstrtab_tasklist_lock' changed =
from 22 in arch/ppc/kernel/kernel.o to 14 in kernel/kernel.o


So, I stuck here a little bit. Do you have an idea what went wrong, or =
can you give me a hint where I have to look (I couldn=B4t even find the =
symbol  "tasklist_lock" in irq.c).
(Next problem will be, that Stefano Babic=B4s LTT-Patch for =
Xenomai/Linux won=B4t work any more with your new adeos patch, but this =
is an other story).

Our hardware is based on a freescale 5200B, so, as far as I understand =
your question about PICs, your patch should work for our hardware (I =
hope).

Thank you for your help and best regards
Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

