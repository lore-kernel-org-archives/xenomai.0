Message-ID: <e4ef24880710241635p102f5f44i3f5e5e88bc0e4b02@domain.hid>
Date: Wed, 24 Oct 2007 16:35:27 -0700
From: "Robert Gubler" <rgubler@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5956_23427722.1193268928002"
Subject: [Xenomai-help] Problems building Xenomai 2.4-rc4 and linux 2.6.23
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_5956_23427722.1193268928002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am trying to build a kernel that supports xenomai, but every combination
of xenomai releases, adeos-ipipe patches, and linux kernels don't seem to
build successfully for me.  First, I'd like to know if someone recommends a
particular version of all of these that is known to work for you?? Right now
I am trying to use:

linux-2.6.23.tar.bz2  (from kernel.org)
xenomai-2.4-rc4.tar.bz2
adeos-ipipe-2.6.23-i386-1.10-10.patch


Heres is what I am doing:

# ./prepare-kernel.sh --linux=~/incoming/linux-2.6.23--adeos=~/incoming/adeos-
ipipe-2.6.23-i386-1.10-10.patch --arch=i386

..... (no indication of failure) ....

# cd ~/incoming/linux-2.6.23

# make clean distclean mrproper

# make menuconfig

# make

......


  AS      arch/i386/boot/compressed/head.o
  CC      arch/i386/boot/compressed/misc.o
In file included from include/linux/ipipe_base.h:29,
                 from include/linux/kernel.h:17,
                 from include/asm/system.h:4,
                 from include/asm/processor.h:18,
                 from include/asm/thread_info.h:16,
                 from include/linux/thread_info.h:21,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/vmalloc.h:4,
                 from arch/i386/boot/compressed/misc.c:14:
include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or
directory
make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1
make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
make: *** [bzImage] Error 2


I've read the included README.INSTALL and TROUBLESHOOTING docs included with
xenomai, but they didn't seem to help me in this case.  If anyone has
recommendations for me that would be great!

Thanks,

Rob

------=_Part_5956_23427722.1193268928002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I am trying to build a kernel that supports xenomai, but every combination of xenomai releases, adeos-ipipe patches, and linux kernels don&#39;t seem to build successfully for me.&nbsp; First, I&#39;d like to know if someone recommends a particular version of all of these that is known to work for you?? Right now I am trying to use:
<br><br>linux-2.6.23.tar.bz2&nbsp; (from <a href="http://kernel.org">kernel.org</a>)<br>xenomai-2.4-rc4.tar.bz2<br>adeos-ipipe-2.6.23-i386-1.10-10.patch<br><br><br>Heres is what I am doing:<br><br><div id="mb_0"># ./prepare-kernel.sh
 --linux=~/incoming/linux-2.6.23 --adeos=~/incoming/adeos-ipipe-2.6.23-i386-1.10-10.patch --arch=i386<br><br>..... (no indication of failure) ....<br><br># cd ~/incoming/linux-2.6.23<br><br># make clean distclean mrproper
<br><br># make menuconfig
<br><br># make<br><br>......<br><br><br>&nbsp; AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/i386/boot/compressed/head.o<br>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/i386/boot/compressed/misc.o<br>In file included from include/linux/ipipe_base.h:29,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/kernel.h:17,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/asm/system.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/asm/processor.h:18,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/asm/thread_info.h:16,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/thread_info.h:21,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/preempt.h:9,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/spinlock.h:49,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/vmalloc.h:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from arch/i386/boot/compressed/misc.c:14:<br>include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or directory
<br>make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1<br>make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2<br>make: *** [bzImage] Error 2<br><br><br>I&#39;ve read the included README.INSTALL and TROUBLESHOOTING docs included with xenomai, but they didn&#39;t seem to help me in this case.&nbsp; If anyone has recommendations for me that would be great!
<br><br>Thanks,<br><br>Rob<br><br>
</div><br>

------=_Part_5956_23427722.1193268928002--

