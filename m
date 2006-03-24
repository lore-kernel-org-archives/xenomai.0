Message-ID: <61632.205.250.209.80.1143238337.squirrel@domain.hid>
Date: Fri, 24 Mar 2006 14:12:17 -0800 (GMT+8)
From: "Igor Cheifot" <icheifot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Cross Compilation Error
Reply-To: icheifot@domain.hid
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

Hi
I'm trying to compile the 2.6.14 Xenomai patch kernel for ARM architechture.
I'm using arm-linux-gcc version 3.4.2 and i get the following error

make[1]: Entering directory `/usr/src/linux-2.6.14.7-ARM'
  CHK     include/linux/version.h
make[2]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arm-linux-ld:arch/arm/kernel/vmlinux.lds:730: parse error
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/usr/src/linux-2.6.14.7-ARM'
make: *** [stamp-build] Error 2

Any ideas how to fix this?
Thanx a lot in advance

-- 
Igor Cheifot
President/CEO
Concept17 Studios
tel: 604-377-4901



