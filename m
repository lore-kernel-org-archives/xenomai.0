Date: Sat, 20 Aug 2016 12:40:03 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160820124003.5c728ba0@md1em3qc>
In-Reply-To: <20160820121738.035c8c06@md1em3qc>
References: <20160820121738.035c8c06@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Fw: Installation of Xenomai 2.6.4 - Kernel panic on
 SCSI after reboot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Michele Belotti <miki.belotti@gmail.com>

Michele,

as you already found out the issue does not seem to be connected to
Xenomai. I am guessing the kernel does not contain the drivers to
find/mount the rootfs. And the configuration or content of your initrd
seem to be wrong so that module loading does not work as expected.
Maybe you kernel .config does not even build the drivers for your
scsi-Controller as modules, in that case the initrd wont help even if it
is ok.

You have two options to resolve that problem:
1. build all required drivers with =3Dy instead of =3Dm
2. find and fix the problem in the initrd

The best way is to start with a regular 3.18 kernel and see how to
install that one on your machine.
You found this link:
http://linuxaleph.blogspot.de/2014/06/kernel-panic-scsiwaitscan-on-centos.h=
tml
and it talks about a misconfiguration or bug in dracut. Dracut is the
thing that builds your initrd and it reads like your version of dracut
could build you a broken initrd.
But in your case it is _not_ "virtio_blk" but another scsi driver.

Please send "lspci" and try to find out which driver you working kernel
uses for the scsi-controller ("lsmod"). And please send it as text and
not photographs.

Henning

Am Sat, 20 Aug 2016 12:17:38 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> Please keep the discussion on the list and always use the
> "reply-to-all" function of your mailer.
>=20
>=20
> Beginn der weitergeleiteten Nachricht:
>=20
> Datum: Sat, 20 Aug 2016 10:37:39 +0200
> Von: Michele Belotti <miki.belotti@gmail.com>
> An: Henning Schild <henning.schild@siemens.com>
> Betreff: Re: [Xenomai] Installation of Xenomai 2.6.4 - Kernel panic on
> SCSI after reboot
>=20
>=20
> Dear Henning,
> Thank you for your e-mail, I'll try to clarify a bit the problem.
> My aim is to install xenomai (kernel linux  linux-3.8.13
>  ipipe-core-3.10.32-x86-6) on the machine HP described in the
> Purchase details I sent you with my previous e-mail.
> I have already successfully installed the same xenomai on several
> machines, using the same settings.
> When I try to install the xenomai on the HP server I got the following
> error message:
> FATAL: Module scsi_wait_scan not found (a print screen is in
> attachment). [image: Inline image 1]
>=20
>=20
> I executed different tests in order to solve the problem, but till
> now I was not able to succeed.
>=20
> I'll list the different tests here below:
>=20
>=20
> Pre-requisite:
>=20
> a. I use kernel linux  linux-3.8.13;
> b. #copy the the pre configured Makefile to kernel folder
> c. rename the preconfigured Makefile to take the place of the orig
> makefile (only difference is the EXTRAVERSION=3D _xenomai-2.6.4. This
> will be added to the bootloader)
> d.copy the latest ipipe patch for this kernel
> e.   I patch it with          ${XEN_SRC}/scripts/prepare-kernel.sh
> --linux=3Dlinux-3.8.13
> --adeos=3D${XEN_SRC}ksrc/arch/x86/patches/ipipe-core-3.10.32-x86-4.patch
> --arch=3Dx86
>=20
> f. I add my .conf file (the one attached on my previous e-mail)
> g. compile with make clean && make -j 24 && make modules -j 24 && make
> modules_install && make install
> h. #set grub to boot in new kernel made
>             sed -i "/default=3D1/c\default=3D0" /boot/grub/grub.conf
>=20
>=20
> 1) In order to compile the xenomay i use the following command:
>=20
> *make clean && make -j 24 && make modules -j 24 && make
> modules_install && make install*
>=20
> As a first attempt I included in the .conf the scsi module of the HP
> via make menuconfig, but no success
>=20
>=20
> 2) On internet I found a couple of links where the same problem is
> described, even if not for xenomai:
>=20
> a. https://bugzilla.kernel.org/show_bug.cgi?id=3D60758
>=20
> b. http://linuxaleph.blogspot.de/2014/06/kernel-panic-scsiwaits
> can-on-centos.html
>=20
> As you can see, for this problem, they have an explanation at least
> for kernel 3.13.They say that the problem is linked with the fact
> that the version introduces multi queue block i/o for virtio_blk,
> which in turn does not call any more blk_init_queue() but
> blk_mq_init_queue() instead. Dracut matches against symbol
> blk_init_queue but not yet against symbol blk_mq_init_queue.
>=20
> --> as a first attempt I executed the following code as suggested:   =20
>=20
> *echo 'add_drivers+=3D"virtio_blk" ' >
> /etc/dracut.conf.d/force-vitio_blk-to-ensure-boot.conf*
>=20
> *cp /boot/initramfs-3.8.13_xenomai-2.6.4.img
> /boot/initramfs-3.8.13_xenomai-2.6.4.img.bak*
>=20
> *dracut -f /boot/initramfs-3.8.13_xenomai-2.6.4.img
> 3.8.13_xenomai-2.6.4*
>=20
> but no success
>=20
> --> after I also added virtio in the configuration file before =20
> compiling xenomai, but also here no success.
>=20
>=20
> 3) When I compile xenomai I can note that different scsi modules are
> compiled an installed (lease see the attached picture)
> [image: Inline image 1]
>=20
>=20
> I had a look in the folder linux-3.8.13-xenomai-2.6.4/drivers/scsi
> and I noted that indeed the scsi_wait_scan is not there,
> as a consequence it seems that the scsi_wait_scan is not present
> anymore in the linux-3.8.13 distribution.
> I had a look at an older linux distribution (linux-3.4) and indeed in
> that case the scsi_wait_scan is still there, in
> linux-3.4//drivers/scsi. My idea is somehow to add the scsi_wait_scan
> to my linux-3.8.13-xenomai-2.6.4 and to compile and install it.
> If done in the correct way, I should be able to see on the screen
> during the compilation something like:
>=20
> *CC [M] drivers/scsi/scsi_wait_scan.o           should be shown after
> CC [M] drivers/scsi/scsi_transport_srp.o*
>=20
> and
>=20
> *INSTALL drivers/scsi/scsi_wait_scan.ko       should be shown after
> INSTALL  drivers/scsi/scsi_transport_srp.ko*
>=20
> I tried it copying the scsi_wait_scan in linux-3.8.13//drivers/scsi
> before patching it with xenomai. Then I tried to compile with:
>=20
> *make clean && make -j 24 && make modules -j 24 && make
> modules_install && make install*
>=20
> but no success.
>=20
>=20
>=20
>=20
> Now I would like to kindly ask you if in the past you had such a
> problem:
>=20
> *FATAL: Module scsi_wait_scan not found.*
>=20
> and if you have a suggestion to solve it. In addition, I would like to
> ask you how it is possible to add the * "*scsi_wait_scan"
> to the list of compiled modules (as explained at the end of point 3).
> It is still not clear to me if such problem is linked with my HW or
> is a problem linked linux distribution or both. On this respect I
> would like to add that I was able to compile the xenomai (exactly the
> same with the same .config) on a Virtual Machine that I was running
> on the same HW.
>=20
> Thank you in advance for you support,
>=20
>=20
> Kind Regards
>=20
>=20
> Michele
>=20
>=20
> 2016-08-19 19:03 GMT+02:00 Henning Schild
> <henning.schild@siemens.com>:
>=20
> > Michele,
> >
> > that is a lot of information, most of it does not seem too useful.
> > What exactly is the error message you get and you are working on?
> >
> > I can only assume it is the usual "my root partition does not exist"
> > and you really just miss the module.
> >
> > When building an essential driver as an external module you will
> > need an initrd. Consult documentation of your distribution to
> > figure out how to best update a kernel and create/update the initrd
> > for it. I would even suggest you just try that with a "regular"
> > linux kernel, because from what you wrote you might have missed a
> > step or two in installing that new ipipe-kernel.
> >
> > Find some comments as inline replies in you mail below.
> >
> > Henning
> >
> > Am Fri, 19 Aug 2016 17:55:09 +0200
> > schrieb Michele Belotti <miki.belotti@gmail.com>:
> >   =20
> > > I have already installed the Xenomai 2.6.4 on several machine with
> > > Red Hat 6.7 successfully (kernel linux  linux-3.8.13
> > > ipipe-core-3.10.32-x86-6) on the machine HP described in the
> > > Purchase details. The installation seems correct except to the
> > > fact the probably the SCSI driver are not correctly
> > > installed. The configuration is the one described in the
> > > xenomai_kernel.config file
> > >
> > > We make a lot of test different that I try to summarize
> > > hereafter...
> > >
> > >
> > >
> > > As suggested, we added our SCSI model in the .config but it
> > > doesn=E2=80=99t resolve the problem, we still have the core dump.
> > >
> > > Googling, we found that
> > > (https://bugzilla.kernel.org/show_bug.cgi?id=3D60758) to solve our
> > > problem (scsi_wait_scan not found) we should enable
> > > CONFIG_SCSI_SCAN_ASYN =C3=A0 Y  in the .config file.
> > >
> > > We did it, but it still does not work.
> > >
> > > Now, there is something strange.
> > >
> > > If i run the following command:
> > >
> > >
> > >
> > > lsinitrd | grep wait
> > >
> > >
> > >
> > > I can see the wait module in the following folder:
> > >
> > > /lib/modules/2.6.32-573.el6.x86-64/kernel/drivers/scsi/scsi_wait_scan=
.ko   =20
> >
> > Well lsinitrd shows the content of the initrd, not the content of
> > your rootfs. Even though for the kernel specific modules you
> > probably want that to be the same.
> > Does that initrd contain /lib/modules/linux-3.8.13-xenomai-2.6.4 as
> > well?
> >   =20
> > >
> > >
> > > but if I look in the following folder:
> > > /usr/src/kernls/linux-3.8.13-xenomai-2.6.4/drivers/scsi I=E2=80=99m n=
ot
> > > able to find it.   =20
> >
> > That is a totally different path. Did you forget "make
> > modules_install"? You want all relevant modules to be
> > in /lib/modules/3.8.13-xeno.. and after creating/updating the initrd
> > you also want to find them in there.
> >
> > And you want to make sure the initrd is actually used. It needs to
> > be mentioned in the bootloader config.
> >   =20
> > >
> > > If my understanding is correct, the scsi_wait_scan module is
> > > needed to =E2=80=9Cwait=E2=80=9D the scan of the scsi drivers before =
they are
> > > mounted.
> > >
> > >
> > > In order to speed up the different tests, I created the
> > > ./usr/src/kernels/linux-3.8.13-xenomai-2.6.4 following manually
> > > the build_install_xenomai_kernel.sh and then, instead of mv this
> > > version to $FIN_DIR (raw 140) I just
> > >
> > > cp  ./usr/src/kernels/linux-3.8.13-xenomai-2.6.4  /usr/src/kernels/
> > > and I update the .config inside with my config every time I want
> > > to perform a new test; then I compile and I update the grub.
> > >
> > >
> > >
> > >
> > >
> > > 1)            In order to create a new config file I always use
> > > the make menuconfig. Please find attached two version of the
> > > config files (the most significative) I used to compile the
> > > software (of course I renamed in .config before recompiling).
> > >
> > > Using config_1 I have the following messages after the make:
> > >
> > > ERROR: modinfo: could not find module cpufreq_ondemand
> > >
> > > ERROR: modinfo: could not find module freq_table
> > >
> > > ERROR: modinfo: could not find module pcc_cpufreq
> > >
> > > ERROR: modinfo: could not find module power_meter
> > >
> > > ERROR: modinfo: could not find module acpi_ipmi
> > >
> > > ERROR: modinfo: could not find module sb_edac
> > >
> > > ERROR: modinfo: could not find module hpsa
> > >
> > > ERROR: modinfo: could not find module wmi
> > >
> > >
> > >
> > > Using configure_2 I have the following messages after the make:
> > >
> > >                 ERROR: modinfo: could not find module
> > > cpufreq_ondemand
> > >
> > > ERROR: modinfo: could not find module freq_table
> > >
> > > ERROR: modinfo: could not find module pcc_cpufreq
> > >
> > > ERROR: modinfo: could not find module sg
> > >
> > > ERROR: modinfo: could not find module mdio
> > >
> > > ERROR: modinfo: could not find module power_meter
> > >
> > > ERROR: modinfo: could not find module acpi_ipmi
> > >
> > > ERROR: modinfo: could not find module sb_edac
> > >
> > > ERROR: modinfo: could not find module lpc_ich
> > >
> > > ERROR: modinfo: could not find module mfd_core
> > >
> > > ERROR: modinfo: could not find module sd_mod
> > >
> > > ERROR: modinfo: could not find module crc_t10dif
> > >
> > > ERROR: modinfo: could not find module hpsa
> > >
> > > ERROR: modinfo: could not find module wmi
> > >
> > >                 as you know I cannot add some modules as they have
> > > conficts with Xenomay.
> > >
> > > 2)            For the scsi_module_wait error I found on internet
> > > the following links:
> > >
> > > a.            https://bugzilla.kernel.org/show_bug.cgi?id=3D60758
> > >
> > > b.
> > > http://linuxaleph.blogspot.de/2014/06/kernel-panic-   =20
> > scsiwaitscan-on-centos.html   =20
> > >
> > > For this problem they have an explanation at least for kernel
> > > 3.13, an idea can be this kernel for PGD instead of 3.8. Anyway,
> > > they say that the problem is linked with
> > >
> > >                 the fact that the version introduces multi queue
> > > block i/o for virtio_blk, which in turn does not any more call
> > > blk_init_queue() but blk_mq_init_queue() instead.
> > >
> > > Dracut matches against symbol blk_init_queue but not yet against
> > > symbol blk_mq_init_queue. As you can see in the config file I
> > > added the virtio and also I performed the suggested procedure to
> > > fix the problem, i.e. :
> > >
> > > I listed the /boot directory and the I executed:
> > >
> > >
> > >
> > > echo 'add_drivers+=3D"virtio_blk" ' >
> > > /etc/dracut.conf.d/force-vitio_blk-to-ensure-boot.conf
> > >
> > > cp /boot/initramfs-3.8.13_xenomai-2.6.4.img
> > > /boot/initramfs-3.8.13_xenomai-2.6.4.img.bak
> > >
> > > dracut -f /boot/initramfs-3.8.13_xenomai-2.6.4.img
> > > 3.8.13_xenomai-2.6.4
> > >
> > >
> > >
> > > But the error is still there. I did the same also for
> > > initramfs-2.6.32-573.el6.x86_64.img, but the error is still there.
> > > By the way, I can confirm that the initramfs  is updated after
> > > each make.
> > >
> > > 3)            The scsi_wait_scan driver is apparently an old
> > > driver that indeed is not present in the driver/scsi folder of
> > > the linux distribution we used during the xenomai patching. But
> > > it is present in
> > >
> > > /lib/modules/2.6.32-573.el6.x86_64/kernel/drivers/scsi/.
> > >
> > > As during the make different drivers/scsi are installed (e.g.
> > > scsi_transport etc) I downloaded an older linux version and I
> > > copied the scsi_wait_scan.c in drivers/scsi
> > >
> > > cp
> > > scsi_wait_scan.c /usr/src/kernels/linux-3.8.13-   =20
> > xenomai-2.6.4/drivers/scsi   =20
> > >
> > > Unfortunately at the end the scsi_wait_scan.o was not present in
> > > /lib/modules/3.8.13_xenomai-2.6.4/kernel/drivers/scsi/ , therefore
> > > it has not been installed. I think that if we manage to install
> > > this driver together with all the others we may solve the problem.
> > >
> > > Of course I also tried to cp scsi_wait_scan.o :
> > >
> > > cp /lib/modules/2.6.32-573.el6.x86_64/kernel/drivers/scsi/   =20
> > scsi_wait_scan.ko   =20
> > > /lib/modules/3.8.13_xenomai-2.6.4/kernel/drivers/scsi/
> > >
> > > but it does not solve the problem. The strange thing is that I was
> > > not able to insert the scsi_wait_scan using the make menuconfig.
> > >
> > > I also tried the =E2=80=9Cinsmod scsi_wait_scan=E2=80=9D, but no succ=
ess.
> > >
> > >
> > >
> > > In conclusion I think that there are at least two possibility (on
> > > top of the VM installation using full machine power):
> > >
> > > 1)            To install properly the scsi_wait_scan as it is done
> > > for the other modules
> > >
> > > 2)            To try to patch and recompile the xenomai using a
> > > different linux core.
> > >
> > >
> > >
> > >
> > > 1)            I copied the scsi_wait_scan.c in
> > > linux-3.8.13-xenomai-2.6.4/drivers/scsi before performing the
> > > xenomai patching. Then I copiled the kernel, but the error is
> > > still there.
> > >
> > > 2)            As I copied the scsi_wait_scan.c from linux-3.4, I
> > > tried directly to patch the linux-3.4, using the
> > > ipipe-core-3.4.6-x86-2.patch and ipipe-core-3.4.6-x86-4.patch,
> > > but I was not able to patch the xenomai, or, better, with
> > > ipipe-core-3.4.6-x86-2.patch it was not possible to patch xenomay,
> > > with ipipe-core-3.4.6-x86-4.patch it was possible to patch the
> > > xenomai but then I was not able to recompile the kernel.
> > >
> > >
> > >
> > >
> > >
> > > As explained one possible solution (in my opinion) is to add the
> > > scsi_wait_scan to the modules that are compiled and installed
> > > during the make. if done in the correct way, the:
> > >
> > >
> > >
> > > CC [M] drivers/scsi/scsi_wait_scan.o           should be shown
> > > after CC [M] drivers/scsi/scsi_transport_srp.o
> > >
> > > and
> > >
> > > INSTALL drivers/scsi/scsi_wait_scan.ko       should be shown after
> > > INSTALL drivers/scsi/scsi_transport_srp.ko
> > >
> > >
> > >
> > > during the kernel compilation.
> > >
> > >
> > >
> > > I don't know how it is possible to add scsi_wait_scan at the list
> > > of modules to be compiled. I tried to  modifiyng the
> > >
> > > make clean && make -j 24 && make modules -j 24 && make
> > > modules_install && make install but I was not able to add the
> > > scsi_wait_scan.
> > >
> > >
> > >
> > >
> > > Cpould you please give me some hint on how to solve the problem?
> > > Any suggestion will be very welcome.
> > > If you need additional information, please let me know
> > >
> > > Thanks a lot in advance.
> > >
> > > Michele
> > >
> > >
> > >
> > >   [image: Immagine incorporata 2]
> > >
> > > Michele
> > >
> > > [image: Immagine incorporata 1]
> > > -------------- next part --------------
> > > A non-text attachment was scrubbed...
> > > Name: PDG HW Purchase details.jpg
> > > Type: image/jpeg
> > > Size: 58022 bytes
> > > Desc: not available
> > > URL:
> > > <http://xenomai.org/pipermail/xenomai/attachments/20160819/
> > 81148731/attachment.jpg>
> > > -------------- next part -------------- A non-text attachment was
> > > scrubbed... Name: IMAG1932.jpg
> > > Type: image/jpeg
> > > Size: 2609075 bytes
> > > Desc: not available
> > > URL:
> > > <http://xenomai.org/pipermail/xenomai/attachments/20160819/   =20
> > 81148731/attachment-0001.jpg>   =20
> > > -------------- next part
> > > -------------- ./build_install_xenomai_kernel_noquestions.sh: line
> > > 1: =EF=BB=BF#!/bin/bash: No such file or directory
> > > **************************************************
> > > * Greetings from TAS-Deutschland!                *
> > > **************************************************
> > > *This script will install the Xenomai version:   *
> > > * xenomai-2.6.4                               *
> > > * The kernel host version is: linux-3.8.13    *
> > > **************************************************
> > > ...
> > > mkdir: cannot create directory `usr/': File exists
> > > mkdir: cannot create directory `usr/src/': File exists
> > > mkdir: cannot create directory `usr/src/kernels/': File exists
> > >
> > > Next step: prepare the kernel
> > > patching file arch/x86/Kconfig
> > > patching file arch/x86/Kconfig.debug
> > > patching file arch/x86/include/asm/apic.h
> > > patching file arch/x86/include/asm/apicdef.h
> > > patching file arch/x86/include/asm/debugreg.h
> > > patching file arch/x86/include/asm/desc.h
> > > patching file arch/x86/include/asm/fpu-internal.h
> > > patching file arch/x86/include/asm/hw_irq.h
> > > patching file arch/x86/include/asm/i8259.h
> > > patching file arch/x86/include/asm/ipi.h
> > > patching file arch/x86/include/asm/ipipe.h
> > > patching file arch/x86/include/asm/ipipe_32.h
> > > patching file arch/x86/include/asm/ipipe_64.h
> > > patching file arch/x86/include/asm/ipipe_base.h
> > > patching file arch/x86/include/asm/irq_vectors.h
> > > patching file arch/x86/include/asm/irqflags.h
> > > patching file arch/x86/include/asm/mmu_context.h
> > > patching file arch/x86/include/asm/page_64_types.h
> > > patching file arch/x86/include/asm/processor.h
> > > patching file arch/x86/include/asm/special_insns.h
> > > patching file arch/x86/include/asm/switch_to.h
> > > patching file arch/x86/include/asm/thread_info.h
> > > patching file arch/x86/include/asm/traps.h
> > > patching file arch/x86/include/asm/tsc.h
> > > patching file arch/x86/kernel/Makefile
> > > patching file arch/x86/kernel/apic/apic.c
> > > patching file arch/x86/kernel/apic/apic_flat_64.c
> > > patching file arch/x86/kernel/apic/io_apic.c
> > > patching file arch/x86/kernel/apic/ipi.c
> > > patching file arch/x86/kernel/apic/x2apic_cluster.c
> > > patching file arch/x86/kernel/apic/x2apic_phys.c
> > > patching file arch/x86/kernel/cpu/common.c
> > > patching file arch/x86/kernel/cpu/mtrr/cyrix.c
> > > patching file arch/x86/kernel/cpu/mtrr/generic.c
> > > patching file arch/x86/kernel/dumpstack_32.c
> > > patching file arch/x86/kernel/dumpstack_64.c
> > > patching file arch/x86/kernel/entry_32.S
> > > patching file arch/x86/kernel/entry_64.S
> > > patching file arch/x86/kernel/hpet.c
> > > patching file arch/x86/kernel/i387.c
> > > patching file arch/x86/kernel/i8253.c
> > > patching file arch/x86/kernel/i8259.c
> > > patching file arch/x86/kernel/ipipe.c
> > > patching file arch/x86/kernel/irq.c
> > > patching file arch/x86/kernel/irqinit.c
> > > patching file arch/x86/kernel/kgdb.c
> > > patching file arch/x86/kernel/pcspeaker.c
> > > patching file arch/x86/kernel/process.c
> > > patching file arch/x86/kernel/process_32.c
> > > patching file arch/x86/kernel/process_64.c
> > > patching file arch/x86/kernel/ptrace.c
> > > patching file arch/x86/kernel/smp.c
> > > patching file arch/x86/kernel/smpboot.c
> > > patching file arch/x86/kernel/traps.c
> > > patching file arch/x86/kernel/tsc.c
> > > patching file arch/x86/kernel/vm86_32.c
> > > patching file arch/x86/kernel/vsyscall_64.c
> > > patching file arch/x86/kernel/xsave.c
> > > patching file arch/x86/kvm/svm.c
> > > patching file arch/x86/kvm/vmx.c
> > > patching file arch/x86/kvm/x86.c
> > > patching file arch/x86/lib/mmx_32.c
> > > patching file arch/x86/lib/thunk_64.S
> > > patching file arch/x86/lib/usercopy.c
> > > patching file arch/x86/mm/fault.c
> > > patching file arch/x86/mm/tlb.c
> > > patching file arch/x86/platform/uv/tlb_uv.c
> > > patching file drivers/clocksource/Makefile
> > > patching file drivers/clocksource/i8253.c
> > > patching file drivers/clocksource/ipipe_i486_tsc_emu.S
> > > patching file drivers/gpu/drm/i915/i915_gem.c
> > > patching file drivers/pci/htirq.c
> > > patching file drivers/cpuidle/Kconfig
> > > patching file drivers/tty/serial/8250/8250.c
> > > patching file fs/exec.c
> > > patching file fs/proc/array.c
> > > patching file include/asm-generic/atomic.h
> > > patching file include/asm-generic/bitops/atomic.h
> > > patching file include/asm-generic/cmpxchg-local.h
> > > patching file include/asm-generic/percpu.h
> > > patching file include/ipipe/setup.h
> > > patching file include/ipipe/thread_info.h
> > > patching file include/linux/clockchips.h
> > > patching file include/linux/clocksource.h
> > > patching file include/linux/ftrace.h
> > > patching file include/linux/hardirq.h
> > > patching file include/linux/i8253.h
> > > patching file include/linux/ipipe.h
> > > patching file include/linux/ipipe_base.h
> > > patching file include/linux/ipipe_compat.h
> > > patching file include/linux/ipipe_debug.h
> > > patching file include/linux/ipipe_domain.h
> > > patching file include/linux/ipipe_lock.h
> > > patching file include/linux/ipipe_tickdev.h
> > > patching file include/linux/ipipe_trace.h
> > > patching file include/linux/irq.h
> > > patching file include/linux/irqdesc.h
> > > patching file include/linux/irqnr.h
> > > patching file include/linux/kernel.h
> > > patching file include/linux/kvm_host.h
> > > patching file include/linux/preempt.h
> > > patching file include/linux/rwlock.h
> > > patching file include/linux/rwlock_api_smp.h
> > > patching file include/linux/sched.h
> > > patching file include/linux/spinlock.h
> > > patching file include/linux/spinlock_api_smp.h
> > > patching file include/linux/spinlock_up.h
> > > patching file include/uapi/asm-generic/mman-common.h
> > > patching file include/uapi/asm-generic/resource.h
> > > patching file include/uapi/linux/resource.h
> > > patching file init/Kconfig
> > > patching file init/main.c
> > > patching file kernel/Makefile
> > > patching file kernel/debug/debug_core.c
> > > patching file kernel/debug/gdbstub.c
> > > patching file kernel/exit.c
> > > patching file kernel/fork.c
> > > patching file kernel/ipipe/Kconfig
> > > patching file kernel/ipipe/Kconfig.debug
> > > patching file kernel/ipipe/Makefile
> > > patching file kernel/ipipe/compat.c
> > > patching file kernel/ipipe/core.c
> > > patching file kernel/ipipe/timer.c
> > > patching file kernel/ipipe/tracer.c
> > > patching file kernel/irq/chip.c
> > > patching file kernel/irq/generic-chip.c
> > > patching file kernel/irq/irqdesc.c
> > > patching file kernel/irq/manage.c
> > > patching file kernel/lockdep.c
> > > patching file kernel/panic.c
> > > patching file kernel/power/hibernate.c
> > > patching file kernel/printk.c
> > > patching file kernel/sched/clock.c
> > > patching file kernel/sched/core.c
> > > patching file kernel/signal.c
> > > patching file kernel/spinlock.c
> > > patching file kernel/time/clockevents.c
> > > patching file kernel/time/clocksource.c
> > > patching file kernel/time/tick-common.c
> > > patching file kernel/time/tick-sched.c
> > > patching file kernel/timer.c
> > > patching file kernel/trace/Kconfig
> > > patching file kernel/trace/ftrace.c
> > > patching file kernel/trace/trace.c
> > > patching file kernel/trace/trace_clock.c
> > > patching file kernel/trace/trace_functions.c
> > > patching file kernel/trace/trace_functions_graph.c
> > > patching file lib/Kconfig.debug
> > > patching file lib/atomic64.c
> > > patching file lib/bust_spinlocks.c
> > > patching file lib/ioremap.c
> > > patching file lib/smp_processor_id.c
> > > patching file mm/Kconfig
> > > patching file mm/memory.c
> > > patching file mm/mlock.c
> > > patching file mm/mmap.c
> > > patching file mm/mmu_context.c
> > > patching file mm/mprotect.c
> > > patching file mm/vmalloc.c
> > >
> > > Next step: move to /usr/src/kernel/
> > > mv: inter-device move failed:
> > > `./usr/src/kernels/linux-3.8.13-xenomai-2.6.4/' to
> > > `/usr/src/kernels/linux-3.8.13-xenomai-2.6.4'; unable to remove
> > > target: Directory not empty total 39916 drwxrwxr-x  31 root root
> > > 4096 Jul 27 12:01 arch drwxrwxr-x   3 root root     4096 Jul 27
> > > 11:59 block -rw-rw-r--   1 root root    18693 May 11  2013 COPYING
> > > -rw-rw-r--   1 root root    95054 May 11  2013 CREDITS drwxrwxr-x
> > > 4 root root    20480 Jul 27 12:01 crypto drwxrwxr-x  99 root root
> > > 12288 Jul 27 12:01 Documentation drwxrwxr-x 109 root root     4096
> > > Jul 27 12:01 drivers -rw-r--r--   1 root root        0 Jul 27
> > > 12:00 extra_certificates drwxrwxr-x  36 root root     4096 Jul 27
> > > 12:01 firmware drwxrwxr-x  72 root root    12288 Jul 27 12:01 fs
> > > drwxrwxr-x  29 root root     4096 Jul 27 11:59 include
> > > drwxrwxr-x   2 root root     4096 Jul 27 12:01 init
> > > drwxrwxr-x   2 root root     4096 Jul 27 11:59 ipc
> > > -rw-rw-r--   1 root root     2536 May 11  2013 Kbuild
> > > -rw-rw-r--   1 root root      252 May 11  2013 Kconfig
> > > drwxrwxr-x  12 root root    12288 Jul 27 12:00 kernel
> > > drwxrwxr-x   9 root root    20480 Jul 27 12:01 lib
> > > -rw-rw-r--   1 root root   239609 May 11  2013 MAINTAINERS
> > > -rwxr--r--   1 root root    48040 Jul 27 11:59 Makefile
> > > drwxrwxr-x   2 root root    12288 Jul 27 11:59 mm
> > > -rw-r--r--   1 root root     5849 Jul 27 11:59 modules.builtin
> > > -rw-r--r--   1 root root    56319 Jul 27 12:01 modules.order
> > > -rw-r--r--   1 root root   710577 Jul 27 12:01 Module.symvers
> > > drwxrwxr-x  55 root root     4096 Jul 27 12:00 net
> > > -rw-rw-r--   1 root root    18736 May 11  2013 README
> > > -rw-rw-r--   1 root root     3371 May 11  2013 REPORTING-BUGS
> > > drwxrwxr-x  13 root root     4096 May 11  2013 samples
> > > drwxrwxr-x  13 root root     4096 Jul 27 12:01 scripts
> > > drwxrwxr-x   9 root root     4096 Jul 27 11:59 security
> > > -rw-r--r--   1 root root     3272 Jul 27 12:00 signing_key.priv
> > > -rw-r--r--   1 root root     1446 Jul 27 12:00 signing_key.x509
> > > drwxrwxr-x  22 root root     4096 Jul 27 12:01 sound
> > > -rw-r--r--   1 root root  2617524 Jul 27 12:01 System.map
> > > drwxrwxr-x  15 root root     4096 May 11  2013 tools
> > > drwxrwxr-x   3 root root     4096 Jul 27 12:01 usr
> > > drwxrwxr-x   3 root root     4096 May 11  2013 virt
> > > -rwxr-xr-x   1 root root 17905357 Jul 27 12:01 vmlinux
> > > -rw-r--r--   1 root root 23146092 Jul 27 12:01 vmlinux.o
> > > -rw-r--r--   1 root root      372 Jul 27 12:00 x509.genkey
> > >
> > > Next step: Build and install the kernel with xenomai-2.6.4.
> > >
> > >   CLEAN   .
> > >   CLEAN   arch/x86/kernel/cpu
> > >   CLEAN   arch/x86/kernel
> > >   CLEAN   arch/x86/realmode/rm
> > >   CLEAN   arch/x86/vdso
> > >   CLEAN   arch/x86/lib
> > >   CLEAN   crypto/asymmetric_keys
> > >   CLEAN   drivers/gpu/drm/radeon
> > >   CLEAN   drivers/scsi/aic7xxx
> > >   CLEAN   drivers/tty/vt
> > >   CLEAN   drivers/video/logo
> > >   CLEAN   firmware
> > >   CLEAN   kernel
> > >   CLEAN   lib/raid6
> > >   CLEAN   lib
> > >   CLEAN   security/selinux
> > >   CLEAN   usr
> > >   CLEAN   Documentation/accounting
> > >   CLEAN   Documentation/auxdisplay
> > >   CLEAN   Documentation/connector
> > >   CLEAN   Documentation/filesystems
> > >   CLEAN   Documentation/ia64
> > >   CLEAN   Documentation/laptops
> > >   CLEAN   Documentation/misc-devices/mei
> > >   CLEAN   Documentation/networking/timestamping
> > >   CLEAN   Documentation/networking
> > >   CLEAN   Documentation/pcmcia
> > >   CLEAN   Documentation/spi
> > >   CLEAN   Documentation/timers
> > >   CLEAN   Documentation/watchdog/src
> > >   CLEAN   arch/x86/boot/compressed
> > >   CLEAN   arch/x86/boot
> > >   CLEAN   arch/x86/tools
> > >   CLEAN   .tmp_versions
> > > make[1]: Nothing to be done for `all'.
> > >   HOSTCC  scripts/basic/fixdep
> > >   CHK     include/generated/uapi/linux/version.h
> > >   CHK     include/generated/utsrelease.h
> > >   HOSTCC  arch/x86/tools/relocs
> > >   HOSTCC  scripts/kallsyms
> > >   HOSTCC  scripts/pnmtologo
> > >   HOSTCC  scripts/conmakehash
> > >   HOSTCC  scripts/recordmcount
> > >   HOSTCC  scripts/sortextable
> > >   HOSTCC  scripts/asn1_compiler
> > >   HOSTCC  scripts/mod/mk_elfconfig
> > >   CC      scripts/mod/empty.o
> > >   HOSTCC  scripts/genksyms/genksyms.o
> > >   HOSTCC  scripts/genksyms/lex.lex.o
> > >   HOSTCC  scripts/genksyms/parse.tab.o
> > >   HOSTCC  scripts/selinux/genheaders/genheaders
> > >   HOSTCC  scripts/selinux/mdp/mdp
> > >   MKELF   scripts/mod/elfconfig.h
> > >   HOSTCC  scripts/mod/file2alias.o
> > >   HOSTCC  scripts/mod/modpost.o
> > >   HOSTCC  scripts/mod/sumversion.o
> > >   CC      kernel/bounds.s
> > >   GEN     include/generated/bounds.h
> > >   CC      arch/x86/kernel/asm-offsets.s
> > >   HOSTLD  scripts/genksyms/genksyms
> > >   GEN     include/generated/asm-offsets.h
> > >   CALL    scripts/checksyscalls.sh
> > >   HOSTLD  scripts/mod/modpost
> > >   CHK     include/generated/compile.h
> > >   CC      init/main.o
> > >   CC      init/do_mounts.o
> > >   CC      init/do_mounts_rd.o
> > >   CC      init/do_mounts_initrd.o
> > >   CC      init/do_mounts_md.o
> > >   CC      init/initramfs.o
> > >   CC      init/calibrate.o
> > >   CC      init/init_task.o
> > >   CC      init/version.o
> > >   HOSTCC  usr/gen_init_cpio
> > >   AS      arch/x86/ia32/ia32entry.o
> > >   LD      arch/x86/crypto/built-in.o
> > >   CC      arch/x86/kernel/process_64.o
> > >   LD      arch/x86/net/built-in.o
> > >   CC      arch/x86/kernel/signal.o
> > >   AS      arch/x86/kernel/entry_64.o
> > >   CC      arch/x86/ia32/sys_ia32.o
> > >   LD      arch/x86/kvm/built-in.o
> > >   CC      arch/x86/realmode/init.o
> > >   CC [M]  arch/x86/kvm/svm.o
> > >   CC [M]  arch/x86/crypto/ablk_helper.o
> > >   LD      arch/x86/platform/ce4100/built-in.o
> > >   AS [M]  arch/x86/crypto/aes-x86_64-asm_64.o
> > >   CC      arch/x86/mm/init.o
> > >   CC      arch/x86/platform/efi/efi.o
> > >   CC      arch/x86/vdso/vma.o
> > >   CC      kernel/fork.o
> > >   LDS     arch/x86/vdso/vdso.lds
> > >   CC      arch/x86/platform/efi/efi_64.o
> > >   AS      arch/x86/platform/efi/efi_stub_64.o
> > >   CC      arch/x86/ia32/ia32_signal.o
> > >   CC      arch/x86/ia32/nosyscall.o
> > >   AS      arch/x86/vdso/vdso-note.o
> > >   AS      arch/x86/realmode/rm/header.o
> > >   AS      arch/x86/realmode/rm/trampoline_64.o
> > >   AS      arch/x86/realmode/rm/stack.o
> > >   LD      arch/x86/platform/geode/built-in.o
> > >   CC [M]  arch/x86/kvm/vmx.o
> > >   CC      arch/x86/vdso/vclock_gettime.o
> > >   AS      arch/x86/realmode/rm/reboot.o
> > >   GEN     usr/initramfs_data.cpio
> > >   AS      arch/x86/realmode/rm/wakeup_asm.o
> > >   AS      usr/initramfs_data.o
> > >   CC [M]  arch/x86/kvm/../../../virt/kvm/kvm_main.o
> > >   CC      arch/x86/realmode/rm/wakemain.o
> > >   LD      usr/built-in.o
> > >   CC [M]  arch/x86/kvm/../../../virt/kvm/ioapic.o
> > >   CC      mm/filemap.o
> > >   CC [M]  arch/x86/kvm/../../../virt/kvm/coalesced_mmio.o
> > >   CC      mm/mempool.o
> > >   CC      fs/open.o
> > >   CC      fs/read_write.o
> > >   CC      arch/x86/realmode/rm/video-mode.o
> > >   AS      arch/x86/realmode/rm/copy.o
> > >   CC      kernel/exec_domain.o
> > >   CC      kernel/panic.o
> > >   CC      kernel/printk.o
> > >   CC      arch/x86/mm/init_64.o
> > >   CC      arch/x86/mm/fault.o
> > >   AS      arch/x86/realmode/rm/bioscall.o
> > >   CC      arch/x86/realmode/rm/regs.o
> > >   CC      arch/x86/realmode/rm/video-vga.o
> > >   CC      arch/x86/vdso/vgetcpu.o
> > >   CC [M]  arch/x86/crypto/aes_glue.o
> > >   LDS     arch/x86/vdso/vdso32/vdso32.lds
> > >   CC      arch/x86/ia32/syscall_ia32.o
> > >   AS [M]  arch/x86/crypto/aesni-intel_asm.o
> > >   CC      arch/x86/ia32/ipc32.o
> > >   LD      init/mounts.o
> > >   LD      init/built-in.o
> > >   CC      arch/x86/realmode/rm/video-vesa.o
> > >   CC      arch/x86/realmode/rm/video-bios.o
> > >   CC [M]  arch/x86/kvm/../../../virt/kvm/irq_comm.o
> > >   AS      arch/x86/vdso/vdso32/note.o
> > >   AS      arch/x86/vdso/vdso32/int80.o
> > >   CC      arch/x86/kernel/traps.o
> > >   AS      arch/x86/vdso/vdso32/syscall.o
> > >   LD      arch/x86/platform/efi/built-in.o
> > >   CC      arch/x86/kernel/irq.o
> > >   CC      arch/x86/kernel/irq_64.o
> > >   PASYMS  arch/x86/realmode/rm/pasyms.h
> > >   CC      arch/x86/kernel/dumpstack_64.o
> > >   AS      arch/x86/vdso/vdso32/sysenter.o
> > >   LDS     arch/x86/realmode/rm/realmode.lds
> > >   LD      arch/x86/platform/iris/built-in.o
> > >   LD      arch/x86/realmode/rm/realmode.elf
> > >   LD      arch/x86/platform/mrst/built-in.o
> > >   CC      arch/x86/vdso/vdso32-setup.o
> > >   RELOCS  arch/x86/realmode/rm/realmode.relocs
> > >   CC [M]  arch/x86/crypto/aesni-intel_glue.o
> > >   OBJCOPY arch/x86/realmode/rm/realmode.bin
> > >   LD      arch/x86/platform/olpc/built-in.o
> > >   AS      arch/x86/realmode/rmpiggy.o
> > >   LD      arch/x86/platform/scx200/built-in.o
> > >   LD      arch/x86/realmode/built-in.o
> > >   CC [M]  arch/x86/kvm/../../../virt/kvm/eventfd.o
> > >   CC      arch/x86/platform/sfi/sfi.o
> > >   LD      arch/x86/platform/uv/built-in.o
> > >   CC      arch/x86/kernel/time.o
> > >   CC [M]  arch/x86/kvm/../../../virt/kvm/assigned-dev.o
> > >   LD      arch/x86/platform/visws/built-in.o
> > >   CC [M]  arch/x86/kvm/../../../virt/kvm/iommu.o
> > >   CC      arch/x86/ia32/audit.o
> > >   LD      arch/x86/ia32/built-in.o
> > >   CC [M]  arch/x86/kvm/../../../virt/kvm/async_pf.o
> > >   CC [M]  arch/x86/crypto/fpu.o
> > >   CC [M]  arch/x86/crypto/crc32c-intel_glue.o
> > >   AS [M]  arch/x86/crypto/crc32c-pcl-intel-asm_64.o
> > >   CC [M]  arch/x86/kvm/x86.o
> > >   CC [M]  arch/x86/kvm/mmu.o
> > >   CC      arch/x86/mm/ioremap.o
> > >   VDSO    arch/x86/vdso/vdso.so.dbg
> > >   CC [M]  arch/x86/kvm/emulate.o
> > >   CC      arch/x86/mm/extable.o
> > >   CC      mm/oom_kill.o
> > >   LD      arch/x86/platform/sfi/built-in.o
> > >   LD      arch/x86/platform/built-in.o
> > >   CC [M]  arch/x86/kvm/i8259.o
> > >   CC      ipc/compat.o
> > >   CC [M]  arch/x86/kvm/irq.o
> > >   VDSO    arch/x86/vdso/vdso32-int80.so.dbg
> > >   CC      fs/file_table.o
> > >   CC      fs/super.o
> > >   CC      ipc/util.o
> > >   CC      fs/char_dev.o
> > >   CC      ipc/msgutil.o
> > >   VDSO    arch/x86/vdso/vdso32-syscall.so.dbg
> > >   CC      ipc/msg.o
> > >   CC      fs/stat.o
> > >   CC      arch/x86/kernel/ioport.o
> > >   AS [M]  arch/x86/crypto/ghash-clmulni-intel_asm.o
> > >   VDSO    arch/x86/vdso/vdso32-sysenter.so.dbg
> > >   CC [M]  arch/x86/crypto/ghash-clmulni-intel_glue.o
> > >   VDSOSYM arch/x86/vdso/vdso-syms.lds
> > >   CC [M]  arch/x86/kvm/lapic.o
> > >   VDSOSYM arch/x86/vdso/vdso32-int80-syms.lds
> > >   VDSOSYM arch/x86/vdso/vdso32-syscall-syms.lds
> > >   VDSOSYM arch/x86/vdso/vdso32-sysenter-syms.lds
> > >   OBJCOPY arch/x86/vdso/vdso.so
> > >   OBJCOPY arch/x86/vdso/vdso32-int80.so
> > >   OBJCOPY arch/x86/vdso/vdso32-syscall.so
> > >   OBJCOPY arch/x86/vdso/vdso32-sysenter.so
> > >   VDSOSYM arch/x86/vdso/vdso32-syms.lds
> > >   AS      arch/x86/vdso/vdso.o
> > >   AS      arch/x86/vdso/vdso32.o
> > >   CC      kernel/cpu.o
> > >   LD      arch/x86/vdso/built-in.o
> > >   CC [M]  arch/x86/kvm/i8254.o
> > >   CC [M]  arch/x86/kvm/cpuid.o
> > >   CC      kernel/exit.o
> > >   CC      ipc/sem.o
> > >   CC      kernel/itimer.o
> > >   CC      arch/x86/mm/pageattr.o
> > >   CC      arch/x86/mm/mmap.o
> > >   TIMEC   kernel/timeconst.h
> > >   CC      arch/x86/kernel/ldt.o
> > >   CC      kernel/softirq.o
> > >   CC      mm/fadvise.o
> > >   CC      mm/maccess.o
> > >   CC      arch/x86/kernel/dumpstack.o
> > >   CC      kernel/resource.o
> > > arch/x86/kvm/mmu.c: In function =E2=80=98kvm_test_age_rmapp=E2=80=99:
> > > arch/x86/kvm/mmu.c:1386: warning: =E2=80=98iter.desc=E2=80=99 may be =
used
> > > uninitialized in this function AS [M]
> > > arch/x86/crypto/salsa20-x86_64-asm_64.o CC [M]
> > > arch/x86/crypto/salsa20_glue.o AS [M]
> > > arch/x86/crypto/twofish-x86_64-asm_64.o CC
> > > arch/x86/kernel/nmi.o CC      ipc/shm.o
> > >   CC      mm/page_alloc.o
> > >   CC      mm/page-writeback.o
> > >   CC      arch/x86/kernel/setup.o
> > >   CC      ipc/ipcns_notifier.o
> > >   CC      ipc/syscall.o
> > >   CC      fs/exec.o
> > >   CC      arch/x86/kernel/x86_init.o
> > >   CC      arch/x86/kernel/i8259.o
> > >   CC      arch/x86/kernel/irqinit.o
> > >   CC [M]  arch/x86/crypto/twofish_glue.o
> > >   CC      arch/x86/kernel/jump_label.o
> > >   CC      arch/x86/kernel/irq_work.o
> > >   CC      ipc/ipc_sysctl.o
> > >   CC      arch/x86/kernel/probe_roms.o
> > >   CC      arch/x86/kernel/sys_x86_64.o
> > >   CC      fs/pipe.o
> > >   CC      fs/namei.o
> > >   CC      mm/readahead.o
> > >   CC      mm/swap.o
> > >   CC [M]  arch/x86/kvm/pmu.o
> > >   CC      arch/x86/mm/pat.o
> > >   LD [M]  arch/x86/crypto/aes-x86_64.o
> > >   LD [M]  arch/x86/crypto/twofish-x86_64.o
> > >   LD [M]  arch/x86/crypto/salsa20-x86_64.o
> > >   LD [M]  arch/x86/crypto/aesni-intel.o
> > >   CC      ipc/mqueue.o
> > >   CC      arch/x86/kernel/x8664_ksyms_64.o
> > >   LD [M]  arch/x86/crypto/ghash-clmulni-intel.o
> > >   LD [M]  arch/x86/crypto/crc32c-intel.o
> > >   CC      arch/x86/kernel/syscall_64.o
> > >   CC      kernel/sysctl.o
> > >   CC      arch/x86/mm/pgtable.o
> > >   CC      kernel/sysctl_binary.o
> > >   CC      arch/x86/mm/physaddr.o
> > >   CC      arch/x86/mm/gup.o
> > >   CC      arch/x86/mm/setup_nx.o
> > >   CC      arch/x86/mm/pat_rbtree.o
> > >   CC      arch/x86/mm/tlb.o
> > >   CC      mm/truncate.o
> > >   CC      mm/vmscan.o
> > >   CC      mm/shmem.o
> > >   CC      mm/util.o
> > >   CC      arch/x86/kernel/vsyscall_64.o
> > >   AS      arch/x86/kernel/vsyscall_emu_64.o
> > >   CC      mm/mmzone.o
> > >   CC      fs/fcntl.o
> > >   CC      mm/vmstat.o
> > >   CC      kernel/capability.o
> > >   CC      mm/backing-dev.o
> > >   CC      security/integrity/iint.o
> > >   CC      crypto/api.o
> > >   CC      crypto/cipher.o
> > >   CC      crypto/compress.o
> > >   CC      crypto/algapi.o
> > >   CC      ipc/compat_mq.o
> > >   CC      arch/x86/mm/hugetlbpage.o
> > >   CC      security/integrity/ima/ima_fs.o
> > >   CC      security/integrity/ima/ima_queue.o
> > >   CC      security/integrity/ima/ima_init.o
> > >   CC      arch/x86/kernel/bootflag.o
> > >   LD      security/integrity/integrity.o
> > >   CC      arch/x86/mm/numa.o
> > >   CC      arch/x86/mm/numa_64.o
> > >   CC      arch/x86/kernel/e820.o
> > >   CC      arch/x86/kernel/pci-dma.o
> > >   CC      arch/x86/kernel/quirks.o
> > >   CC      arch/x86/kernel/topology.o
> > >   CC      arch/x86/mm/amdtopology.o
> > >   CC      ipc/namespace.o
> > >   CC      ipc/mq_sysctl.o
> > >   CC      arch/x86/kernel/kdebugfs.o
> > >   CC      mm/mm_init.o
> > >   CC      mm/mmu_context.o
> > >   CC      security/integrity/ima/ima_main.o
> > >   CC      kernel/ptrace.o
> > >   CC      security/integrity/ima/ima_crypto.o
> > >   CC      security/integrity/ima/ima_api.o
> > >   CC      security/integrity/ima/ima_policy.o
> > >   CC      kernel/timer.o
> > >   CC      kernel/user.o
> > >   CC      security/integrity/ima/ima_audit.o
> > >   LD      ipc/built-in.o
> > >   CC      kernel/signal.o
> > >   CC      kernel/sys.o
> > >   CC      kernel/kmod.o
> > >   CC      kernel/workqueue.o
> > >   CC      block/elevator.o
> > >   CC      block/blk-core.o
> > >   CC      block/blk-tag.o
> > >   CC      block/blk-sysfs.o
> > >   CC      block/blk-flush.o
> > >   CC      block/blk-settings.o
> > >   CC      drivers/acpi/tables.o
> > >   CC      arch/x86/mm/srat.o
> > >   LD      sound/built-in.o
> > >   CC      fs/ioctl.o
> > >   CC [M]  sound/sound_core.o
> > >   CC      crypto/scatterwalk.o
> > >   LD      security/integrity/ima/ima.o
> > >   CC      crypto/proc.o
> > >   LD      security/integrity/ima/built-in.o
> > >   LD      security/integrity/built-in.o
> > >   CC      crypto/ablkcipher.o
> > >   CC      security/keys/gc.o
> > >   CC      security/keys/key.o
> > >   CC      security/keys/keyring.o
> > >   CC      arch/x86/kernel/alternative.o
> > >   LD      arch/x86/mm/built-in.o
> > >   CC      arch/x86/kernel/i8253.o
> > >   CC      security/keys/keyctl.o
> > >   CC      drivers/acpi/blacklist.o
> > >   CC      drivers/acpi/osl.o
> > >   CC      arch/x86/kernel/pci-nommu.o
> > >   CC      arch/x86/kernel/hw_breakpoint.o
> > >   CC      security/keys/permission.o
> > >   CC      mm/percpu.o
> > >   CC [M]  sound/ac97_bus.o
> > >   LD [M]  arch/x86/kvm/kvm.o
> > >   LD [M]  arch/x86/kvm/kvm-intel.o
> > >   LD [M]  arch/x86/kvm/kvm-amd.o
> > >   CC      drivers/acpi/utils.o
> > >   CC      kernel/pid.o
> > >   CC      kernel/task_work.o
> > >   CC      kernel/rcupdate.o
> > >   LD      drivers/amba/built-in.o
> > >   CC      kernel/extable.o
> > >   CC      block/blk-ioc.o
> > >   CC      block/blk-map.o
> > >   CC      kernel/params.o
> > >   CC      kernel/posix-timers.o
> > >   LD      sound/arm/built-in.o
> > >   CC      block/blk-exec.o
> > >   CC      block/blk-merge.o
> > >   CC      fs/readdir.o
> > >   CC      fs/select.o
> > >   CC      block/blk-softirq.o
> > >   CC      drivers/acpi/reboot.o
> > >   CC      drivers/acpi/nvs.o
> > >   CC      crypto/blkcipher.o
> > >   CC      drivers/acpi/wakeup.o
> > >   CC      security/keys/process_keys.o
> > >   LD      sound/atmel/built-in.o
> > >   CC      security/keys/request_key.o
> > >   LD      sound/core/oss/built-in.o
> > >   CC      arch/x86/kernel/tsc.o
> > >   CC [M]  sound/core/oss/mixer_oss.o
> > >   CC [M]  sound/core/oss/pcm_oss.o
> > >   CC      security/keys/request_key_auth.o
> > >   CC      security/keys/user_defined.o
> > >   CC      security/keys/compat.o
> > >   CC      drivers/acpi/sleep.o
> > >   CC      security/keys/proc.o
> > >   CC      arch/x86/kernel/io_delay.o
> > >   CC      arch/x86/kernel/rtc.o
> > >   LD      sound/core/seq/built-in.o
> > >   CC [M]  sound/core/seq/seq_device.o
> > >   CC [M]  sound/core/seq/seq_dummy.o
> > >   CC [M]  sound/core/seq/seq_midi_emul.o
> > >   CC      kernel/kthread.o
> > >   CC      kernel/wait.o
> > >   CC      kernel/kfifo.o
> > >   CC      kernel/sys_ni.o
> > >   CC      kernel/posix-cpu-timers.o
> > >   CC      mm/slab_common.o
> > >   CC [M]  sound/core/oss/pcm_plugin.o
> > >   CC      mm/compaction.o
> > >   CC      mm/balloon_compaction.o
> > >   CC      mm/interval_tree.o
> > >   CC      block/blk-timeout.o
> > >   CC      block/blk-iopoll.o
> > >   CC      block/blk-lib.o
> > >   CC      security/keys/sysctl.o
> > >   CC      fs/fifo.o
> > >   CC      crypto/ahash.o
> > >   CC      fs/dcache.o
> > >   CC      fs/inode.o
> > >   LD      security/keys/built-in.o
> > >   CC      arch/x86/kernel/pci-iommu_table.o
> > >   GEN     security/selinux/flask.h
> > > security/selinux/av_permissions.h CC      drivers/acpi/device_pm.o
> > >   CC      security/selinux/avc.o
> > >   CC      drivers/acpi/proc.o
> > >   CC      drivers/acpi/bus.o
> > >   CC      security/selinux/hooks.o
> > >   CC      crypto/shash.o
> > >   CC      security/selinux/selinuxfs.o
> > >   CC [M]  sound/core/seq/seq_midi_event.o
> > >   CC      security/selinux/netlink.o
> > >   CC      kernel/mutex.o
> > >   CC [M]  sound/core/hrtimer.o
> > >   CC [M]  sound/core/hwdep.o
> > >   CC [M]  sound/core/memalloc.o
> > >   CC      security/selinux/nlmsgtab.o
> > >   CC      arch/x86/kernel/resource.o
> > >   CC      arch/x86/kernel/process.o
> > >   CC      arch/x86/kernel/i387.o
> > >   CC      security/selinux/netif.o
> > >   CC      security/selinux/netnode.o
> > >   CC      block/ioctl.o
> > >   CC      security/selinux/netport.o
> > >   CC      arch/x86/kernel/xsave.o
> > >   CC      mm/fremap.o
> > >   CC      mm/highmem.o
> > >   CC [M]  sound/core/oss/io.o
> > >   CC [M]  sound/core/oss/copy.o
> > >   CC      kernel/hrtimer.o
> > >   CC      kernel/rwsem.o
> > >   CC [M]  sound/core/seq/seq_midi.o
> > >   CC [M]  sound/core/seq/seq_virmidi.o
> > >   CC [M]  sound/core/seq/seq.o
> > >   CC [M]  sound/core/seq/seq_lock.o
> > >   CC [M]  sound/core/seq/seq_clientmgr.o
> > >   CC      drivers/acpi/glue.o
> > >   CC      drivers/acpi/scan.o
> > >   CC [M]  sound/core/seq/seq_memory.o
> > >   CC [M]  sound/core/seq/seq_queue.o
> > >   CC [M]  sound/core/oss/linear.o
> > >   CC [M]  sound/core/seq/seq_fifo.o
> > >   CC [M]  sound/core/seq/seq_prioq.o
> > >   CC      crypto/algboss.o
> > >   CC [M]  sound/core/seq/seq_timer.o
> > >   CC [M]  sound/core/seq/seq_system.o
> > >   CC      security/selinux/exports.o
> > >   CC      mm/madvise.o
> > >   CC      security/selinux/ss/ebitmap.o
> > >   CC      block/genhd.o
> > >   CC      block/scsi_ioctl.o
> > >   CC      block/partition-generic.o
> > >   CC      block/partitions/check.o
> > >   CC      block/partitions/amiga.o
> > >   CC      block/partitions/mac.o
> > >   CC      block/bsg.o
> > >   CC      block/partitions/msdos.o
> > >   CC      arch/x86/kernel/ptrace.o
> > >   CC      arch/x86/kernel/tls.o
> > >   CC      block/partitions/osf.o
> > >   CC [M]  sound/core/oss/mulaw.o
> > >   CC      block/partitions/sgi.o
> > >   CC      fs/attr.o
> > >   CC      fs/bad_inode.o
> > >   CC      fs/file.o
> > >   CC      fs/filesystems.o
> > >   CC      mm/memory.o
> > >   CC      mm/mincore.o
> > >   CC      crypto/testmgr.o
> > >   CC      crypto/crypto_wq.o
> > >   CC      crypto/aead.o
> > >   CC      crypto/chainiv.o
> > >   CC      security/commoncap.o
> > >   CC      drivers/acpi/resource.o
> > >   CC      security/min_addr.o
> > >   CC      kernel/nsproxy.o
> > >   CC      kernel/srcu.o
> > >   CC      security/security.o
> > >   CC [M]  sound/core/oss/route.o
> > >   CC      security/capability.o
> > >   LD      sound/drivers/built-in.o
> > >   CC [M]  sound/drivers/aloop.o
> > >   CC [M]  sound/drivers/dummy.o
> > >   CC      block/partitions/sun.o
> > >   CC      block/partitions/efi.o
> > >   CC      block/partitions/karma.o
> > >   CC      security/inode.o
> > >   CC [M]  sound/drivers/mtpav.o
> > >   CC [M]  sound/drivers/virmidi.o
> > >   CC      crypto/eseqiv.o
> > >   LD      crypto/crypto_hash.o
> > >   CC [M]  sound/core/oss/rate.o
> > >   CC [M]  sound/core/seq/seq_ports.o
> > >   CC      kernel/semaphore.o
> > >   CC [M]  sound/core/seq/seq_info.o
> > >   LD      sound/core/seq/oss/built-in.o
> > >   CC [M]  sound/core/seq/oss/seq_oss.o
> > >   CC      fs/namespace.o
> > >   CC      drivers/acpi/processor_core.o
> > >   CC      fs/seq_file.o
> > >   CC      fs/xattr.o
> > >   CC      arch/x86/kernel/step.o
> > >   CC      security/selinux/ss/hashtab.o
> > >   CC      security/selinux/ss/symtab.o
> > >   CC      security/selinux/ss/sidtab.o
> > >   CC      mm/mlock.o
> > >   CC      security/selinux/ss/avtab.o
> > >   CC      security/selinux/ss/policydb.o
> > >   CC      kernel/notifier.o
> > >   LD      block/partitions/built-in.o
> > >   CC      block/bsg-lib.o
> > >   CC      kernel/ksysfs.o
> > >   CC [M]  sound/core/seq/oss/seq_oss_init.o
> > >   CC      kernel/cred.o
> > >   CC      crypto/pcompress.o
> > >   LD      firmware/built-in.o
> > >   LD      crypto/cryptomgr.o
> > >   LD [M]  sound/core/oss/snd-mixer-oss.o
> > >   CC      kernel/async.o
> > >   CC      kernel/range.o
> > >   LD [M]  sound/core/oss/snd-pcm-oss.o
> > >   CC      kernel/groups.o
> > >   CC      drivers/ata/libata-core.o
> > >   CC      block/blk-cgroup.o
> > >   CC      arch/x86/kernel/i8237.o
> > >   LD      sound/drivers/mpu401/built-in.o
> > >   CC [M]  sound/drivers/mpu401/mpu401_uart.o
> > >   CC [M]  sound/drivers/mpu401/mpu401.o
> > >   CC      drivers/acpi/ec.o
> > >   LD [M]  sound/core/seq/snd-seq.o
> > >   CC [M]  sound/core/seq/oss/seq_oss_timer.o
> > >   CC      arch/x86/kernel/stacktrace.o
> > >   CC      arch/x86/kernel/acpi/boot.o
> > >   CC      arch/x86/kernel/acpi/sleep.o
> > >   AS      arch/x86/kernel/acpi/wakeup_64.o
> > >   CC [M]  sound/core/seq/oss/seq_oss_ioctl.o
> > >   CC [M]  sound/core/sgbuf.o
> > >   CC      arch/x86/kernel/apic/apic.o
> > >   CC      arch/x86/kernel/apic/apic_noop.o
> > >   CC      arch/x86/kernel/apic/ipi.o
> > >   CC      arch/x86/kernel/apic/hw_nmi.o
> > >   CC [M]  sound/core/pcm.o
> > >   CC [M]  sound/core/pcm_native.o
> > >   LD      sound/drivers/opl3/built-in.o
> > >   CC [M]  sound/drivers/opl3/opl3_lib.o
> > >   LD      sound/drivers/opl4/built-in.o
> > >   CC      crypto/hmac.o
> > >   LD      drivers/atm/built-in.o
> > >   CC [M]  drivers/atm/atmtcp.o
> > >   CC      arch/x86/kernel/reboot.o
> > >   LD [M]  sound/drivers/mpu401/snd-mpu401-uart.o
> > >   CC      mm/mmap.o
> > >   LD [M]  sound/drivers/mpu401/snd-mpu401.o
> > >   CC      arch/x86/kernel/cpu/intel_cacheinfo.o
> > >   CC      arch/x86/kernel/cpu/scattered.o
> > >   CC      arch/x86/kernel/cpu/topology.o
> > >   CC      drivers/ata/libata-scsi.o
> > >   CC [M]  sound/core/seq/oss/seq_oss_event.o
> > >   CC [M]  sound/core/seq/oss/seq_oss_rw.o
> > >   CC      drivers/ata/libata-eh.o
> > >   CC      drivers/ata/libata-transport.o
> > >   CC      block/blk-throttle.o
> > >   CC      kernel/lglock.o
> > >   CC      block/noop-iosched.o
> > >   CC      security/lsm_audit.o
> > >   CC [M]  sound/drivers/opl3/opl3_synth.o
> > >   CC      drivers/acpi/dock.o
> > >   CC      fs/libfs.o
> > >   CC      crypto/md5.o
> > >   CC      crypto/sha1_generic.o
> > >   CC [M]  sound/core/seq/oss/seq_oss_synth.o
> > >   LD      arch/x86/kernel/acpi/built-in.o
> > >   CC [M]  sound/core/seq/oss/seq_oss_midi.o
> > >   CC      crypto/sha256_generic.o
> > >   CC      kernel/smpboot.o
> > >   CC      kernel/events/core.o
> > >   CC      kernel/events/ring_buffer.o
> > >   CC      arch/x86/kernel/cpu/proc.o
> > >   CC      kernel/events/callchain.o
> > >   CC      kernel/events/hw_breakpoint.o
> > >   CC [M]  sound/drivers/opl3/opl3_seq.o
> > >   CC      security/selinux/ss/services.o
> > >   CC      fs/fs-writeback.o
> > >   CC      fs/pnode.o
> > >   MKCAP   arch/x86/kernel/cpu/capflags.c
> > >   CC      arch/x86/kernel/cpu/powerflags.o
> > >   CC      arch/x86/kernel/cpu/common.o
> > >   LD      sound/drivers/pcsp/built-in.o
> > >   CC [M]  sound/drivers/pcsp/pcsp.o
> > >   CC      block/deadline-iosched.o
> > >   CC [M]  sound/drivers/pcsp/pcsp_lib.o
> > >   CC [M]  sound/drivers/pcsp/pcsp_mixer.o
> > >   CC      arch/x86/kernel/apic/io_apic.o
> > >   CC      arch/x86/kernel/apic/apic_flat_64.o
> > >   CC [M]  sound/drivers/pcsp/pcsp_input.o
> > >   CC [M]  sound/core/seq/oss/seq_oss_readq.o
> > >   LD      drivers/auxdisplay/built-in.o
> > >   CC [M]  drivers/auxdisplay/ks0108.o
> > >   CC      drivers/acpi/pci_root.o
> > >   CC [M]  sound/drivers/opl3/opl3_midi.o
> > >   CC      crypto/aes_generic.o
> > >   CC [M]  sound/drivers/opl3/opl3_drums.o
> > >   CC      crypto/crc32c.o
> > >   CC [M]  sound/drivers/opl3/opl3_oss.o
> > >   CC [M]  sound/core/seq/oss/seq_oss_writeq.o
> > >   CC      mm/mprotect.o
> > >   LD      sound/firewire/built-in.o
> > >   LD [M]  sound/drivers/pcsp/snd-pcsp.o
> > >   CC      security/selinux/ss/conditional.o
> > >   LD      sound/i2c/built-in.o
> > >   CC      security/selinux/ss/mls.o
> > >   CC [M]  sound/i2c/cs8427.o
> > >   CC      security/selinux/ss/status.o
> > >   CC      block/cfq-iosched.o
> > >   CC [M]  drivers/auxdisplay/cfag12864b.o
> > >   CC      block/compat_ioctl.o
> > >   CC      arch/x86/kernel/cpu/vmware.o
> > >   CC      arch/x86/kernel/cpu/hypervisor.o
> > >   LD [M]  sound/core/seq/oss/snd-seq-oss.o
> > >   LD [M]  sound/core/seq/snd-seq-device.o
> > >   LD [M]  sound/core/seq/snd-seq-midi-event.o
> > >   CC      arch/x86/kernel/cpu/mshyperv.o
> > >   LD [M]  sound/core/seq/snd-seq-dummy.o
> > >   CC      arch/x86/kernel/cpu/rdrand.o
> > >   LD [M]  sound/core/seq/snd-seq-virmidi.o
> > >   LD [M]  sound/core/seq/snd-seq-midi.o
> > >   CC      block/blk-integrity.o
> > >   LD [M]  sound/core/seq/snd-seq-midi-emul.o
> > >   CC [M]  sound/core/pcm_lib.o
> > >   LD [M]  sound/drivers/opl3/snd-opl3-lib.o
> > >   LD [M]  sound/drivers/opl3/snd-opl3-synth.o
> > >   LD      sound/drivers/vx/built-in.o
> > >   CC [M]  sound/drivers/vx/vx_core.o
> > >   CC [M]  sound/drivers/vx/vx_hwdep.o
> > >   CC      drivers/ata/libata-sff.o
> > >   CC [M]  sound/drivers/vx/vx_pcm.o
> > >   CC [M]  sound/drivers/vx/vx_mixer.o
> > >   CC      drivers/ata/libata-pmp.o
> > >   CC      drivers/ata/libata-acpi.o
> > >   CC      drivers/acpi/pci_link.o
> > >   CC      mm/mremap.o
> > >   CC [M]  drivers/auxdisplay/cfag12864bfb.o
> > >   CC      arch/x86/kernel/cpu/match.o
> > >   CC      arch/x86/kernel/cpu/bugs_64.o
> > >   CC      arch/x86/kernel/apic/probe_64.o
> > >   CC      crypto/rng.o
> > >   CC      drivers/base/core.o
> > >   CC [M]  sound/i2c/i2c.o
> > >   CC      security/selinux/xfrm.o
> > >   CC      security/selinux/netlabel.o
> > >   LD      drivers/bcma/built-in.o
> > >   CC [M]  drivers/bcma/main.o
> > >   CC      arch/x86/kernel/cpu/intel.o
> > >   CC      arch/x86/kernel/cpu/amd.o
> > >   CC      arch/x86/kernel/cpu/centaur.o
> > >   CC [M]  drivers/ata/ahci.o
> > >   CC [M]  drivers/ata/libahci.o
> > >   CC      fs/drop_caches.o
> > >   CC [M]  drivers/ata/sata_inic162x.o
> > >   CC      drivers/acpi/pci_irq.o
> > >   CC      mm/msync.o
> > >   CC      mm/rmap.o
> > >   CC [M]  sound/drivers/vx/vx_cmd.o
> > >   LD      arch/x86/kernel/apic/built-in.o
> > >   CC [M]  sound/drivers/vx/vx_uer.o
> > >   CC      crypto/krng.o
> > >   LD      sound/i2c/other/built-in.o
> > >   CC [M]  sound/i2c/other/ak4113.o
> > >   CC [M]  sound/i2c/other/ak4114.o
> > >   CC [M]  sound/i2c/other/ak4xxx-adda.o
> > >   CC [M]  sound/i2c/other/pt2258.o
> > >   CC      fs/splice.o
> > >   CC      fs/sync.o
> > >   CC      fs/utimes.o
> > >   CC      drivers/block/brd.o
> > >   LD      security/selinux/selinux.o
> > >   LD      drivers/block/aoe/built-in.o
> > >   CC      arch/x86/kernel/cpu/perf_event.o
> > >   LD      security/selinux/built-in.o
> > >   CC [M]  drivers/block/aoe/aoeblk.o
> > >   CC      security/device_cgroup.o
> > >   CC [M]  drivers/bcma/scan.o
> > >   CC [M]  drivers/bcma/core.o
> > >   CC      crypto/asymmetric_keys/asymmetric_type.o
> > >   CC      drivers/acpi/pci_bind.o
> > >   LD [M]  sound/drivers/vx/snd-vx-lib.o
> > >   LD [M]  sound/drivers/snd-dummy.o
> > >   LD [M]  sound/drivers/snd-aloop.o
> > >   LD [M]  sound/drivers/snd-virmidi.o
> > >   LD [M]  sound/drivers/snd-mtpav.o
> > >   CC [M]  sound/core/pcm_timer.o
> > >   CC [M]  sound/core/pcm_misc.o
> > >   CC      drivers/acpi/acpi_platform.o
> > >   LD      block/built-in.o
> > >   CC      drivers/acpi/power.o
> > >   CC      drivers/acpi/event.o
> > >   CC      drivers/acpi/sysfs.o
> > >   CC      crypto/asymmetric_keys/signature.o
> > >   ASN.1   crypto/asymmetric_keys/x509-asn1.c
> > > Extracted 200 tokens
> > > Extracted 14 types
> > > Extracted 11 actions
> > > Pass 1
> > > Pass 2
> > >   CC      arch/x86/kernel/msr.o
> > >   CC [M]  drivers/ata/sata_sil24.o
> > >   CC      drivers/acpi/debugfs.o
> > >   LD      drivers/bluetooth/built-in.o
> > >   CC [M]  drivers/bluetooth/hci_vhci.o
> > >   LD      kernel/events/built-in.o
> > >   CC [M]  drivers/bluetooth/btmrvl_main.o
> > >   CC      drivers/base/bus.o
> > >   LD      security/built-in.o
> > >   CC [M]  drivers/bcma/sprom.o
> > >   CC      kernel/ipipe/core.o
> > >   LD [M]  sound/i2c/other/snd-ak4xxx-adda.o
> > >   LD [M]  sound/i2c/other/snd-ak4114.o
> > >   LD [M]  sound/i2c/other/snd-ak4113.o
> > >   LD [M]  sound/i2c/other/snd-pt2258.o
> > >   LD      drivers/bus/built-in.o
> > >   CC      drivers/block/loop.o
> > >   LD      drivers/cdrom/built-in.o
> > >   LD [M]  sound/i2c/snd-cs8427.o
> > >   CC [M]  drivers/cdrom/cdrom.o
> > >   LD [M]  sound/i2c/snd-i2c.o
> > >   CC [M]  drivers/ata/pdc_adma.o
> > >   CC [M]  drivers/block/floppy.o
> > >   CC      drivers/base/dd.o
> > >   CC      mm/vmalloc.o
> > >   CC [M]  drivers/block/aoe/aoechr.o
> > >   CC [M]  drivers/block/aoe/aoecmd.o
> > >   ASN.1   crypto/asymmetric_keys/x509_rsakey-asn1.c
> > > Extracted 16 tokens
> > > Extracted 1 types
> > > Extracted 1 actions
> > > Pass 1
> > > Pass 2
> > >   CC      crypto/asymmetric_keys/x509_public_key.o
> > >   CC [M]  sound/core/pcm_memory.o
> > >   CC [M]  sound/core/rawmidi.o
> > >   CC [M]  sound/core/timer.o
> > >   CC [M]  drivers/block/aoe/aoedev.o
> > >   CC      kernel/ipipe/timer.o
> > >   CC [M]  drivers/block/aoe/aoemain.o
> > >   CC [M]  drivers/bcma/driver_chipcommon.o
> > >   CC      drivers/acpi/numa.o
> > >   CC      crypto/asymmetric_keys/public_key.o
> > >   CC      crypto/asymmetric_keys/rsa.o
> > >   CC [M]  sound/core/sound.o
> > >   CC [M]  sound/core/init.o
> > >   CC      fs/stack.o
> > >   CC      fs/fs_struct.o
> > >   CC [M]  drivers/ata/sata_qstor.o
> > >   CC      drivers/base/syscore.o
> > >   CC      arch/x86/kernel/cpu/perf_event_amd.o
> > >   CC      drivers/base/driver.o
> > >   CC      arch/x86/kernel/cpu/perf_event_p6.o
> > >   CC      arch/x86/kernel/cpu/perf_event_knc.o
> > >   CC      crypto/asymmetric_keys/x509-asn1.o
> > >   CC      crypto/asymmetric_keys/x509_rsakey-asn1.o
> > >   CC      drivers/base/class.o
> > >   CC [M]  drivers/bcma/driver_chipcommon_pmu.o
> > >   CC      crypto/asymmetric_keys/x509_cert_parser.o
> > >   CC      drivers/acpi/cm_sbs.o
> > >   CC      kernel/ipipe/compat.o
> > >   CC      drivers/acpi/video_detect.o
> > >   CC [M]  drivers/bluetooth/btmrvl_debugfs.o
> > >   CC [M]  drivers/bluetooth/hci_ldisc.o
> > >   CC      fs/statfs.o
> > >   CC [M]  drivers/bluetooth/hci_h4.o
> > >   CC      fs/buffer.o
> > >   CC      fs/bio.o
> > >   CC [M]  sound/core/memory.o
> > >   CC [M]  sound/core/info.o
> > >   LD      crypto/asymmetric_keys/asymmetric_keys.o
> > >   LD      crypto/asymmetric_keys/x509_key_parser.o
> > >   LD      crypto/asymmetric_keys/built-in.o
> > >   LD      crypto/async_tx/built-in.o
> > >   CC [M]  crypto/async_tx/async_tx.o
> > >   CC [M]  crypto/async_tx/async_memcpy.o
> > >   CC [M]  drivers/block/aoe/aoenet.o
> > >   CC [M]  crypto/async_tx/async_xor.o
> > >   CC      drivers/base/platform.o
> > >   CC      arch/x86/kernel/cpu/perf_event_p4.o
> > >   LD      kernel/ipipe/built-in.o
> > >   CC      drivers/base/cpu.o
> > >   CC      kernel/irq/irqdesc.o
> > >   CC      drivers/base/firmware.o
> > >   CC      mm/pagewalk.o
> > >   CC      mm/pgtable-generic.o
> > >   CC      mm/process_vm_access.o
> > >   CC      drivers/acpi/acpica/dsargs.o
> > >   CC [M]  drivers/bcma/driver_pci.o
> > >   CC [M]  drivers/bcma/driver_gmac_cmn.o
> > >   CC [M]  drivers/ata/sata_sx4.o
> > >   CC      drivers/acpi/acpica/dscontrol.o
> > >   CC [M]  drivers/ata/ata_piix.o
> > >   CC      drivers/char/mem.o
> > >   CC [M]  drivers/bluetooth/hci_bcsp.o
> > >   CC [M]  drivers/bluetooth/hci_ll.o
> > >   CC [M]  drivers/bluetooth/bcm203x.o
> > >   CC [M]  drivers/bluetooth/bpa10x.o
> > >   CC      drivers/char/random.o
> > >   CC [M]  sound/core/control.o
> > >   CC      drivers/char/misc.o
> > >   CC [M]  crypto/async_tx/async_pq.o
> > >   CC      drivers/char/raw.o
> > >   LD [M]  drivers/block/aoe/aoe.o
> > >   CC [M]  crypto/async_tx/async_raid6_recov.o
> > >   CC [M]  crypto/async_tx/raid6test.o
> > >   CC      kernel/irq/handle.o
> > >   CC      arch/x86/kernel/cpu/perf_event_intel_lbr.o
> > >   CC      drivers/acpi/acpica/dsfield.o
> > >   CC      drivers/acpi/acpica/dsinit.o
> > >   CC      mm/init-mm.o
> > >   CC [M]  drivers/bcma/driver_gpio.o
> > >   CC      mm/nobootmem.o
> > >   CC      mm/memblock.o
> > >   CC      mm/bounce.o
> > >   CC      mm/page_io.o
> > >   CC      kernel/irq/manage.o
> > >   CC      drivers/acpi/acpica/dsmethod.o
> > >   CC      kernel/irq/spurious.o
> > >   CC      kernel/irq/resend.o
> > >   LD      drivers/char/ipmi/built-in.o
> > >   CC [M]  drivers/block/cciss.o
> > >   CC [M]  drivers/char/ipmi/ipmi_msghandler.o
> > >   CC [M]  drivers/ata/sata_mv.o
> > >   CC [M]  drivers/char/ipmi/ipmi_devintf.o
> > >   CC [M]  drivers/bcma/host_pci.o
> > >   CC      drivers/base/init.o
> > >   CC      drivers/base/map.o
> > >   CC      drivers/base/devres.o
> > >   CC      drivers/base/attribute_container.o
> > >   CC      drivers/base/transport_class.o
> > >   CC      arch/x86/kernel/cpu/perf_event_intel_ds.o
> > >   CC      arch/x86/kernel/cpu/perf_event_intel.o
> > >   CC      arch/x86/kernel/cpu/perf_event_intel_uncore.o
> > >   CC      arch/x86/kernel/cpu/mcheck/mce.o
> > >   CC      drivers/acpi/acpica/dsmthdat.o
> > >   CC      drivers/acpi/acpica/dsobject.o
> > >   CC [M]  drivers/bluetooth/bfusb.o
> > >   CC [M]  crypto/seqiv.o
> > >   CC [M]  crypto/vmac.o
> > >   CC      fs/block_dev.o
> > >   CC      fs/direct-io.o
> > >   CC      fs/mpage.o
> > >   LD [M]  drivers/bcma/bcma.o
> > >   CC      fs/ioprio.o
> > >   CC      drivers/char/hpet.o
> > >   CC      fs/proc_namespace.o
> > >   CC      mm/swap_state.o
> > >   CC      mm/swapfile.o
> > >   CC      drivers/base/topology.o
> > >   CC      drivers/base/devtmpfs.o
> > >   CC      drivers/base/power/sysfs.o
> > >   CC      drivers/acpi/acpica/dsopcode.o
> > >   CC      drivers/acpi/acpica/dsutils.o
> > >   CC [M]  sound/core/misc.o
> > >   CC      drivers/acpi/acpica/dswexec.o
> > >   CC      kernel/irq/chip.o
> > >   CC      kernel/irq/dummychip.o
> > >   CC      kernel/irq/devres.o
> > >   CC      kernel/irq/autoprobe.o
> > >   CC      kernel/irq/irqdomain.o
> > >   CC      drivers/base/power/generic_ops.o
> > >   CC [M]  drivers/bluetooth/dtl1_cs.o
> > >   CC      drivers/base/power/common.o
> > >   CC      drivers/char/nvram.o
> > >   CC      drivers/acpi/acpica/dswload.o
> > >   CC      drivers/char/agp/backend.o
> > >   CC      drivers/char/hw_random/core.o
> > >   CC      drivers/char/agp/frontend.o
> > >   CC      drivers/char/agp/generic.o
> > >   CC      drivers/char/hw_random/tpm-rng.o
> > >   CC [M]  crypto/xcbc.o
> > >   CC [M]  sound/core/device.o
> > >   CC [M]  sound/core/isadma.o
> > >   CC [M]  drivers/char/hw_random/timeriomem-rng.o
> > >   LD      drivers/char/pcmcia/built-in.o
> > >   CC [M]  drivers/char/pcmcia/cm4000_cs.o
> > >   CC      drivers/base/power/qos.o
> > >   CC      drivers/base/power/main.o
> > >   CC [M]  drivers/char/pcmcia/cm4040_cs.o
> > >   CC      drivers/acpi/acpica/dswload2.o
> > >   CC      drivers/acpi/acpica/dswscope.o
> > >   CC      fs/bio-integrity.o
> > >   CC [M]  drivers/ata/sata_nv.o
> > >   CC      arch/x86/kernel/cpu/mcheck/mce-severity.o
> > >   LD      fs/autofs4/built-in.o
> > >   CC [M]  crypto/crypto_null.o
> > >   CC [M]  fs/autofs4/init.o
> > >   CC      kernel/irq/proc.o
> > >   CC      kernel/irq/migration.o
> > >   CC [M]  drivers/char/hw_random/intel-rng.o
> > >   CC [M]  drivers/char/hw_random/amd-rng.o
> > >   CC [M]  drivers/char/hw_random/via-rng.o
> > >   CC [M]  fs/autofs4/inode.o
> > >   CC [M]  drivers/bluetooth/bt3c_cs.o
> > >   CC [M]  sound/core/sound_oss.o
> > >   CC [M]  drivers/char/ipmi/ipmi_si_intf.o
> > >   CC [M]  drivers/bluetooth/bluecard_cs.o
> > >   CC [M]  drivers/char/hw_random/virtio-rng.o
> > >   CC      arch/x86/kernel/cpu/mcheck/mce_intel.o
> > >   CC      drivers/acpi/acpica/dswstate.o
> > >   CC      drivers/base/dma-mapping.o
> > >   CC      drivers/base/regmap/regmap.o
> > >   CC      drivers/base/regmap/regcache.o
> > >   CC [M]  crypto/md4.o
> > >   CC [M]  crypto/rmd128.o
> > >   CC [M]  crypto/rmd160.o
> > >   CC      kernel/irq/pm.o
> > >   CC      mm/dmapool.o
> > >   CC      mm/hugetlb.o
> > >   LD      drivers/char/hw_random/rng-core.o
> > >   LD      drivers/char/hw_random/built-in.o
> > >   CC      mm/mempolicy.o
> > >   CC      mm/sparse.o
> > >   CC      arch/x86/kernel/cpu/mcheck/mce_amd.o
> > >   CC [M]  sound/core/info_oss.o
> > >   CC [M]  fs/autofs4/root.o
> > >   CC      drivers/acpi/acpica/evevent.o
> > >   CC      drivers/acpi/acpica/evgpe.o
> > >   CC      drivers/acpi/acpica/evgpeblk.o
> > >   CC      drivers/acpi/acpica/evgpeinit.o
> > >   CC      drivers/char/agp/isoch.o
> > >   LD      kernel/irq/built-in.o
> > >   CC      kernel/power/qos.o
> > >   CC      kernel/sched/core.o
> > >   CC      drivers/base/power/wakeup.o
> > >   CC      drivers/base/power/runtime.o
> > >   CC      kernel/sched/clock.o
> > >   CC      mm/sparse-vmemmap.o
> > >   CC      mm/mmu_notifier.o
> > >   CC [M]  drivers/bluetooth/btuart_cs.o
> > >   CC [M]  drivers/bluetooth/btusb.o
> > >   CC [M]  drivers/ata/sata_promise.o
> > >   CC [M]  drivers/ata/sata_sil.o
> > >   CC [M]  drivers/ata/sata_sis.o
> > >   CC      drivers/acpi/acpica/evgpeutil.o
> > >   CC      drivers/acpi/acpica/evglock.o
> > >   CC [M]  sound/core/vmaster.o
> > >   CC [M]  crypto/rmd256.o
> > >   CC [M]  drivers/block/pktcdvd.o
> > >   CC      arch/x86/kernel/cpu/mcheck/threshold.o
> > >   CC      drivers/char/agp/compat_ioctl.o
> > >   CC [M]  fs/autofs4/symlink.o
> > >   CC [M]  drivers/char/ipmi/ipmi_kcs_sm.o
> > >   CC [M]  drivers/char/ipmi/ipmi_smic_sm.o
> > >   CC      arch/x86/kernel/cpu/mcheck/therm_throt.o
> > >   CC      kernel/power/main.o
> > >   CC      kernel/power/console.o
> > >   CC      drivers/acpi/acpica/evmisc.o
> > >   CC      kernel/power/process.o
> > >   CC      drivers/base/regmap/regcache-rbtree.o
> > >   CC      drivers/base/regmap/regcache-lzo.o
> > >   CC [M]  fs/autofs4/waitq.o
> > >   CC [M]  fs/autofs4/expire.o
> > >   CC [M]  crypto/rmd320.o
> > >   CC [M]  fs/autofs4/dev-ioctl.o
> > >   CC [M]  crypto/sha512_generic.o
> > >   CC [M]  sound/core/ctljack.o
> > >   CC      arch/x86/kernel/cpu/mtrr/main.o
> > >   LD      drivers/base/power/built-in.o
> > >   CC [M]  drivers/char/ipmi/ipmi_bt_sm.o
> > >   CC      drivers/char/agp/amd64-agp.o
> > >   CC      drivers/char/agp/intel-agp.o
> > >   CC      drivers/acpi/acpica/evregion.o
> > >   CC      drivers/char/agp/intel-gtt.o
> > >   CC      drivers/char/agp/sis-agp.o
> > >   CC      drivers/char/agp/via-agp.o
> > >   CC      arch/x86/kernel/cpu/mcheck/mce-apei.o
> > >   CC      drivers/base/regmap/regmap-debugfs.o
> > >   CC [M]  drivers/ata/sata_svw.o
> > >   CC [M]  drivers/bluetooth/btsdio.o
> > >   LD [M]  drivers/bluetooth/btmrvl.o
> > >   CC [M]  drivers/ata/sata_uli.o
> > >   CC      arch/x86/kernel/cpuid.o
> > >   CC [M]  drivers/base/regmap/regmap-i2c.o
> > >   CC      arch/x86/kernel/cpu/perfctr-watchdog.o
> > >   CC [M]  drivers/char/ipmi/ipmi_watchdog.o
> > >   CC [M]  sound/core/jack.o
> > >   CC      kernel/power/suspend.o
> > >   CC      mm/ksm.o
> > >   CC      mm/slab.o
> > >   CC      drivers/base/dma-buf.o
> > >   LD      drivers/clk/built-in.o
> > > drivers/base/regmap/regmap-debugfs.c: In function
> > > =E2=80=98regmap_debugfs_get_dump_start=E2=80=99:
> > > drivers/base/regmap/regmap-debugfs.c:83: warning: =E2=80=98ret=E2=80=
=99 may be
> > > used uninitialized in this function CC
> > > drivers/clocksource/acpi_pm.o LD [M]  fs/autofs4/autofs4.o
> > > CC      drivers/base/firmware_class.o CC
> > > drivers/acpi/acpica/evrgnini.o LD      fs/btrfs/built-in.o
> > >   CC [M]  fs/btrfs/super.o
> > >   CC [M]  crypto/wp512.o
> > >   CC [M]  crypto/tgr192.o
> > >   CC [M]  crypto/gf128mul.o
> > >   CC [M]  arch/x86/kernel/cpu/mcheck/mce-inject.o
> > >   CC      kernel/time/timekeeping.o
> > >   LD      drivers/base/regmap/built-in.o
> > >   CC      kernel/trace/trace_clock.o
> > >   CC [M]  drivers/ata/sata_via.o
> > >   CC [M]  drivers/ata/sata_vsc.o
> > >   CC [M]  drivers/bluetooth/btmrvl_sdio.o
> > >   CC      drivers/clocksource/i8253.o
> > >   CC [M]  drivers/block/nvme.o
> > >   CC      kernel/xenomai/arch/generic/hal.o
> > >   CC      drivers/acpi/acpica/evsci.o
> > >   LD      sound/core/built-in.o
> > >   CC      arch/x86/kernel/cpu/mtrr/if.o
> > >   LD [M]  sound/core/snd.o
> > >   LD [M]  sound/core/snd-hwdep.o
> > >   LD      drivers/char/agp/agpgart.o
> > >   LD [M]  sound/core/snd-timer.o
> > >   LD      drivers/char/agp/built-in.o
> > >   LD [M]  sound/core/snd-hrtimer.o
> > >   LD [M]  sound/core/snd-pcm.o
> > >   CC      drivers/char/tpm/tpm.o
> > >   LD [M]  sound/core/snd-page-alloc.o
> > >   CC [M]  drivers/char/ipmi/ipmi_poweroff.o
> > >   CC      kernel/power/hibernate.o
> > >   LD [M]  sound/core/snd-rawmidi.o
> > >   CC      kernel/power/snapshot.o
> > >   LD      sound/isa/built-in.o
> > >   LD      sound/isa/ad1816a/built-in.o
> > >   LD      arch/x86/kernel/cpu/mcheck/built-in.o
> > >   CC [M]  drivers/char/virtio_console.o
> > >   LD      sound/isa/cs423x/built-in.o
> > >   LD      sound/isa/ad1848/built-in.o
> > >   CC [M]  drivers/char/lp.o
> > >   LD      sound/isa/es1688/built-in.o
> > >   CC      kernel/power/swap.o
> > >   LD      sound/isa/galaxy/built-in.o
> > >   CC      kernel/trace/ftrace.o
> > >   LD      sound/isa/gus/built-in.o
> > >   LD      drivers/clocksource/built-in.o
> > >   LD      sound/isa/msnd/built-in.o
> > >   CC      kernel/freezer.o
> > >   LD      sound/isa/opti9xx/built-in.o
> > >   CC [M]  crypto/ecb.o
> > >   CC      drivers/acpi/acpica/evxface.o
> > >   LD      sound/isa/sb/built-in.o
> > >   CC [M]  sound/isa/sb/sb_common.o
> > >   CC [M]  sound/isa/sb/sb_mixer.o
> > >   CC [M]  sound/isa/sb/sb16_main.o
> > >   CC [M]  drivers/ata/pata_ali.o
> > >   CC      arch/x86/kernel/cpu/mtrr/generic.o
> > >   LD [M]  drivers/char/ipmi/ipmi_si.o
> > >   CC      arch/x86/kernel/cpu/mtrr/cleanup.o
> > >   LD      kernel/xenomai/arch/generic/xeno_hal.o
> > >   LD      kernel/xenomai/arch/generic/built-in.o
> > >   LD      kernel/xenomai/arch/built-in.o
> > >   CC [M]  crypto/cbc.o
> > >   CC      kernel/xenomai/nucleus/bufd.o
> > >   CC      drivers/base/node.o
> > >   CC      kernel/time/ntp.o
> > >   CC      drivers/base/memory.o
> > >   LD [M]  drivers/bluetooth/hci_uart.o
> > >   CC      drivers/base/module.o
> > >   CC      drivers/acpi/acpica/evxfevnt.o
> > >   CC      drivers/acpi/acpica/evxfgpe.o
> > >   CC      drivers/acpi/acpica/evxfregn.o
> > >   CC      drivers/acpi/acpica/exconfig.o
> > >   CC      drivers/acpi/acpica/exconvrt.o
> > >   CC [M]  drivers/ata/pata_amd.o
> > >   CC [M]  crypto/pcbc.o
> > >   CC      drivers/char/tpm/tpm_eventlog.o
> > >   CC      drivers/char/tpm/tpm_acpi.o
> > >   CC [M]  drivers/char/i8k.o
> > >   CC      kernel/power/user.o
> > >   CC      kernel/time/clocksource.o
> > >   LD [M]  sound/isa/sb/snd-sb-common.o
> > >   CC [M]  drivers/block/osdblk.o
> > >   LD [M]  sound/isa/sb/snd-sb16-dsp.o
> > >   LD      sound/isa/wavefront/built-in.o
> > >   LD      sound/isa/wss/built-in.o
> > >   CC [M]  drivers/block/cryptoloop.o
> > >   CC [M]  drivers/char/ppdev.o
> > >   LD      arch/x86/kernel/cpu/mtrr/built-in.o
> > >   CC      drivers/char/tpm/tpm_ppi.o
> > >   CC      arch/x86/kernel/cpu/perf_event_amd_ibs.o
> > >   LD      sound/mips/built-in.o
> > >   LD      sound/parisc/built-in.o
> > >   LD      sound/pci/built-in.o
> > >   CC [M]  sound/pci/ad1889.o
> > >   LD      sound/pcmcia/built-in.o
> > >   LD      sound/pcmcia/pdaudiocf/built-in.o
> > >   CC      kernel/xenomai/nucleus/heap.o
> > >   LD      sound/pcmcia/vx/built-in.o
> > >   CC [M]  sound/pci/atiixp_modem.o
> > >   CC      kernel/xenomai/nucleus/intr.o
> > >   CC [M]  sound/pci/atiixp.o
> > >   LD      drivers/base/built-in.o
> > >   CC      kernel/xenomai/skins/native/module.o
> > >   CC      kernel/xenomai/skins/native/task.o
> > >   CC      drivers/acpi/acpica/excreate.o
> > >   CC      drivers/acpi/acpica/exdebug.o
> > >   CC [M]  crypto/cts.o
> > >   CC [M]  fs/btrfs/ctree.o
> > >   CC [M]  crypto/lrw.o
> > >   CC [M]  crypto/xts.o
> > >   CC [M]  drivers/ata/pata_artop.o
> > >   CC [M]  fs/btrfs/extent-tree.o
> > >   CC [M]  drivers/block/virtio_blk.o
> > >   CC      kernel/power/block_io.o
> > >   CC      mm/memory_hotplug.o
> > >   CC      kernel/power/poweroff.o
> > >   CC      kernel/time/jiffies.o
> > >   CC      kernel/time/timer_list.o
> > >   CC      drivers/acpi/acpica/exdump.o
> > >   CC      drivers/char/tpm/tpm_tis.o
> > >   CC      drivers/acpi/acpica/exfield.o
> > >   CC      drivers/acpi/acpica/exfldio.o
> > >   CC      drivers/acpi/acpica/exmutex.o
> > >   CC      drivers/acpi/acpica/exnames.o
> > >   CC      kernel/trace/ring_buffer.o
> > >   CC      kernel/trace/trace.o
> > >   CC      arch/x86/kernel/cpu/capflags.o
> > >   CC      kernel/sched/cputime.o
> > >   CC      kernel/xenomai/nucleus/pod.o
> > >   CC [M]  drivers/ata/pata_atiixp.o
> > >   LD      kernel/power/built-in.o
> > >   CC      kernel/xenomai/nucleus/registry.o
> > >   LD      arch/x86/kernel/cpu/built-in.o
> > >   CC      kernel/xenomai/nucleus/synch.o
> > >   CC [M]  drivers/ata/pata_atp867x.o
> > >   CC [M]  crypto/ctr.o
> > >   CC [M]  sound/pci/bt87x.o
> > >   CC [M]  sound/pci/cmipci.o
> > >   CC      arch/x86/kernel/early-quirks.o
> > >   CC      kernel/time/timeconv.o
> > >   CC [M]  sound/pci/cs5530.o
> > >   CC [M]  drivers/block/sx8.o
> > >   LD      drivers/block/mtip32xx/built-in.o
> > >   CC [M]  drivers/block/mtip32xx/mtip32xx.o
> > >   CC [M]  sound/pci/ens1370.o
> > >   CC [M]  drivers/char/tpm/tpm_nsc.o
> > >   CC      mm/filemap_xip.o
> > >   CC      drivers/acpi/acpica/exoparg1.o
> > >   CC      kernel/sched/idle_task.o
> > >   CC      kernel/sched/fair.o
> > >   CC [M]  crypto/gcm.o
> > >   CC      kernel/time/posix-clock.o
> > >   CC      arch/x86/kernel/ipipe.o
> > >   CC      arch/x86/kernel/smp.o
> > >   CC      kernel/xenomai/skins/native/timer.o
> > >   CC [M]  drivers/ata/pata_cmd64x.o
> > >   CC [M]  drivers/ata/pata_hpt366.o
> > >   CC      drivers/acpi/acpica/exoparg2.o
> > >   CC [M]  drivers/char/tpm/tpm_atmel.o
> > >   CC      kernel/profile.o
> > >   CC      kernel/stacktrace.o
> > >   CC      mm/migrate.o
> > >   CC      drivers/acpi/acpica/exoparg3.o
> > >   CC      kernel/time/alarmtimer.o
> > >   CC      kernel/time/clockevents.o
> > >   CC [M]  drivers/char/tpm/tpm_infineon.o
> > >   CC      kernel/sched/rt.o
> > >   CC      kernel/sched/stop_task.o
> > >   CC [M]  drivers/ata/pata_hpt37x.o
> > >   CC      kernel/sched/cpupri.o
> > >   CC      kernel/sched/auto_group.o
> > >   CC      kernel/trace/trace_output.o
> > >   CC      kernel/trace/trace_stat.o
> > >   CC [M]  crypto/ccm.o
> > >   CC      arch/x86/kernel/smpboot.o
> > >   CC      drivers/acpi/acpica/exoparg6.o
> > >   CC      kernel/xenomai/skins/native/syscall.o
> > >   CC      drivers/acpi/acpica/exprep.o
> > >   CC [M]  sound/pci/ak4531_codec.o
> > >   CC [M]  sound/pci/ens1371.o
> > >   CC      drivers/acpi/acpica/exmisc.o
> > >   CC      drivers/acpi/acpica/exregion.o
> > >   CC      kernel/time/tick-common.o
> > >   CC      drivers/acpi/acpica/exresnte.o
> > >   CC      drivers/acpi/acpica/exresolv.o
> > >   CC      arch/x86/kernel/tsc_sync.o
> > >   LD      drivers/char/tpm/tpm_bios.o
> > >   CC      arch/x86/kernel/setup_percpu.o
> > >   LD      drivers/char/tpm/built-in.o
> > >   CC [M]  drivers/char/tlclk.o
> > >   CC      arch/x86/kernel/mpparse.o
> > >   CC      arch/x86/kernel/ftrace.o
> > >   CC [M]  drivers/ata/pata_hpt3x2n.o
> > >   CC      arch/x86/kernel/trace_clock.o
> > >   CC      arch/x86/kernel/machine_kexec_64.o
> > >   AS      arch/x86/kernel/relocate_kernel_64.o
> > >   LD      drivers/block/built-in.o
> > >   CC      arch/x86/kernel/crash.o
> > >   CC      arch/x86/kernel/crash_dump_64.o
> > >   CC [M]  crypto/cryptd.o
> > >   CC [M]  crypto/des_generic.o
> > >   CC      arch/x86/kernel/kprobes.o
> > >   CC      kernel/xenomai/skins/native/pipe.o
> > >   CC      kernel/time/tick-broadcast.o
> > >   CC      drivers/acpi/acpica/exresop.o
> > >   CC      drivers/acpi/acpica/exstore.o
> > >   CC      kernel/xenomai/nucleus/thread.o
> > >   CC      kernel/xenomai/nucleus/timebase.o
> > >   CC      kernel/trace/trace_printk.o
> > >   CC      mm/memory-failure.o
> > >   CC      kernel/trace/trace_sched_switch.o
> > >   CC      kernel/trace/trace_functions.o
> > >   CC      mm/page_isolation.o
> > >   CC      kernel/futex.o
> > >   CC      drivers/acpi/acpica/exstoren.o
> > >   CC      kernel/time/tick-oneshot.o
> > >   CC [M]  drivers/char/hangcheck-timer.o
> > >   CC      kernel/time/tick-sched.o
> > >   CC [M]  drivers/ata/pata_hpt3x3.o
> > >   CC [M]  drivers/ata/pata_it8213.o
> > >   LD      drivers/char/built-in.o
> > >   CC [M]  sound/pci/es1968.o
> > >   CC [M]  drivers/ata/pata_it821x.o
> > >   CC [M]  drivers/ata/pata_jmicron.o
> > >   CC [M]  sound/pci/intel8x0.o
> > >   CC [M]  drivers/ata/pata_marvell.o
> > >   CC      arch/x86/kernel/kprobes-opt.o
> > >   CC [M]  drivers/ata/pata_netcell.o
> > >   CC      drivers/acpi/apei/apei-base.o
> > >   CC      drivers/acpi/acpica/exstorob.o
> > >   CC      drivers/acpi/acpica/exsystem.o
> > >   LD      kernel/sched/built-in.o
> > >   CC [M]  fs/btrfs/print-tree.o
> > >   CC [M]  crypto/fcrypt.o
> > >   CC [M]  fs/btrfs/root-tree.o
> > >   CC [M]  fs/btrfs/dir-item.o
> > >   CC [M]  fs/btrfs/file-item.o
> > >   CC      kernel/xenomai/nucleus/timer.o
> > >   CC      kernel/trace/trace_sched_wakeup.o
> > >   CC      kernel/trace/trace_nop.o
> > >   CC      kernel/trace/trace_stack.o
> > >   CC      kernel/trace/trace_functions_graph.o
> > >   CC      drivers/acpi/acpica/exutils.o
> > >   CC      kernel/trace/blktrace.o
> > >   LD      kernel/time/built-in.o
> > >   CC [M]  crypto/blowfish_generic.o
> > >   CC      arch/x86/pci/i386.o
> > >   CC      arch/x86/pci/init.o
> > >   CC      arch/x86/pci/mmconfig_64.o
> > >   CC      drivers/connector/cn_queue.o
> > >   CC [M]  drivers/ata/pata_ninja32.o
> > >   CC      arch/x86/kernel/module.o
> > >   CC      arch/x86/kernel/early_printk.o
> > >   LD      mm/built-in.o
> > >   CC      arch/x86/kernel/hpet.o
> > >   CC      arch/x86/kernel/amd_nb.o
> > >   CC      kernel/xenomai/nucleus/sched.o
> > >   CC      arch/x86/pci/direct.o
> > >   CC      arch/x86/pci/mmconfig-shared.o
> > >   CC      drivers/acpi/acpica/hwacpi.o
> > >   CC      arch/x86/pci/fixup.o
> > >   CC      arch/x86/kernel/pcspeaker.o
> > >   CC      drivers/acpi/apei/hest.o
> > >   CC      drivers/acpi/apei/cper.o
> > >   CC [M]  crypto/blowfish_common.o
> > >   CC [M]  crypto/twofish_common.o
> > >   CC      arch/x86/kernel/pci-swiotlb.o
> > >   CC [M]  crypto/serpent_generic.o
> > >   CC [M]  crypto/camellia_generic.o
> > >   CC [M]  crypto/cast_common.o
> > >   CC [M]  crypto/cast5_generic.o
> > >   CC      drivers/acpi/acpica/hwesleep.o
> > >   CC [M]  drivers/ata/pata_oldpiix.o
> > >   CC [M]  fs/btrfs/inode-item.o
> > >   CC [M]  drivers/ata/pata_pdc2027x.o
> > >   CC [M]  drivers/ata/pata_pdc202xx_old.o
> > >   CC      kernel/xenomai/skins/native/sem.o
> > >   CC [M]  sound/pci/intel8x0m.o
> > >   CC      drivers/connector/connector.o
> > >   CC      drivers/connector/cn_proc.o
> > >   CC [M]  fs/btrfs/inode-map.o
> > >   CC      kernel/futex_compat.o
> > >   CC [M]  fs/btrfs/disk-io.o
> > >   CC      drivers/acpi/acpica/hwgpe.o
> > >   CC [M]  fs/btrfs/transaction.o
> > >   CC [M]  fs/btrfs/inode.o
> > >   CC      arch/x86/pci/acpi.o
> > >   CC      arch/x86/pci/legacy.o
> > >   CC      drivers/acpi/apei/erst.o
> > >   CC      kernel/trace/trace_events.o
> > >   CC      arch/x86/kernel/perf_regs.o
> > >   CC      kernel/trace/trace_export.o
> > >   CC [M]  drivers/ata/pata_rdc.o
> > >   CC      kernel/trace/trace_syscalls.o
> > >   CC      kernel/trace/trace_event_perf.o
> > >   CC      drivers/acpi/acpica/hwpci.o
> > >   CC      drivers/acpi/acpica/hwregs.o
> > >   CC      kernel/trace/trace_events_filter.o
> > >   CC      drivers/acpi/acpica/hwsleep.o
> > >   CC      kernel/xenomai/nucleus/sched-idle.o
> > >   CC      drivers/acpi/acpica/hwvalid.o
> > >   CC      drivers/acpi/acpica/hwxface.o
> > >   CC      drivers/acpi/acpica/hwxfsleep.o
> > >   CC [M]  drivers/ata/pata_sch.o
> > >   CC      arch/x86/kernel/audit_64.o
> > >   CC [M]  sound/pci/maestro3.o
> > >   LD      drivers/connector/cn.o
> > >   LD      drivers/connector/built-in.o
> > >   CC      arch/x86/kernel/amd_gart_64.o
> > >   CC      arch/x86/kernel/aperture_64.o
> > >   CC      arch/x86/pci/irq.o
> > >   CC      kernel/xenomai/skins/native/event.o
> > >   CC      arch/x86/pci/common.o
> > >   CC      kernel/xenomai/skins/native/mutex.o
> > >   CC      arch/x86/pci/early.o
> > >   CC      arch/x86/pci/bus_numa.o
> > >   CC      arch/x86/pci/amd_bus.o
> > >   CC      kernel/xenomai/skins/native/cond.o
> > >   CC      kernel/xenomai/nucleus/sched-rt.o
> > >   CC      kernel/xenomai/skins/native/queue.o
> > >   CC      kernel/xenomai/skins/native/heap.o
> > >   CC      kernel/xenomai/skins/native/alarm.o
> > >   CC      drivers/acpi/acpica/nsaccess.o
> > >   CC      drivers/acpi/apei/ghes.o
> > >   CC [M]  drivers/acpi/apei/einj.o
> > >   CC [M]  drivers/ata/pata_serverworks.o
> > >   CC [M]  drivers/acpi/apei/erst-dbg.o
> > >   CC      drivers/acpi/acpica/nsalloc.o
> > >   CC      drivers/acpi/acpica/nsdump.o
> > >   CC      drivers/acpi/acpica/nseval.o
> > >   CC      kernel/trace/trace_kprobe.o
> > >   CC      arch/x86/power/cpu.o
> > >   CC      arch/x86/power/hibernate_64.o
> > >   LD      arch/x86/pci/built-in.o
> > >   CC      arch/x86/kernel/pci-calgary_64.o
> > >   CC      arch/x86/kernel/tce_64.o
> > >   AS      arch/x86/power/hibernate_asm_64.o
> > >   CC      arch/x86/kernel/mmconf-fam10h_64.o
> > >   CC [M]  sound/pci/rme32.o
> > >   CC [M]  sound/pci/rme96.o
> > >   CC      arch/x86/video/fbdev.o
> > >   CC      drivers/acpi/acpica/nsinit.o
> > >   CC [M]  drivers/ata/pata_sil680.o
> > >   CC      kernel/xenomai/nucleus/shadow.o
> > >   LD      drivers/acpi/apei/apei.o
> > >   CC      arch/x86/kernel/vsmp_64.o
> > >   AS      arch/x86/kernel/head_64.o
> > >   LD      drivers/acpi/apei/built-in.o
> > >   CC      arch/x86/kernel/head64.o
> > >   CC      kernel/rtmutex.o
> > >   CC      kernel/dma.o
> > >   CC      kernel/smp.o
> > >   CC      arch/x86/xenomai/hal_64.o
> > >   CC      arch/x86/xenomai/hal-common.o
> > >   CC      arch/x86/xenomai/usercopy_64.o
> > >   CC      arch/x86/xenomai/smi.o
> > >   CC      kernel/xenomai/nucleus/pipe.o
> > >   CC      kernel/xenomai/nucleus/map.o
> > >   CC      drivers/acpi/acpica/nsload.o
> > >   CC      drivers/acpi/acpica/nsnames.o
> > >   CC      drivers/acpi/acpica/nsobject.o
> > >   LD      arch/x86/power/built-in.o
> > >   CC      drivers/acpi/ac.o
> > >   CC      kernel/trace/power-traces.o
> > >   CC      kernel/xenomai/skins/native/buffer.o
> > >   CC      kernel/trace/rpm-traces.o
> > >   LD      arch/x86/video/built-in.o
> > >   CC      kernel/trace/trace_probe.o
> > >   CC [M]  kernel/trace/ring_buffer_benchmark.o
> > >   CC [M]  drivers/ata/pata_sis.o
> > >   CC      kernel/xenomai/skins/posix/sched.o
> > >   LD      kernel/xenomai/skins/psos+/built-in.o
> > >   CC      kernel/xenomai/skins/posix/thread_attr.o
> > >   CC      kernel/xenomai/skins/posix/thread.o
> > >   CC      drivers/acpi/acpica/nsparse.o
> > >   CC      kernel/xenomai/skins/posix/mutex_attr.o
> > >   CC      arch/x86/xenomai/c1e.o
> > >   CC      arch/x86/kernel/head.o
> > >   CC [M]  drivers/ata/pata_via.o
> > >   LD      arch/x86/oprofile/built-in.o
> > >   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/oprof.o
> > >   CC      net/socket.o
> > >   CC      drivers/acpi/acpica/nspredef.o
> > >   CC      net/802/fc.o
> > >   CC [M]  sound/pci/via82xx_modem.o
> > >   CC [M]  sound/pci/via82xx.o
> > >   CC      net/802/fddi.o
> > >   LDS     arch/x86/kernel/vmlinux.lds
> > >   CC [M]  arch/x86/kernel/microcode_core.o
> > >   CC [M]  crypto/cast6_generic.o
> > >   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/cpu_buffer.o
> > >   CC [M]
> > > arch/x86/oprofile/../../../drivers/oprofile/buffer_sync.o CC [M]
> > > arch/x86/oprofile/../../../drivers/oprofile/event_buffer.o
> > > LD      arch/x86/xenomai/xeno_hal.o LD
> > > arch/x86/xenomai/built-in.o CC [M]
> > > arch/x86/oprofile/../../../drivers/oprofile/oprofile_files.o CC
> > > [M]  fs/btrfs/file.o CC [M]
> > > arch/x86/oprofile/../../../drivers/oprofile/oprofilefs.o LD
> > > kernel/trace/libftrace.o LD      kernel/trace/built-in.o
> > >   CC [M]
> > > arch/x86/oprofile/../../../drivers/oprofile/oprofile_stats.o CC
> > > [M]  arch/x86/oprofile/../../../drivers/oprofile/timer_int.o CC
> > > [M]  drivers/ata/pata_pcmcia.o CC
> > > drivers/acpi/acpica/nsrepair.o LD
> > > kernel/xenomai/skins/native/xeno_native.o LD
> > > kernel/xenomai/skins/native/built-in.o CC
> > > drivers/acpi/acpica/nsrepair2.o CC [M]  drivers/ata/pata_acpi.o
> > >   CC [M]  drivers/ata/ata_generic.o
> > >   CC [M]  fs/btrfs/tree-defrag.o
> > >   CC [M]  fs/btrfs/extent_map.o
> > >   CC      drivers/acpi/button.o
> > >   LD      drivers/ata/libata.o
> > >   CC      drivers/acpi/fan.o
> > >   CC      drivers/acpi/pci_slot.o
> > >   CC [M]  fs/btrfs/sysfs.o
> > >   CC [M]  fs/btrfs/struct-funcs.o
> > >   CC [M]  fs/btrfs/xattr.o
> > >   CC [M]  arch/x86/kernel/microcode_intel.o
> > >   CC [M]  arch/x86/kernel/microcode_amd.o
> > >   CC      lib/bcd.o
> > >   CC [M]
> > > arch/x86/oprofile/../../../drivers/oprofile/nmi_timer_int.o CC [M]
> > > arch/x86/oprofile/init.o CC
> > > kernel/xenomai/skins/posix/mutex.o CC      lib/div64.o
> > >   CC [M]  crypto/arc4.o
> > >   CC [M]  net/802/p8022.o
> > >   CC      lib/sort.o
> > >   CC      drivers/acpi/acpica/nssearch.o
> > >   CC [M]  crypto/tea.o
> > >   CC      drivers/acpi/acpica/nsutils.o
> > >   CC      kernel/xenomai/nucleus/select.o
> > >   CC      drivers/acpi/acpica/nswalk.o
> > >   LD      drivers/ata/built-in.o
> > >   CC      drivers/acpi/acpica/nsxfeval.o
> > >   CC      drivers/acpi/acpica/nsxfname.o
> > >   CC [M]  arch/x86/oprofile/backtrace.o
> > >   CC [M]  arch/x86/oprofile/nmi_int.o
> > >   CC      drivers/acpi/acpica/nsxfobj.o
> > >   LD      sound/pci/ac97/built-in.o
> > >   LD      sound/pci/ali5451/built-in.o
> > >   CC [M]  sound/pci/ac97/ac97_codec.o
> > >   CC [M]  sound/pci/ali5451/ali5451.o
> > >   CC [M]  sound/pci/ac97/ac97_pcm.o
> > >   CC [M]  sound/pci/ac97/ac97_proc.o
> > >   CC      lib/parser.o
> > >   CC      lib/halfmd4.o
> > >   LD      sound/pci/asihpi/built-in.o
> > >   CC      lib/debug_locks.o
> > >   LD      arch/x86/kernel/built-in.o
> > >   CC      kernel/xenomai/skins/rtdm/core.o
> > >   CC [M]  crypto/khazad.o
> > >   CC      kernel/xenomai/skins/rtdm/device.o
> > >   CC [M]  crypto/anubis.o
> > >   CC      kernel/xenomai/skins/rtdm/drvlib.o
> > >   CC      kernel/xenomai/skins/rtdm/module.o
> > >   LD [M]  arch/x86/kernel/microcode.o
> > >   CC      kernel/xenomai/skins/rtdm/syscall.o
> > >   LD      arch/x86/built-in.o
> > >   CC      kernel/xenomai/skins/rtdm/proc.o
> > >   CC      drivers/acpi/acpica/psargs.o
> > >   CC [M]  fs/btrfs/ordered-data.o
> > >   CC [M]  fs/btrfs/extent_io.o
> > >   CC      drivers/acpi/acpica/psloop.o
> > >   CC [M]  net/802/psnap.o
> > >   CC      lib/random32.o
> > >   CC      lib/bust_spinlocks.o
> > >   LD      sound/pci/au88x0/built-in.o
> > >   CC [M]  sound/pci/au88x0/au8810.o
> > >   CC      lib/hexdump.o
> > >   CC [M]  arch/x86/oprofile/op_model_amd.o
> > >   CC [M]  arch/x86/oprofile/op_model_ppro.o
> > >   CC [M]  crypto/seed.o
> > >   CC [M]  crypto/deflate.o
> > >   CC      kernel/xenomai/skins/posix/cond_attr.o
> > >   CC [M]  crypto/zlib.o
> > >   LD      sound/sh/built-in.o
> > >   LD      sound/ppc/built-in.o
> > >   CC [M]  net/802/stp.o
> > >   CC [M]  crypto/michael_mic.o
> > >   LD      sound/soc/built-in.o
> > >   CC [M]  crypto/authenc.o
> > >   CC [M]  net/802/garp.o
> > >   CC      lib/kasprintf.o
> > >   CC      drivers/acpi/acpica/psopcode.o
> > >   CC      drivers/acpi/acpica/psparse.o
> > >   LD [M]  sound/pci/ali5451/snd-ali5451.o
> > >   CC      drivers/acpi/acpica/psscope.o
> > >   CC      kernel/xenomai/nucleus/vfile.o
> > >   CC      kernel/xenomai/nucleus/module.o
> > >   CC [M]  arch/x86/oprofile/op_model_p4.o
> > >   LD      fs/cachefiles/built-in.o
> > >   CC [M]  fs/cachefiles/bind.o
> > >   LD      fs/cifs/built-in.o
> > >   CC [M]  fs/cifs/cifsfs.o
> > >   CC      lib/bitmap.o
> > >   CC      lib/scatterlist.o
> > >   CC [M]  fs/cifs/cifssmb.o
> > >   CC [M]  fs/cifs/cifs_debug.o
> > >   CC [M]  fs/cifs/connect.o
> > >   CC      drivers/acpi/acpica/pstree.o
> > >   CC [M]  fs/cifs/dir.o
> > >   CC [M]  fs/cifs/file.o
> > >   LD      kernel/xenomai/skins/uitron/built-in.o
> > >   CC [M]  fs/cifs/inode.o
> > >   CC [M]  fs/cifs/link.o
> > >   CC [M]  fs/cifs/misc.o
> > >   CC      drivers/acpi/acpica/psutils.o
> > >   LD      fs/configfs/built-in.o
> > >   CC [M]  fs/configfs/inode.o
> > >   LD [M]  arch/x86/oprofile/oprofile.o
> > >   LD      fs/cramfs/built-in.o
> > >   CC      kernel/xenomai/skins/posix/cond.o
> > >   CC [M]  fs/cramfs/inode.o
> > >   LD      kernel/xenomai/skins/rtdm/xeno_rtdm.o
> > >   CC [M]  crypto/authencesn.o
> > >   LD      kernel/xenomai/skins/rtdm/built-in.o
> > >   CC [M]  crypto/lzo.o
> > >   CC [M]  fs/cachefiles/daemon.o
> > >   LD      net/802/built-in.o
> > >   CC      net/8021q/vlan_core.o
> > >   LD      net/9p/built-in.o
> > >   CC [M]  net/9p/mod.o
> > >   CC      drivers/acpi/acpica/pswalk.o
> > >   CC [M]  net/9p/client.o
> > >   LD      kernel/xenomai/nucleus/xeno_nucleus.o
> > >   CC      lib/string_helpers.o
> > >   CC [M]  net/9p/error.o
> > >   LD      kernel/xenomai/nucleus/built-in.o
> > >   CC [M]  net/9p/util.o
> > >   CC [M]  net/9p/protocol.o
> > >   CC [M]  net/9p/trans_fd.o
> > >   CC      lib/gcd.o
> > >   CC [M]  fs/configfs/file.o
> > >   CC      drivers/acpi/acpica/psxface.o
> > >   CC      drivers/acpi/acpica/rsaddr.o
> > >   CC      drivers/acpi/acpica/rscalc.o
> > >   CC      lib/lcm.o
> > >   CC [M]  fs/cramfs/uncompress.o
> > >   CC      lib/list_sort.o
> > >   CC [M]  fs/cachefiles/interface.o
> > >   CC      lib/uuid.o
> > >   CC [M]  fs/cachefiles/key.o
> > >   CC [M]  fs/cachefiles/main.o
> > >   LD [M]  fs/cramfs/cramfs.o
> > >   CC [M]  fs/cachefiles/namei.o
> > >   CC [M]  crypto/ansi_cprng.o
> > >   CC [M]  fs/configfs/dir.o
> > >   CC [M]  fs/configfs/symlink.o
> > >   CC [M]  crypto/tcrypt.o
> > >   CC [M]  fs/configfs/mount.o
> > >   CC [M]  fs/configfs/item.o
> > >   CC      drivers/acpi/acpica/rscreate.o
> > >   CC      drivers/acpi/acpica/rsinfo.o
> > >   CC      lib/flex_array.o
> > >   CC      drivers/acpi/acpica/rsio.o
> > >   CC [M]  sound/pci/au88x0/au8820.o
> > >   CC [M]  net/8021q/vlan.o
> > >   CC [M]  net/8021q/vlan_dev.o
> > >   CC [M]  net/8021q/vlan_netlink.o
> > >   CC      drivers/acpi/acpica/rsirq.o
> > >   LD [M]  sound/pci/ac97/snd-ac97-codec.o
> > >   LD      sound/pci/aw2/built-in.o
> > >   LD      sound/pci/ca0106/built-in.o
> > >   CC      drivers/acpi/acpica/rslist.o
> > >   CC [M]  fs/btrfs/volumes.o
> > >   CC [M]  sound/pci/ca0106/ca0106_main.o
> > >   CC [M]  sound/pci/ca0106/ca0106_proc.o
> > >   CC [M]  sound/pci/ca0106/ca0106_mixer.o
> > >   CC [M]  sound/pci/ca0106/ca_midi.o
> > >   CC      kernel/xenomai/skins/posix/sem.o
> > >   CC      kernel/xenomai/skins/posix/cancel.o
> > >   CC      fs/debugfs/inode.o
> > >   CC      kernel/xenomai/skins/posix/once.o
> > >   CC      lib/bsearch.o
> > >   CC      kernel/xenomai/skins/posix/signal.o
> > >   CC      kernel/xenomai/skins/posix/tsd.o
> > >   CC      lib/find_last_bit.o
> > >   CC      kernel/xenomai/skins/posix/clock.o
> > >   CC [M]  fs/cachefiles/rdwr.o
> > >   CC      drivers/acpi/acpica/rsmemory.o
> > >   CC      lib/find_next_bit.o
> > >   LD [M]  fs/configfs/configfs.o
> > >   CC      drivers/acpi/acpica/rsmisc.o
> > >   CC [M]  fs/cachefiles/security.o
> > >   CC [M]  fs/cachefiles/xattr.o
> > >   CC      lib/llist.o
> > >   CC      lib/memweight.o
> > >   CC      lib/kstrtox.o
> > >   CC      fs/debugfs/file.o
> > >   CC      kernel/spinlock.o
> > >   CC      kernel/xenomai/skins/posix/timer.o
> > >   CC [M]  crypto/ghash-generic.o
> > >   CC [M]  net/9p/trans_common.o
> > >   CC [M]  net/8021q/vlan_gvrp.o
> > >   CC [M]  net/9p/trans_rdma.o
> > >   CC [M]  net/8021q/vlanproc.o
> > >   CC [M]  crypto/xor.o
> > >   CC      drivers/acpi/acpica/rsserial.o
> > >   CC      lib/iomap.o
> > >   LD [M]  sound/pci/ca0106/snd-ca0106.o
> > >   CC      lib/pci_iomap.o
> > >   CC      lib/iomap_copy.o
> > >   CC      drivers/acpi/acpica/rsutils.o
> > >   CC      drivers/acpi/acpica/rsxface.o
> > >   LD [M]  fs/cachefiles/cachefiles.o
> > >   CC [M]  fs/btrfs/async-thread.o
> > >   CC [M]  fs/btrfs/ioctl.o
> > >   CC [M]  fs/btrfs/locking.o
> > >   CC [M]  fs/btrfs/orphan.o
> > >   CC [M]  fs/btrfs/export.o
> > >   CC      drivers/acpi/acpica/tbfadt.o
> > >   CC [M]  fs/btrfs/tree-log.o
> > >   CC [M]  fs/btrfs/free-space-cache.o
> > >   CC [M]  fs/btrfs/zlib.o
> > >   LD      fs/debugfs/debugfs.o
> > >   CC [M]  fs/btrfs/lzo.o
> > >   CC [M]  fs/cifs/netmisc.o
> > >   LD      fs/debugfs/built-in.o
> > >   CC [M]  fs/cifs/smbencrypt.o
> > >   CC      drivers/acpi/acpica/tbfind.o
> > >   LD      sound/sparc/built-in.o
> > >   CC      drivers/acpi/acpica/tbinstal.o
> > >   CC [M]  fs/btrfs/compression.o
> > >   LD      crypto/crypto.o
> > >   LD      net/8021q/built-in.o
> > >   LD      crypto/crypto_algapi.o
> > >   LD [M]  net/8021q/8021q.o
> > >   LD      crypto/crypto_blkcipher.o
> > >   LD      crypto/built-in.o
> > >   CC [M]  fs/btrfs/delayed-ref.o
> > >   CC      kernel/uid16.o
> > >   CC      lib/devres.o
> > >   CC [M]  sound/pci/au88x0/au8830.o
> > >   LD      net/atm/built-in.o
> > >   CC [M]  net/atm/addr.o
> > >   LD      net/bluetooth/built-in.o
> > >   CC [M]  net/bluetooth/af_bluetooth.o
> > >   CC [M]  net/9p/trans_virtio.o
> > >   CC [M]  net/atm/pvc.o
> > >   CC      arch/x86/lib/msr-smp.o
> > >   CC [M]  net/atm/signaling.o
> > >   CC [M]  net/atm/svc.o
> > >   LD      net/can/built-in.o
> > >   LD      net/bridge/built-in.o
> > >   CC [M]  net/can/bcm.o
> > >   CC [M]  net/bridge/br.o
> > >   CC      kernel/xenomai/skins/posix/registry.o
> > >   CC      drivers/acpi/acpica/tbutils.o
> > >   CC [M]  net/bridge/br_device.o
> > >   CC [M]  net/bridge/br_fdb.o
> > >   CC [M]  net/bridge/br_forward.o
> > >   CC      arch/x86/lib/cache-smp.o
> > >   CC [M]  fs/cifs/transport.o
> > >   CC      lib/check_signature.o
> > >   CC      lib/hweight.o
> > >   CC      drivers/acpi/acpica/tbxface.o
> > >   CC      arch/x86/lib/msr.o
> > >   AS      arch/x86/lib/msr-reg.o
> > >   CC      arch/x86/lib/msr-reg-export.o
> > >   AS      arch/x86/lib/iomap_copy_64.o
> > >   AS      arch/x86/lib/clear_page_64.o
> > >   AS      arch/x86/lib/cmpxchg16b_emu.o
> > >   CC [M]  fs/cifs/asn1.o
> > >   CC [M]  net/bridge/br_if.o
> > >   CC [M]  net/bridge/br_input.o
> > >   CC [M]  fs/cifs/cifs_unicode.o
> > >   CC [M]  fs/cifs/nterr.o
> > >   CC [M]  fs/cifs/xattr.o
> > >   CC      lib/bitrev.o
> > >   LD [M]  net/9p/9pnet.o
> > >   LD [M]  net/9p/9pnet_virtio.o
> > >   LD [M]  net/9p/9pnet_rdma.o
> > >   CC      lib/crc16.o
> > >   HOSTCC  lib/gen_crc32table
> > >   CC [M]  net/atm/ioctl.o
> > >   CC      lib/genalloc.o
> > >   CC      lib/lzo/lzo1x_compress.o
> > >   CC      lib/mpi/generic_mpih-lshift.o
> > >   CC      kernel/xenomai/skins/posix/mq.o
> > >   AS      arch/x86/lib/copy_page_64.o
> > >   AS      arch/x86/lib/copy_user_64.o
> > >   CC      lib/lzo/lzo1x_decompress.o
> > >   AS      arch/x86/lib/copy_user_nocache_64.o
> > >   CC [M]  net/bluetooth/hci_core.o
> > >   CC      drivers/acpi/acpica/tbxfload.o
> > >   AS      arch/x86/lib/csum-copy_64.o
> > >   CC      arch/x86/lib/csum-partial_64.o
> > >   CC      drivers/acpi/acpica/tbxfroot.o
> > >   CC      drivers/acpi/acpica/utaddress.o
> > >   LD      lib/raid6/built-in.o
> > >   LD      lib/reed_solomon/built-in.o
> > >   CC [M]  net/can/raw.o
> > >   CC [M]  lib/reed_solomon/reed_solomon.o
> > >   CC [M]  lib/raid6/algos.o
> > >   CC [M]  lib/raid6/recov.o
> > >   CC      lib/mpi/generic_mpih-mul1.o
> > >   CC      lib/mpi/generic_mpih-mul2.o
> > >   CC [M]  net/bridge/br_ioctl.o
> > >   CC [M]  net/bridge/br_notify.o
> > >   CC [M]  net/bridge/br_stp.o
> > >   CC [M]  net/can/af_can.o
> > >   CC [M]  fs/btrfs/relocation.o
> > >   CC [M]  net/bluetooth/hci_conn.o
> > >   CC [M]  fs/btrfs/delayed-inode.o
> > >   CC [M]  fs/btrfs/scrub.o
> > >   CC      drivers/acpi/acpica/utalloc.o
> > >   CC      arch/x86/lib/csum-wrappers_64.o
> > >   LD      lib/lzo/lzo_compress.o
> > >   LD      kernel/xenomai/skins/vrtx/built-in.o
> > >   LD      lib/lzo/lzo_decompress.o
> > >   LD      lib/lzo/built-in.o
> > >   CC      arch/x86/lib/delay.o
> > >   CC      drivers/acpi/acpica/utcopy.o
> > >   CC      lib/mpi/generic_mpih-mul3.o
> > >   AS      arch/x86/lib/getuser.o
> > >   CC      lib/mpi/generic_mpih-rshift.o
> > >   CC      lib/mpi/generic_mpih-sub1.o
> > >   CC [M]  fs/cifs/cifsencrypt.o
> > >   CC      lib/mpi/generic_mpih-add1.o
> > >   CC [M]  net/bridge/br_stp_bpdu.o
> > >   CC [M]  net/atm/common.o
> > >   CC [M]  net/atm/atm_misc.o
> > >   CC [M]  net/atm/raw.o
> > >   CC [M]  net/bridge/br_stp_if.o
> > >   HOSTCC  lib/raid6/mktables
> > >   CC      net/core/sock.o
> > >   CC      net/dcb/dcbnl.o
> > >   CC      drivers/acpi/acpica/utexcep.o
> > >   GEN     arch/x86/lib/inat-tables.c
> > >   CC      lib/mpi/mpicoder.o
> > >   CC      lib/mpi/mpi-bit.o
> > >   CC      drivers/acpi/container.o
> > >   CC      arch/x86/lib/insn.o
> > >   CC      drivers/acpi/acpi_memhotplug.o
> > >   UNROLL  lib/raid6/int1.c
> > >   UNROLL  lib/raid6/int2.c
> > >   UNROLL  lib/raid6/int4.c
> > >   UNROLL  lib/raid6/int8.c
> > >   UNROLL  lib/raid6/int16.c
> > >   UNROLL  lib/raid6/int32.c
> > >   CC [M]  lib/raid6/recov_ssse3.o
> > >   CC [M]  lib/raid6/recov_avx2.o
> > > lib/raid6/recov_avx2.c:11:5: warning: "CONFIG_AS_AVX2" is not
> > > defined lib/raid6/recov_avx2.c:322:2: warning: #warning "your
> > > version of binutils lacks AVX2 support" AS
> > > arch/x86/lib/memcpy_64.o LD
> > > kernel/xenomai/skins/vxworks/built-in.o CC
> > > drivers/acpi/battery.o AS      arch/x86/lib/memmove_64.o
> > >   LD [M]  sound/pci/au88x0/snd-au8810.o
> > >   LD [M]  sound/pci/au88x0/snd-au8820.o
> > >   LD      sound/spi/built-in.o
> > >   LD [M]  sound/pci/au88x0/snd-au8830.o
> > >   CC [M]  net/can/proc.o
> > >   AS      arch/x86/lib/memset_64.o
> > >   LD      sound/pci/cs46xx/built-in.o
> > >   CC [M]  sound/pci/cs46xx/cs46xx.o
> > >   AS      arch/x86/lib/putuser.o
> > >   CC      lib/mpi/mpi-cmp.o
> > >   CC      drivers/acpi/acpica/utdebug.o
> > >   AS      arch/x86/lib/rwlock.o
> > >   CC      kernel/xenomai/skins/posix/module.o
> > >   CC      drivers/acpi/acpica/utdecode.o
> > >   CC      drivers/acpi/acpica/utdelete.o
> > >   AS      arch/x86/lib/rwsem.o
> > >   LD      sound/synth/built-in.o
> > >   LD      sound/usb/built-in.o
> > >   CC [M]  sound/synth/util_mem.o
> > >   CC [M]  sound/usb/card.o
> > >   CC [M]  fs/cifs/readdir.o
> > >   AS      arch/x86/lib/thunk_64.o
> > >   CC [M]  net/bridge/br_stp_timer.o
> > >   CC      arch/x86/lib/usercopy.o
> > >   CC [M]  net/bridge/br_netlink.o
> > >   CC [M]  net/bridge/br_sysfs_if.o
> > >   CC [M]  lib/raid6/mmx.o
> > >   CC [M]  lib/raid6/sse1.o
> > >   CC [M]  lib/raid6/sse2.o
> > >   CC [M]  lib/raid6/avx2.o
> > >   CC      lib/mpi/mpih-cmp.o
> > >   CC      lib/mpi/mpih-div.o
> > >   CC      lib/mpi/mpih-mul.o
> > >   CC      drivers/acpi/acpica/uteval.o
> > >   CC [M]  sound/usb/clock.o
> > >   CC      lib/mpi/mpi-pow.o
> > >   CC [M]  sound/pci/cs46xx/cs46xx_lib.o
> > >   CC [M]  sound/pci/cs46xx/dsp_spos.o
> > >   CC      drivers/acpi/hed.o
> > >   CC      kernel/xenomai/skins/posix/apc.o
> > >   LD      sound/synth/emux/built-in.o
> > >   LD [M]  net/can/can.o
> > >   CC [M]  sound/synth/emux/emux.o
> > >   LD [M]  net/can/can-raw.o
> > >   LD [M]  net/can/can-bcm.o
> > >   CC [M]  sound/synth/emux/emux_synth.o
> > >   CC      drivers/acpi/acpica/utglobal.o
> > >   CC [M]  net/atm/resources.o
> > >   CC [M]  net/atm/atm_sysfs.o
> > >   CC      drivers/acpi/acpica/utids.o
> > >   CC      arch/x86/lib/usercopy_64.o
> > >   CC      drivers/acpi/acpica/utinit.o
> > >   TABLE   lib/raid6/tables.c
> > >   CC [M]  lib/raid6/int1.o
> > >   CC [M]  drivers/acpi/acpi_ipmi.o
> > >   CC      drivers/acpi/acpica/utlock.o
> > >   CC [M]  sound/usb/endpoint.o
> > >   CC [M]  net/bluetooth/hci_event.o
> > >   CC      lib/mpi/mpiutil.o
> > >   LD      drivers/crypto/built-in.o
> > >   CC [M]  fs/cifs/ioctl.o
> > >   CC [M]  drivers/crypto/padlock-aes.o
> > >   CC [M]  net/bridge/br_sysfs_br.o
> > >   CC [M]  net/bridge/br_netfilter.o
> > >   CC [M]  net/bridge/br_multicast.o
> > >   CC      net/dcb/dcbevent.o
> > >   LD      arch/x86/lib/built-in.o
> > >   CC      arch/x86/lib/inat.o
> > >   CC [M]  fs/btrfs/reada.o
> > >   CC      drivers/acpi/acpica/utmath.o
> > >   CC      fs/devpts/inode.o
> > >   CC      drivers/acpi/acpica/utmisc.o
> > >   AR      arch/x86/lib/lib.a
> > >   CC [M]  lib/raid6/int2.o
> > >   CC [M]  lib/raid6/int4.o
> > >   CC      kernel/xenomai/skins/posix/syscall.o
> > >   LD      lib/mpi/mpi.o
> > >   LD      lib/mpi/built-in.o
> > >   CC [M]  lib/raid6/int8.o
> > >   LD      fs/dlm/built-in.o
> > >   CC [M]  fs/dlm/ast.o
> > >   CC [M]  fs/dlm/config.o
> > >   LD      net/dccp/built-in.o
> > >   CC [M]  net/dccp/ccid.o
> > >   CC [M]  sound/synth/emux/emux_seq.o
> > >   CC [M]  sound/synth/emux/emux_nrpn.o
> > >   CC [M]  sound/synth/emux/emux_effect.o
> > >   CC      drivers/acpi/acpica/utmutex.o
> > >   CC [M]  drivers/crypto/padlock-sha.o
> > >   CC [M]  sound/synth/emux/emux_proc.o
> > >   CC [M]  fs/cifs/sess.o
> > >   CC [M]  sound/usb/format.o
> > >   CC [M]  net/atm/proc.o
> > >   LD      fs/devpts/devpts.o
> > >   LD      fs/devpts/built-in.o
> > >   CC [M]  net/atm/clip.o
> > >   CC [M]  net/atm/br2684.o
> > >   CC [M]  lib/raid6/int16.o
> > >   CC      net/core/request_sock.o
> > >   CC      net/core/skbuff.o
> > >   CC      net/core/iovec.o
> > >   CC      net/core/datagram.o
> > >   LD      net/dcb/built-in.o
> > >   CC [M]  drivers/acpi/video.o
> > >   CC [M]  sound/pci/cs46xx/dsp_spos_scb_lib.o
> > >   CC [M]  drivers/acpi/sbshc.o
> > >   CC [M]  fs/btrfs/backref.o
> > >   CC [M]  sound/synth/emux/emux_hwdep.o
> > >   CC      drivers/acpi/acpica/utobject.o
> > >   CC      drivers/acpi/acpica/utosi.o
> > >   CC      drivers/acpi/acpica/utresrc.o
> > >   CC [M]  lib/raid6/int32.o
> > >   CC [M]  net/dccp/feat.o
> > >   CC      drivers/acpi/acpica/utstate.o
> > >   CC [M]  sound/usb/helper.o
> > >   CC [M]  fs/dlm/dir.o
> > >   CC [M]  sound/synth/emux/soundfont.o
> > >   CC [M]  sound/synth/emux/emux_oss.o
> > >   CC [M]  net/bridge/br_mdb.o
> > >   LD      net/bridge/netfilter/built-in.o
> > >   CC [M]  net/bridge/netfilter/ebtables.o
> > >   CC      drivers/acpi/acpica/utxface.o
> > >   CC      drivers/acpi/acpica/utxfinit.o
> > >   CC [M]  sound/usb/mixer.o
> > >   CC [M]  lib/raid6/tables.o
> > >   CC [M]  sound/usb/mixer_quirks.o
> > >   CC [M]  fs/cifs/export.o
> > >   CC [M]  drivers/acpi/sbs.o
> > >   CC [M]  fs/cifs/smb1ops.o
> > >   CC [M]  net/atm/lec.o
> > >   CC [M]  net/atm/pppoatm.o
> > >   CC [M]  fs/dlm/lock.o
> > >   CC [M]  fs/dlm/lockspace.o
> > >   LD [M]  sound/pci/cs46xx/snd-cs46xx.o
> > >   LD      sound/pci/cs5535audio/built-in.o
> > >   CC [M]  sound/pci/cs5535audio/cs5535audio.o
> > >   CC [M]  sound/pci/cs5535audio/cs5535audio_pcm.o
> > >   CC [M]  sound/pci/cs5535audio/cs5535audio_pm.o
> > >   LD [M]  net/atm/atm.o
> > >   CC [M]  drivers/acpi/acpi_i2c.o
> > >   CC      drivers/acpi/acpica/utxferror.o
> > >   CC      drivers/acpi/acpica/utxfmutex.o
> > >   CC [M]  fs/btrfs/ulist.o
> > >   LD [M]  sound/synth/emux/snd-emux-synth.o
> > >   LD [M]  sound/synth/snd-util-mem.o
> > >   LD      net/dns_resolver/built-in.o
> > >   CC [M]  net/dns_resolver/dns_key.o
> > >   CC      net/dsa/dsa.o
> > >   CC      net/dsa/slave.o
> > >   LD [M]  net/bridge/bridge.o
> > >   LD [M]  sound/soundcore.o
> > >   CC      net/dsa/tag_dsa.o
> > >   CC [M]  net/dns_resolver/dns_query.o
> > >   LD      drivers/acpi/acpi.o
> > >   CC [M]  net/bluetooth/mgmt.o
> > >   CC [M]  net/bluetooth/hci_sock.o
> > >   LD      sound/pci/ctxfi/built-in.o
> > >   CC [M]  sound/pci/ctxfi/xfi.o
> > >   LD      sound/pci/echoaudio/built-in.o
> > >   CC [M]  sound/pci/echoaudio/darla20.o
> > >   LD [M]  sound/pci/cs5535audio/snd-cs5535audio.o
> > >   CC [M]  sound/pci/echoaudio/darla24.o
> > >   CC [M]  sound/pci/echoaudio/echo3g.o
> > >   LD      kernel/xenomai/skins/posix/xeno_posix.o
> > >   CC [M]  fs/btrfs/qgroup.o
> > >   CC [M]  fs/cifs/cifsacl.o
> > >   CC [M]  fs/btrfs/send.o
> > >   LD      kernel/xenomai/skins/posix/built-in.o
> > >   LD [M]  lib/raid6/raid6_pq.o
> > >   CC      lib/xz/xz_dec_syms.o
> > >   LD      kernel/xenomai/skins/built-in.o
> > >   CC [M]  net/dccp/input.o
> > >   LD      kernel/xenomai/built-in.o
> > >   LD      drivers/acpi/acpica/acpi.o
> > >   CC [M]  net/dccp/minisocks.o
> > >   LD      drivers/acpi/acpica/built-in.o
> > >   CC [M]  net/dccp/options.o
> > >   LD      drivers/acpi/built-in.o
> > >   CC      kernel/module.o
> > >   LD [M]  net/dns_resolver/dns_resolver.o
> > >   LD      drivers/dca/built-in.o
> > >   CC [M]  drivers/dca/dca-core.o
> > >   CC      drivers/dma/dmaengine.o
> > >   CC      drivers/dma/iovlock.o
> > >   CC [M]  sound/usb/pcm.o
> > >   CC      lib/xz/xz_dec_stream.o
> > >   CC [M]  sound/pci/ctxfi/ctatc.o
> > >   CC      lib/xz/xz_dec_lzma2.o
> > >   CC      net/dsa/tag_edsa.o
> > >   CC      net/dsa/tag_trailer.o
> > >   CC      net/core/stream.o
> > >   CC      net/core/scm.o
> > >   CC [M]  drivers/dca/dca-sysfs.o
> > >   CC      drivers/edac/edac_stub.o
> > >   CC [M]  fs/cifs/cifs_spnego.o
> > >   CC [M]  net/bridge/netfilter/ebtable_broute.o
> > >   CC [M]  net/bridge/netfilter/ebtable_filter.o
> > >   CC [M]  net/bridge/netfilter/ebtable_nat.o
> > >   CC [M]  net/bridge/netfilter/ebt_802_3.o
> > >   CC      lib/xz/xz_dec_bcj.o
> > >   CC [M]  fs/cifs/dns_resolve.o
> > >   LD [M]  drivers/dca/dca.o
> > >   LD      drivers/dma/ioat/built-in.o
> > >   LD      net/dsa/dsa_core.o
> > >   CC [M]  drivers/dma/ioat/pci.o
> > >   CC [M]  drivers/dma/ioat/dma.o
> > >   CC [M]  sound/usb/proc.o
> > >   LD      net/dsa/built-in.o
> > >   CC [M]  drivers/dma/ioat/dma_v2.o
> > >   CC [M]  sound/usb/quirks.o
> > >   CC [M]  drivers/dma/ioat/dma_v3.o
> > >   CC [M]  drivers/edac/amd64_edac.o
> > >   CC [M]  net/dccp/output.o
> > >   CC [M]  net/dccp/proto.o
> > >   LD      lib/xz/xz_dec.o
> > >   LD      lib/xz/built-in.o
> > >   CC [M]  net/dccp/timer.o
> > >   LD      lib/zlib_deflate/built-in.o
> > >   CC [M]  lib/zlib_deflate/deflate.o
> > >   CC [M]  sound/pci/ctxfi/ctvmem.o
> > >   CC [M]  lib/zlib_deflate/deftree.o
> > >   CC [M]  sound/pci/ctxfi/ctpcm.o
> > >   CC [M]  sound/pci/ctxfi/ctmixer.o
> > >   CC      net/core/gen_stats.o
> > >   CC [M]  fs/btrfs/dev-replace.o
> > >   CC [M]  sound/pci/echoaudio/gina20.o
> > >   CC [M]  sound/pci/echoaudio/gina24.o
> > >   CC [M]  net/bridge/netfilter/ebt_among.o
> > >   CC      net/core/gen_estimator.o
> > >   CC [M]  fs/cifs/cifs_dfs_ref.o
> > >   CC [M]  sound/usb/stream.o
> > >   CC [M]  sound/usb/midi.o
> > >   CC [M]  net/bluetooth/hci_sysfs.o
> > >   CC [M]  fs/dlm/main.o
> > >   CC [M]  fs/dlm/member.o
> > >   CC [M]  fs/dlm/memory.o
> > >   CC [M]  net/bluetooth/l2cap_core.o
> > >   CC [M]  lib/zlib_deflate/deflate_syms.o
> > >   CC      kernel/module_signing.o
> > >   CC      kernel/modsign_pubkey.o
> > >   CC [M]  sound/pci/ctxfi/ctresource.o
> > >   CC [M]  sound/pci/ctxfi/ctsrc.o
> > >   CC [M]  net/bluetooth/l2cap_sock.o
> > >   CC [M]  net/bluetooth/smp.o
> > >   CC [M]  net/bridge/netfilter/ebt_arp.o
> > >   CC [M]  sound/pci/echoaudio/indigo.o
> > >   CC [M]  fs/btrfs/acl.o
> > >   LD [M]  fs/cifs/cifs.o
> > >   CC [M]  drivers/dma/ioat/dca.o
> > >   CC [M]  sound/pci/echoaudio/indigodj.o
> > >   CC [M]  fs/dlm/midcomms.o
> > >   CC [M]  fs/dlm/netlink.o
> > >   LD [M]  lib/zlib_deflate/zlib_deflate.o
> > >   CC [M]  sound/pci/echoaudio/indigodjx.o
> > >   CC      lib/zlib_inflate/inffast.o
> > >   CC      lib/textsearch.o
> > >   CC      net/core/net_namespace.o
> > >   CC [M]  drivers/edac/edac_mc.o
> > >   AS      kernel/modsign_certificate.o
> > >   CC      kernel/kallsyms.o
> > >   CC [M]  net/dccp/qpolicy.o
> > >   CC      kernel/acct.o
> > >   CC      kernel/kexec.o
> > >   CC      lib/zlib_inflate/inflate.o
> > >   CC      lib/zlib_inflate/infutil.o
> > >   CC      lib/zlib_inflate/inftrees.o
> > >   CC      lib/zlib_inflate/inflate_syms.o
> > >   CC      kernel/compat.o
> > >   CC [M]  sound/pci/ctxfi/ctamixer.o
> > >   CC [M]  fs/dlm/lowcomms.o
> > >   CC [M]  sound/pci/ctxfi/ctdaio.o
> > >   CC [M]  sound/pci/ctxfi/ctimap.o
> > >   LD [M]  fs/btrfs/btrfs.o
> > >   LD      sound/usb/6fire/built-in.o
> > >   CC [M]  sound/usb/6fire/chip.o
> > >   LD      sound/usb/caiaq/built-in.o
> > >   CC [M]  sound/usb/caiaq/device.o
> > >   CC [M]  net/bridge/netfilter/ebt_ip.o
> > >   CC [M]  sound/usb/caiaq/audio.o
> > >   CC [M]  sound/usb/caiaq/midi.o
> > >   CC [M]  sound/usb/caiaq/control.o
> > >   LD [M]  drivers/dma/ioat/ioatdma.o
> > >   LD      drivers/dma/built-in.o
> > >   CC [M]  sound/usb/caiaq/input.o
> > >   LD      fs/ecryptfs/built-in.o
> > >   CC [M]  net/dccp/ccids/ccid2.o
> > >   CC [M]  net/dccp/ackvec.o
> > >   LD      lib/zlib_inflate/zlib_inflate.o
> > >   CC [M]  fs/ecryptfs/dentry.o
> > >   LD      lib/zlib_inflate/built-in.o
> > >   CC      net/ethernet/eth.o
> > >   CC      lib/percpu_counter.o
> > >   CC      lib/swiotlb.o
> > >   CC      lib/iommu-helper.o
> > >   CC [M]  sound/usb/6fire/comm.o
> > >   CC [M]  sound/usb/6fire/midi.o
> > >   CC [M]  sound/pci/ctxfi/cthardware.o
> > >   CC [M]  sound/pci/ctxfi/cttimer.o
> > >   CC [M]  sound/usb/6fire/control.o
> > >   CC [M]  sound/pci/ctxfi/cthw20k2.o
> > >   CC      net/core/secure_seq.o
> > >   CC      net/core/flow_dissector.o
> > >   CC [M]  sound/pci/echoaudio/indigoio.o
> > >   CC [M]  drivers/edac/edac_device.o
> > >   CC [M]  drivers/edac/edac_mc_sysfs.o
> > >   CC [M]  sound/pci/echoaudio/indigoiox.o
> > >   CC [M]  net/bridge/netfilter/ebt_ip6.o
> > >   CC [M]  fs/ecryptfs/file.o
> > >   CC [M]  net/bridge/netfilter/ebt_limit.o
> > >   CC [M]  fs/ecryptfs/inode.o
> > >   CC [M]  fs/ecryptfs/main.o
> > >   CC [M]  fs/ecryptfs/super.o
> > >   CC [M]  sound/pci/ctxfi/cthw20k1.o
> > >   LD      net/ieee802154/built-in.o
> > >   CC [M]  net/ieee802154/af_ieee802154.o
> > >   CC [M]  sound/usb/6fire/firmware.o
> > >   CC [M]  fs/dlm/plock.o
> > >   CC [M]  sound/usb/6fire/pcm.o
> > >   LD [M]  sound/usb/caiaq/snd-usb-caiaq.o
> > >   CC      kernel/cgroup.o
> > >   CC      kernel/cgroup_freezer.o
> > >   CC      kernel/cpuset.o
> > >   CC [M]  net/dccp/ccids/ccid3.o
> > >   CC [M]  net/bridge/netfilter/ebt_mark_m.o
> > >   LD      net/ethernet/built-in.o
> > >   CC      lib/syscall.o
> > >   CC      lib/dynamic_debug.o
> > >   CC      net/ipv4/route.o
> > >   CC      net/ipv4/inetpeer.o
> > >   CC [M]  drivers/edac/edac_pci_sysfs.o
> > >   LD      net/ipv6/netfilter/built-in.o
> > >   CC [M]  net/ipv6/netfilter/ip6_tables.o
> > >   CC      net/core/sysctl_net_core.o
> > >   CC      kernel/utsname.o
> > >   CC      drivers/firewire/init_ohci1394_dma.o
> > >   CC [M]  drivers/firewire/core-card.o
> > >   CC [M]  drivers/firewire/core-cdev.o
> > >   CC [M]  fs/ecryptfs/mmap.o
> > >   CC [M]  drivers/firewire/core-device.o
> > >   CC [M]  net/ieee802154/raw.o
> > >   CC [M]  drivers/firewire/core-iso.o
> > >   LD [M]  sound/usb/6fire/snd-usb-6fire.o
> > >   LD      sound/usb/misc/built-in.o
> > >   CC [M]  sound/usb/misc/ua101.o
> > >   LD      sound/usb/usx2y/built-in.o
> > >   CC [M]  sound/usb/usx2y/us122l.o
> > >   CC [M]  sound/usb/usx2y/usbusx2y.o
> > >   CC [M]  fs/dlm/rcom.o
> > >   CC [M]  sound/usb/usx2y/usX2Yhwdep.o
> > >   CC [M]  net/bridge/netfilter/ebt_pkttype.o
> > >   LD [M]  sound/pci/ctxfi/snd-ctxfi.o
> > >   CC [M]  sound/usb/usx2y/usx2yhwdeppcm.o
> > >   CC [M]  sound/pci/echoaudio/layla20.o
> > >   CC      net/core/dev.o
> > >   CC [M]  fs/ecryptfs/read_write.o
> > >   CC [M]  fs/ecryptfs/crypto.o
> > >   CC [M]  drivers/edac/edac_module.o
> > >   CC [M]  net/bluetooth/sco.o
> > >   CC [M]  net/dccp/ccids/lib/tfrc.o
> > >   CC [M]  drivers/edac/edac_device_sysfs.o
> > >   CC [M]  drivers/firewire/core-topology.o
> > >   CC [M]  net/dccp/ccids/lib/tfrc_equation.o
> > >   CC      lib/nlattr.o
> > >   CC [M]  net/ieee802154/dgram.o
> > >   CC      lib/average.o
> > >   CC [M]  fs/dlm/recover.o
> > >   CC [M]  fs/dlm/recoverd.o
> > >   CC [M]  net/bridge/netfilter/ebt_stp.o
> > >   CC [M]  fs/dlm/requestqueue.o
> > >   CC [M]  net/bridge/netfilter/ebt_vlan.o
> > >   CC [M]  net/bridge/netfilter/ebt_arpreply.o
> > >   CC [M]  fs/ecryptfs/keystore.o
> > >   CC [M]  fs/dlm/user.o
> > >   LD [M]  sound/usb/misc/snd-ua101.o
> > >   CC [M]  fs/dlm/util.o
> > >   LD [M]  sound/usb/snd-usb-audio.o
> > >   CC [M]  fs/dlm/debug_fs.o
> > >   CC [M]  drivers/edac/edac_pci.o
> > >   CC [M]  drivers/edac/mce_amd.o
> > >   CC [M]  fs/ecryptfs/messaging.o
> > >   CC [M]  fs/ecryptfs/miscdev.o
> > >   CC [M]  drivers/firewire/core-transaction.o
> > >   CC [M]  fs/ecryptfs/kthread.o
> > >   LD [M]  sound/usb/usx2y/snd-usb-usx2y.o
> > >   CC [M]  net/dccp/ccids/lib/packet_history.o
> > >   CC [M]  net/ieee802154/netlink.o
> > >   LD [M]  sound/usb/usx2y/snd-usb-us122l.o
> > >   LD [M]  sound/usb/snd-usbmidi-lib.o
> > >   CC [M]  net/ieee802154/nl-mac.o
> > >   CC      net/ipv4/protocol.o
> > >   CC [M]  net/ipv6/netfilter/ip6table_filter.o
> > >   CC [M]  net/ipv6/netfilter/ip6table_mangle.o
> > >   CC [M]  net/bluetooth/lib.o
> > >   CC      net/ipv4/ip_input.o
> > >   CC [M]  net/bridge/netfilter/ebt_mark.o
> > >   CC      net/ipv4/ip_fragment.o
> > >   CC      lib/cpu_rmap.o
> > >   CC      lib/dynamic_queue_limits.o
> > >   CC [M]  net/bridge/netfilter/ebt_dnat.o
> > >   CC      lib/clz_tab.o
> > >   CC      lib/strncpy_from_user.o
> > >   CC [M]  net/bridge/netfilter/ebt_redirect.o
> > >   CC [M]  fs/ecryptfs/debug.o
> > >   CC [M]  net/bridge/netfilter/ebt_snat.o
> > >   LD [M]  fs/dlm/dlm.o
> > >   CC [M]  net/bridge/netfilter/ebt_log.o
> > >   CC [M]  net/bluetooth/a2mp.o
> > >   CC [M]  drivers/edac/i5000_edac.o
> > >   CC [M]  sound/pci/echoaudio/layla24.o
> > >   CC [M]  drivers/edac/i5100_edac.o
> > >   CC [M]  drivers/edac/i5400_edac.o
> > >   CC [M]  sound/pci/echoaudio/mia.o
> > >   CC      net/core/ethtool.o
> > >   CC [M]  net/ipv6/netfilter/ip6table_raw.o
> > >   CC      lib/strnlen_user.o
> > >   CC [M]  net/ipv6/netfilter/ip6table_security.o
> > >   LD [M]  fs/ecryptfs/ecryptfs.o
> > >   CC [M]  drivers/firewire/net.o
> > >   CC [M]  net/dccp/ccids/lib/loss_interval.o
> > >   CC      kernel/pid_namespace.o
> > >   LD      fs/exofs/built-in.o
> > >   CC [M]  fs/exofs/ore.o
> > >   CC [M]  fs/exofs/ore_raid.o
> > >   CC      kernel/res_counter.o
> > >   CC      lib/asn1_decoder.o
> > >   GEN     lib/oid_registry_data.c
> > > Compiling 49 OIDs
> > >   CC [M]  drivers/firewire/ohci.o
> > >   CC      drivers/firmware/dmi_scan.o
> > >   CC [M]  drivers/firewire/sbp2.o
> > >   CC [M]  net/ieee802154/nl-phy.o
> > >   LD      net/key/built-in.o
> > >   CC [M]  net/bridge/netfilter/ebt...   =20
> >
> > [Messaggio troncato]   =20
> -------------- next part --------------
>    Dear Henning,
>    Thank you for your e-mail, I'll try to clarify a bit the problem.
>    My aim is to install xenomai (kernel linux  linux-3.8.13
>     ipipe-core-3.10.32-x86-6) on the machine HP described in the
>    Purchase details I sent you with my previous e-mail.
>    I have already successfully installed the same xenomai on several
>    machines, using the same settings.
>    When I try to install the xenomai on the HP server I got the
> following error message:
>    FATAL: Module scsi_wait_scan not found (a print screen is in
>    attachment).
>    Inline image 1
>    I executed different tests in order to solve the problem, but till
> now I was not able to succeed.
>    I'll list the different tests here below:
>    Pre-requisite:
>    a. I use kernel linux  linux-3.8.13;
>    b. #copy the the pre configured Makefile to kernel folder
>    c. rename the preconfigured Makefile to take the place of the orig
>    makefile (only difference is the EXTRAVERSION=3D _xenomai-2.6.4. This
>    will be added to the bootloader)
>    d.copy the latest ipipe patch for this kernel
>    e.   I patch it with          ${XEN_SRC}/scripts/prepare-kernel.sh
>    --linux=3Dlinux-3.8.13
>    --adeos=3D${XEN_SRC}ksrc/arch/x86/patches/ipipe-core-3.10.32-x86-4.pat=
ch
>    --arch=3Dx86
>    f. I add my .conf file (the one attached on my previous e-mail)
>    g. compile with make clean && make -j 24 && make modules -j 24 &&
> make modules_install && make install
>    h. #set grub to boot in new kernel made
>                sed -i "/default=3D1/c\default=3D0" /boot/grub/grub.conf
>    1) In order to compile the xenomay i use the following command:
>    make clean && make -j 24 && make modules -j 24 && make
> modules_install && make install
>    As a first attempt I included in the .conf the scsi module of the
> HP via make menuconfig, but no success
>    2) On internet I found a couple of links where the same problem is
>    described, even if not for xenomai:
>    a. [1]https://bugzilla.kernel.org/show_bug.cgi?id=3D60758
>    b. [2]http://linuxaleph.blogspot.de/2014/06/kernel-panic-scsiwaits
>    can-on-centos.html
>=20
>    As you can see, for this problem, they have an explanation at
> least for kernel 3.13.They say that the problem is linked with the
> fact that the version introduces multi queue block i/o for
> virtio_blk, which in turn does not call any more blk_init_queue() but
> blk_mq_init_queue() instead. Dracut matches against symbol
> blk_init_queue but not yet against symbol blk_mq_init_queue.
>=20
>    --> as a first attempt I executed the following code as
> suggested: =20
>=20
>    echo 'add_drivers+=3D"virtio_blk" ' > /etc/dracut.conf.d/force-vitio
>    _blk-to-ensure-boot.conf
>=20
>    cp /boot/initramfs-3.8.13_xenomai-2.6.4.img
>    /boot/initramfs-3.8.13_xenomai-2.6.4.img.bak
>=20
>    dracut -f /boot/initramfs-3.8.13_xenomai-2.6.4.img
> 3.8.13_xenomai-2.6.4
>=20
>    but no success
>=20
>    --> after I also added virtio in the configuration file before =20
>    compiling xenomai, but also here no success.
>=20
>    3) When I compile xenomai I can note that different scsi modules
> are compiled an installed (lease see the attached picture)
>    Inline image 1
>    I had a look in the folder linux-3.8.13-xenomai-2.6.4/drivers/scsi
> and I noted that indeed the scsi_wait_scan is not there,
>    as a consequence it seems that the scsi_wait_scan is not present
>    anymore in the linux-3.8.13 distribution.
>    I had a look at an older linux distribution (linux-3.4) and indeed
> in that case the scsi_wait_scan is still there, in
>    linux-3.4//drivers/scsi.
>    My idea is somehow to add the scsi_wait_scan to my
>    linux-3.8.13-xenomai-2.6.4 and to compile and install it.
>    If done in the correct way, I should be able to see on the screen
>    during the compilation something like:
>=20
>    CC [M] drivers/scsi/scsi_wait_scan.o           should be shown
> after CC [M] drivers/scsi/scsi_transport_srp.o
>=20
>    and
>=20
>    INSTALL drivers/scsi/scsi_wait_scan.ko       should be shown after
>    INSTALL  drivers/scsi/scsi_transport_srp.ko
>    I tried it copying the scsi_wait_scan in linux-3.8.13//drivers/scsi
>    before patching it with xenomai. Then I tried to compile with:
>    make clean && make -j 24 && make modules -j 24 && make
> modules_install && make install
>    but no success.
>    Now I would like to kindly ask you if in the past you had such a
>    problem:
>    FATAL: Module scsi_wait_scan not found.
>    and if you have a suggestion to solve it. In addition, I would
> like to ask you how it is possible to add the  "scsi_wait_scan"
>    to the list of compiled modules (as explained at the end of point
> 3). It is still not clear to me if such problem is linked with my HW
> or is a problem linked linux distribution or both. On this respect I
> would like to add that I was able to compile the xenomai (exactly the
> same with the same .config) on a Virtual Machine that I was running
> on the same HW.
>    Thank you in advance for you support,
>    Kind Regards
>=20
>    Michele
>    2016-08-19 19:03 GMT+02:00 Henning Schild
>    <[3]henning.schild@siemens.com>:
>=20
>      Michele,
>      that is a lot of information, most of it does not seem too
> useful. What
>      exactly is the error message you get and you are working on?
>      I can only assume it is the usual "my root partition does not
> exist" and you really just miss the module.
>      When building an essential driver as an external module you will
>      need
>      an initrd. Consult documentation of your distribution to figure
> out how
>      to best update a kernel and create/update the initrd for it.
>      I would even suggest you just try that with a "regular" linux
>      kernel,
>      because from what you wrote you might have missed a step or two
> in installing that new ipipe-kernel.
>      Find some comments as inline replies in you mail below.
>      Henning
>      Am Fri, 19 Aug 2016 17:55:09 +0200
>      schrieb Michele Belotti <[4]miki.belotti@gmail.com>:
>      > I have already installed the Xenomai 2.6.4 on several machine
>      > with Red Hat 6.7 successfully (kernel linux  linux-3.8.13
>      > ipipe-core-3.10.32-x86-6) on the machine HP described in the =20
>      Purchase
>      > details. The installation seems correct except to the fact the
>      > probably the SCSI driver are not correctly
>      > installed. The configuration is the one described in the
>      > xenomai_kernel.config file
>      >
>      > We make a lot of test different that I try to summarize =20
>      hereafter...
>      >
>      >
>      >
>      > As suggested, we added our SCSI model in the .config but it =20
>      doesn=E2=80=99t
>      > resolve the problem, we still have the core dump.
>      >
>      > Googling, we found that
>      > ([5]https://bugzilla.kernel.org/show_bug.cgi?id=3D60758) to
>      > solve =20
>      our
>      > problem (scsi_wait_scan not found) we should enable
>      > CONFIG_SCSI_SCAN_ASYN =C3=A0 Y  in the .config file.
>      >
>      > We did it, but it still does not work.
>      >
>      > Now, there is something strange.
>      >
>      > If i run the following command:
>      >
>      >
>      >
>      > lsinitrd | grep wait
>      >
>      >
>      >
>      > I can see the wait module in the following folder:
>      >
>      > /lib/modules/2.6.32-573.el6.x86-64/kernel/drivers/scsi/ =20
>      scsi_wait_scan.ko
>      Well lsinitrd shows the content of the initrd, not the content of
>      your
>      rootfs. Even though for the kernel specific modules you probably
>      want
>      that to be the same.
>      Does that initrd contain /lib/modules/linux-3.8.13-xenomai-2.6.4
> as well?
>      >
>      >
>      > but if I look in the following folder:
>      > /usr/src/kernls/linux-3.8.13-xenomai-2.6.4/drivers/scsi I=E2=80=99m
>      > not =20
>      able
>      > to find it. =20
>      That is a totally different path. Did you forget "make
>      modules_install"?
>      You want all relevant modules to be in /lib/modules/3.8.13-xeno..
>      and
>      after creating/updating the initrd you also want to find them in
>      there.
>      And you want to make sure the initrd is actually used. It needs
> to be
>      mentioned in the bootloader config.
>=20
>    >
>    > If my understanding is correct, the scsi_wait_scan module is
>    > needed =20
>    to
>    > =E2=80=9Cwait=E2=80=9D the scan of the scsi drivers before they are =
mounted.
>    >
>    >
>    > In order to speed up the different tests, I created the
>    > ./usr/src/kernels/linux-3.8.13-xenomai-2.6.4 following manually
>    > the build_install_xenomai_kernel.sh and then, instead of mv this
>    > version to $FIN_DIR (raw 140) I just
>    >
>    > cp  ./usr/src/kernels/linux-3.8.13-xenomai-2.6.4  /usr/src/kernels/
>    > and I update the .config inside with my config every time I want
>    > to perform a new test; then I compile and I update the grub.
>    >
>    >
>    >
>    >
>    >
>    > 1)            In order to create a new config file I always use
>    > the make menuconfig. Please find attached two version of the
>    > config files (the most significative) I used to compile the
>    > software (of course I renamed in .config before recompiling).
>    >
>    > Using config_1 I have the following messages after the make:
>    >
>    > ERROR: modinfo: could not find module cpufreq_ondemand
>    >
>    > ERROR: modinfo: could not find module freq_table
>    >
>    > ERROR: modinfo: could not find module pcc_cpufreq
>    >
>    > ERROR: modinfo: could not find module power_meter
>    >
>    > ERROR: modinfo: could not find module acpi_ipmi
>    >
>    > ERROR: modinfo: could not find module sb_edac
>    >
>    > ERROR: modinfo: could not find module hpsa
>    >
>    > ERROR: modinfo: could not find module wmi
>    >
>    >
>    >
>    > Using configure_2 I have the following messages after the make:
>    >
>    >                 ERROR: modinfo: could not find module =20
>    cpufreq_ondemand
>    >
>    > ERROR: modinfo: could not find module freq_table
>    >
>    > ERROR: modinfo: could not find module pcc_cpufreq
>    >
>    > ERROR: modinfo: could not find module sg
>    >
>    > ERROR: modinfo: could not find module mdio
>    >
>    > ERROR: modinfo: could not find module power_meter
>    >
>    > ERROR: modinfo: could not find module acpi_ipmi
>    >
>    > ERROR: modinfo: could not find module sb_edac
>    >
>    > ERROR: modinfo: could not find module lpc_ich
>    >
>    > ERROR: modinfo: could not find module mfd_core
>    >
>    > ERROR: modinfo: could not find module sd_mod
>    >
>    > ERROR: modinfo: could not find module crc_t10dif
>    >
>    > ERROR: modinfo: could not find module hpsa
>    >
>    > ERROR: modinfo: could not find module wmi
>    >
>    >                 as you know I cannot add some modules as they
>    > have conficts with Xenomay.
>    >
>    > 2)            For the scsi_module_wait error I found on internet
>    > the following links:
>    >
>    > a.
>    > [6]https://bugzilla.kernel.org/show_bug.cgi?id=3D60758
>    >
>    > b.
>    > [7]http://linuxaleph.blogspot.de/2014/06/kernel-panic- =20
>    scsiwaitscan-on-centos.html
>    >
>    > For this problem they have an explanation at least for kernel
>    > 3.13, an idea can be this kernel for PGD instead of 3.8. Anyway,
>    > they say that the problem is linked with
>    >
>    >                 the fact that the version introduces multi queue
>    > block i/o for virtio_blk, which in turn does not any more call
>    > blk_init_queue() but blk_mq_init_queue() instead.
>    >
>    > Dracut matches against symbol blk_init_queue but not yet against
>    > symbol blk_mq_init_queue. As you can see in the config file I
>    > added the virtio and also I performed the suggested procedure to
>    > fix the problem, i.e. :
>    >
>    > I listed the /boot directory and the I executed:
>    >
>    >
>    >
>    > echo 'add_drivers+=3D"virtio_blk" ' >
>    > /etc/dracut.conf.d/force-vitio_blk-to-ensure-boot.conf
>    >
>    > cp /boot/initramfs-3.8.13_xenomai-2.6.4.img
>    > /boot/initramfs-3.8.13_xenomai-2.6.4.img.bak
>    >
>    > dracut -f /boot/initramfs-3.8.13_xenomai-2.6.4.img
>    > 3.8.13_xenomai-2.6.4
>    >
>    >
>    >
>    > But the error is still there. I did the same also for
>    > initramfs-2.6.32-573.el6.x86_64.img, but the error is still
>    > there. By the way, I can confirm that the initramfs  is updated
>    > after each =20
>    make.
>    >
>    > 3)            The scsi_wait_scan driver is apparently an old
>    > driver that indeed is not present in the driver/scsi folder of
>    > the linux distribution we used during the xenomai patching. But
>    > it is present =20
>    in
>    >
>    > /lib/modules/2.6.32-573.el6.x86_64/kernel/drivers/scsi/.
>    >
>    > As during the make different drivers/scsi are installed (e.g.
>    > scsi_transport etc) I downloaded an older linux version and I
>    > copied the scsi_wait_scan.c in drivers/scsi
>    >
>    > cp
>    > scsi_wait_scan.c /usr/src/kernels/linux-3.8.13- =20
>    xenomai-2.6.4/drivers/scsi
>    >
>    > Unfortunately at the end the scsi_wait_scan.o was not present in
>    > /lib/modules/3.8.13_xenomai-2.6.4/kernel/drivers/scsi/ ,
>    > therefore it has not been installed. I think that if we manage
>    > to install this driver together with all the others we may solve
>    > the problem.
>    >
>    > Of course I also tried to cp scsi_wait_scan.o :
>    >
>    > cp /lib/modules/2.6.32-573.el6.x86_64/kernel/drivers/scsi/ =20
>    scsi_wait_scan.ko
>    > /lib/modules/3.8.13_xenomai-2.6.4/kernel/drivers/scsi/
>    >
>    > but it does not solve the problem. The strange thing is that I
>    > was not able to insert the scsi_wait_scan using the make
>    > menuconfig.
>    >
>    > I also tried the =E2=80=9Cinsmod scsi_wait_scan=E2=80=9D, but no suc=
cess.
>    >
>    >
>    >
>    > In conclusion I think that there are at least two possibility
>    > (on top of the VM installation using full machine power):
>    >
>    > 1)            To install properly the scsi_wait_scan as it is
>    > done for the other modules
>    >
>    > 2)            To try to patch and recompile the xenomai using a
>    > different linux core.
>    >
>    >
>    >
>    >
>    > 1)            I copied the scsi_wait_scan.c in
>    > linux-3.8.13-xenomai-2.6.4/drivers/scsi before performing the
>    > xenomai patching. Then I copiled the kernel, but the error is
>    > still there.
>    >
>    > 2)            As I copied the scsi_wait_scan.c from linux-3.4,
>    > I =20
>    tried
>    > directly to patch the linux-3.4, using the
>    > ipipe-core-3.4.6-x86-2.patch and ipipe-core-3.4.6-x86-4.patch,
>    > but I was not able to patch the xenomai, or, better, with
>    > ipipe-core-3.4.6-x86-2.patch it was not possible to patch
>    > xenomay, with ipipe-core-3.4.6-x86-4.patch it was possible to
>    > patch the xenomai but then I was not able to recompile the
>    > kernel.
>    >
>    >
>    >
>    >
>    >
>    > As explained one possible solution (in my opinion) is to add the
>    > scsi_wait_scan to the modules that are compiled and installed
>    > during the make. if done in the correct way, the:
>    >
>    >
>    >
>    > CC [M] drivers/scsi/scsi_wait_scan.o           should be shown
>    > after CC [M] drivers/scsi/scsi_transport_srp.o
>    >
>    > and
>    >
>    > INSTALL drivers/scsi/scsi_wait_scan.ko       should be shown
>    > after INSTALL drivers/scsi/scsi_transport_srp.ko
>    >
>    >
>    >
>    > during the kernel compilation.
>    >
>    >
>    >
>    > I don't know how it is possible to add scsi_wait_scan at the
>    > list of modules to be compiled. I tried to  modifiyng the
>    >
>    > make clean && make -j 24 && make modules -j 24 && make
>    > modules_install && make install but I was not able to add the
>    > scsi_wait_scan.
>    >
>    >
>    >
>    >
>    > Cpould you please give me some hint on how to solve the problem?
>    > Any suggestion will be very welcome.
>    > If you need additional information, please let me know
>    >
>    > Thanks a lot in advance.
>    >
>    > Michele
>    >
>    >
>    >
>    >   [image: Immagine incorporata 2]
>    >
>    > Michele
>    >
>    > [image: Immagine incorporata 1] =20
>=20
>      > -------------- next part --------------
>      > A non-text attachment was scrubbed...
>      > Name: PDG HW Purchase details.jpg
>      > Type: image/jpeg
>      > Size: 58022 bytes
>      > Desc: not available
>      > URL:
>      > <[8]http://xenomai.org/pipermail/xenomai/attachments/20160819/
>      81148731/attachment.jpg>
>      > -------------- next part -------------- A non-text attachment
>      > was scrubbed... Name: IMAG1932.jpg
>      > Type: image/jpeg
>      > Size: 2609075 bytes
>      > Desc: not available
>      > URL:
>      > <[9]http://xenomai.org/pipermail/xenomai/attachments/20160819/ =20
>      81148731/attachment-0001.jpg>
>      > -------------- next part
>      > -------------- ./build_install_xenomai_kernel_noquestions.sh:
>      > line 1: =EF=BB=BF#!/bin/bash: No such file or directory
>      > **************************************************
>      > * Greetings from TAS-Deutschland!                *
>      > **************************************************
>      > *This script will install the Xenomai version:   *
>      > * xenomai-2.6.4                               *
>      > * The kernel host version is: linux-3.8.13    *
>      > **************************************************
>      > ...
>      > mkdir: cannot create directory `usr/': File exists
>      > mkdir: cannot create directory `usr/src/': File exists
>      > mkdir: cannot create directory `usr/src/kernels/': File exists
>      >
>      > Next step: prepare the kernel
>      > patching file arch/x86/Kconfig
>      > patching file arch/x86/Kconfig.debug
>      > patching file arch/x86/include/asm/apic.h
>      > patching file arch/x86/include/asm/apicdef.h
>      > patching file arch/x86/include/asm/debugreg.h
>      > patching file arch/x86/include/asm/desc.h
>      > patching file arch/x86/include/asm/fpu-internal.h
>      > patching file arch/x86/include/asm/hw_irq.h
>      > patching file arch/x86/include/asm/i8259.h
>      > patching file arch/x86/include/asm/ipi.h
>      > patching file arch/x86/include/asm/ipipe.h
>      > patching file arch/x86/include/asm/ipipe_32.h
>      > patching file arch/x86/include/asm/ipipe_64.h
>      > patching file arch/x86/include/asm/ipipe_base.h
>      > patching file arch/x86/include/asm/irq_vectors.h
>      > patching file arch/x86/include/asm/irqflags.h
>      > patching file arch/x86/include/asm/mmu_context.h
>      > patching file arch/x86/include/asm/page_64_types.h
>      > patching file arch/x86/include/asm/processor.h
>      > patching file arch/x86/include/asm/special_insns.h
>      > patching file arch/x86/include/asm/switch_to.h
>      > patching file arch/x86/include/asm/thread_info.h
>      > patching file arch/x86/include/asm/traps.h
>      > patching file arch/x86/include/asm/tsc.h
>      > patching file arch/x86/kernel/Makefile
>      > patching file arch/x86/kernel/apic/apic.c
>      > patching file arch/x86/kernel/apic/apic_flat_64.c
>      > patching file arch/x86/kernel/apic/io_apic.c
>      > patching file arch/x86/kernel/apic/ipi.c
>      > patching file arch/x86/kernel/apic/x2apic_cluster.c
>      > patching file arch/x86/kernel/apic/x2apic_phys.c
>      > patching file arch/x86/kernel/cpu/common.c
>      > patching file arch/x86/kernel/cpu/mtrr/cyrix.c
>      > patching file arch/x86/kernel/cpu/mtrr/generic.c
>      > patching file arch/x86/kernel/dumpstack_32.c
>      > patching file arch/x86/kernel/dumpstack_64.c
>      > patching file arch/x86/kernel/entry_32.S
>      > patching file arch/x86/kernel/entry_64.S
>      > patching file arch/x86/kernel/hpet.c
>      > patching file arch/x86/kernel/i387.c
>      > patching file arch/x86/kernel/i8253.c
>      > patching file arch/x86/kernel/i8259.c
>      > patching file arch/x86/kernel/ipipe.c
>      > patching file arch/x86/kernel/irq.c
>      > patching file arch/x86/kernel/irqinit.c
>      > patching file arch/x86/kernel/kgdb.c
>      > patching file arch/x86/kernel/pcspeaker.c
>      > patching file arch/x86/kernel/process.c
>      > patching file arch/x86/kernel/process_32.c
>      > patching file arch/x86/kernel/process_64.c
>      > patching file arch/x86/kernel/ptrace.c
>      > patching file arch/x86/kernel/smp.c
>      > patching file arch/x86/kernel/smpboot.c
>      > patching file arch/x86/kernel/traps.c
>      > patching file arch/x86/kernel/tsc.c
>      > patching file arch/x86/kernel/vm86_32.c
>      > patching file arch/x86/kernel/vsyscall_64.c
>      > patching file arch/x86/kernel/xsave.c
>      > patching file arch/x86/kvm/svm.c
>      > patching file arch/x86/kvm/vmx.c
>      > patching file arch/x86/kvm/x86.c
>      > patching file arch/x86/lib/mmx_32.c
>      > patching file arch/x86/lib/thunk_64.S
>      > patching file arch/x86/lib/usercopy.c
>      > patching file arch/x86/mm/fault.c
>      > patching file arch/x86/mm/tlb.c
>      > patching file arch/x86/platform/uv/tlb_uv.c
>      > patching file drivers/clocksource/Makefile
>      > patching file drivers/clocksource/i8253.c
>      > patching file drivers/clocksource/ipipe_i486_tsc_emu.S
>      > patching file drivers/gpu/drm/i915/i915_gem.c
>      > patching file drivers/pci/htirq.c
>      > patching file drivers/cpuidle/Kconfig
>      > patching file drivers/tty/serial/8250/8250.c
>      > patching file fs/exec.c
>      > patching file fs/proc/array.c
>      > patching file include/asm-generic/atomic.h
>      > patching file include/asm-generic/bitops/atomic.h
>      > patching file include/asm-generic/cmpxchg-local.h
>      > patching file include/asm-generic/percpu.h
>      > patching file include/ipipe/setup.h
>      > patching file include/ipipe/thread_info.h
>      > patching file include/linux/clockchips.h
>      > patching file include/linux/clocksource.h
>      > patching file include/linux/ftrace.h
>      > patching file include/linux/hardirq.h
>      > patching file include/linux/i8253.h
>      > patching file include/linux/ipipe.h
>      > patching file include/linux/ipipe_base.h
>      > patching file include/linux/ipipe_compat.h
>      > patching file include/linux/ipipe_debug.h
>      > patching file include/linux/ipipe_domain.h
>      > patching file include/linux/ipipe_lock.h
>      > patching file include/linux/ipipe_tickdev.h
>      > patching file include/linux/ipipe_trace.h
>      > patching file include/linux/irq.h
>      > patching file include/linux/irqdesc.h
>      > patching file include/linux/irqnr.h
>      > patching file include/linux/kernel.h
>      > patching file include/linux/kvm_host.h
>      > patching file include/linux/preempt.h
>      > patching file include/linux/rwlock.h
>      > patching file include/linux/rwlock_api_smp.h
>      > patching file include/linux/sched.h
>      > patching file include/linux/spinlock.h
>      > patching file include/linux/spinlock_api_smp.h
>      > patching file include/linux/spinlock_up.h
>      > patching file include/uapi/asm-generic/mman-common.h
>      > patching file include/uapi/asm-generic/resource.h
>      > patching file include/uapi/linux/resource.h
>      > patching file init/Kconfig
>      > patching file init/main.c
>      > patching file kernel/Makefile
>      > patching file kernel/debug/debug_core.c
>      > patching file kernel/debug/gdbstub.c
>      > patching file kernel/exit.c
>      > patching file kernel/fork.c
>      > patching file kernel/ipipe/Kconfig
>      > patching file kernel/ipipe/Kconfig.debug
>      > patching file kernel/ipipe/Makefile
>      > patching file kernel/ipipe/compat.c
>      > patching file kernel/ipipe/core.c
>      > patching file kernel/ipipe/timer.c
>      > patching file kernel/ipipe/tracer.c
>      > patching file kernel/irq/chip.c
>      > patching file kernel/irq/generic-chip.c
>      > patching file kernel/irq/irqdesc.c
>      > patching file kernel/irq/manage.c
>      > patching file kernel/lockdep.c
>      > patching file kernel/panic.c
>      > patching file kernel/power/hibernate.c
>      > patching file kernel/printk.c
>      > patching file kernel/sched/clock.c
>      > patching file kernel/sched/core.c
>      > patching file kernel/signal.c
>      > patching file kernel/spinlock.c
>      > patching file kernel/time/clockevents.c
>      > patching file kernel/time/clocksource.c
>      > patching file kernel/time/tick-common.c
>      > patching file kernel/time/tick-sched.c
>      > patching file kernel/timer.c
>      > patching file kernel/trace/Kconfig
>      > patching file kernel/trace/ftrace.c
>      > patching file kernel/trace/trace.c
>      > patching file kernel/trace/trace_clock.c
>      > patching file kernel/trace/trace_functions.c
>      > patching file kernel/trace/trace_functions_graph.c
>      > patching file lib/Kconfig.debug
>      > patching file lib/atomic64.c
>      > patching file lib/bust_spinlocks.c
>      > patching file lib/ioremap.c
>      > patching file lib/smp_processor_id.c
>      > patching file mm/Kconfig
>      > patching file mm/memory.c
>      > patching file mm/mlock.c
>      > patching file mm/mmap.c
>      > patching file mm/mmu_context.c
>      > patching file mm/mprotect.c
>      > patching file mm/vmalloc.c
>      >
>      > Next step: move to /usr/src/kernel/
>      > mv: inter-device move failed:
>      > `./usr/src/kernels/linux-3.8.13-xenomai-2.6.4/' to
>      > `/usr/src/kernels/linux-3.8.13-xenomai-2.6.4'; unable to remove
>      > target: Directory not empty total 39916 drwxrwxr-x  31 root
>      > root 4096 Jul 27 12:01 arch drwxrwxr-x   3 root root     4096
>      > Jul 27 =20
>      11:59
>      > block -rw-rw-r--   1 root root    18693 May 11  2013 COPYING
>      > -rw-rw-r--   1 root root    95054 May 11  2013 CREDITS
>      > drwxrwxr-x =20
>       4
>      > root root    20480 Jul 27 12:01 crypto drwxrwxr-x  99 root root
>      > 12288 Jul 27 12:01 Documentation drwxrwxr-x 109 root root
>      > 4096 Jul 27 12:01 drivers -rw-r--r--   1 root root        0
>      > Jul 27 =20
>      12:00
>      > extra_certificates drwxrwxr-x  36 root root     4096 Jul 27
>      > 12:01 firmware drwxrwxr-x  72 root root    12288 Jul 27 12:01
>      > fs drwxrwxr-x  29 root root     4096 Jul 27 11:59 include
>      > drwxrwxr-x   2 root root     4096 Jul 27 12:01 init
>      > drwxrwxr-x   2 root root     4096 Jul 27 11:59 ipc
>      > -rw-rw-r--   1 root root     2536 May 11  2013 Kbuild
>      > -rw-rw-r--   1 root root      252 May 11  2013 Kconfig
>      > drwxrwxr-x  12 root root    12288 Jul 27 12:00 kernel
>      > drwxrwxr-x   9 root root    20480 Jul 27 12:01 lib
>      > -rw-rw-r--   1 root root   239609 May 11  2013 MAINTAINERS
>      > -rwxr--r--   1 root root    48040 Jul 27 11:59 Makefile
>      > drwxrwxr-x   2 root root    12288 Jul 27 11:59 mm
>      > -rw-r--r--   1 root root     5849 Jul 27 11:59 modules.builtin
>      > -rw-r--r--   1 root root    56319 Jul 27 12:01 modules.order
>      > -rw-r--r--   1 root root   710577 Jul 27 12:01 Module.symvers
>      > drwxrwxr-x  55 root root     4096 Jul 27 12:00 net
>      > -rw-rw-r--   1 root root    18736 May 11  2013 README
>      > -rw-rw-r--   1 root root     3371 May 11  2013 REPORTING-BUGS
>      > drwxrwxr-x  13 root root     4096 May 11  2013 samples
>      > drwxrwxr-x  13 root root     4096 Jul 27 12:01 scripts
>      > drwxrwxr-x   9 root root     4096 Jul 27 11:59 security
>      > -rw-r--r--   1 root root     3272 Jul 27 12:00 signing_key.priv
>      > -rw-r--r--   1 root root     1446 Jul 27 12:00 signing_key.x509
>      > drwxrwxr-x  22 root root     4096 Jul 27 12:01 sound
>      > -rw-r--r--   1 root root  2617524 Jul 27 12:01 System.map
>      > drwxrwxr-x  15 root root     4096 May 11  2013 tools
>      > drwxrwxr-x   3 root root     4096 Jul 27 12:01 usr
>      > drwxrwxr-x   3 root root     4096 May 11  2013 virt
>      > -rwxr-xr-x   1 root root 17905357 Jul 27 12:01 vmlinux
>      > -rw-r--r--   1 root root 23146092 Jul 27 12:01 vmlinux.o
>      > -rw-r--r--   1 root root      372 Jul 27 12:00 x509.genkey
>      >
>      > Next step: Build and install the kernel with xenomai-2.6.4.
>      >
>      >   CLEAN   .
>      >   CLEAN   arch/x86/kernel/cpu
>      >   CLEAN   arch/x86/kernel
>      >   CLEAN   arch/x86/realmode/rm
>      >   CLEAN   arch/x86/vdso
>      >   CLEAN   arch/x86/lib
>      >   CLEAN   crypto/asymmetric_keys
>      >   CLEAN   drivers/gpu/drm/radeon
>      >   CLEAN   drivers/scsi/aic7xxx
>      >   CLEAN   drivers/tty/vt
>      >   CLEAN   drivers/video/logo
>      >   CLEAN   firmware
>      >   CLEAN   kernel
>      >   CLEAN   lib/raid6
>      >   CLEAN   lib
>      >   CLEAN   security/selinux
>      >   CLEAN   usr
>      >   CLEAN   Documentation/accounting
>      >   CLEAN   Documentation/auxdisplay
>      >   CLEAN   Documentation/connector
>      >   CLEAN   Documentation/filesystems
>      >   CLEAN   Documentation/ia64
>      >   CLEAN   Documentation/laptops
>      >   CLEAN   Documentation/misc-devices/mei
>      >   CLEAN   Documentation/networking/timestamping
>      >   CLEAN   Documentation/networking
>      >   CLEAN   Documentation/pcmcia
>      >   CLEAN   Documentation/spi
>      >   CLEAN   Documentation/timers
>      >   CLEAN   Documentation/watchdog/src
>      >   CLEAN   arch/x86/boot/compressed
>      >   CLEAN   arch/x86/boot
>      >   CLEAN   arch/x86/tools
>      >   CLEAN   .tmp_versions
>      > make[1]: Nothing to be done for `all'.
>      >   HOSTCC  scripts/basic/fixdep
>      >   CHK     include/generated/uapi/linux/version.h
>      >   CHK     include/generated/utsrelease.h
>      >   HOSTCC  arch/x86/tools/relocs
>      >   HOSTCC  scripts/kallsyms
>      >   HOSTCC  scripts/pnmtologo
>      >   HOSTCC  scripts/conmakehash
>      >   HOSTCC  scripts/recordmcount
>      >   HOSTCC  scripts/sortextable
>      >   HOSTCC  scripts/asn1_compiler
>      >   HOSTCC  scripts/mod/mk_elfconfig
>      >   CC      scripts/mod/empty.o
>      >   HOSTCC  scripts/genksyms/genksyms.o
>      >   HOSTCC  scripts/genksyms/lex.lex.o
>      >   HOSTCC  scripts/genksyms/parse.tab.o
>      >   HOSTCC  scripts/selinux/genheaders/genheaders
>      >   HOSTCC  scripts/selinux/mdp/mdp
>      >   MKELF   scripts/mod/elfconfig.h
>      >   HOSTCC  scripts/mod/file2alias.o
>      >   HOSTCC  scripts/mod/modpost.o
>      >   HOSTCC  scripts/mod/sumversion.o
>      >   CC      kernel/bounds.s
>      >   GEN     include/generated/bounds.h
>      >   CC      arch/x86/kernel/asm-offsets.s
>      >   HOSTLD  scripts/genksyms/genksyms
>      >   GEN     include/generated/asm-offsets.h
>      >   CALL    scripts/checksyscalls.sh
>      >   HOSTLD  scripts/mod/modpost
>      >   CHK     include/generated/compile.h
>      >   CC      init/main.o
>      >   CC      init/do_mounts.o
>      >   CC      init/do_mounts_rd.o
>      >   CC      init/do_mounts_initrd.o
>      >   CC      init/do_mounts_md.o
>      >   CC      init/initramfs.o
>      >   CC      init/calibrate.o
>      >   CC      init/init_task.o
>      >   CC      init/version.o
>      >   HOSTCC  usr/gen_init_cpio
>      >   AS      arch/x86/ia32/ia32entry.o
>      >   LD      arch/x86/crypto/built-in.o
>      >   CC      arch/x86/kernel/process_64.o
>      >   LD      arch/x86/net/built-in.o
>      >   CC      arch/x86/kernel/signal.o
>      >   AS      arch/x86/kernel/entry_64.o
>      >   CC      arch/x86/ia32/sys_ia32.o
>      >   LD      arch/x86/kvm/built-in.o
>      >   CC      arch/x86/realmode/init.o
>      >   CC [M]  arch/x86/kvm/svm.o
>      >   CC [M]  arch/x86/crypto/ablk_helper.o
>      >   LD      arch/x86/platform/ce4100/built-in.o
>      >   AS [M]  arch/x86/crypto/aes-x86_64-asm_64.o
>      >   CC      arch/x86/mm/init.o
>      >   CC      arch/x86/platform/efi/efi.o
>      >   CC      arch/x86/vdso/vma.o
>      >   CC      kernel/fork.o
>      >   LDS     arch/x86/vdso/vdso.lds
>      >   CC      arch/x86/platform/efi/efi_64.o
>      >   AS      arch/x86/platform/efi/efi_stub_64.o
>      >   CC      arch/x86/ia32/ia32_signal.o
>      >   CC      arch/x86/ia32/nosyscall.o
>      >   AS      arch/x86/vdso/vdso-note.o
>      >   AS      arch/x86/realmode/rm/header.o
>      >   AS      arch/x86/realmode/rm/trampoline_64.o
>      >   AS      arch/x86/realmode/rm/stack.o
>      >   LD      arch/x86/platform/geode/built-in.o
>      >   CC [M]  arch/x86/kvm/vmx.o
>      >   CC      arch/x86/vdso/vclock_gettime.o
>      >   AS      arch/x86/realmode/rm/reboot.o
>      >   GEN     usr/initramfs_data.cpio
>      >   AS      arch/x86/realmode/rm/wakeup_asm.o
>      >   AS      usr/initramfs_data.o
>      >   CC [M]  arch/x86/kvm/../../../virt/kvm/kvm_main.o
>      >   CC      arch/x86/realmode/rm/wakemain.o
>      >   LD      usr/built-in.o
>      >   CC [M]  arch/x86/kvm/../../../virt/kvm/ioapic.o
>      >   CC      mm/filemap.o
>      >   CC [M]  arch/x86/kvm/../../../virt/kvm/coalesced_mmio.o
>      >   CC      mm/mempool.o
>      >   CC      fs/open.o
>      >   CC      fs/read_write.o
>      >   CC      arch/x86/realmode/rm/video-mode.o
>      >   AS      arch/x86/realmode/rm/copy.o
>      >   CC      kernel/exec_domain.o
>      >   CC      kernel/panic.o
>      >   CC      kernel/printk.o
>      >   CC      arch/x86/mm/init_64.o
>      >   CC      arch/x86/mm/fault.o
>      >   AS      arch/x86/realmode/rm/bioscall.o
>      >   CC      arch/x86/realmode/rm/regs.o
>      >   CC      arch/x86/realmode/rm/video-vga.o
>      >   CC      arch/x86/vdso/vgetcpu.o
>      >   CC [M]  arch/x86/crypto/aes_glue.o
>      >   LDS     arch/x86/vdso/vdso32/vdso32.lds
>      >   CC      arch/x86/ia32/syscall_ia32.o
>      >   AS [M]  arch/x86/crypto/aesni-intel_asm.o
>      >   CC      arch/x86/ia32/ipc32.o
>      >   LD      init/mounts.o
>      >   LD      init/built-in.o
>      >   CC      arch/x86/realmode/rm/video-vesa.o
>      >   CC      arch/x86/realmode/rm/video-bios.o
>      >   CC [M]  arch/x86/kvm/../../../virt/kvm/irq_comm.o
>      >   AS      arch/x86/vdso/vdso32/note.o
>      >   AS      arch/x86/vdso/vdso32/int80.o
>      >   CC      arch/x86/kernel/traps.o
>      >   AS      arch/x86/vdso/vdso32/syscall.o
>      >   LD      arch/x86/platform/efi/built-in.o
>      >   CC      arch/x86/kernel/irq.o
>      >   CC      arch/x86/kernel/irq_64.o
>      >   PASYMS  arch/x86/realmode/rm/pasyms.h
>      >   CC      arch/x86/kernel/dumpstack_64.o
>      >   AS      arch/x86/vdso/vdso32/sysenter.o
>      >   LDS     arch/x86/realmode/rm/realmode.lds
>      >   LD      arch/x86/platform/iris/built-in.o
>      >   LD      arch/x86/realmode/rm/realmode.elf
>      >   LD      arch/x86/platform/mrst/built-in.o
>      >   CC      arch/x86/vdso/vdso32-setup.o
>      >   RELOCS  arch/x86/realmode/rm/realmode.relocs
>      >   CC [M]  arch/x86/crypto/aesni-intel_glue.o
>      >   OBJCOPY arch/x86/realmode/rm/realmode.bin
>      >   LD      arch/x86/platform/olpc/built-in.o
>      >   AS      arch/x86/realmode/rmpiggy.o
>      >   LD      arch/x86/platform/scx200/built-in.o
>      >   LD      arch/x86/realmode/built-in.o
>      >   CC [M]  arch/x86/kvm/../../../virt/kvm/eventfd.o
>      >   CC      arch/x86/platform/sfi/sfi.o
>      >   LD      arch/x86/platform/uv/built-in.o
>      >   CC      arch/x86/kernel/time.o
>      >   CC [M]  arch/x86/kvm/../../../virt/kvm/assigned-dev.o
>      >   LD      arch/x86/platform/visws/built-in.o
>      >   CC [M]  arch/x86/kvm/../../../virt/kvm/iommu.o
>      >   CC      arch/x86/ia32/audit.o
>      >   LD      arch/x86/ia32/built-in.o
>      >   CC [M]  arch/x86/kvm/../../../virt/kvm/async_pf.o
>      >   CC [M]  arch/x86/crypto/fpu.o
>      >   CC [M]  arch/x86/crypto/crc32c-intel_glue.o
>      >   AS [M]  arch/x86/crypto/crc32c-pcl-intel-asm_64.o
>      >   CC [M]  arch/x86/kvm/x86.o
>      >   CC [M]  arch/x86/kvm/mmu.o
>      >   CC      arch/x86/mm/ioremap.o
>      >   VDSO    arch/x86/vdso/vdso.so.dbg
>      >   CC [M]  arch/x86/kvm/emulate.o
>      >   CC      arch/x86/mm/extable.o
>      >   CC      mm/oom_kill.o
>      >   LD      arch/x86/platform/sfi/built-in.o
>      >   LD      arch/x86/platform/built-in.o
>      >   CC [M]  arch/x86/kvm/i8259.o
>      >   CC      ipc/compat.o
>      >   CC [M]  arch/x86/kvm/irq.o
>      >   VDSO    arch/x86/vdso/vdso32-int80.so.dbg
>      >   CC      fs/file_table.o
>      >   CC      fs/super.o
>      >   CC      ipc/util.o
>      >   CC      fs/char_dev.o
>      >   CC      ipc/msgutil.o
>      >   VDSO    arch/x86/vdso/vdso32-syscall.so.dbg
>      >   CC      ipc/msg.o
>      >   CC      fs/stat.o
>      >   CC      arch/x86/kernel/ioport.o
>      >   AS [M]  arch/x86/crypto/ghash-clmulni-intel_asm.o
>      >   VDSO    arch/x86/vdso/vdso32-sysenter.so.dbg
>      >   CC [M]  arch/x86/crypto/ghash-clmulni-intel_glue.o
>      >   VDSOSYM arch/x86/vdso/vdso-syms.lds
>      >   CC [M]  arch/x86/kvm/lapic.o
>      >   VDSOSYM arch/x86/vdso/vdso32-int80-syms.lds
>      >   VDSOSYM arch/x86/vdso/vdso32-syscall-syms.lds
>      >   VDSOSYM arch/x86/vdso/vdso32-sysenter-syms.lds
>      >   OBJCOPY arch/x86/vdso/vdso.so
>      >   OBJCOPY arch/x86/vdso/vdso32-int80.so
>      >   OBJCOPY arch/x86/vdso/vdso32-syscall.so
>      >   OBJCOPY arch/x86/vdso/vdso32-sysenter.so
>      >   VDSOSYM arch/x86/vdso/vdso32-syms.lds
>      >   AS      arch/x86/vdso/vdso.o
>      >   AS      arch/x86/vdso/vdso32.o
>      >   CC      kernel/cpu.o
>      >   LD      arch/x86/vdso/built-in.o
>      >   CC [M]  arch/x86/kvm/i8254.o
>      >   CC [M]  arch/x86/kvm/cpuid.o
>      >   CC      kernel/exit.o
>      >   CC      ipc/sem.o
>      >   CC      kernel/itimer.o
>      >   CC      arch/x86/mm/pageattr.o
>      >   CC      arch/x86/mm/mmap.o
>      >   TIMEC   kernel/timeconst.h
>      >   CC      arch/x86/kernel/ldt.o
>      >   CC      kernel/softirq.o
>      >   CC      mm/fadvise.o
>      >   CC      mm/maccess.o
>      >   CC      arch/x86/kernel/dumpstack.o
>      >   CC      kernel/resource.o
>      > arch/x86/kvm/mmu.c: In function =E2=80=98kvm_test_age_rmapp=E2=80=
=99:
>      > arch/x86/kvm/mmu.c:1386: warning: =E2=80=98iter.desc=E2=80=99 may =
be used
>      > uninitialized in this function AS [M]
>      > arch/x86/crypto/salsa20-x86_64-asm_64.o CC [M]
>      > arch/x86/crypto/salsa20_glue.o AS [M]
>      > arch/x86/crypto/twofish-x86_64-asm_64.o CC =20
>      arch/x86/kernel/nmi.o
>      >   CC      ipc/shm.o
>      >   CC      mm/page_alloc.o
>      >   CC      mm/page-writeback.o
>      >   CC      arch/x86/kernel/setup.o
>      >   CC      ipc/ipcns_notifier.o
>      >   CC      ipc/syscall.o
>      >   CC      fs/exec.o
>      >   CC      arch/x86/kernel/x86_init.o
>      >   CC      arch/x86/kernel/i8259.o
>      >   CC      arch/x86/kernel/irqinit.o
>      >   CC [M]  arch/x86/crypto/twofish_glue.o
>      >   CC      arch/x86/kernel/jump_label.o
>      >   CC      arch/x86/kernel/irq_work.o
>      >   CC      ipc/ipc_sysctl.o
>      >   CC      arch/x86/kernel/probe_roms.o
>      >   CC      arch/x86/kernel/sys_x86_64.o
>      >   CC      fs/pipe.o
>      >   CC      fs/namei.o
>      >   CC      mm/readahead.o
>      >   CC      mm/swap.o
>      >   CC [M]  arch/x86/kvm/pmu.o
>      >   CC      arch/x86/mm/pat.o
>      >   LD [M]  arch/x86/crypto/aes-x86_64.o
>      >   LD [M]  arch/x86/crypto/twofish-x86_64.o
>      >   LD [M]  arch/x86/crypto/salsa20-x86_64.o
>      >   LD [M]  arch/x86/crypto/aesni-intel.o
>      >   CC      ipc/mqueue.o
>      >   CC      arch/x86/kernel/x8664_ksyms_64.o
>      >   LD [M]  arch/x86/crypto/ghash-clmulni-intel.o
>      >   LD [M]  arch/x86/crypto/crc32c-intel.o
>      >   CC      arch/x86/kernel/syscall_64.o
>      >   CC      kernel/sysctl.o
>      >   CC      arch/x86/mm/pgtable.o
>      >   CC      kernel/sysctl_binary.o
>      >   CC      arch/x86/mm/physaddr.o
>      >   CC      arch/x86/mm/gup.o
>      >   CC      arch/x86/mm/setup_nx.o
>      >   CC      arch/x86/mm/pat_rbtree.o
>      >   CC      arch/x86/mm/tlb.o
>      >   CC      mm/truncate.o
>      >   CC      mm/vmscan.o
>      >   CC      mm/shmem.o
>      >   CC      mm/util.o
>      >   CC      arch/x86/kernel/vsyscall_64.o
>      >   AS      arch/x86/kernel/vsyscall_emu_64.o
>      >   CC      mm/mmzone.o
>      >   CC      fs/fcntl.o
>      >   CC      mm/vmstat.o
>      >   CC      kernel/capability.o
>      >   CC      mm/backing-dev.o
>      >   CC      security/integrity/iint.o
>      >   CC      crypto/api.o
>      >   CC      crypto/cipher.o
>      >   CC      crypto/compress.o
>      >   CC      crypto/algapi.o
>      >   CC      ipc/compat_mq.o
>      >   CC      arch/x86/mm/hugetlbpage.o
>      >   CC      security/integrity/ima/ima_fs.o
>      >   CC      security/integrity/ima/ima_queue.o
>      >   CC      security/integrity/ima/ima_init.o
>      >   CC      arch/x86/kernel/bootflag.o
>      >   LD      security/integrity/integrity.o
>      >   CC      arch/x86/mm/numa.o
>      >   CC      arch/x86/mm/numa_64.o
>      >   CC      arch/x86/kernel/e820.o
>      >   CC      arch/x86/kernel/pci-dma.o
>      >   CC      arch/x86/kernel/quirks.o
>      >   CC      arch/x86/kernel/topology.o
>      >   CC      arch/x86/mm/amdtopology.o
>      >   CC      ipc/namespace.o
>      >   CC      ipc/mq_sysctl.o
>      >   CC      arch/x86/kernel/kdebugfs.o
>      >   CC      mm/mm_init.o
>      >   CC      mm/mmu_context.o
>      >   CC      security/integrity/ima/ima_main.o
>      >   CC      kernel/ptrace.o
>      >   CC      security/integrity/ima/ima_crypto.o
>      >   CC      security/integrity/ima/ima_api.o
>      >   CC      security/integrity/ima/ima_policy.o
>      >   CC      kernel/timer.o
>      >   CC      kernel/user.o
>      >   CC      security/integrity/ima/ima_audit.o
>      >   LD      ipc/built-in.o
>      >   CC      kernel/signal.o
>      >   CC      kernel/sys.o
>      >   CC      kernel/kmod.o
>      >   CC      kernel/workqueue.o
>      >   CC      block/elevator.o
>      >   CC      block/blk-core.o
>      >   CC      block/blk-tag.o
>      >   CC      block/blk-sysfs.o
>      >   CC      block/blk-flush.o
>      >   CC      block/blk-settings.o
>      >   CC      drivers/acpi/tables.o
>      >   CC      arch/x86/mm/srat.o
>      >   LD      sound/built-in.o
>      >   CC      fs/ioctl.o
>      >   CC [M]  sound/sound_core.o
>      >   CC      crypto/scatterwalk.o
>      >   LD      security/integrity/ima/ima.o
>      >   CC      crypto/proc.o
>      >   LD      security/integrity/ima/built-in.o
>      >   LD      security/integrity/built-in.o
>      >   CC      crypto/ablkcipher.o
>      >   CC      security/keys/gc.o
>      >   CC      security/keys/key.o
>      >   CC      security/keys/keyring.o
>      >   CC      arch/x86/kernel/alternative.o
>      >   LD      arch/x86/mm/built-in.o
>      >   CC      arch/x86/kernel/i8253.o
>      >   CC      security/keys/keyctl.o
>      >   CC      drivers/acpi/blacklist.o
>      >   CC      drivers/acpi/osl.o
>      >   CC      arch/x86/kernel/pci-nommu.o
>      >   CC      arch/x86/kernel/hw_breakpoint.o
>      >   CC      security/keys/permission.o
>      >   CC      mm/percpu.o
>      >   CC [M]  sound/ac97_bus.o
>      >   LD [M]  arch/x86/kvm/kvm.o
>      >   LD [M]  arch/x86/kvm/kvm-intel.o
>      >   LD [M]  arch/x86/kvm/kvm-amd.o
>      >   CC      drivers/acpi/utils.o
>      >   CC      kernel/pid.o
>      >   CC      kernel/task_work.o
>      >   CC      kernel/rcupdate.o
>      >   LD      drivers/amba/built-in.o
>      >   CC      kernel/extable.o
>      >   CC      block/blk-ioc.o
>      >   CC      block/blk-map.o
>      >   CC      kernel/params.o
>      >   CC      kernel/posix-timers.o
>      >   LD      sound/arm/built-in.o
>      >   CC      block/blk-exec.o
>      >   CC      block/blk-merge.o
>      >   CC      fs/readdir.o
>      >   CC      fs/select.o
>      >   CC      block/blk-softirq.o
>      >   CC      drivers/acpi/reboot.o
>      >   CC      drivers/acpi/nvs.o
>      >   CC      crypto/blkcipher.o
>      >   CC      drivers/acpi/wakeup.o
>      >   CC      security/keys/process_keys.o
>      >   LD      sound/atmel/built-in.o
>      >   CC      security/keys/request_key.o
>      >   LD      sound/core/oss/built-in.o
>      >   CC      arch/x86/kernel/tsc.o
>      >   CC [M]  sound/core/oss/mixer_oss.o
>      >   CC [M]  sound/core/oss/pcm_oss.o
>      >   CC      security/keys/request_key_auth.o
>      >   CC      security/keys/user_defined.o
>      >   CC      security/keys/compat.o
>      >   CC      drivers/acpi/sleep.o
>      >   CC      security/keys/proc.o
>      >   CC      arch/x86/kernel/io_delay.o
>      >   CC      arch/x86/kernel/rtc.o
>      >   LD      sound/core/seq/built-in.o
>      >   CC [M]  sound/core/seq/seq_device.o
>      >   CC [M]  sound/core/seq/seq_dummy.o
>      >   CC [M]  sound/core/seq/seq_midi_emul.o
>      >   CC      kernel/kthread.o
>      >   CC      kernel/wait.o
>      >   CC      kernel/kfifo.o
>      >   CC      kernel/sys_ni.o
>      >   CC      kernel/posix-cpu-timers.o
>      >   CC      mm/slab_common.o
>      >   CC [M]  sound/core/oss/pcm_plugin.o
>      >   CC      mm/compaction.o
>      >   CC      mm/balloon_compaction.o
>      >   CC      mm/interval_tree.o
>      >   CC      block/blk-timeout.o
>      >   CC      block/blk-iopoll.o
>      >   CC      block/blk-lib.o
>      >   CC      security/keys/sysctl.o
>      >   CC      fs/fifo.o
>      >   CC      crypto/ahash.o
>      >   CC      fs/dcache.o
>      >   CC      fs/inode.o
>      >   LD      security/keys/built-in.o
>      >   CC      arch/x86/kernel/pci-iommu_table.o
>      >   GEN     security/selinux/flask.h security/selinux/av_ =20
>      permissions.h
>      >   CC      drivers/acpi/device_pm.o
>      >   CC      security/selinux/avc.o
>      >   CC      drivers/acpi/proc.o
>      >   CC      drivers/acpi/bus.o
>      >   CC      security/selinux/hooks.o
>      >   CC      crypto/shash.o
>      >   CC      security/selinux/selinuxfs.o
>      >   CC [M]  sound/core/seq/seq_midi_event.o
>      >   CC      security/selinux/netlink.o
>      >   CC      kernel/mutex.o
>      >   CC [M]  sound/core/hrtimer.o
>      >   CC [M]  sound/core/hwdep.o
>      >   CC [M]  sound/core/memalloc.o
>      >   CC      security/selinux/nlmsgtab.o
>      >   CC      arch/x86/kernel/resource.o
>      >   CC      arch/x86/kernel/process.o
>      >   CC      arch/x86/kernel/i387.o
>      >   CC      security/selinux/netif.o
>      >   CC      security/selinux/netnode.o
>      >   CC      block/ioctl.o
>      >   CC      security/selinux/netport.o
>      >   CC      arch/x86/kernel/xsave.o
>      >   CC      mm/fremap.o
>      >   CC      mm/highmem.o
>      >   CC [M]  sound/core/oss/io.o
>      >   CC [M]  sound/core/oss/copy.o
>      >   CC      kernel/hrtimer.o
>      >   CC      kernel/rwsem.o
>      >   CC [M]  sound/core/seq/seq_midi.o
>      >   CC [M]  sound/core/seq/seq_virmidi.o
>      >   CC [M]  sound/core/seq/seq.o
>      >   CC [M]  sound/core/seq/seq_lock.o
>      >   CC [M]  sound/core/seq/seq_clientmgr.o
>      >   CC      drivers/acpi/glue.o
>      >   CC      drivers/acpi/scan.o
>      >   CC [M]  sound/core/seq/seq_memory.o
>      >   CC [M]  sound/core/seq/seq_queue.o
>      >   CC [M]  sound/core/oss/linear.o
>      >   CC [M]  sound/core/seq/seq_fifo.o
>      >   CC [M]  sound/core/seq/seq_prioq.o
>      >   CC      crypto/algboss.o
>      >   CC [M]  sound/core/seq/seq_timer.o
>      >   CC [M]  sound/core/seq/seq_system.o
>      >   CC      security/selinux/exports.o
>      >   CC      mm/madvise.o
>      >   CC      security/selinux/ss/ebitmap.o
>      >   CC      block/genhd.o
>      >   CC      block/scsi_ioctl.o
>      >   CC      block/partition-generic.o
>      >   CC      block/partitions/check.o
>      >   CC      block/partitions/amiga.o
>      >   CC      block/partitions/mac.o
>      >   CC      block/bsg.o
>      >   CC      block/partitions/msdos.o
>      >   CC      arch/x86/kernel/ptrace.o
>      >   CC      arch/x86/kernel/tls.o
>      >   CC      block/partitions/osf.o
>      >   CC [M]  sound/core/oss/mulaw.o
>      >   CC      block/partitions/sgi.o
>      >   CC      fs/attr.o
>      >   CC      fs/bad_inode.o
>      >   CC      fs/file.o
>      >   CC      fs/filesystems.o
>      >   CC      mm/memory.o
>      >   CC      mm/mincore.o
>      >   CC      crypto/testmgr.o
>      >   CC      crypto/crypto_wq.o
>      >   CC      crypto/aead.o
>      >   CC      crypto/chainiv.o
>      >   CC      security/commoncap.o
>      >   CC      drivers/acpi/resource.o
>      >   CC      security/min_addr.o
>      >   CC      kernel/nsproxy.o
>      >   CC      kernel/srcu.o
>      >   CC      security/security.o
>      >   CC [M]  sound/core/oss/route.o
>      >   CC      security/capability.o
>      >   LD      sound/drivers/built-in.o
>      >   CC [M]  sound/drivers/aloop.o
>      >   CC [M]  sound/drivers/dummy.o
>      >   CC      block/partitions/sun.o
>      >   CC      block/partitions/efi.o
>      >   CC      block/partitions/karma.o
>      >   CC      security/inode.o
>      >   CC [M]  sound/drivers/mtpav.o
>      >   CC [M]  sound/drivers/virmidi.o
>      >   CC      crypto/eseqiv.o
>      >   LD      crypto/crypto_hash.o
>      >   CC [M]  sound/core/oss/rate.o
>      >   CC [M]  sound/core/seq/seq_ports.o
>      >   CC      kernel/semaphore.o
>      >   CC [M]  sound/core/seq/seq_info.o
>      >   LD      sound/core/seq/oss/built-in.o
>      >   CC [M]  sound/core/seq/oss/seq_oss.o
>      >   CC      fs/namespace.o
>      >   CC      drivers/acpi/processor_core.o
>      >   CC      fs/seq_file.o
>      >   CC      fs/xattr.o
>      >   CC      arch/x86/kernel/step.o
>      >   CC      security/selinux/ss/hashtab.o
>      >   CC      security/selinux/ss/symtab.o
>      >   CC      security/selinux/ss/sidtab.o
>      >   CC      mm/mlock.o
>      >   CC      security/selinux/ss/avtab.o
>      >   CC      security/selinux/ss/policydb.o
>      >   CC      kernel/notifier.o
>      >   LD      block/partitions/built-in.o
>      >   CC      block/bsg-lib.o
>      >   CC      kernel/ksysfs.o
>      >   CC [M]  sound/core/seq/oss/seq_oss_init.o
>      >   CC      kernel/cred.o
>      >   CC      crypto/pcompress.o
>      >   LD      firmware/built-in.o
>      >   LD      crypto/cryptomgr.o
>      >   LD [M]  sound/core/oss/snd-mixer-oss.o
>      >   CC      kernel/async.o
>      >   CC      kernel/range.o
>      >   LD [M]  sound/core/oss/snd-pcm-oss.o
>      >   CC      kernel/groups.o
>      >   CC      drivers/ata/libata-core.o
>      >   CC      block/blk-cgroup.o
>      >   CC      arch/x86/kernel/i8237.o
>      >   LD      sound/drivers/mpu401/built-in.o
>      >   CC [M]  sound/drivers/mpu401/mpu401_uart.o
>      >   CC [M]  sound/drivers/mpu401/mpu401.o
>      >   CC      drivers/acpi/ec.o
>      >   LD [M]  sound/core/seq/snd-seq.o
>      >   CC [M]  sound/core/seq/oss/seq_oss_timer.o
>      >   CC      arch/x86/kernel/stacktrace.o
>      >   CC      arch/x86/kernel/acpi/boot.o
>      >   CC      arch/x86/kernel/acpi/sleep.o
>      >   AS      arch/x86/kernel/acpi/wakeup_64.o
>      >   CC [M]  sound/core/seq/oss/seq_oss_ioctl.o
>      >   CC [M]  sound/core/sgbuf.o
>      >   CC      arch/x86/kernel/apic/apic.o
>      >   CC      arch/x86/kernel/apic/apic_noop.o
>      >   CC      arch/x86/kernel/apic/ipi.o
>      >   CC      arch/x86/kernel/apic/hw_nmi.o
>      >   CC [M]  sound/core/pcm.o
>      >   CC [M]  sound/core/pcm_native.o
>      >   LD      sound/drivers/opl3/built-in.o
>      >   CC [M]  sound/drivers/opl3/opl3_lib.o
>      >   LD      sound/drivers/opl4/built-in.o
>      >   CC      crypto/hmac.o
>      >   LD      drivers/atm/built-in.o
>      >   CC [M]  drivers/atm/atmtcp.o
>      >   CC      arch/x86/kernel/reboot.o
>      >   LD [M]  sound/drivers/mpu401/snd-mpu401-uart.o
>      >   CC      mm/mmap.o
>      >   LD [M]  sound/drivers/mpu401/snd-mpu401.o
>      >   CC      arch/x86/kernel/cpu/intel_cacheinfo.o
>      >   CC      arch/x86/kernel/cpu/scattered.o
>      >   CC      arch/x86/kernel/cpu/topology.o
>      >   CC      drivers/ata/libata-scsi.o
>      >   CC [M]  sound/core/seq/oss/seq_oss_event.o
>      >   CC [M]  sound/core/seq/oss/seq_oss_rw.o
>      >   CC      drivers/ata/libata-eh.o
>      >   CC      drivers/ata/libata-transport.o
>      >   CC      block/blk-throttle.o
>      >   CC      kernel/lglock.o
>      >   CC      block/noop-iosched.o
>      >   CC      security/lsm_audit.o
>      >   CC [M]  sound/drivers/opl3/opl3_synth.o
>      >   CC      drivers/acpi/dock.o
>      >   CC      fs/libfs.o
>      >   CC      crypto/md5.o
>      >   CC      crypto/sha1_generic.o
>      >   CC [M]  sound/core/seq/oss/seq_oss_synth.o
>      >   LD      arch/x86/kernel/acpi/built-in.o
>      >   CC [M]  sound/core/seq/oss/seq_oss_midi.o
>      >   CC      crypto/sha256_generic.o
>      >   CC      kernel/smpboot.o
>      >   CC      kernel/events/core.o
>      >   CC      kernel/events/ring_buffer.o
>      >   CC      arch/x86/kernel/cpu/proc.o
>      >   CC      kernel/events/callchain.o
>      >   CC      kernel/events/hw_breakpoint.o
>      >   CC [M]  sound/drivers/opl3/opl3_seq.o
>      >   CC      security/selinux/ss/services.o
>      >   CC      fs/fs-writeback.o
>      >   CC      fs/pnode.o
>      >   MKCAP   arch/x86/kernel/cpu/capflags.c
>      >   CC      arch/x86/kernel/cpu/powerflags.o
>      >   CC      arch/x86/kernel/cpu/common.o
>      >   LD      sound/drivers/pcsp/built-in.o
>      >   CC [M]  sound/drivers/pcsp/pcsp.o
>      >   CC      block/deadline-iosched.o
>      >   CC [M]  sound/drivers/pcsp/pcsp_lib.o
>      >   CC [M]  sound/drivers/pcsp/pcsp_mixer.o
>      >   CC      arch/x86/kernel/apic/io_apic.o
>      >   CC      arch/x86/kernel/apic/apic_flat_64.o
>      >   CC [M]  sound/drivers/pcsp/pcsp_input.o
>      >   CC [M]  sound/core/seq/oss/seq_oss_readq.o
>      >   LD      drivers/auxdisplay/built-in.o
>      >   CC [M]  drivers/auxdisplay/ks0108.o
>      >   CC      drivers/acpi/pci_root.o
>      >   CC [M]  sound/drivers/opl3/opl3_midi.o
>      >   CC      crypto/aes_generic.o
>      >   CC [M]  sound/drivers/opl3/opl3_drums.o
>      >   CC      crypto/crc32c.o
>      >   CC [M]  sound/drivers/opl3/opl3_oss.o
>      >   CC [M]  sound/core/seq/oss/seq_oss_writeq.o
>      >   CC      mm/mprotect.o
>      >   LD      sound/firewire/built-in.o
>      >   LD [M]  sound/drivers/pcsp/snd-pcsp.o
>      >   CC      security/selinux/ss/conditional.o
>      >   LD      sound/i2c/built-in.o
>      >   CC      security/selinux/ss/mls.o
>      >   CC [M]  sound/i2c/cs8427.o
>      >   CC      security/selinux/ss/status.o
>      >   CC      block/cfq-iosched.o
>      >   CC [M]  drivers/auxdisplay/cfag12864b.o
>      >   CC      block/compat_ioctl.o
>      >   CC      arch/x86/kernel/cpu/vmware.o
>      >   CC      arch/x86/kernel/cpu/hypervisor.o
>      >   LD [M]  sound/core/seq/oss/snd-seq-oss.o
>      >   LD [M]  sound/core/seq/snd-seq-device.o
>      >   LD [M]  sound/core/seq/snd-seq-midi-event.o
>      >   CC      arch/x86/kernel/cpu/mshyperv.o
>      >   LD [M]  sound/core/seq/snd-seq-dummy.o
>      >   CC      arch/x86/kernel/cpu/rdrand.o
>      >   LD [M]  sound/core/seq/snd-seq-virmidi.o
>      >   LD [M]  sound/core/seq/snd-seq-midi.o
>      >   CC      block/blk-integrity.o
>      >   LD [M]  sound/core/seq/snd-seq-midi-emul.o
>      >   CC [M]  sound/core/pcm_lib.o
>      >   LD [M]  sound/drivers/opl3/snd-opl3-lib.o
>      >   LD [M]  sound/drivers/opl3/snd-opl3-synth.o
>      >   LD      sound/drivers/vx/built-in.o
>      >   CC [M]  sound/drivers/vx/vx_core.o
>      >   CC [M]  sound/drivers/vx/vx_hwdep.o
>      >   CC      drivers/ata/libata-sff.o
>      >   CC [M]  sound/drivers/vx/vx_pcm.o
>      >   CC [M]  sound/drivers/vx/vx_mixer.o
>      >   CC      drivers/ata/libata-pmp.o
>      >   CC      drivers/ata/libata-acpi.o
>      >   CC      drivers/acpi/pci_link.o
>      >   CC      mm/mremap.o
>      >   CC [M]  drivers/auxdisplay/cfag12864bfb.o
>      >   CC      arch/x86/kernel/cpu/match.o
>      >   CC      arch/x86/kernel/cpu/bugs_64.o
>      >   CC      arch/x86/kernel/apic/probe_64.o
>      >   CC      crypto/rng.o
>      >   CC      drivers/base/core.o
>      >   CC [M]  sound/i2c/i2c.o
>      >   CC      security/selinux/xfrm.o
>      >   CC      security/selinux/netlabel.o
>      >   LD      drivers/bcma/built-in.o
>      >   CC [M]  drivers/bcma/main.o
>      >   CC      arch/x86/kernel/cpu/intel.o
>      >   CC      arch/x86/kernel/cpu/amd.o
>      >   CC      arch/x86/kernel/cpu/centaur.o
>      >   CC [M]  drivers/ata/ahci.o
>      >   CC [M]  drivers/ata/libahci.o
>      >   CC      fs/drop_caches.o
>      >   CC [M]  drivers/ata/sata_inic162x.o
>      >   CC      drivers/acpi/pci_irq.o
>      >   CC      mm/msync.o
>      >   CC      mm/rmap.o
>      >   CC [M]  sound/drivers/vx/vx_cmd.o
>      >   LD      arch/x86/kernel/apic/built-in.o
>      >   CC [M]  sound/drivers/vx/vx_uer.o
>      >   CC      crypto/krng.o
>      >   LD      sound/i2c/other/built-in.o
>      >   CC [M]  sound/i2c/other/ak4113.o
>      >   CC [M]  sound/i2c/other/ak4114.o
>      >   CC [M]  sound/i2c/other/ak4xxx-adda.o
>      >   CC [M]  sound/i2c/other/pt2258.o
>      >   CC      fs/splice.o
>      >   CC      fs/sync.o
>      >   CC      fs/utimes.o
>      >   CC      drivers/block/brd.o
>      >   LD      security/selinux/selinux.o
>      >   LD      drivers/block/aoe/built-in.o
>      >   CC      arch/x86/kernel/cpu/perf_event.o
>      >   LD      security/selinux/built-in.o
>      >   CC [M]  drivers/block/aoe/aoeblk.o
>      >   CC      security/device_cgroup.o
>      >   CC [M]  drivers/bcma/scan.o
>      >   CC [M]  drivers/bcma/core.o
>      >   CC      crypto/asymmetric_keys/asymmetric_type.o
>      >   CC      drivers/acpi/pci_bind.o
>      >   LD [M]  sound/drivers/vx/snd-vx-lib.o
>      >   LD [M]  sound/drivers/snd-dummy.o
>      >   LD [M]  sound/drivers/snd-aloop.o
>      >   LD [M]  sound/drivers/snd-virmidi.o
>      >   LD [M]  sound/drivers/snd-mtpav.o
>      >   CC [M]  sound/core/pcm_timer.o
>      >   CC [M]  sound/core/pcm_misc.o
>      >   CC      drivers/acpi/acpi_platform.o
>      >   LD      block/built-in.o
>      >   CC      drivers/acpi/power.o
>      >   CC      drivers/acpi/event.o
>      >   CC      drivers/acpi/sysfs.o
>      >   CC      crypto/asymmetric_keys/signature.o
>      >   ASN.1   crypto/asymmetric_keys/x509-asn1.c
>      > Extracted 200 tokens
>      > Extracted 14 types
>      > Extracted 11 actions
>      > Pass 1
>      > Pass 2
>      >   CC      arch/x86/kernel/msr.o
>      >   CC [M]  drivers/ata/sata_sil24.o
>      >   CC      drivers/acpi/debugfs.o
>      >   LD      drivers/bluetooth/built-in.o
>      >   CC [M]  drivers/bluetooth/hci_vhci.o
>      >   LD      kernel/events/built-in.o
>      >   CC [M]  drivers/bluetooth/btmrvl_main.o
>      >   CC      drivers/base/bus.o
>      >   LD      security/built-in.o
>      >   CC [M]  drivers/bcma/sprom.o
>      >   CC      kernel/ipipe/core.o
>      >   LD [M]  sound/i2c/other/snd-ak4xxx-adda.o
>      >   LD [M]  sound/i2c/other/snd-ak4114.o
>      >   LD [M]  sound/i2c/other/snd-ak4113.o
>      >   LD [M]  sound/i2c/other/snd-pt2258.o
>      >   LD      drivers/bus/built-in.o
>      >   CC      drivers/block/loop.o
>      >   LD      drivers/cdrom/built-in.o
>      >   LD [M]  sound/i2c/snd-cs8427.o
>      >   CC [M]  drivers/cdrom/cdrom.o
>      >   LD [M]  sound/i2c/snd-i2c.o
>      >   CC [M]  drivers/ata/pdc_adma.o
>      >   CC [M]  drivers/block/floppy.o
>      >   CC      drivers/base/dd.o
>      >   CC      mm/vmalloc.o
>      >   CC [M]  drivers/block/aoe/aoechr.o
>      >   CC [M]  drivers/block/aoe/aoecmd.o
>      >   ASN.1   crypto/asymmetric_keys/x509_rsakey-asn1.c
>      > Extracted 16 tokens
>      > Extracted 1 types
>      > Extracted 1 actions
>      > Pass 1
>      > Pass 2
>      >   CC      crypto/asymmetric_keys/x509_public_key.o
>      >   CC [M]  sound/core/pcm_memory.o
>      >   CC [M]  sound/core/rawmidi.o
>      >   CC [M]  sound/core/timer.o
>      >   CC [M]  drivers/block/aoe/aoedev.o
>      >   CC      kernel/ipipe/timer.o
>      >   CC [M]  drivers/block/aoe/aoemain.o
>      >   CC [M]  drivers/bcma/driver_chipcommon.o
>      >   CC      drivers/acpi/numa.o
>      >   CC      crypto/asymmetric_keys/public_key.o
>      >   CC      crypto/asymmetric_keys/rsa.o
>      >   CC [M]  sound/core/sound.o
>      >   CC [M]  sound/core/init.o
>      >   CC      fs/stack.o
>      >   CC      fs/fs_struct.o
>      >   CC [M]  drivers/ata/sata_qstor.o
>      >   CC      drivers/base/syscore.o
>      >   CC      arch/x86/kernel/cpu/perf_event_amd.o
>      >   CC      drivers/base/driver.o
>      >   CC      arch/x86/kernel/cpu/perf_event_p6.o
>      >   CC      arch/x86/kernel/cpu/perf_event_knc.o
>      >   CC      crypto/asymmetric_keys/x509-asn1.o
>      >   CC      crypto/asymmetric_keys/x509_rsakey-asn1.o
>      >   CC      drivers/base/class.o
>      >   CC [M]  drivers/bcma/driver_chipcommon_pmu.o
>      >   CC      crypto/asymmetric_keys/x509_cert_parser.o
>      >   CC      drivers/acpi/cm_sbs.o
>      >   CC      kernel/ipipe/compat.o
>      >   CC      drivers/acpi/video_detect.o
>      >   CC [M]  drivers/bluetooth/btmrvl_debugfs.o
>      >   CC [M]  drivers/bluetooth/hci_ldisc.o
>      >   CC      fs/statfs.o
>      >   CC [M]  drivers/bluetooth/hci_h4.o
>      >   CC      fs/buffer.o
>      >   CC      fs/bio.o
>      >   CC [M]  sound/core/memory.o
>      >   CC [M]  sound/core/info.o
>      >   LD      crypto/asymmetric_keys/asymmetric_keys.o
>      >   LD      crypto/asymmetric_keys/x509_key_parser.o
>      >   LD      crypto/asymmetric_keys/built-in.o
>      >   LD      crypto/async_tx/built-in.o
>      >   CC [M]  crypto/async_tx/async_tx.o
>      >   CC [M]  crypto/async_tx/async_memcpy.o
>      >   CC [M]  drivers/block/aoe/aoenet.o
>      >   CC [M]  crypto/async_tx/async_xor.o
>      >   CC      drivers/base/platform.o
>      >   CC      arch/x86/kernel/cpu/perf_event_p4.o
>      >   LD      kernel/ipipe/built-in.o
>      >   CC      drivers/base/cpu.o
>      >   CC      kernel/irq/irqdesc.o
>      >   CC      drivers/base/firmware.o
>      >   CC      mm/pagewalk.o
>      >   CC      mm/pgtable-generic.o
>      >   CC      mm/process_vm_access.o
>      >   CC      drivers/acpi/acpica/dsargs.o
>      >   CC [M]  drivers/bcma/driver_pci.o
>      >   CC [M]  drivers/bcma/driver_gmac_cmn.o
>      >   CC [M]  drivers/ata/sata_sx4.o
>      >   CC      drivers/acpi/acpica/dscontrol.o
>      >   CC [M]  drivers/ata/ata_piix.o
>      >   CC      drivers/char/mem.o
>      >   CC [M]  drivers/bluetooth/hci_bcsp.o
>      >   CC [M]  drivers/bluetooth/hci_ll.o
>      >   CC [M]  drivers/bluetooth/bcm203x.o
>      >   CC [M]  drivers/bluetooth/bpa10x.o
>      >   CC      drivers/char/random.o
>      >   CC [M]  sound/core/control.o
>      >   CC      drivers/char/misc.o
>      >   CC [M]  crypto/async_tx/async_pq.o
>      >   CC      drivers/char/raw.o
>      >   LD [M]  drivers/block/aoe/aoe.o
>      >   CC [M]  crypto/async_tx/async_raid6_recov.o
>      >   CC [M]  crypto/async_tx/raid6test.o
>      >   CC      kernel/irq/handle.o
>      >   CC      arch/x86/kernel/cpu/perf_event_intel_lbr.o
>      >   CC      drivers/acpi/acpica/dsfield.o
>      >   CC      drivers/acpi/acpica/dsinit.o
>      >   CC      mm/init-mm.o
>      >   CC [M]  drivers/bcma/driver_gpio.o
>      >   CC      mm/nobootmem.o
>      >   CC      mm/memblock.o
>      >   CC      mm/bounce.o
>      >   CC      mm/page_io.o
>      >   CC      kernel/irq/manage.o
>      >   CC      drivers/acpi/acpica/dsmethod.o
>      >   CC      kernel/irq/spurious.o
>      >   CC      kernel/irq/resend.o
>      >   LD      drivers/char/ipmi/built-in.o
>      >   CC [M]  drivers/block/cciss.o
>      >   CC [M]  drivers/char/ipmi/ipmi_msghandler.o
>      >   CC [M]  drivers/ata/sata_mv.o
>      >   CC [M]  drivers/char/ipmi/ipmi_devintf.o
>      >   CC [M]  drivers/bcma/host_pci.o
>      >   CC      drivers/base/init.o
>      >   CC      drivers/base/map.o
>      >   CC      drivers/base/devres.o
>      >   CC      drivers/base/attribute_container.o
>      >   CC      drivers/base/transport_class.o
>      >   CC      arch/x86/kernel/cpu/perf_event_intel_ds.o
>      >   CC      arch/x86/kernel/cpu/perf_event_intel.o
>      >   CC      arch/x86/kernel/cpu/perf_event_intel_uncore.o
>      >   CC      arch/x86/kernel/cpu/mcheck/mce.o
>      >   CC      drivers/acpi/acpica/dsmthdat.o
>      >   CC      drivers/acpi/acpica/dsobject.o
>      >   CC [M]  drivers/bluetooth/bfusb.o
>      >   CC [M]  crypto/seqiv.o
>      >   CC [M]  crypto/vmac.o
>      >   CC      fs/block_dev.o
>      >   CC      fs/direct-io.o
>      >   CC      fs/mpage.o
>      >   LD [M]  drivers/bcma/bcma.o
>      >   CC      fs/ioprio.o
>      >   CC      drivers/char/hpet.o
>      >   CC      fs/proc_namespace.o
>      >   CC      mm/swap_state.o
>      >   CC      mm/swapfile.o
>      >   CC      drivers/base/topology.o
>      >   CC      drivers/base/devtmpfs.o
>      >   CC      drivers/base/power/sysfs.o
>      >   CC      drivers/acpi/acpica/dsopcode.o
>      >   CC      drivers/acpi/acpica/dsutils.o
>      >   CC [M]  sound/core/misc.o
>      >   CC      drivers/acpi/acpica/dswexec.o
>      >   CC      kernel/irq/chip.o
>      >   CC      kernel/irq/dummychip.o
>      >   CC      kernel/irq/devres.o
>      >   CC      kernel/irq/autoprobe.o
>      >   CC      kernel/irq/irqdomain.o
>      >   CC      drivers/base/power/generic_ops.o
>      >   CC [M]  drivers/bluetooth/dtl1_cs.o
>      >   CC      drivers/base/power/common.o
>      >   CC      drivers/char/nvram.o
>      >   CC      drivers/acpi/acpica/dswload.o
>      >   CC      drivers/char/agp/backend.o
>      >   CC      drivers/char/hw_random/core.o
>      >   CC      drivers/char/agp/frontend.o
>      >   CC      drivers/char/agp/generic.o
>      >   CC      drivers/char/hw_random/tpm-rng.o
>      >   CC [M]  crypto/xcbc.o
>      >   CC [M]  sound/core/device.o
>      >   CC [M]  sound/core/isadma.o
>      >   CC [M]  drivers/char/hw_random/timeriomem-rng.o
>      >   LD      drivers/char/pcmcia/built-in.o
>      >   CC [M]  drivers/char/pcmcia/cm4000_cs.o
>      >   CC      drivers/base/power/qos.o
>      >   CC      drivers/base/power/main.o
>      >   CC [M]  drivers/char/pcmcia/cm4040_cs.o
>      >   CC      drivers/acpi/acpica/dswload2.o
>      >   CC      drivers/acpi/acpica/dswscope.o
>      >   CC      fs/bio-integrity.o
>      >   CC [M]  drivers/ata/sata_nv.o
>      >   CC      arch/x86/kernel/cpu/mcheck/mce-severity.o
>      >   LD      fs/autofs4/built-in.o
>      >   CC [M]  crypto/crypto_null.o
>      >   CC [M]  fs/autofs4/init.o
>      >   CC      kernel/irq/proc.o
>      >   CC      kernel/irq/migration.o
>      >   CC [M]  drivers/char/hw_random/intel-rng.o
>      >   CC [M]  drivers/char/hw_random/amd-rng.o
>      >   CC [M]  drivers/char/hw_random/via-rng.o
>      >   CC [M]  fs/autofs4/inode.o
>      >   CC [M]  drivers/bluetooth/bt3c_cs.o
>      >   CC [M]  sound/core/sound_oss.o
>      >   CC [M]  drivers/char/ipmi/ipmi_si_intf.o
>      >   CC [M]  drivers/bluetooth/bluecard_cs.o
>      >   CC [M]  drivers/char/hw_random/virtio-rng.o
>      >   CC      arch/x86/kernel/cpu/mcheck/mce_intel.o
>      >   CC      drivers/acpi/acpica/dswstate.o
>      >   CC      drivers/base/dma-mapping.o
>      >   CC      drivers/base/regmap/regmap.o
>      >   CC      drivers/base/regmap/regcache.o
>      >   CC [M]  crypto/md4.o
>      >   CC [M]  crypto/rmd128.o
>      >   CC [M]  crypto/rmd160.o
>      >   CC      kernel/irq/pm.o
>      >   CC      mm/dmapool.o
>      >   CC      mm/hugetlb.o
>      >   LD      drivers/char/hw_random/rng-core.o
>      >   LD      drivers/char/hw_random/built-in.o
>      >   CC      mm/mempolicy.o
>      >   CC      mm/sparse.o
>      >   CC      arch/x86/kernel/cpu/mcheck/mce_amd.o
>      >   CC [M]  sound/core/info_oss.o
>      >   CC [M]  fs/autofs4/root.o
>      >   CC      drivers/acpi/acpica/evevent.o
>      >   CC      drivers/acpi/acpica/evgpe.o
>      >   CC      drivers/acpi/acpica/evgpeblk.o
>      >   CC      drivers/acpi/acpica/evgpeinit.o
>      >   CC      drivers/char/agp/isoch.o
>      >   LD      kernel/irq/built-in.o
>      >   CC      kernel/power/qos.o
>      >   CC      kernel/sched/core.o
>      >   CC      drivers/base/power/wakeup.o
>      >   CC      drivers/base/power/runtime.o
>      >   CC      kernel/sched/clock.o
>      >   CC      mm/sparse-vmemmap.o
>      >   CC      mm/mmu_notifier.o
>      >   CC [M]  drivers/bluetooth/btuart_cs.o
>      >   CC [M]  drivers/bluetooth/btusb.o
>      >   CC [M]  drivers/ata/sata_promise.o
>      >   CC [M]  drivers/ata/sata_sil.o
>      >   CC [M]  drivers/ata/sata_sis.o
>      >   CC      drivers/acpi/acpica/evgpeutil.o
>      >   CC      drivers/acpi/acpica/evglock.o
>      >   CC [M]  sound/core/vmaster.o
>      >   CC [M]  crypto/rmd256.o
>      >   CC [M]  drivers/block/pktcdvd.o
>      >   CC      arch/x86/kernel/cpu/mcheck/threshold.o
>      >   CC      drivers/char/agp/compat_ioctl.o
>      >   CC [M]  fs/autofs4/symlink.o
>      >   CC [M]  drivers/char/ipmi/ipmi_kcs_sm.o
>      >   CC [M]  drivers/char/ipmi/ipmi_smic_sm.o
>      >   CC      arch/x86/kernel/cpu/mcheck/therm_throt.o
>      >   CC      kernel/power/main.o
>      >   CC      kernel/power/console.o
>      >   CC      drivers/acpi/acpica/evmisc.o
>      >   CC      kernel/power/process.o
>      >   CC      drivers/base/regmap/regcache-rbtree.o
>      >   CC      drivers/base/regmap/regcache-lzo.o
>      >   CC [M]  fs/autofs4/waitq.o
>      >   CC [M]  fs/autofs4/expire.o
>      >   CC [M]  crypto/rmd320.o
>      >   CC [M]  fs/autofs4/dev-ioctl.o
>      >   CC [M]  crypto/sha512_generic.o
>      >   CC [M]  sound/core/ctljack.o
>      >   CC      arch/x86/kernel/cpu/mtrr/main.o
>      >   LD      drivers/base/power/built-in.o
>      >   CC [M]  drivers/char/ipmi/ipmi_bt_sm.o
>      >   CC      drivers/char/agp/amd64-agp.o
>      >   CC      drivers/char/agp/intel-agp.o
>      >   CC      drivers/acpi/acpica/evregion.o
>      >   CC      drivers/char/agp/intel-gtt.o
>      >   CC      drivers/char/agp/sis-agp.o
>      >   CC      drivers/char/agp/via-agp.o
>      >   CC      arch/x86/kernel/cpu/mcheck/mce-apei.o
>      >   CC      drivers/base/regmap/regmap-debugfs.o
>      >   CC [M]  drivers/ata/sata_svw.o
>      >   CC [M]  drivers/bluetooth/btsdio.o
>      >   LD [M]  drivers/bluetooth/btmrvl.o
>      >   CC [M]  drivers/ata/sata_uli.o
>      >   CC      arch/x86/kernel/cpuid.o
>      >   CC [M]  drivers/base/regmap/regmap-i2c.o
>      >   CC      arch/x86/kernel/cpu/perfctr-watchdog.o
>      >   CC [M]  drivers/char/ipmi/ipmi_watchdog.o
>      >   CC [M]  sound/core/jack.o
>      >   CC      kernel/power/suspend.o
>      >   CC      mm/ksm.o
>      >   CC      mm/slab.o
>      >   CC      drivers/base/dma-buf.o
>      >   LD      drivers/clk/built-in.o
>      > drivers/base/regmap/regmap-debugfs.c: In function
>      > =E2=80=98regmap_debugfs_get_dump_start=E2=80=99:
>      > drivers/base/regmap/regmap-debugfs.c:83: warning: =E2=80=98ret=E2=
=80=99 may
>      > be =20
>      used
>      > uninitialized in this function CC =20
>      drivers/clocksource/acpi_pm.o
>      > LD [M]  fs/autofs4/autofs4.o CC
>      > drivers/base/firmware_class.o CC
>      > drivers/acpi/acpica/evrgnini.o LD      fs/btrfs/built-in.o
>      >   CC [M]  fs/btrfs/super.o
>      >   CC [M]  crypto/wp512.o
>      >   CC [M]  crypto/tgr192.o
>      >   CC [M]  crypto/gf128mul.o
>      >   CC [M]  arch/x86/kernel/cpu/mcheck/mce-inject.o
>      >   CC      kernel/time/timekeeping.o
>      >   LD      drivers/base/regmap/built-in.o
>      >   CC      kernel/trace/trace_clock.o
>      >   CC [M]  drivers/ata/sata_via.o
>      >   CC [M]  drivers/ata/sata_vsc.o
>      >   CC [M]  drivers/bluetooth/btmrvl_sdio.o
>      >   CC      drivers/clocksource/i8253.o
>      >   CC [M]  drivers/block/nvme.o
>      >   CC      kernel/xenomai/arch/generic/hal.o
>      >   CC      drivers/acpi/acpica/evsci.o
>      >   LD      sound/core/built-in.o
>      >   CC      arch/x86/kernel/cpu/mtrr/if.o
>      >   LD [M]  sound/core/snd.o
>      >   LD [M]  sound/core/snd-hwdep.o
>      >   LD      drivers/char/agp/agpgart.o
>      >   LD [M]  sound/core/snd-timer.o
>      >   LD      drivers/char/agp/built-in.o
>      >   LD [M]  sound/core/snd-hrtimer.o
>      >   LD [M]  sound/core/snd-pcm.o
>      >   CC      drivers/char/tpm/tpm.o
>      >   LD [M]  sound/core/snd-page-alloc.o
>      >   CC [M]  drivers/char/ipmi/ipmi_poweroff.o
>      >   CC      kernel/power/hibernate.o
>      >   LD [M]  sound/core/snd-rawmidi.o
>      >   CC      kernel/power/snapshot.o
>      >   LD      sound/isa/built-in.o
>      >   LD      sound/isa/ad1816a/built-in.o
>      >   LD      arch/x86/kernel/cpu/mcheck/built-in.o
>      >   CC [M]  drivers/char/virtio_console.o
>      >   LD      sound/isa/cs423x/built-in.o
>      >   LD      sound/isa/ad1848/built-in.o
>      >   CC [M]  drivers/char/lp.o
>      >   LD      sound/isa/es1688/built-in.o
>      >   CC      kernel/power/swap.o
>      >   LD      sound/isa/galaxy/built-in.o
>      >   CC      kernel/trace/ftrace.o
>      >   LD      sound/isa/gus/built-in.o
>      >   LD      drivers/clocksource/built-in.o
>      >   LD      sound/isa/msnd/built-in.o
>      >   CC      kernel/freezer.o
>      >   LD      sound/isa/opti9xx/built-in.o
>      >   CC [M]  crypto/ecb.o
>      >   CC      drivers/acpi/acpica/evxface.o
>      >   LD      sound/isa/sb/built-in.o
>      >   CC [M]  sound/isa/sb/sb_common.o
>      >   CC [M]  sound/isa/sb/sb_mixer.o
>      >   CC [M]  sound/isa/sb/sb16_main.o
>      >   CC [M]  drivers/ata/pata_ali.o
>      >   CC      arch/x86/kernel/cpu/mtrr/generic.o
>      >   LD [M]  drivers/char/ipmi/ipmi_si.o
>      >   CC      arch/x86/kernel/cpu/mtrr/cleanup.o
>      >   LD      kernel/xenomai/arch/generic/xeno_hal.o
>      >   LD      kernel/xenomai/arch/generic/built-in.o
>      >   LD      kernel/xenomai/arch/built-in.o
>      >   CC [M]  crypto/cbc.o
>      >   CC      kernel/xenomai/nucleus/bufd.o
>      >   CC      drivers/base/node.o
>      >   CC      kernel/time/ntp.o
>      >   CC      drivers/base/memory.o
>      >   LD [M]  drivers/bluetooth/hci_uart.o
>      >   CC      drivers/base/module.o
>      >   CC      drivers/acpi/acpica/evxfevnt.o
>      >   CC      drivers/acpi/acpica/evxfgpe.o
>      >   CC      drivers/acpi/acpica/evxfregn.o
>      >   CC      drivers/acpi/acpica/exconfig.o
>      >   CC      drivers/acpi/acpica/exconvrt.o
>      >   CC [M]  drivers/ata/pata_amd.o
>      >   CC [M]  crypto/pcbc.o
>      >   CC      drivers/char/tpm/tpm_eventlog.o
>      >   CC      drivers/char/tpm/tpm_acpi.o
>      >   CC [M]  drivers/char/i8k.o
>      >   CC      kernel/power/user.o
>      >   CC      kernel/time/clocksource.o
>      >   LD [M]  sound/isa/sb/snd-sb-common.o
>      >   CC [M]  drivers/block/osdblk.o
>      >   LD [M]  sound/isa/sb/snd-sb16-dsp.o
>      >   LD      sound/isa/wavefront/built-in.o
>      >   LD      sound/isa/wss/built-in.o
>      >   CC [M]  drivers/block/cryptoloop.o
>      >   CC [M]  drivers/char/ppdev.o
>      >   LD      arch/x86/kernel/cpu/mtrr/built-in.o
>      >   CC      drivers/char/tpm/tpm_ppi.o
>      >   CC      arch/x86/kernel/cpu/perf_event_amd_ibs.o
>      >   LD      sound/mips/built-in.o
>      >   LD      sound/parisc/built-in.o
>      >   LD      sound/pci/built-in.o
>      >   CC [M]  sound/pci/ad1889.o
>      >   LD      sound/pcmcia/built-in.o
>      >   LD      sound/pcmcia/pdaudiocf/built-in.o
>      >   CC      kernel/xenomai/nucleus/heap.o
>      >   LD      sound/pcmcia/vx/built-in.o
>      >   CC [M]  sound/pci/atiixp_modem.o
>      >   CC      kernel/xenomai/nucleus/intr.o
>      >   CC [M]  sound/pci/atiixp.o
>      >   LD      drivers/base/built-in.o
>      >   CC      kernel/xenomai/skins/native/module.o
>      >   CC      kernel/xenomai/skins/native/task.o
>      >   CC      drivers/acpi/acpica/excreate.o
>      >   CC      drivers/acpi/acpica/exdebug.o
>      >   CC [M]  crypto/cts.o
>      >   CC [M]  fs/btrfs/ctree.o
>      >   CC [M]  crypto/lrw.o
>      >   CC [M]  crypto/xts.o
>      >   CC [M]  drivers/ata/pata_artop.o
>      >   CC [M]  fs/btrfs/extent-tree.o
>      >   CC [M]  drivers/block/virtio_blk.o
>      >   CC      kernel/power/block_io.o
>      >   CC      mm/memory_hotplug.o
>      >   CC      kernel/power/poweroff.o
>      >   CC      kernel/time/jiffies.o
>      >   CC      kernel/time/timer_list.o
>      >   CC      drivers/acpi/acpica/exdump.o
>      >   CC      drivers/char/tpm/tpm_tis.o
>      >   CC      drivers/acpi/acpica/exfield.o
>      >   CC      drivers/acpi/acpica/exfldio.o
>      >   CC      drivers/acpi/acpica/exmutex.o
>      >   CC      drivers/acpi/acpica/exnames.o
>      >   CC      kernel/trace/ring_buffer.o
>      >   CC      kernel/trace/trace.o
>      >   CC      arch/x86/kernel/cpu/capflags.o
>      >   CC      kernel/sched/cputime.o
>      >   CC      kernel/xenomai/nucleus/pod.o
>      >   CC [M]  drivers/ata/pata_atiixp.o
>      >   LD      kernel/power/built-in.o
>      >   CC      kernel/xenomai/nucleus/registry.o
>      >   LD      arch/x86/kernel/cpu/built-in.o
>      >   CC      kernel/xenomai/nucleus/synch.o
>      >   CC [M]  drivers/ata/pata_atp867x.o
>      >   CC [M]  crypto/ctr.o
>      >   CC [M]  sound/pci/bt87x.o
>      >   CC [M]  sound/pci/cmipci.o
>      >   CC      arch/x86/kernel/early-quirks.o
>      >   CC      kernel/time/timeconv.o
>      >   CC [M]  sound/pci/cs5530.o
>      >   CC [M]  drivers/block/sx8.o
>      >   LD      drivers/block/mtip32xx/built-in.o
>      >   CC [M]  drivers/block/mtip32xx/mtip32xx.o
>      >   CC [M]  sound/pci/ens1370.o
>      >   CC [M]  drivers/char/tpm/tpm_nsc.o
>      >   CC      mm/filemap_xip.o
>      >   CC      drivers/acpi/acpica/exoparg1.o
>      >   CC      kernel/sched/idle_task.o
>      >   CC      kernel/sched/fair.o
>      >   CC [M]  crypto/gcm.o
>      >   CC      kernel/time/posix-clock.o
>      >   CC      arch/x86/kernel/ipipe.o
>      >   CC      arch/x86/kernel/smp.o
>      >   CC      kernel/xenomai/skins/native/timer.o
>      >   CC [M]  drivers/ata/pata_cmd64x.o
>      >   CC [M]  drivers/ata/pata_hpt366.o
>      >   CC      drivers/acpi/acpica/exoparg2.o
>      >   CC [M]  drivers/char/tpm/tpm_atmel.o
>      >   CC      kernel/profile.o
>      >   CC      kernel/stacktrace.o
>      >   CC      mm/migrate.o
>      >   CC      drivers/acpi/acpica/exoparg3.o
>      >   CC      kernel/time/alarmtimer.o
>      >   CC      kernel/time/clockevents.o
>      >   CC [M]  drivers/char/tpm/tpm_infineon.o
>      >   CC      kernel/sched/rt.o
>      >   CC      kernel/sched/stop_task.o
>      >   CC [M]  drivers/ata/pata_hpt37x.o
>      >   CC      kernel/sched/cpupri.o
>      >   CC      kernel/sched/auto_group.o
>      >   CC      kernel/trace/trace_output.o
>      >   CC      kernel/trace/trace_stat.o
>      >   CC [M]  crypto/ccm.o
>      >   CC      arch/x86/kernel/smpboot.o
>      >   CC      drivers/acpi/acpica/exoparg6.o
>      >   CC      kernel/xenomai/skins/native/syscall.o
>      >   CC      drivers/acpi/acpica/exprep.o
>      >   CC [M]  sound/pci/ak4531_codec.o
>      >   CC [M]  sound/pci/ens1371.o
>      >   CC      drivers/acpi/acpica/exmisc.o
>      >   CC      drivers/acpi/acpica/exregion.o
>      >   CC      kernel/time/tick-common.o
>      >   CC      drivers/acpi/acpica/exresnte.o
>      >   CC      drivers/acpi/acpica/exresolv.o
>      >   CC      arch/x86/kernel/tsc_sync.o
>      >   LD      drivers/char/tpm/tpm_bios.o
>      >   CC      arch/x86/kernel/setup_percpu.o
>      >   LD      drivers/char/tpm/built-in.o
>      >   CC [M]  drivers/char/tlclk.o
>      >   CC      arch/x86/kernel/mpparse.o
>      >   CC      arch/x86/kernel/ftrace.o
>      >   CC [M]  drivers/ata/pata_hpt3x2n.o
>      >   CC      arch/x86/kernel/trace_clock.o
>      >   CC      arch/x86/kernel/machine_kexec_64.o
>      >   AS      arch/x86/kernel/relocate_kernel_64.o
>      >   LD      drivers/block/built-in.o
>      >   CC      arch/x86/kernel/crash.o
>      >   CC      arch/x86/kernel/crash_dump_64.o
>      >   CC [M]  crypto/cryptd.o
>      >   CC [M]  crypto/des_generic.o
>      >   CC      arch/x86/kernel/kprobes.o
>      >   CC      kernel/xenomai/skins/native/pipe.o
>      >   CC      kernel/time/tick-broadcast.o
>      >   CC      drivers/acpi/acpica/exresop.o
>      >   CC      drivers/acpi/acpica/exstore.o
>      >   CC      kernel/xenomai/nucleus/thread.o
>      >   CC      kernel/xenomai/nucleus/timebase.o
>      >   CC      kernel/trace/trace_printk.o
>      >   CC      mm/memory-failure.o
>      >   CC      kernel/trace/trace_sched_switch.o
>      >   CC      kernel/trace/trace_functions.o
>      >   CC      mm/page_isolation.o
>      >   CC      kernel/futex.o
>      >   CC      drivers/acpi/acpica/exstoren.o
>      >   CC      kernel/time/tick-oneshot.o
>      >   CC [M]  drivers/char/hangcheck-timer.o
>      >   CC      kernel/time/tick-sched.o
>      >   CC [M]  drivers/ata/pata_hpt3x3.o
>      >   CC [M]  drivers/ata/pata_it8213.o
>      >   LD      drivers/char/built-in.o
>      >   CC [M]  sound/pci/es1968.o
>      >   CC [M]  drivers/ata/pata_it821x.o
>      >   CC [M]  drivers/ata/pata_jmicron.o
>      >   CC [M]  sound/pci/intel8x0.o
>      >   CC [M]  drivers/ata/pata_marvell.o
>      >   CC      arch/x86/kernel/kprobes-opt.o
>      >   CC [M]  drivers/ata/pata_netcell.o
>      >   CC      drivers/acpi/apei/apei-base.o
>      >   CC      drivers/acpi/acpica/exstorob.o
>      >   CC      drivers/acpi/acpica/exsystem.o
>      >   LD      kernel/sched/built-in.o
>      >   CC [M]  fs/btrfs/print-tree.o
>      >   CC [M]  crypto/fcrypt.o
>      >   CC [M]  fs/btrfs/root-tree.o
>      >   CC [M]  fs/btrfs/dir-item.o
>      >   CC [M]  fs/btrfs/file-item.o
>      >   CC      kernel/xenomai/nucleus/timer.o
>      >   CC      kernel/trace/trace_sched_wakeup.o
>      >   CC      kernel/trace/trace_nop.o
>      >   CC      kernel/trace/trace_stack.o
>      >   CC      kernel/trace/trace_functions_graph.o
>      >   CC      drivers/acpi/acpica/exutils.o
>      >   CC      kernel/trace/blktrace.o
>      >   LD      kernel/time/built-in.o
>      >   CC [M]  crypto/blowfish_generic.o
>      >   CC      arch/x86/pci/i386.o
>      >   CC      arch/x86/pci/init.o
>      >   CC      arch/x86/pci/mmconfig_64.o
>      >   CC      drivers/connector/cn_queue.o
>      >   CC [M]  drivers/ata/pata_ninja32.o
>      >   CC      arch/x86/kernel/module.o
>      >   CC      arch/x86/kernel/early_printk.o
>      >   LD      mm/built-in.o
>      >   CC      arch/x86/kernel/hpet.o
>      >   CC      arch/x86/kernel/amd_nb.o
>      >   CC      kernel/xenomai/nucleus/sched.o
>      >   CC      arch/x86/pci/direct.o
>      >   CC      arch/x86/pci/mmconfig-shared.o
>      >   CC      drivers/acpi/acpica/hwacpi.o
>      >   CC      arch/x86/pci/fixup.o
>      >   CC      arch/x86/kernel/pcspeaker.o
>      >   CC      drivers/acpi/apei/hest.o
>      >   CC      drivers/acpi/apei/cper.o
>      >   CC [M]  crypto/blowfish_common.o
>      >   CC [M]  crypto/twofish_common.o
>      >   CC      arch/x86/kernel/pci-swiotlb.o
>      >   CC [M]  crypto/serpent_generic.o
>      >   CC [M]  crypto/camellia_generic.o
>      >   CC [M]  crypto/cast_common.o
>      >   CC [M]  crypto/cast5_generic.o
>      >   CC      drivers/acpi/acpica/hwesleep.o
>      >   CC [M]  drivers/ata/pata_oldpiix.o
>      >   CC [M]  fs/btrfs/inode-item.o
>      >   CC [M]  drivers/ata/pata_pdc2027x.o
>      >   CC [M]  drivers/ata/pata_pdc202xx_old.o
>      >   CC      kernel/xenomai/skins/native/sem.o
>      >   CC [M]  sound/pci/intel8x0m.o
>      >   CC      drivers/connector/connector.o
>      >   CC      drivers/connector/cn_proc.o
>      >   CC [M]  fs/btrfs/inode-map.o
>      >   CC      kernel/futex_compat.o
>      >   CC [M]  fs/btrfs/disk-io.o
>      >   CC      drivers/acpi/acpica/hwgpe.o
>      >   CC [M]  fs/btrfs/transaction.o
>      >   CC [M]  fs/btrfs/inode.o
>      >   CC      arch/x86/pci/acpi.o
>      >   CC      arch/x86/pci/legacy.o
>      >   CC      drivers/acpi/apei/erst.o
>      >   CC      kernel/trace/trace_events.o
>      >   CC      arch/x86/kernel/perf_regs.o
>      >   CC      kernel/trace/trace_export.o
>      >   CC [M]  drivers/ata/pata_rdc.o
>      >   CC      kernel/trace/trace_syscalls.o
>      >   CC      kernel/trace/trace_event_perf.o
>      >   CC      drivers/acpi/acpica/hwpci.o
>      >   CC      drivers/acpi/acpica/hwregs.o
>      >   CC      kernel/trace/trace_events_filter.o
>      >   CC      drivers/acpi/acpica/hwsleep.o
>      >   CC      kernel/xenomai/nucleus/sched-idle.o
>      >   CC      drivers/acpi/acpica/hwvalid.o
>      >   CC      drivers/acpi/acpica/hwxface.o
>      >   CC      drivers/acpi/acpica/hwxfsleep.o
>      >   CC [M]  drivers/ata/pata_sch.o
>      >   CC      arch/x86/kernel/audit_64.o
>      >   CC [M]  sound/pci/maestro3.o
>      >   LD      drivers/connector/cn.o
>      >   LD      drivers/connector/built-in.o
>      >   CC      arch/x86/kernel/amd_gart_64.o
>      >   CC      arch/x86/kernel/aperture_64.o
>      >   CC      arch/x86/pci/irq.o
>      >   CC      kernel/xenomai/skins/native/event.o
>      >   CC      arch/x86/pci/common.o
>      >   CC      kernel/xenomai/skins/native/mutex.o
>      >   CC      arch/x86/pci/early.o
>      >   CC      arch/x86/pci/bus_numa.o
>      >   CC      arch/x86/pci/amd_bus.o
>      >   CC      kernel/xenomai/skins/native/cond.o
>      >   CC      kernel/xenomai/nucleus/sched-rt.o
>      >   CC      kernel/xenomai/skins/native/queue.o
>      >   CC      kernel/xenomai/skins/native/heap.o
>      >   CC      kernel/xenomai/skins/native/alarm.o
>      >   CC      drivers/acpi/acpica/nsaccess.o
>      >   CC      drivers/acpi/apei/ghes.o
>      >   CC [M]  drivers/acpi/apei/einj.o
>      >   CC [M]  drivers/ata/pata_serverworks.o
>      >   CC [M]  drivers/acpi/apei/erst-dbg.o
>      >   CC      drivers/acpi/acpica/nsalloc.o
>      >   CC      drivers/acpi/acpica/nsdump.o
>      >   CC      drivers/acpi/acpica/nseval.o
>      >   CC      kernel/trace/trace_kprobe.o
>      >   CC      arch/x86/power/cpu.o
>      >   CC      arch/x86/power/hibernate_64.o
>      >   LD      arch/x86/pci/built-in.o
>      >   CC      arch/x86/kernel/pci-calgary_64.o
>      >   CC      arch/x86/kernel/tce_64.o
>      >   AS      arch/x86/power/hibernate_asm_64.o
>      >   CC      arch/x86/kernel/mmconf-fam10h_64.o
>      >   CC [M]  sound/pci/rme32.o
>      >   CC [M]  sound/pci/rme96.o
>      >   CC      arch/x86/video/fbdev.o
>      >   CC      drivers/acpi/acpica/nsinit.o
>      >   CC [M]  drivers/ata/pata_sil680.o
>      >   CC      kernel/xenomai/nucleus/shadow.o
>      >   LD      drivers/acpi/apei/apei.o
>      >   CC      arch/x86/kernel/vsmp_64.o
>      >   AS      arch/x86/kernel/head_64.o
>      >   LD      drivers/acpi/apei/built-in.o
>      >   CC      arch/x86/kernel/head64.o
>      >   CC      kernel/rtmutex.o
>      >   CC      kernel/dma.o
>      >   CC      kernel/smp.o
>      >   CC      arch/x86/xenomai/hal_64.o
>      >   CC      arch/x86/xenomai/hal-common.o
>      >   CC      arch/x86/xenomai/usercopy_64.o
>      >   CC      arch/x86/xenomai/smi.o
>      >   CC      kernel/xenomai/nucleus/pipe.o
>      >   CC      kernel/xenomai/nucleus/map.o
>      >   CC      drivers/acpi/acpica/nsload.o
>      >   CC      drivers/acpi/acpica/nsnames.o
>      >   CC      drivers/acpi/acpica/nsobject.o
>      >   LD      arch/x86/power/built-in.o
>      >   CC      drivers/acpi/ac.o
>      >   CC      kernel/trace/power-traces.o
>      >   CC      kernel/xenomai/skins/native/buffer.o
>      >   CC      kernel/trace/rpm-traces.o
>      >   LD      arch/x86/video/built-in.o
>      >   CC      kernel/trace/trace_probe.o
>      >   CC [M]  kernel/trace/ring_buffer_benchmark.o
>      >   CC [M]  drivers/ata/pata_sis.o
>      >   CC      kernel/xenomai/skins/posix/sched.o
>      >   LD      kernel/xenomai/skins/psos+/built-in.o
>      >   CC      kernel/xenomai/skins/posix/thread_attr.o
>      >   CC      kernel/xenomai/skins/posix/thread.o
>      >   CC      drivers/acpi/acpica/nsparse.o
>      >   CC      kernel/xenomai/skins/posix/mutex_attr.o
>      >   CC      arch/x86/xenomai/c1e.o
>      >   CC      arch/x86/kernel/head.o
>      >   CC [M]  drivers/ata/pata_via.o
>      >   LD      arch/x86/oprofile/built-in.o
>      >   CC [M]  arch/x86/oprofile/../../../drivers/oprofile/oprof.o
>      >   CC      net/socket.o
>      >   CC      drivers/acpi/acpica/nspredef.o
>      >   CC      net/802/fc.o
>      >   CC [M]  sound/pci/via82xx_modem.o
>      >   CC [M]  sound/pci/via82xx.o
>      >   CC      net/802/fddi.o
>      >   LDS     arch/x86/kernel/vmlinux.lds
>      >   CC [M]  arch/x86/kernel/microcode_core.o
>      >   CC [M]  crypto/cast6_generic.o
>      >   CC [M]
>      > arch/x86/oprofile/../../../drivers/oprofile/cpu_buffer.o CC
>      > [M]  arch/x86/oprofile/../../../ =20
>      drivers/oprofile/buffer_sync.o
>      >   CC [M]  arch/x86/oprofile/../../../ =20
>      drivers/oprofile/event_buffer.o
>      >   LD      arch/x86/xenomai/xeno_hal.o
>      >   LD      arch/x86/xenomai/built-in.o
>      >   CC [M]
>      > arch/x86/oprofile/../../../drivers/oprofile/oprofile_ =20
>      files.o
>      >   CC [M]  fs/btrfs/file.o
>      >   CC [M]
>      > arch/x86/oprofile/../../../drivers/oprofile/oprofilefs.o
>      > LD      kernel/trace/libftrace.o LD
>      > kernel/trace/built-in.o CC [M]
>      > arch/x86/oprofile/../../../drivers/oprofile/oprofile_ =20
>      stats.o
>      >   CC [M]
>      > arch/x86/oprofile/../../../drivers/oprofile/timer_int.o CC
>      > [M]  drivers/ata/pata_pcmcia.o CC
>      > drivers/acpi/acpica/nsrepair.o LD
>      > kernel/xenomai/skins/native/xeno_native.o LD
>      > kernel/xenomai/skins/native/built-in.o CC
>      > drivers/acpi/acpica/nsrepair2.o CC [M]  drivers/ata/pata_acpi.o
>      >   CC [M]  drivers/ata/ata_generic.o
>      >   CC [M]  fs/btrfs/tree-defrag.o
>      >   CC [M]  fs/btrfs/extent_map.o
>      >   CC      drivers/acpi/button.o
>      >   LD      drivers/ata/libata.o
>      >   CC      drivers/acpi/fan.o
>      >   CC      drivers/acpi/pci_slot.o
>      >   CC [M]  fs/btrfs/sysfs.o
>      >   CC [M]  fs/btrfs/struct-funcs.o
>      >   CC [M]  fs/btrfs/xattr.o
>      >   CC [M]  arch/x86/kernel/microcode_intel.o
>      >   CC [M]  arch/x86/kernel/microcode_amd.o
>      >   CC      lib/bcd.o
>      >   CC [M]
>      > arch/x86/oprofile/../../../drivers/oprofile/nmi_timer_ =20
>      int.o
>      >   CC [M]  arch/x86/oprofile/init.o
>      >   CC      kernel/xenomai/skins/posix/mutex.o
>      >   CC      lib/div64.o
>      >   CC [M]  crypto/arc4.o
>      >   CC [M]  net/802/p8022.o
>      >   CC      lib/sort.o
>      >   CC      drivers/acpi/acpica/nssearch.o
>      >   CC [M]  crypto/tea.o
>      >   CC      drivers/acpi/acpica/nsutils.o
>      >   CC      kernel/xenomai/nucleus/select.o
>      >   CC      drivers/acpi/acpica/nswalk.o
>      >   LD      drivers/ata/built-in.o
>      >   CC      drivers/acpi/acpica/nsxfeval.o
>      >   CC      drivers/acpi/acpica/nsxfname.o
>      >   CC [M]  arch/x86/oprofile/backtrace.o
>      >   CC [M]  arch/x86/oprofile/nmi_int.o
>      >   CC      drivers/acpi/acpica/nsxfobj.o
>      >   LD      sound/pci/ac97/built-in.o
>      >   LD      sound/pci/ali5451/built-in.o
>      >   CC [M]  sound/pci/ac97/ac97_codec.o
>      >   CC [M]  sound/pci/ali5451/ali5451.o
>      >   CC [M]  sound/pci/ac97/ac97_pcm.o
>      >   CC [M]  sound/pci/ac97/ac97_proc.o
>      >   CC      lib/parser.o
>      >   CC      lib/halfmd4.o
>      >   LD      sound/pci/asihpi/built-in.o
>      >   CC      lib/debug_locks.o
>      >   LD      arch/x86/kernel/built-in.o
>      >   CC      kernel/xenomai/skins/rtdm/core.o
>      >   CC [M]  crypto/khazad.o
>      >   CC      kernel/xenomai/skins/rtdm/device.o
>      >   CC [M]  crypto/anubis.o
>      >   CC      kernel/xenomai/skins/rtdm/drvlib.o
>      >   CC      kernel/xenomai/skins/rtdm/module.o
>      >   LD [M]  arch/x86/kernel/microcode.o
>      >   CC      kernel/xenomai/skins/rtdm/syscall.o
>      >   LD      arch/x86/built-in.o
>      >   CC      kernel/xenomai/skins/rtdm/proc.o
>      >   CC      drivers/acpi/acpica/psargs.o
>      >   CC [M]  fs/btrfs/ordered-data.o
>      >   CC [M]  fs/btrfs/extent_io.o
>      >   CC      drivers/acpi/acpica/psloop.o
>      >   CC [M]  net/802/psnap.o
>      >   CC      lib/random32.o
>      >   CC      lib/bust_spinlocks.o
>      >   LD      sound/pci/au88x0/built-in.o
>      >   CC [M]  sound/pci/au88x0/au8810.o
>      >   CC      lib/hexdump.o
>      >   CC [M]  arch/x86/oprofile/op_model_amd.o
>      >   CC [M]  arch/x86/oprofile/op_model_ppro.o
>      >   CC [M]  crypto/seed.o
>      >   CC [M]  crypto/deflate.o
>      >   CC      kernel/xenomai/skins/posix/cond_attr.o
>      >   CC [M]  crypto/zlib.o
>      >   LD      sound/sh/built-in.o
>      >   LD      sound/ppc/built-in.o
>      >   CC [M]  net/802/stp.o
>      >   CC [M]  crypto/michael_mic.o
>      >   LD      sound/soc/built-in.o
>      >   CC [M]  crypto/authenc.o
>      >   CC [M]  net/802/garp.o
>      >   CC      lib/kasprintf.o
>      >   CC      drivers/acpi/acpica/psopcode.o
>      >   CC      drivers/acpi/acpica/psparse.o
>      >   LD [M]  sound/pci/ali5451/snd-ali5451.o
>      >   CC      drivers/acpi/acpica/psscope.o
>      >   CC      kernel/xenomai/nucleus/vfile.o
>      >   CC      kernel/xenomai/nucleus/module.o
>      >   CC [M]  arch/x86/oprofile/op_model_p4.o
>      >   LD      fs/cachefiles/built-in.o
>      >   CC [M]  fs/cachefiles/bind.o
>      >   LD      fs/cifs/built-in.o
>      >   CC [M]  fs/cifs/cifsfs.o
>      >   CC      lib/bitmap.o
>      >   CC      lib/scatterlist.o
>      >   CC [M]  fs/cifs/cifssmb.o
>      >   CC [M]  fs/cifs/cifs_debug.o
>      >   CC [M]  fs/cifs/connect.o
>      >   CC      drivers/acpi/acpica/pstree.o
>      >   CC [M]  fs/cifs/dir.o
>      >   CC [M]  fs/cifs/file.o
>      >   LD      kernel/xenomai/skins/uitron/built-in.o
>      >   CC [M]  fs/cifs/inode.o
>      >   CC [M]  fs/cifs/link.o
>      >   CC [M]  fs/cifs/misc.o
>      >   CC      drivers/acpi/acpica/psutils.o
>      >   LD      fs/configfs/built-in.o
>      >   CC [M]  fs/configfs/inode.o
>      >   LD [M]  arch/x86/oprofile/oprofile.o
>      >   LD      fs/cramfs/built-in.o
>      >   CC      kernel/xenomai/skins/posix/cond.o
>      >   CC [M]  fs/cramfs/inode.o
>      >   LD      kernel/xenomai/skins/rtdm/xeno_rtdm.o
>      >   CC [M]  crypto/authencesn.o
>      >   LD      kernel/xenomai/skins/rtdm/built-in.o
>      >   CC [M]  crypto/lzo.o
>      >   CC [M]  fs/cachefiles/daemon.o
>      >   LD      net/802/built-in.o
>      >   CC      net/8021q/vlan_core.o
>      >   LD      net/9p/built-in.o
>      >   CC [M]  net/9p/mod.o
>      >   CC      drivers/acpi/acpica/pswalk.o
>      >   CC [M]  net/9p/client.o
>      >   LD      kernel/xenomai/nucleus/xeno_nucleus.o
>      >   CC      lib/string_helpers.o
>      >   CC [M]  net/9p/error.o
>      >   LD      kernel/xenomai/nucleus/built-in.o
>      >   CC [M]  net/9p/util.o
>      >   CC [M]  net/9p/protocol.o
>      >   CC [M]  net/9p/trans_fd.o
>      >   CC      lib/gcd.o
>      >   CC [M]  fs/configfs/file.o
>      >   CC      drivers/acpi/acpica/psxface.o
>      >   CC      drivers/acpi/acpica/rsaddr.o
>      >   CC      drivers/acpi/acpica/rscalc.o
>      >   CC      lib/lcm.o
>      >   CC [M]  fs/cramfs/uncompress.o
>      >   CC      lib/list_sort.o
>      >   CC [M]  fs/cachefiles/interface.o
>      >   CC      lib/uuid.o
>      >   CC [M]  fs/cachefiles/key.o
>      >   CC [M]  fs/cachefiles/main.o
>      >   LD [M]  fs/cramfs/cramfs.o
>      >   CC [M]  fs/cachefiles/namei.o
>      >   CC [M]  crypto/ansi_cprng.o
>      >   CC [M]  fs/configfs/dir.o
>      >   CC [M]  fs/configfs/symlink.o
>      >   CC [M]  crypto/tcrypt.o
>      >   CC [M]  fs/configfs/mount.o
>      >   CC [M]  fs/configfs/item.o
>      >   CC      drivers/acpi/acpica/rscreate.o
>      >   CC      drivers/acpi/acpica/rsinfo.o
>      >   CC      lib/flex_array.o
>      >   CC      drivers/acpi/acpica/rsio.o
>      >   CC [M]  sound/pci/au88x0/au8820.o
>      >   CC [M]  net/8021q/vlan.o
>      >   CC [M]  net/8021q/vlan_dev.o
>      >   CC [M]  net/8021q/vlan_netlink.o
>      >   CC      drivers/acpi/acpica/rsirq.o
>      >   LD [M]  sound/pci/ac97/snd-ac97-codec.o
>      >   LD      sound/pci/aw2/built-in.o
>      >   LD      sound/pci/ca0106/built-in.o
>      >   CC      drivers/acpi/acpica/rslist.o
>      >   CC [M]  fs/btrfs/volumes.o
>      >   CC [M]  sound/pci/ca0106/ca0106_main.o
>      >   CC [M]  sound/pci/ca0106/ca0106_proc.o
>      >   CC [M]  sound/pci/ca0106/ca0106_mixer.o
>      >   CC [M]  sound/pci/ca0106/ca_midi.o
>      >   CC      kernel/xenomai/skins/posix/sem.o
>      >   CC      kernel/xenomai/skins/posix/cancel.o
>      >   CC      fs/debugfs/inode.o
>      >   CC      kernel/xenomai/skins/posix/once.o
>      >   CC      lib/bsearch.o
>      >   CC      kernel/xenomai/skins/posix/signal.o
>      >   CC      kernel/xenomai/skins/posix/tsd.o
>      >   CC      lib/find_last_bit.o
>      >   CC      kernel/xenomai/skins/posix/clock.o
>      >   CC [M]  fs/cachefiles/rdwr.o
>      >   CC      drivers/acpi/acpica/rsmemory.o
>      >   CC      lib/find_next_bit.o
>      >   LD [M]  fs/configfs/configfs.o
>      >   CC      drivers/acpi/acpica/rsmisc.o
>      >   CC [M]  fs/cachefiles/security.o
>      >   CC [M]  fs/cachefiles/xattr.o
>      >   CC      lib/llist.o
>      >   CC      lib/memweight.o
>      >   CC      lib/kstrtox.o
>      >   CC      fs/debugfs/file.o
>      >   CC      kernel/spinlock.o
>      >   CC      kernel/xenomai/skins/posix/timer.o
>      >   CC [M]  crypto/ghash-generic.o
>      >   CC [M]  net/9p/trans_common.o
>      >   CC [M]  net/8021q/vlan_gvrp.o
>      >   CC [M]  net/9p/trans_rdma.o
>      >   CC [M]  net/8021q/vlanproc.o
>      >   CC [M]  crypto/xor.o
>      >   CC      drivers/acpi/acpica/rsserial.o
>      >   CC      lib/iomap.o
>      >   LD [M]  sound/pci/ca0106/snd-ca0106.o
>      >   CC      lib/pci_iomap.o
>      >   CC      lib/iomap_copy.o
>      >   CC      drivers/acpi/acpica/rsutils.o
>      >   CC      drivers/acpi/acpica/rsxface.o
>      >   LD [M]  fs/cachefiles/cachefiles.o
>      >   CC [M]  fs/btrfs/async-thread.o
>      >   CC [M]  fs/btrfs/ioctl.o
>      >   CC [M]  fs/btrfs/locking.o
>      >   CC [M]  fs/btrfs/orphan.o
>      >   CC [M]  fs/btrfs/export.o
>      >   CC      drivers/acpi/acpica/tbfadt.o
>      >   CC [M]  fs/btrfs/tree-log.o
>      >   CC [M]  fs/btrfs/free-space-cache.o
>      >   CC [M]  fs/btrfs/zlib.o
>      >   LD      fs/debugfs/debugfs.o
>      >   CC [M]  fs/btrfs/lzo.o
>      >   CC [M]  fs/cifs/netmisc.o
>      >   LD      fs/debugfs/built-in.o
>      >   CC [M]  fs/cifs/smbencrypt.o
>      >   CC      drivers/acpi/acpica/tbfind.o
>      >   LD      sound/sparc/built-in.o
>      >   CC      drivers/acpi/acpica/tbinstal.o
>      >   CC [M]  fs/btrfs/compression.o
>      >   LD      crypto/crypto.o
>      >   LD      net/8021q/built-in.o
>      >   LD      crypto/crypto_algapi.o
>      >   LD [M]  net/8021q/8021q.o
>      >   LD      crypto/crypto_blkcipher.o
>      >   LD      crypto/built-in.o
>      >   CC [M]  fs/btrfs/delayed-ref.o
>      >   CC      kernel/uid16.o
>      >   CC      lib/devres.o
>      >   CC [M]  sound/pci/au88x0/au8830.o
>      >   LD      net/atm/built-in.o
>      >   CC [M]  net/atm/addr.o
>      >   LD      net/bluetooth/built-in.o
>      >   CC [M]  net/bluetooth/af_bluetooth.o
>      >   CC [M]  net/9p/trans_virtio.o
>      >   CC [M]  net/atm/pvc.o
>      >   CC      arch/x86/lib/msr-smp.o
>      >   CC [M]  net/atm/signaling.o
>      >   CC [M]  net/atm/svc.o
>      >   LD      net/can/built-in.o
>      >   LD      net/bridge/built-in.o
>      >   CC [M]  net/can/bcm.o
>      >   CC [M]  net/bridge/br.o
>      >   CC      kernel/xenomai/skins/posix/registry.o
>      >   CC      drivers/acpi/acpica/tbutils.o
>      >   CC [M]  net/bridge/br_device.o
>      >   CC [M]  net/bridge/br_fdb.o
>      >   CC [M]  net/bridge/br_forward.o
>      >   CC      arch/x86/lib/cache-smp.o
>      >   CC [M]  fs/cifs/transport.o
>      >   CC      lib/check_signature.o
>      >   CC      lib/hweight.o
>      >   CC      drivers/acpi/acpica/tbxface.o
>      >   CC      arch/x86/lib/msr.o
>      >   AS      arch/x86/lib/msr-reg.o
>      >   CC      arch/x86/lib/msr-reg-export.o
>      >   AS      arch/x86/lib/iomap_copy_64.o
>      >   AS      arch/x86/lib/clear_page_64.o
>      >   AS      arch/x86/lib/cmpxchg16b_emu.o
>      >   CC [M]  fs/cifs/asn1.o
>      >   CC [M]  net/bridge/br_if.o
>      >   CC [M]  net/bridge/br_input.o
>      >   CC [M]  fs/cifs/cifs_unicode.o
>      >   CC [M]  fs/cifs/nterr.o
>      >   CC [M]  fs/cifs/xattr.o
>      >   CC      lib/bitrev.o
>      >   LD [M]  net/9p/9pnet.o
>      >   LD [M]  net/9p/9pnet_virtio.o
>      >   LD [M]  net/9p/9pnet_rdma.o
>      >   CC      lib/crc16.o
>      >   HOSTCC  lib/gen_crc32table
>      >   CC [M]  net/atm/ioctl.o
>      >   CC      lib/genalloc.o
>      >   CC      lib/lzo/lzo1x_compress.o
>      >   CC      lib/mpi/generic_mpih-lshift.o
>      >   CC      kernel/xenomai/skins/posix/mq.o
>      >   AS      arch/x86/lib/copy_page_64.o
>      >   AS      arch/x86/lib/copy_user_64.o
>      >   CC      lib/lzo/lzo1x_decompress.o
>      >   AS      arch/x86/lib/copy_user_nocache_64.o
>      >   CC [M]  net/bluetooth/hci_core.o
>      >   CC      drivers/acpi/acpica/tbxfload.o
>      >   AS      arch/x86/lib/csum-copy_64.o
>      >   CC      arch/x86/lib/csum-partial_64.o
>      >   CC      drivers/acpi/acpica/tbxfroot.o
>      >   CC      drivers/acpi/acpica/utaddress.o
>      >   LD      lib/raid6/built-in.o
>      >   LD      lib/reed_solomon/built-in.o
>      >   CC [M]  net/can/raw.o
>      >   CC [M]  lib/reed_solomon/reed_solomon.o
>      >   CC [M]  lib/raid6/algos.o
>      >   CC [M]  lib/raid6/recov.o
>      >   CC      lib/mpi/generic_mpih-mul1.o
>      >   CC      lib/mpi/generic_mpih-mul2.o
>      >   CC [M]  net/bridge/br_ioctl.o
>      >   CC [M]  net/bridge/br_notify.o
>      >   CC [M]  net/bridge/br_stp.o
>      >   CC [M]  net/can/af_can.o
>      >   CC [M]  fs/btrfs/relocation.o
>      >   CC [M]  net/bluetooth/hci_conn.o
>      >   CC [M]  fs/btrfs/delayed-inode.o
>      >   CC [M]  fs/btrfs/scrub.o
>      >   CC      drivers/acpi/acpica/utalloc.o
>      >   CC      arch/x86/lib/csum-wrappers_64.o
>      >   LD      lib/lzo/lzo_compress.o
>      >   LD      kernel/xenomai/skins/vrtx/built-in.o
>      >   LD      lib/lzo/lzo_decompress.o
>      >   LD      lib/lzo/built-in.o
>      >   CC      arch/x86/lib/delay.o
>      >   CC      drivers/acpi/acpica/utcopy.o
>      >   CC      lib/mpi/generic_mpih-mul3.o
>      >   AS      arch/x86/lib/getuser.o
>      >   CC      lib/mpi/generic_mpih-rshift.o
>      >   CC      lib/mpi/generic_mpih-sub1.o
>      >   CC [M]  fs/cifs/cifsencrypt.o
>      >   CC      lib/mpi/generic_mpih-add1.o
>      >   CC [M]  net/bridge/br_stp_bpdu.o
>      >   CC [M]  net/atm/common.o
>      >   CC [M]  net/atm/atm_misc.o
>      >   CC [M]  net/atm/raw.o
>      >   CC [M]  net/bridge/br_stp_if.o
>      >   HOSTCC  lib/raid6/mktables
>      >   CC      net/core/sock.o
>      >   CC      net/dcb/dcbnl.o
>      >   CC      drivers/acpi/acpica/utexcep.o
>      >   GEN     arch/x86/lib/inat-tables.c
>      >   CC      lib/mpi/mpicoder.o
>      >   CC      lib/mpi/mpi-bit.o
>      >   CC      drivers/acpi/container.o
>      >   CC      arch/x86/lib/insn.o
>      >   CC      drivers/acpi/acpi_memhotplug.o
>      >   UNROLL  lib/raid6/int1.c
>      >   UNROLL  lib/raid6/int2.c
>      >   UNROLL  lib/raid6/int4.c
>      >   UNROLL  lib/raid6/int8.c
>      >   UNROLL  lib/raid6/int16.c
>      >   UNROLL  lib/raid6/int32.c
>      >   CC [M]  lib/raid6/recov_ssse3.o
>      >   CC [M]  lib/raid6/recov_avx2.o
>      > lib/raid6/recov_avx2.c:11:5: warning: "CONFIG_AS_AVX2" is not =20
>      defined
>      > lib/raid6/recov_avx2.c:322:2: warning: #warning "your version
>      > of binutils lacks AVX2 support" AS
>      > arch/x86/lib/memcpy_64.o LD
>      > kernel/xenomai/skins/vxworks/built-in.o CC
>      > drivers/acpi/battery.o AS      arch/x86/lib/memmove_64.o
>      >   LD [M]  sound/pci/au88x0/snd-au8810.o
>      >   LD [M]  sound/pci/au88x0/snd-au8820.o
>      >   LD      sound/spi/built-in.o
>      >   LD [M]  sound/pci/au88x0/snd-au8830.o
>      >   CC [M]  net/can/proc.o
>      >   AS      arch/x86/lib/memset_64.o
>      >   LD      sound/pci/cs46xx/built-in.o
>      >   CC [M]  sound/pci/cs46xx/cs46xx.o
>      >   AS      arch/x86/lib/putuser.o
>      >   CC      lib/mpi/mpi-cmp.o
>      >   CC      drivers/acpi/acpica/utdebug.o
>      >   AS      arch/x86/lib/rwlock.o
>      >   CC      kernel/xenomai/skins/posix/module.o
>      >   CC      drivers/acpi/acpica/utdecode.o
>      >   CC      drivers/acpi/acpica/utdelete.o
>      >   AS      arch/x86/lib/rwsem.o
>      >   LD      sound/synth/built-in.o
>      >   LD      sound/usb/built-in.o
>      >   CC [M]  sound/synth/util_mem.o
>      >   CC [M]  sound/usb/card.o
>      >   CC [M]  fs/cifs/readdir.o
>      >   AS      arch/x86/lib/thunk_64.o
>      >   CC [M]  net/bridge/br_stp_timer.o
>      >   CC      arch/x86/lib/usercopy.o
>      >   CC [M]  net/bridge/br_netlink.o
>      >   CC [M]  net/bridge/br_sysfs_if.o
>      >   CC [M]  lib/raid6/mmx.o
>      >   CC [M]  lib/raid6/sse1.o
>      >   CC [M]  lib/raid6/sse2.o
>      >   CC [M]  lib/raid6/avx2.o
>      >   CC      lib/mpi/mpih-cmp.o
>      >   CC      lib/mpi/mpih-div.o
>      >   CC      lib/mpi/mpih-mul.o
>      >   CC      drivers/acpi/acpica/uteval.o
>      >   CC [M]  sound/usb/clock.o
>      >   CC      lib/mpi/mpi-pow.o
>      >   CC [M]  sound/pci/cs46xx/cs46xx_lib.o
>      >   CC [M]  sound/pci/cs46xx/dsp_spos.o
>      >   CC      drivers/acpi/hed.o
>      >   CC      kernel/xenomai/skins/posix/apc.o
>      >   LD      sound/synth/emux/built-in.o
>      >   LD [M]  net/can/can.o
>      >   CC [M]  sound/synth/emux/emux.o
>      >   LD [M]  net/can/can-raw.o
>      >   LD [M]  net/can/can-bcm.o
>      >   CC [M]  sound/synth/emux/emux_synth.o
>      >   CC      drivers/acpi/acpica/utglobal.o
>      >   CC [M]  net/atm/resources.o
>      >   CC [M]  net/atm/atm_sysfs.o
>      >   CC      drivers/acpi/acpica/utids.o
>      >   CC      arch/x86/lib/usercopy_64.o
>      >   CC      drivers/acpi/acpica/utinit.o
>      >   TABLE   lib/raid6/tables.c
>      >   CC [M]  lib/raid6/int1.o
>      >   CC [M]  drivers/acpi/acpi_ipmi.o
>      >   CC      drivers/acpi/acpica/utlock.o
>      >   CC [M]  sound/usb/endpoint.o
>      >   CC [M]  net/bluetooth/hci_event.o
>      >   CC      lib/mpi/mpiutil.o
>      >   LD      drivers/crypto/built-in.o
>      >   CC [M]  fs/cifs/ioctl.o
>      >   CC [M]  drivers/crypto/padlock-aes.o
>      >   CC [M]  net/bridge/br_sysfs_br.o
>      >   CC [M]  net/bridge/br_netfilter.o
>      >   CC [M]  net/bridge/br_multicast.o
>      >   CC      net/dcb/dcbevent.o
>      >   LD      arch/x86/lib/built-in.o
>      >   CC      arch/x86/lib/inat.o
>      >   CC [M]  fs/btrfs/reada.o
>      >   CC      drivers/acpi/acpica/utmath.o
>      >   CC      fs/devpts/inode.o
>      >   CC      drivers/acpi/acpica/utmisc.o
>      >   AR      arch/x86/lib/lib.a
>      >   CC [M]  lib/raid6/int2.o
>      >   CC [M]  lib/raid6/int4.o
>      >   CC      kernel/xenomai/skins/posix/syscall.o
>      >   LD      lib/mpi/mpi.o
>      >   LD      lib/mpi/built-in.o
>      >   CC [M]  lib/raid6/int8.o
>      >   LD      fs/dlm/built-in.o
>      >   CC [M]  fs/dlm/ast.o
>      >   CC [M]  fs/dlm/config.o
>      >   LD      net/dccp/built-in.o
>      >   CC [M]  net/dccp/ccid.o
>      >   CC [M]  sound/synth/emux/emux_seq.o
>      >   CC [M]  sound/synth/emux/emux_nrpn.o
>      >   CC [M]  sound/synth/emux/emux_effect.o
>      >   CC      drivers/acpi/acpica/utmutex.o
>      >   CC [M]  drivers/crypto/padlock-sha.o
>      >   CC [M]  sound/synth/emux/emux_proc.o
>      >   CC [M]  fs/cifs/sess.o
>      >   CC [M]  sound/usb/format.o
>      >   CC [M]  net/atm/proc.o
>      >   LD      fs/devpts/devpts.o
>      >   LD      fs/devpts/built-in.o
>      >   CC [M]  net/atm/clip.o
>      >   CC [M]  net/atm/br2684.o
>      >   CC [M]  lib/raid6/int16.o
>      >   CC      net/core/request_sock.o
>      >   CC      net/core/skbuff.o
>      >   CC      net/core/iovec.o
>      >   CC      net/core/datagram.o
>      >   LD      net/dcb/built-in.o
>      >   CC [M]  drivers/acpi/video.o
>      >   CC [M]  sound/pci/cs46xx/dsp_spos_scb_lib.o
>      >   CC [M]  drivers/acpi/sbshc.o
>      >   CC [M]  fs/btrfs/backref.o
>      >   CC [M]  sound/synth/emux/emux_hwdep.o
>      >   CC      drivers/acpi/acpica/utobject.o
>      >   CC      drivers/acpi/acpica/utosi.o
>      >   CC      drivers/acpi/acpica/utresrc.o
>      >   CC [M]  lib/raid6/int32.o
>      >   CC [M]  net/dccp/feat.o
>      >   CC      drivers/acpi/acpica/utstate.o
>      >   CC [M]  sound/usb/helper.o
>      >   CC [M]  fs/dlm/dir.o
>      >   CC [M]  sound/synth/emux/soundfont.o
>      >   CC [M]  sound/synth/emux/emux_oss.o
>      >   CC [M]  net/bridge/br_mdb.o
>      >   LD      net/bridge/netfilter/built-in.o
>      >   CC [M]  net/bridge/netfilter/ebtables.o
>      >   CC      drivers/acpi/acpica/utxface.o
>      >   CC      drivers/acpi/acpica/utxfinit.o
>      >   CC [M]  sound/usb/mixer.o
>      >   CC [M]  lib/raid6/tables.o
>      >   CC [M]  sound/usb/mixer_quirks.o
>      >   CC [M]  fs/cifs/export.o
>      >   CC [M]  drivers/acpi/sbs.o
>      >   CC [M]  fs/cifs/smb1ops.o
>      >   CC [M]  net/atm/lec.o
>      >   CC [M]  net/atm/pppoatm.o
>      >   CC [M]  fs/dlm/lock.o
>      >   CC [M]  fs/dlm/lockspace.o
>      >   LD [M]  sound/pci/cs46xx/snd-cs46xx.o
>      >   LD      sound/pci/cs5535audio/built-in.o
>      >   CC [M]  sound/pci/cs5535audio/cs5535audio.o
>      >   CC [M]  sound/pci/cs5535audio/cs5535audio_pcm.o
>      >   CC [M]  sound/pci/cs5535audio/cs5535audio_pm.o
>      >   LD [M]  net/atm/atm.o
>      >   CC [M]  drivers/acpi/acpi_i2c.o
>      >   CC      drivers/acpi/acpica/utxferror.o
>      >   CC      drivers/acpi/acpica/utxfmutex.o
>      >   CC [M]  fs/btrfs/ulist.o
>      >   LD [M]  sound/synth/emux/snd-emux-synth.o
>      >   LD [M]  sound/synth/snd-util-mem.o
>      >   LD      net/dns_resolver/built-in.o
>      >   CC [M]  net/dns_resolver/dns_key.o
>      >   CC      net/dsa/dsa.o
>      >   CC      net/dsa/slave.o
>      >   LD [M]  net/bridge/bridge.o
>      >   LD [M]  sound/soundcore.o
>      >   CC      net/dsa/tag_dsa.o
>      >   CC [M]  net/dns_resolver/dns_query.o
>      >   LD      drivers/acpi/acpi.o
>      >   CC [M]  net/bluetooth/mgmt.o
>      >   CC [M]  net/bluetooth/hci_sock.o
>      >   LD      sound/pci/ctxfi/built-in.o
>      >   CC [M]  sound/pci/ctxfi/xfi.o
>      >   LD      sound/pci/echoaudio/built-in.o
>      >   CC [M]  sound/pci/echoaudio/darla20.o
>      >   LD [M]  sound/pci/cs5535audio/snd-cs5535audio.o
>      >   CC [M]  sound/pci/echoaudio/darla24.o
>      >   CC [M]  sound/pci/echoaudio/echo3g.o
>      >   LD      kernel/xenomai/skins/posix/xeno_posix.o
>      >   CC [M]  fs/btrfs/qgroup.o
>      >   CC [M]  fs/cifs/cifsacl.o
>      >   CC [M]  fs/btrfs/send.o
>      >   LD      kernel/xenomai/skins/posix/built-in.o
>      >   LD [M]  lib/raid6/raid6_pq.o
>      >   CC      lib/xz/xz_dec_syms.o
>      >   LD      kernel/xenomai/skins/built-in.o
>      >   CC [M]  net/dccp/input.o
>      >   LD      kernel/xenomai/built-in.o
>      >   LD      drivers/acpi/acpica/acpi.o
>      >   CC [M]  net/dccp/minisocks.o
>      >   LD      drivers/acpi/acpica/built-in.o
>      >   CC [M]  net/dccp/options.o
>      >   LD      drivers/acpi/built-in.o
>      >   CC      kernel/module.o
>      >   LD [M]  net/dns_resolver/dns_resolver.o
>      >   LD      drivers/dca/built-in.o
>      >   CC [M]  drivers/dca/dca-core.o
>      >   CC      drivers/dma/dmaengine.o
>      >   CC      drivers/dma/iovlock.o
>      >   CC [M]  sound/usb/pcm.o
>      >   CC      lib/xz/xz_dec_stream.o
>      >   CC [M]  sound/pci/ctxfi/ctatc.o
>      >   CC      lib/xz/xz_dec_lzma2.o
>      >   CC      net/dsa/tag_edsa.o
>      >   CC      net/dsa/tag_trailer.o
>      >   CC      net/core/stream.o
>      >   CC      net/core/scm.o
>      >   CC [M]  drivers/dca/dca-sysfs.o
>      >   CC      drivers/edac/edac_stub.o
>      >   CC [M]  fs/cifs/cifs_spnego.o
>      >   CC [M]  net/bridge/netfilter/ebtable_broute.o
>      >   CC [M]  net/bridge/netfilter/ebtable_filter.o
>      >   CC [M]  net/bridge/netfilter/ebtable_nat.o
>      >   CC [M]  net/bridge/netfilter/ebt_802_3.o
>      >   CC      lib/xz/xz_dec_bcj.o
>      >   CC [M]  fs/cifs/dns_resolve.o
>      >   LD [M]  drivers/dca/dca.o
>      >   LD      drivers/dma/ioat/built-in.o
>      >   LD      net/dsa/dsa_core.o
>      >   CC [M]  drivers/dma/ioat/pci.o
>      >   CC [M]  drivers/dma/ioat/dma.o
>      >   CC [M]  sound/usb/proc.o
>      >   LD      net/dsa/built-in.o
>      >   CC [M]  drivers/dma/ioat/dma_v2.o
>      >   CC [M]  sound/usb/quirks.o
>      >   CC [M]  drivers/dma/ioat/dma_v3.o
>      >   CC [M]  drivers/edac/amd64_edac.o
>      >   CC [M]  net/dccp/output.o
>      >   CC [M]  net/dccp/proto.o
>      >   LD      lib/xz/xz_dec.o
>      >   LD      lib/xz/built-in.o
>      >   CC [M]  net/dccp/timer.o
>      >   LD      lib/zlib_deflate/built-in.o
>      >   CC [M]  lib/zlib_deflate/deflate.o
>      >   CC [M]  sound/pci/ctxfi/ctvmem.o
>      >   CC [M]  lib/zlib_deflate/deftree.o
>      >   CC [M]  sound/pci/ctxfi/ctpcm.o
>      >   CC [M]  sound/pci/ctxfi/ctmixer.o
>      >   CC      net/core/gen_stats.o
>      >   CC [M]  fs/btrfs/dev-replace.o
>      >   CC [M]  sound/pci/echoaudio/gina20.o
>      >   CC [M]  sound/pci/echoaudio/gina24.o
>      >   CC [M]  net/bridge/netfilter/ebt_among.o
>      >   CC      net/core/gen_estimator.o
>      >   CC [M]  fs/cifs/cifs_dfs_ref.o
>      >   CC [M]  sound/usb/stream.o
>      >   CC [M]  sound/usb/midi.o
>      >   CC [M]  net/bluetooth/hci_sysfs.o
>      >   CC [M]  fs/dlm/main.o
>      >   CC [M]  fs/dlm/member.o
>      >   CC [M]  fs/dlm/memory.o
>      >   CC [M]  net/bluetooth/l2cap_core.o
>      >   CC [M]  lib/zlib_deflate/deflate_syms.o
>      >   CC      kernel/module_signing.o
>      >   CC      kernel/modsign_pubkey.o
>      >   CC [M]  sound/pci/ctxfi/ctresource.o
>      >   CC [M]  sound/pci/ctxfi/ctsrc.o
>      >   CC [M]  net/bluetooth/l2cap_sock.o
>      >   CC [M]  net/bluetooth/smp.o
>      >   CC [M]  net/bridge/netfilter/ebt_arp.o
>      >   CC [M]  sound/pci/echoaudio/indigo.o
>      >   CC [M]  fs/btrfs/acl.o
>      >   LD [M]  fs/cifs/cifs.o
>      >   CC [M]  drivers/dma/ioat/dca.o
>      >   CC [M]  sound/pci/echoaudio/indigodj.o
>      >   CC [M]  fs/dlm/midcomms.o
>      >   CC [M]  fs/dlm/netlink.o
>      >   LD [M]  lib/zlib_deflate/zlib_deflate.o
>      >   CC [M]  sound/pci/echoaudio/indigodjx.o
>      >   CC      lib/zlib_inflate/inffast.o
>      >   CC      lib/textsearch.o
>      >   CC      net/core/net_namespace.o
>      >   CC [M]  drivers/edac/edac_mc.o
>      >   AS      kernel/modsign_certificate.o
>      >   CC      kernel/kallsyms.o
>      >   CC [M]  net/dccp/qpolicy.o
>      >   CC      kernel/acct.o
>      >   CC      kernel/kexec.o
>      >   CC      lib/zlib_inflate/inflate.o
>      >   CC      lib/zlib_inflate/infutil.o
>      >   CC      lib/zlib_inflate/inftrees.o
>      >   CC      lib/zlib_inflate/inflate_syms.o
>      >   CC      kernel/compat.o
>      >   CC [M]  sound/pci/ctxfi/ctamixer.o
>      >   CC [M]  fs/dlm/lowcomms.o
>      >   CC [M]  sound/pci/ctxfi/ctdaio.o
>      >   CC [M]  sound/pci/ctxfi/ctimap.o
>      >   LD [M]  fs/btrfs/btrfs.o
>      >   LD      sound/usb/6fire/built-in.o
>      >   CC [M]  sound/usb/6fire/chip.o
>      >   LD      sound/usb/caiaq/built-in.o
>      >   CC [M]  sound/usb/caiaq/device.o
>      >   CC [M]  net/bridge/netfilter/ebt_ip.o
>      >   CC [M]  sound/usb/caiaq/audio.o
>      >   CC [M]  sound/usb/caiaq/midi.o
>      >   CC [M]  sound/usb/caiaq/control.o
>      >   LD [M]  drivers/dma/ioat/ioatdma.o
>      >   LD      drivers/dma/built-in.o
>      >   CC [M]  sound/usb/caiaq/input.o
>      >   LD      fs/ecryptfs/built-in.o
>      >   CC [M]  net/dccp/ccids/ccid2.o
>      >   CC [M]  net/dccp/ackvec.o
>      >   LD      lib/zlib_inflate/zlib_inflate.o
>      >   CC [M]  fs/ecryptfs/dentry.o
>      >   LD      lib/zlib_inflate/built-in.o
>      >   CC      net/ethernet/eth.o
>      >   CC      lib/percpu_counter.o
>      >   CC      lib/swiotlb.o
>      >   CC      lib/iommu-helper.o
>      >   CC [M]  sound/usb/6fire/comm.o
>      >   CC [M]  sound/usb/6fire/midi.o
>      >   CC [M]  sound/pci/ctxfi/cthardware.o
>      >   CC [M]  sound/pci/ctxfi/cttimer.o
>      >   CC [M]  sound/usb/6fire/control.o
>      >   CC [M]  sound/pci/ctxfi/cthw20k2.o
>      >   CC      net/core/secure_seq.o
>      >   CC      net/core/flow_dissector.o
>      >   CC [M]  sound/pci/echoaudio/indigoio.o
>      >   CC [M]  drivers/edac/edac_device.o
>      >   CC [M]  drivers/edac/edac_mc_sysfs.o
>      >   CC [M]  sound/pci/echoaudio/indigoiox.o
>      >   CC [M]  net/bridge/netfilter/ebt_ip6.o
>      >   CC [M]  fs/ecryptfs/file.o
>      >   CC [M]  net/bridge/netfilter/ebt_limit.o
>      >   CC [M]  fs/ecryptfs/inode.o
>      >   CC [M]  fs/ecryptfs/main.o
>      >   CC [M]  fs/ecryptfs/super.o
>      >   CC [M]  sound/pci/ctxfi/cthw20k1.o
>      >   LD      net/ieee802154/built-in.o
>      >   CC [M]  net/ieee802154/af_ieee802154.o
>      >   CC [M]  sound/usb/6fire/firmware.o
>      >   CC [M]  fs/dlm/plock.o
>      >   CC [M]  sound/usb/6fire/pcm.o
>      >   LD [M]  sound/usb/caiaq/snd-usb-caiaq.o
>      >   CC      kernel/cgroup.o
>      >   CC      kernel/cgroup_freezer.o
>      >   CC      kernel/cpuset.o
>      >   CC [M]  net/dccp/ccids/ccid3.o
>      >   CC [M]  net/bridge/netfilter/ebt_mark_m.o
>      >   LD      net/ethernet/built-in.o
>      >   CC      lib/syscall.o
>      >   CC      lib/dynamic_debug.o
>      >   CC      net/ipv4/route.o
>      >   CC      net/ipv4/inetpeer.o
>      >   CC [M]  drivers/edac/edac_pci_sysfs.o
>      >   LD      net/ipv6/netfilter/built-in.o
>      >   CC [M]  net/ipv6/netfilter/ip6_tables.o
>      >   CC      net/core/sysctl_net_core.o
>      >   CC      kernel/utsname.o
>      >   CC      drivers/firewire/init_ohci1394_dma.o
>      >   CC [M]  drivers/firewire/core-card.o
>      >   CC [M]  drivers/firewire/core-cdev.o
>      >   CC [M]  fs/ecryptfs/mmap.o
>      >   CC [M]  drivers/firewire/core-device.o
>      >   CC [M]  net/ieee802154/raw.o
>      >   CC [M]  drivers/firewire/core-iso.o
>      >   LD [M]  sound/usb/6fire/snd-usb-6fire.o
>      >   LD      sound/usb/misc/built-in.o
>      >   CC [M]  sound/usb/misc/ua101.o
>      >   LD      sound/usb/usx2y/built-in.o
>      >   CC [M]  sound/usb/usx2y/us122l.o
>      >   CC [M]  sound/usb/usx2y/usbusx2y.o
>      >   CC [M]  fs/dlm/rcom.o
>      >   CC [M]  sound/usb/usx2y/usX2Yhwdep.o
>      >   CC [M]  net/bridge/netfilter/ebt_pkttype.o
>      >   LD [M]  sound/pci/ctxfi/snd-ctxfi.o
>      >   CC [M]  sound/usb/usx2y/usx2yhwdeppcm.o
>      >   CC [M]  sound/pci/echoaudio/layla20.o
>      >   CC      net/core/dev.o
>      >   CC [M]  fs/ecryptfs/read_write.o
>      >   CC [M]  fs/ecryptfs/crypto.o
>      >   CC [M]  drivers/edac/edac_module.o
>      >   CC [M]  net/bluetooth/sco.o
>      >   CC [M]  net/dccp/ccids/lib/tfrc.o
>      >   CC [M]  drivers/edac/edac_device_sysfs.o
>      >   CC [M]  drivers/firewire/core-topology.o
>      >   CC [M]  net/dccp/ccids/lib/tfrc_equation.o
>      >   CC      lib/nlattr.o
>      >   CC [M]  net/ieee802154/dgram.o
>      >   CC      lib/average.o
>      >   CC [M]  fs/dlm/recover.o
>      >   CC [M]  fs/dlm/recoverd.o
>      >   CC [M]  net/bridge/netfilter/ebt_stp.o
>      >   CC [M]  fs/dlm/requestqueue.o
>      >   CC [M]  net/bridge/netfilter/ebt_vlan.o
>      >   CC [M]  net/bridge/netfilter/ebt_arpreply.o
>      >   CC [M]  fs/ecryptfs/keystore.o
>      >   CC [M]  fs/dlm/user.o
>      >   LD [M]  sound/usb/misc/snd-ua101.o
>      >   CC [M]  fs/dlm/util.o
>      >   LD [M]  sound/usb/snd-usb-audio.o
>      >   CC [M]  fs/dlm/debug_fs.o
>      >   CC [M]  drivers/edac/edac_pci.o
>      >   CC [M]  drivers/edac/mce_amd.o
>      >   CC [M]  fs/ecryptfs/messaging.o
>      >   CC [M]  fs/ecryptfs/miscdev.o
>      >   CC [M]  drivers/firewire/core-transaction.o
>      >   CC [M]  fs/ecryptfs/kthread.o
>      >   LD [M]  sound/usb/usx2y/snd-usb-usx2y.o
>      >   CC [M]  net/dccp/ccids/lib/packet_history.o
>      >   CC [M]  net/ieee802154/netlink.o
>      >   LD [M]  sound/usb/usx2y/snd-usb-us122l.o
>      >   LD [M]  sound/usb/snd-usbmidi-lib.o
>      >   CC [M]  net/ieee802154/nl-mac.o
>      >   CC      net/ipv4/protocol.o
>      >   CC [M]  net/ipv6/netfilter/ip6table_filter.o
>      >   CC [M]  net/ipv6/netfilter/ip6table_mangle.o
>      >   CC [M]  net/bluetooth/lib.o
>      >   CC      net/ipv4/ip_input.o
>      >   CC [M]  net/bridge/netfilter/ebt_mark.o
>      >   CC      net/ipv4/ip_fragment.o
>      >   CC      lib/cpu_rmap.o
>      >   CC      lib/dynamic_queue_limits.o
>      >   CC [M]  net/bridge/netfilter/ebt_dnat.o
>      >   CC      lib/clz_tab.o
>      >   CC      lib/strncpy_from_user.o
>      >   CC [M]  net/bridge/netfilter/ebt_redirect.o
>      >   CC [M]  fs/ecryptfs/debug.o
>      >   CC [M]  net/bridge/netfilter/ebt_snat.o
>      >   LD [M]  fs/dlm/dlm.o
>      >   CC [M]  net/bridge/netfilter/ebt_log.o
>      >   CC [M]  net/bluetooth/a2mp.o
>      >   CC [M]  drivers/edac/i5000_edac.o
>      >   CC [M]  sound/pci/echoaudio/layla24.o
>      >   CC [M]  drivers/edac/i5100_edac.o
>      >   CC [M]  drivers/edac/i5400_edac.o
>      >   CC [M]  sound/pci/echoaudio/mia.o
>      >   CC      net/core/ethtool.o
>      >   CC [M]  net/ipv6/netfilter/ip6table_raw.o
>      >   CC      lib/strnlen_user.o
>      >   CC [M]  net/ipv6/netfilter/ip6table_security.o
>      >   LD [M]  fs/ecryptfs/ecryptfs.o
>      >   CC [M]  drivers/firewire/net.o
>      >   CC [M]  net/dccp/ccids/lib/loss_interval.o
>      >   CC      kernel/pid_namespace.o
>      >   LD      fs/exofs/built-in.o
>      >   CC [M]  fs/exofs/ore.o
>      >   CC [M]  fs/exofs/ore_raid.o
>      >   CC      kernel/res_counter.o
>      >   CC      lib/asn1_decoder.o
>      >   GEN     lib/oid_registry_data.c
>      > Compiling 49 OIDs
>      >   CC [M]  drivers/firewire/ohci.o
>      >   CC      drivers/firmware/dmi_scan.o
>      >   CC [M]  drivers/firewire/sbp2.o
>      >   CC [M]  net/ieee802154/nl-phy.o
>      >   LD      net/key/built-in.o
>      >   CC [M]  net/bridge/netfilter/ebt... =20
>      [Messaggio troncato]
>=20
> References
>=20
>    1. https://bugzilla.kernel.org/show_bug.cgi?id=3D60758
>    2.
> http://linuxaleph.blogspot.de/2014/06/kernel-panic-scsiwaitscan-on-centos=
.html
> 3. mailto:henning.schild@siemens.com 4. mailto:miki.belotti@gmail.com
>    5. https://bugzilla.kernel.org/show_bug.cgi?id=3D60758
>    6. https://bugzilla.kernel.org/show_bug.cgi?id=3D60758
>    7.
> http://linuxaleph.blogspot.de/2014/06/kernel-panic-scsiwaitscan-on-centos=
.html
> 8.
> http://xenomai.org/pipermail/xenomai/attachments/20160819/81148731/attach=
ment.jpg
> 9.
> http://xenomai.org/pipermail/xenomai/attachments/20160819/81148731/attach=
ment-0001.jpg
> -------------- next part -------------- A non-text attachment was
> scrubbed... Name: image.png Type: image/png Size: 499513 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20160820/b358d21f/attac=
hment.png>
> -------------- next part -------------- A non-text attachment was
> scrubbed... Name: image.png
> Type: image/png
> Size: 497700 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20160820/b358d21f/attac=
hment-0001.png>
> _______________________________________________ Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


