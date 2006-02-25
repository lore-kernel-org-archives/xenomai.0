From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 25 Feb 2006 21:25:15 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602252125.17105.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Problems compiling r600 for PPC
Reply-To: niklaus.giger@domain.hid
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

Hi everybody

I had the following problem building the kernel:
kernel/built-in.o: In function 
`rtdm_mmap_buffer':/mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/kernel/xenomai/skins/rtdm/drvlib.c:1386: 
undefined reference to `virt_to_phys'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [_all] Error 2

Adding a 
#include <asm/io.h>
in kernel/xenomai/skins/rtdm/drvlib.c
fixed my compile problem. Is this the correct solution for the other 
architectures also?

svn diff was:
Index: ksrc/skins/rtdm/drvlib.c
===================================================================
--- ksrc/skins/rtdm/drvlib.c    (revision 600)
+++ ksrc/skins/rtdm/drvlib.c    (working copy)
@@ -31,6 +31,7 @@


 #include <linux/delay.h>
+#include <asm/io.h>
 #include <linux/mman.h>

 #include <rtdm/rtdm_driver.h>


Best regards

-- 
Niklaus Giger

