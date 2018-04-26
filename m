Date: Thu, 26 Apr 2018 12:11:09 -0400
Message-ID: <h8k8o2nn4gj7hrnjep8rlfqb.1524759069245@embeddedgreg.com>
From: Greg Gallagher <greg@embeddedgreg.com>
In-Reply-To: <CAOkoxmtZkcrWjcfm3ySkOiucqfCoKT6tUv4JHfV3H3PNs6xk4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Issue with Xenomai 3.0.6,
 I-Pipe 4.9.51 and Linux 4.9.51 on Xilinx Zynq 7000 MPSOC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Salvatore Barone <salvator.barone@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


   Are you patching the Xilinx Linux kernel with the Xenomai patch? Have
   you tried mainline?
   Greg

   From: salvator.barone@gmail.com
   Sent: April 26, 2018 12:01 PM
   To: greg@embeddedgreg.com
   Cc: xenomai@xenomai.org
   Subject: Re: [Xenomai] Issue with Xenomai 3.0.6, I-Pipe 4.9.51 and
   Linux 4.9.51 on Xilinx Zynq 7000 MPSOC

   Hi Greg! I've read all your blog post on this argument! With the xilinz
   linux kernel i have no problem!
   Saluti,
   Salvatore Barone.
   Il Gio 26 Apr 2018, 16:25 Greg Gallagher <[1]greg@embeddedgreg.com> ha
   scritto:

     If you load a non Xenomai kernel do you see the panic?  I think
     there's an issue with your rootfs. I've tested zynq running on 4.14
     ipipe and 4.9 ipipe with Xenomai 3.0.x stable using both a ubuntu
     and
     busybox file system with no issues.  I've tested on Zybo, Minized
     and
     the Zc702 board.  If it's a rootfs problem and not Xenomai related I
     can help you off list.  Try loading a non Xenomai kernel and see if
     the panic still exists.
     -Greg
     On Thu, Apr 26, 2018 at 10:10 AM, Salvatore Barone
     <[2]salvator.barone@gmail.com> wrote:
     > Hi all,
     > I'm trying to run Xenomai 3 on a Xilinx Zynq 7000 MPSOC (on a
     Digilent Zybo
     > development board). I've read a lot of tutorial and documentation
     before
     > posting here.
     > I run into a "kernel panic" and I cannot solve it.
     > I know to be annoying, but just to be not prone to
     misunderstanding, I'm
     > going to report my personal walk-through below!
     >
     > In short: I've downloaded Linux stable sources from git, Xenomai 3
     and
     > I-Pipe. I checkout the 4.9.51 branch, applied the I-Pipe patch as
     follow
     > -----------------------------------------------
     > git clone git://
     > [3]git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
     > git clone git://[4]git.xenomai.org/xenomai-3.git
     > wget -O $IPIPE
     >
     [5]https://xenomai.org/downloads/ipipe/v4.x/arm/ipipe-core-4.9.51-ar
     m-4.patch
     > cd xenomai-3
     > ./scripts/[6]prepare-kernel.sh
     > --linux=linux-stable --ipipe=../[7]ipipe-core-4.9.51-arm-4.patch
     --arch=arm
     > -----------------------------------------------
     > Then, I copied the "xilinx_zynq_defconfig" file, from Xilinx, into
     the
     > arch/arm/configs directory, and then
     > -----------------------------------------------
     > export ARCH=arm
     > export CROSS_COMPILE=arm-linux-gnueabihf-
     > make xilinx_zynq_defconfig
     > make menuconfig
     > -----------------------------------------------
     > I've
     > 1) disabled frequency scaling
     > 2) disabled CMA
     > 3) disabled kernel hacks
     > and then
     > -----------------------------------------------
     > make
     > make UIMAGE_LOADADDR=0x8000 uImage modules
     > make modules_install INSTALL_MOD_PATH=$ZYNQ_MODULES
     > -----------------------------------------------
     > So, I compiled the Xenomai 3 library
     > -----------------------------------------------
     > cd xenomai3
     > git checkout tags/v3.0.6 -b xenomai_3.0.6
     > ./scripts/bootstrap
     > mkdir xeno3_build
     > cd xeno3_build
     > ../configure CFLAGS="-march=armv7-a -mfpu=vfp3 -mfloat-abi=hard"
     > LDFLAGS="-march=armv7-a" --build=x86_64-pc-linux-gnu
     > --host=arm-none-linux-gnueabi --with-core=cobalt --enable-smp
     --enable-tls
     > CC=arm-linux-gnueabihf-gcc LD=arm-linux-gnueabihf-ld
     > make DESTDIR=$XENO_ZYNQ_STAGE install
     > ---------------------------------------------
     >
     > All work as expected.
     > I used linaro latest root fs, adding the xenomai3 library and
     kernel
     > modules, but, at the system boot, I run into "kernel panic".
     > Dump follows
     > ---------------------------------------------
     > [16:06:07:495] EXT4-fs (mmcblk0p2): recovery completeaa
     > [16:06:07:495] EXT4-fs (mmcblk0p2): mounted filesystem with
     ordered data
     > mode. Opts: (null)aa
     > [16:06:07:495] VFS: Mounted root (ext4 filesystem) on device 179:
     [8]2.aa
     > [16:06:07:511] devtmpfs: mountedaa
     > [16:06:07:511] Freeing unused kernel memory: 1024K (c0900000 -
     c0a00000)aa
     > [16:06:07:591] random: fast init doneaa
     > [16:06:07:639] /sbin/init: /lib/arm-linux-gnueabihf/
     [9]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:655] /sbin/init: /lib/arm-linux-gnueabihf/
     [10]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:655] /sbin/init: /lib/arm-linux-gnueabihf/
     [11]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:671] /sbin/init: /lib/arm-linux-gnueabihf/
     [12]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:687] /sbin/init: /lib/arm-linux-gnueabihf/
     [13]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:687] /sbin/init: /lib/arm-linux-gnueabihf/
     [14]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:703] /sbin/init: /lib/arm-linux-gnueabihf/
     [15]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:703] /sbin/init: /lib/arm-linux-gnueabihf/
     [16]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:719] /sbin/init: /lib/arm-linux-gnueabihf/
     [17]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:735] /sbin/init: /lib/arm-linux-gnueabihf/
     [18]libseccomp.so.2: no
     > version information available (required by /sbin/init)aa
     > [16:06:07:735] /sbin/init: /lib/arm-linux-gnueabihf/
     [19]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[20]libselinux.so.1)aa
     > [16:06:07:751] /sbin/init: /lib/arm-linux-gnueabihf/
     [21]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[22]libselinux.so.1)aa
     > [16:06:07:767] /sbin/init: /lib/arm-linux-gnueabihf/
     [23]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[24]libselinux.so.1)aa
     > [16:06:07:783] /sbin/init: /lib/arm-linux-gnueabihf/
     [25]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[26]libcap.so.2)aa
     > [16:06:07:783] /sbin/init: /lib/arm-linux-gnueabihf/
     [27]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[28]libcap.so.2)aa
     > [16:06:07:799] /sbin/init: /lib/arm-linux-gnueabihf/
     [29]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[30]libcap.so.2)aa
     > [16:06:07:815] /sbin/init: /lib/arm-linux-gnueabihf/
     [31]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[32]librt.so.1)aa
     > [16:06:07:831] /sbin/init: /lib/arm-linux-gnueabihf/
     [33]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[34]librt.so.1)aa
     > [16:06:07:831] /sbin/init: /lib/arm-linux-gnueabihf/
     [35]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[36]libseccomp.so.2)aa
     > [16:06:07:847] /sbin/init: /lib/arm-linux-gnueabihf/
     [37]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[38]libpam.so.0)aa
     > [16:06:07:863] /sbin/init: /lib/arm-linux-gnueabihf/
     [39]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[40]libpam.so.0)aa
     > [16:06:07:879] /sbin/init: /lib/arm-linux-gnueabihf/
     [41]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[42]libaudit.so.1)aa
     > [16:06:07:879] /sbin/init: /lib/arm-linux-gnueabihf/
     [43]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[44]libaudit.so.1)aa
     > [16:06:07:895] /sbin/init: /lib/arm-linux-gnueabihf/
     [45]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[46]libkmod.so.2)aa
     > [16:06:07:911] /sbin/init: /lib/arm-linux-gnueabihf/
     [47]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[48]libkmod.so.2)aa
     > [16:06:07:927] /sbin/init: /lib/arm-linux-gnueabihf/
     [49]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[50]libkmod.so.2)aa
     > [16:06:07:943] /sbin/init: /lib/arm-linux-gnueabihf/
     [51]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[52]libapparmor.so.1)aa
     > [16:06:07:943] /sbin/init: /lib/arm-linux-gnueabihf/
     [53]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[54]libapparmor.so.1)aa
     > [16:06:07:959] /sbin/init: /lib/arm-linux-gnueabihf/
     [55]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[56]libapparmor.so.1)aa
     > [16:06:07:975] /sbin/init: /lib/arm-linux-gnueabihf/
     [57]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[58]libapparmor.so.1)aa
     > [16:06:07:991] /sbin/init: /lib/arm-linux-gnueabihf/
     [59]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[60]libmount.so.1)aa
     > [16:06:07:991] /sbin/init: /lib/arm-linux-gnueabihf/
     [61]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[62]libmount.so.1)aa
     > [16:06:08:007] /sbin/init: /lib/arm-linux-gnueabihf/
     [63]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[64]libmount.so.1)aa
     > [16:06:08:023] /sbin/init: /lib/arm-linux-gnueabihf/
     [65]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[66]libmount.so.1)aa
     > [16:06:08:039] /sbin/init: /lib/arm-linux-gnueabihf/
     [67]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[68]libmount.so.1)aa
     > [16:06:08:039] /sbin/init: /lib/arm-linux-gnueabihf/
     [69]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[70]libmount.so.1)aa
     > [16:06:08:055] /sbin/init: /lib/arm-linux-gnueabihf/
     [71]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[72]libmount.so.1)aa
     > [16:06:08:072] /sbin/init: /lib/arm-linux-gnueabihf/
     [73]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/libgcc_[74]s.so.1)aa
     > [16:06:08:087] /sbin/init: /lib/arm-linux-gnueabihf/
     [75]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[76]libpthread.so.0)aa
     > [16:06:08:103] /sbin/init: /lib/arm-linux-gnueabihf/
     [77]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[78]libpthread.so.0)aa
     > [16:06:08:103] /sbin/init: /lib/arm-linux-gnueabihf/
     [79]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[80]libpcre.so.3)aa
     > [16:06:08:119] /sbin/init: /lib/arm-linux-gnueabihf/
     [81]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[82]libdl.so.2)aa
     > [16:06:08:135] /sbin/init: /lib/arm-linux-gnueabihf/
     [83]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[84]libdl.so.2)aa
     > [16:06:08:151] /sbin/init: /lib/arm-linux-gnueabihf/libgcc_
     [85]s.so.1: version
     > `UUID_1.0' not found (required by /lib/arm-linux-gnueabihf/
     [86]libblkid.so.1)aa
     > [16:06:08:151] /sbin/init: /lib/arm-linux-gnueabihf/
     [87]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[88]libblkid.so.1)aa
     > [16:06:08:167] /sbin/init: /lib/arm-linux-gnueabihf/
     [89]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[90]libblkid.so.1)aa
     > [16:06:08:183] /sbin/init: /lib/arm-linux-gnueabihf/
     [91]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[92]libblkid.so.1)aa
     > [16:06:08:199] /sbin/init: /lib/arm-linux-gnueabihf/
     [93]libseccomp.so.2: no
     > version information available (required by
     > /lib/arm-linux-gnueabihf/[94]libblkid.so.1)aa
     > [16:06:08:231] Kernel panic - not syncing: Attempted to kill init!
     > exitcode=0x00000100aa
     > [16:06:08:231] aa
     > [16:06:08:231] CPU0: stoppingaa
     > [16:06:08:231] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
     > 4.9.24-xilinx-dirty #1aa
     > [16:06:08:231] Hardware name: Xilinx Zynq Platformaa
     > [16:06:08:247] I-pipe domain: Linuxaa
     > [16:06:08:247] Backtrace: aa
     > [16:06:08:247] [<c010b2c4>] (dump_backtrace) from [<c010b538>]
     > (show_stack+0x18/0x1c)aa
     > [16:06:08:247]  r6:00000080 r5:00000000 r4:c0a140b8aa
     > [16:06:08:247] [<c010b520>] (show_stack) from [<c031e618>]
     > (dump_stack+0x90/0xb4)aa
     > [16:06:08:263] [<c031e588>] (dump_stack) from [<c010e238>]
     > (handle_IPI+0xe0/0x16c)aa
     > [16:06:08:263]  r7:00000004 r6:00000000 r5:c0a03608 r4:c094b51caa
     > [16:06:08:263] [<c010e158>] (handle_IPI) from [<c010e2f0>]
     > (__ipipe_do_IPI+0x2c/0x38)aa
     > [16:06:08:279]  r10:c0a40ac0 r9:dfbd080c r8:dfbd0810 r7:dfbd0818
     > r6:c0a50c00 r5:00000404aa
     > [16:06:08:279]  r4:c094ab4caa
     > [16:06:08:279] [<c010e2c4>] (__ipipe_do_IPI) from [<c018bcf8>]
     > (__ipipe_do_sync_stage+0x224/0x268)aa
     > [16:06:08:295]  r5:c0a40b00 r4:00000404aa
     > [16:06:08:295] [<c018bad4>] (__ipipe_do_sync_stage) from
     [<c018be40>]
     > (ipipe_unstall_root+0x40/0x50)aa
     > [16:06:08:295]  r10:00000000 r9:c094c5bc r8:00000001 r7:c0a0346c
     > r6:c0a00000 r5:c0a269ccaa
     > [16:06:08:311]  r4:c0948808aa
     > [16:06:08:311] [<c018be00>] (ipipe_unstall_root) from [<c0152464>]
     > (cpu_startup_entry+0x144/0x1d4)aa
     > [16:06:08:311]  r4:dfbd45c0aa
     > [16:06:08:311] [<c0152320>] (cpu_startup_entry) from [<c064fec8>]
     > (rest_init+0x78/0x90)aa
     > [16:06:08:327]  r7:c0a03440aa
     > [16:06:08:327] [<c064fe50>] (rest_init) from [<c0900c74>]
     > (start_kernel+0x308/0x368)aa
     > [16:06:08:327]  r4:c0a30bccaa
     > [16:06:08:327] [<c090096c>] (start_kernel) from [<0000807c>]
     (0x807c)aa
     > [16:06:08:343] ---[ end Kernel panic - not syncing: Attempted to
     kill init!
     > exitcode=0x00000100aa
     > --------------------------------------------
     >
     > What sould I do to solve the issue?
     > Thanks in advance.
     >
     >
     >
     > --
     > Saluti,
     > Salvatore Barone
     > _______________________________________________
     > Xenomai mailing list
     > [95]Xenomai@xenomai.org
     > [96]https://xenomai.org/mailman/listinfo/xenomai

References

   1. mailto:greg@embeddedgreg.com
   2. mailto:salvator.barone@gmail.com
   3. http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
   4. http://git.xenomai.org/xenomai-3.git
   5. https://xenomai.org/downloads/ipipe/v4.x/arm/ipipe-core-4.9.51-arm-4.patch
   6. http://prepare-kernel.sh/
   7. http://ipipe-core-4.9.51-arm-4.patch/
   8. http://2.xn--2caa/
   9. http://libseccomp.so/
  10. http://libseccomp.so/
  11. http://libseccomp.so/
  12. http://libseccomp.so/
  13. http://libseccomp.so/
  14. http://libseccomp.so/
  15. http://libseccomp.so/
  16. http://libseccomp.so/
  17. http://libseccomp.so/
  18. http://libseccomp.so/
  19. http://libseccomp.so/
  20. http://libselinux.so/
  21. http://libseccomp.so/
  22. http://libselinux.so/
  23. http://libseccomp.so/
  24. http://libselinux.so/
  25. http://libseccomp.so/
  26. http://libcap.so/
  27. http://libseccomp.so/
  28. http://libcap.so/
  29. http://libseccomp.so/
  30. http://libcap.so/
  31. http://libseccomp.so/
  32. http://librt.so/
  33. http://libseccomp.so/
  34. http://librt.so/
  35. http://libseccomp.so/
  36. http://libseccomp.so/
  37. http://libseccomp.so/
  38. http://libpam.so/
  39. http://libseccomp.so/
  40. http://libpam.so/
  41. http://libseccomp.so/
  42. http://libaudit.so/
  43. http://libseccomp.so/
  44. http://libaudit.so/
  45. http://libseccomp.so/
  46. http://libkmod.so/
  47. http://libseccomp.so/
  48. http://libkmod.so/
  49. http://libseccomp.so/
  50. http://libkmod.so/
  51. http://libseccomp.so/
  52. http://libapparmor.so/
  53. http://libseccomp.so/
  54. http://libapparmor.so/
  55. http://libseccomp.so/
  56. http://libapparmor.so/
  57. http://libseccomp.so/
  58. http://libapparmor.so/
  59. http://libseccomp.so/
  60. http://libmount.so/
  61. http://libseccomp.so/
  62. http://libmount.so/
  63. http://libseccomp.so/
  64. http://libmount.so/
  65. http://libseccomp.so/
  66. http://libmount.so/
  67. http://libseccomp.so/
  68. http://libmount.so/
  69. http://libseccomp.so/
  70. http://libmount.so/
  71. http://libseccomp.so/
  72. http://libmount.so/
  73. http://libseccomp.so/
  74. http://s.so/
  75. http://libseccomp.so/
  76. http://libpthread.so/
  77. http://libseccomp.so/
  78. http://libpthread.so/
  79. http://libseccomp.so/
  80. http://libpcre.so/
  81. http://libseccomp.so/
  82. http://libdl.so/
  83. http://libseccomp.so/
  84. http://libdl.so/
  85. http://s.so/
  86. http://libblkid.so/
  87. http://libseccomp.so/
  88. http://libblkid.so/
  89. http://libseccomp.so/
  90. http://libblkid.so/
  91. http://libseccomp.so/
  92. http://libblkid.so/
  93. http://libseccomp.so/
  94. http://libblkid.so/
  95. mailto:Xenomai@xenomai.org
  96. https://xenomai.org/mailman/listinfo/xenomai
