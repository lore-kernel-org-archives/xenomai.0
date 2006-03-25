From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17445.21648.814677.451593@domain.hid>
Date: Sat, 25 Mar 2006 15:32:48 +0100
Subject: Re: [Xenomai-help] Cross Compilation Error
In-Reply-To: <61632.205.250.209.80.1143238337.squirrel@domain.hid>
References: <61632.205.250.209.80.1143238337.squirrel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: icheifot@domain.hid
Cc: xenomai@xenomai.org

Igor Cheifot wrote:
 > Hi
 > I'm trying to compile the 2.6.14 Xenomai patch kernel for ARM architechture.
 > I'm using arm-linux-gcc version 3.4.2 and i get the following error
 > 
 > make[1]: Entering directory `/usr/src/linux-2.6.14.7-ARM'
 >   CHK     include/linux/version.h
 > make[2]: `include/asm-arm/mach-types.h' is up to date.
 >   CHK     include/linux/compile.h
 >   CHK     usr/initramfs_list
 >   GEN     .version
 >   CHK     include/linux/compile.h
 >   UPD     include/linux/compile.h
 >   CC      init/version.o
 >   LD      init/built-in.o
 >   LD      .tmp_vmlinux1
 > arm-linux-ld:arch/arm/kernel/vmlinux.lds:730: parse error
 > make[1]: *** [.tmp_vmlinux1] Error 1
 > make[1]: Leaving directory `/usr/src/linux-2.6.14.7-ARM'
 > make: *** [stamp-build] Error 2
 > 
 > Any ideas how to fix this?
 > Thanx a lot in advance

This issue is likely not specific to Xenomai, see :

http://www.ussg.iu.edu/hypermail/linux/kernel/0507.0/0897.html

-- 


					    Gilles Chanteperdrix.

