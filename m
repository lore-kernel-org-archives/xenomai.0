Subject: Re: [Xenomai-core] ksrc/driver refactoring
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0608161603176.7349@domain.hid>
References: <Pine.LNX.4.64.0608161603176.7349@domain.hid>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 18:00:50 +0200
Message-Id: <1155916850.4326.118.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-08-16 at 16:14 +0200, Klaas Gadeyne wrote:
> > I just wanted to drop a note that I did some refactoring on the
> > drivers directory (16550A->serial) and the config menus. If anything is
> > broken, shoot me.
> 
> I don't think this is related, but 2 students of mine got stuck on a linker
> error this morning trying to compile xenomai-trunk on a i386 target
> (2.4.33 kernel with the adeos-ipipe-2.4.32-i386-1.2-06.patch (applied
> with a few minor hunks), gcc 3.3.6 from Debian).
> 
> ld -m elf_i386 -T /usr/src/linux-2.4.33/arch/i386/vmlinux.lds -e stext
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/
> main.o init/version.o init/do_mounts.o \
>                 --start-group \
>                 arch/i386/kernel/kernel.o arch/i386/mm/mm.o
> kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>                  drivers/acpi/acpi.o drivers/char/char.o
> drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
> drivers/char             /agp/agp.o drivers/ide/idedriver.o
> drivers/cdrom/driver.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o
> drivers/net/pcmcia/pcmcia_             net.o drivers/video/video.o
> drivers/media/media.o kernel/xenomai/nucleus/xeno_nucleus.o
> kernel/xenomai/skins/native/xeno_native.o
> kernel/xenomai/skins/posix/xeno_posix.o
> kernel/xenomai/skins/rtdm/xeno_rtdm.o
> drivers/xenomai/16550A/xeno_16550A.o drivers/xenom
> ai/testing/xeno_timerbench.o arch/i386/xenomai/built-in.o \
>                 net/network.o \
>                 /usr/src/linux-2.4.33/arch/i386/lib/lib.a
> /usr/src/linux-2.4.33/lib/lib.a
> /usr/src/linux-2.4.33/arch/i386/lib/lib             .a \
>                 --end-group \
>                 -o vmlinux
> drivers/char/char.o: In function `handle_scancode':
> (.text+0x1b25a): undefined reference to `pckbd_sysrq_xlate'
> make: *** [vmlinux] Error 1
> 
> The "quick-fix" solution was to disable the magic_sysrq_key option
> from the kernel.  I first thought the problem was due to a missing
> dependency in the the kernel and not at all xenomai-related (and since
> the quick hack worked, they didn't search any further), but now that
> I've read your mail I started to doubt if it might be related.
> 
> Let me know if it might be related and if you want further info.
> 
> But I'll wait before shooting :-)
> 

There seems to be a few "generic" 2.4 kernel issues in the same area.
For instance, building the kernel without CONFIG_VT causes
handle_scancode to be undefined, since driver/char/Makefile does not
build keyboard.c in such a case, albeit it's used by the input
subsystem. In any case, this is not related to Adeos/Xenomai.

> klaas
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



