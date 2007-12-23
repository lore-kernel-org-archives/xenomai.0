MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18286.42879.115252.945308@domain.hid>
Date: Sun, 23 Dec 2007 19:22:55 +0100
In-Reply-To: <200712231747.35449.niklaus.giger@domain.hid>
References: <200712231747.35449.niklaus.giger@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Buildbot is back (and reporting errors)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
 > a) The simulator fails in two tests with the vxworks skins. In
 > http://ngiger.dyndns.org/buildbot/builders/sim_f/builds/1/steps/check_si=
m/logs/stdio
 > you will find at the end the lines
 > > Some problems were reported in:
 > > vxworks->t010726-1::
 > > vxworks->t010823-2::
 > Going back one finds:
 > > starting VxWorks services.
 > > Xenoscope: lt-t010823-2: fatal in MvmIrq (time=3D30000718.974563):
 > > test interrupted by watchdog.
 > and
 > > starting VxWorks services.
 > > Xenoscope: lt-t010726-1: fatal in MvmIrq (time=3D30000718.974820):
 > > test interrupted by watchdog.

Ok, we look at these.

 >=20
 > b) The i386 builds fails in
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_metapage.c: In
 > > function 'metapage_read_end_io':
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_metapage.c:29=
5:
 > > warning: 'return' with a value, in function returning void
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_metapage.c: In
 > > function 'metapage_write_end_io':
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_metapage.c:35=
2:
 > > warning: 'return' with a value, in function returning void CC [M]=20
 > > fs/jfs/jfs_logmgr.o
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c: In
 > > function 'lbmStartIO':
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2165:
 > > error: too many arguments to function 'lbmIODone'
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c: In
 > > function 'lbmIODone':
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2238:
 > > warning: 'return' with a value, in function returning void
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2263:
 > > warning: 'return' with a value, in function returning void
 > > /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2343:
 > > warning: 'return' with a value, in function returning void make[3]: ***
 > > [fs/jfs/jfs_logmgr.o] Error 1
 >=20
 > c) The buildbot reported the following error for the PPC build in
 > http://ngiger.dyndns.org/buildbot/builders/ppc_f/builds/1/steps/build/lo=
gs/stdio
 > > /var/buildbot/slave/ppc_f/linux-2.6-xenomai/drivers/net/via-rhine.c:44=
:1:
 > > error: unterminated #ifndef make[3]: *** [drivers/net/via-rhine.o] Err=
or 1
 > > make[2]: *** [drivers/net] Error 2
 > > make[1]: *** [drivers] Error 2
 >=20
 > d) For my PPC405 board I got in
 > http://ngiger.dyndns.org/buildbot/builders/hcu3_f/builds/2/steps/build/l=
ogs/stdio
 > the error
 > > =A0 CC =A0 =A0 =A0arch/ppc/kernel/smp.o
 > > /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c: In
 > > function 'start_secondary':
 > > /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c:34=
1:
 > > error: implicit declaration of function 'get_paca'
 > > /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c:34=
1:
 > > error: invalid type argument of '->'
 > > /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c:34=
1:
 > > warning: cast from pointer to integer of different size make[2]: ***
 > > [arch/ppc/kernel/smp.o] Error 1
 > > make[1]: *** [arch/ppc/kernel] Error 2
 >=20
 > e) For the TQM (here I am not sure whether I use a good combination of
 > the Linux tarball, xenomai and rtnet. So please drop me a note to correct
 > my error. The steps can be found in=20
 > http://ngiger.dyndns.org/buildbot/builders/tqm_f/builds/1
 > but are distributed. I used the xenomai trunk,
 > ftp://ftp.denx.de/pub/linux/linuxppc_2_4_devel-2006-04-06-1735.tar.bz2
 > -adeos=3Dksrc/arch/powerpc/patches/adeos-ipipe-2.4.25-*.patch=20
 > http://rtnet.svn.sourceforge.net/svnroot/rtnet/trunk/rtnet
 > To compile the linux kernel I called
 > make ARCH=3Dppc uImage modules
 > with the following environment flags:
 > =A0 CFLAGS=3D-g
 > =A0 CROSS_COMPILE=3Dppc_8xx-
 > In
 > http://ngiger.dyndns.org/buildbot/builders/tqm_f/builds/1/steps/mk_kerne=
l/logs/stdio
 > you find the following errors:
 > > In file included from
 > > /home/buildbot/slave/tqm_f/linux/include/linux/unistd.h:9, from
 > > init/do_mounts.c:5:
 > > /home/buildbot/slave/tqm_f/linux/include/asm/unistd.h:385: warning:
 > > conflicting types for built-in function '_exit' init/do_mounts.c:54: e=
rror:
 > > static declaration of 'root_device_name' follows non-static declaration
 > > /home/buildbot/slave/tqm_f/linux/include/linux/fs.h:1568: error: previ=
ous
 > > declaration of 'root_device_name' was here init/do_mounts.c: In functi=
on
 > > 'identify_ramdisk_image':
 > > init/do_mounts.c:507: warning: pointer targets in passing argument 2 of
 > > 'read' differ in signedness init/do_mounts.c:542: warning: pointer tar=
gets
 > > in passing argument 2 of 'read' differ in signedness init/do_mounts.c:=
 In
 > > function 'fill_inbuf':
 > > init/do_mounts.c:1006: warning: pointer targets in passing argument 2 =
of
 > > 'read' differ in signedness init/do_mounts.c: In function 'flush_windo=
w':
 > > init/do_mounts.c:1024: warning: pointer targets in passing argument 2 =
of
 > > 'write' differ in signedness make: *** [init/do_mounts.o] Error 1


Are you sure these errors are related to Xenomai, do not you get the
same errors if you build the kernel without Xenomai enabled ? Also,
you should tell us which versions of Linux you used, and post a link to
the kernel configuration.

--=20


					    Gilles Chanteperdrix.

