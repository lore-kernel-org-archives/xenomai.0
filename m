Message-ID: <435E7972.90809@domain.hid>
Date: Tue, 25 Oct 2005 20:29:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Usage of sim with xenomai-2.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E00E6CE2@domain.hid>
	<435E3A68.9090601@domain.hid>
In-Reply-To: <435E3A68.9090601@domain.hid>
Content-Type: multipart/mixed; boundary="------------050404080205010108020808"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------050404080205010108020808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> ROSSIER Daniel wrote:
> 
>> Hi Philippe,
>>
>> Here is the info about my env:
>>
>> - kernel 2.6.9
>> - glibc 2.3.5
>> - gcc 3.4.4
>> - actually, I built my env. from scratch (no distro) - simply from 
>> www.linuxfromscratch.org
>>
>> But everything else works fine :-) (xenomai works perfectly. I tested 
>> it with the LinuxTraceToolkit, and it works as well)
>>
>> Here is the fragment of log, right before the failure (all the 
>> compilation steps before are OK):
>>
>>
>> make[4]: Leaving directory 
>> `/home/rossier/xenomai-2.0/sim/gcic/gcc-build/i686-pc-linux-gnu/libiberty' 
>>
>> make[3]: Leaving directory 
>> `/home/rossier/xenomai-2.0/sim/gcic/gcc-build/i686-pc-linux-gnu/libiberty' 
>>
>> make[3]: Entering directory 
>> `/home/rossier/xenomai-2.0/sim/gcic/gcc-build/i686-pc-linux-gnu/libio'
>> if [ x"no" = xyes ] && [ ! -d pic ]; then \
>>   mkdir pic; \
>> else true; fi
>> touch stamp-picdir
>> test x"no" != xyes ||\
>>   /home/rossier/xenomai-2.0/sim/gcic/gcc-build/gcc/xgcc 
>> -B/home/rossier/xenomai-2.0/sim/gcic/gcc-build/gcc/ 
>> -B/usr/realtime/libexec/gcic/i686-pc-linux-gnu/bin/ -c -g -O2 -I. 
>> -I../../../gcc-2.95.3/libio -D_IO_MTSAFE_IO  
>> ../../../gcc-2.95.3/libio/iogetline.c -o pic/iogetline.o 
>> /home/rossier/xenomai-2.0/sim/gcic/gcc-build/gcc/xgcc 
>> -B/home/rossier/xenomai-2.0/sim/gcic/gcc-build/gcc/ 
>> -B/usr/realtime/libexec/gcic/i686-pc-linux-gnu/bin/ -c -g -O2 -I. 
>> -I../../../gcc-2.95.3/libio -D_IO_MTSAFE_IO 
>> ../../../gcc-2.95.3/libio/iogetline.c
>> In file included from ../../../gcc-2.95.3/libio/libio.h:167,
>>                  from ../../../gcc-2.95.3/libio/iolibio.h:1,
>>                  from ../../../gcc-2.95.3/libio/libioP.h:47,
>>                  from ../../../gcc-2.95.3/libio/iogetline.c:26:
>> /usr/include/bits/stdio-lock.h:24: lowlevellock.h: No such file or 
>> directory
>> make[3]: *** [iogetline.o] Error 1
>> make[3]: Leaving directory 
>> `/home/rossier/xenomai-2.0/sim/gcic/gcc-build/i686-pc-linux-gnu/libio'
>> make[2]: *** [all-target-libio] Error 2
>> make[2]: Leaving directory `/home/rossier/xenomai-2.0/sim/gcic/gcc-build'
>> make[1]: *** [gcc-build/.gcic-built] Error 2
>> make[1]: Leaving directory `/home/rossier/xenomai-2.0/sim/gcic'
>> make: *** [all-recursive] Error 1
>> root@domain.hid#
>>
> 
> It seems to be an incompatibility issue between the NPTL and gcc-2.95.x:
> http://sources.redhat.com/ml/glibc-bugs/2004-06/msg00144.html
> 
> The best way to solve this would be to get rid of the MT support for 
> building the GCC-based instrumenter, since we don't need it, and libio/ 
> compilation would not break. I'll look at some way to fix this.
> 

Could you try the following steps and let me know if that works in your environment:

- unpack the gcc-2.95.3 archive
- apply the attached patch against the gcc tree
- pack back the tree
- configure, build and install Xenomai again to use the patched gcc archive for 
building the simulator.

In order to test the resulting stuff:

- export PATH=/usr/realtime/bin:$PATH
- export LD_LIBRARY_PATH=/usr/realtime/lib:$LD_LIBRARY_PATH
- cd xenomai-2.0/skins/vxworks/demos
- make sim

You should have the "satch_s" executable available in the current dir at that 
point; just start the following command then:
$ xenoscope satch_s

PS: at Xenomai configuration time, make sure to have selected the VxWorks skin 
among the APIs to build.

-- 

Philippe.

--------------050404080205010108020808
Content-Type: text/x-patch;
 name="gcc-2.95.3-no-mt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-2.95.3-no-mt.patch"

diff -uNrp gcc-2.95.3/libio/config/mtsafe.mt gcc-2.95.3-no-mt/libio/config/mtsafe.mt
--- gcc-2.95.3/libio/config/mtsafe.mt	1997-09-27 06:07:24.000000000 +0200
+++ gcc-2.95.3-no-mt/libio/config/mtsafe.mt	2005-10-25 19:43:24.000000000 +0200
@@ -1,2 +1,3 @@
 # tell we want the mt-safe version
-MT_CFLAGS = -D_IO_MTSAFE_IO
+# MT_CFLAGS = -D_IO_MTSAFE_IO
+MT_CFLAGS =
diff -uNrp gcc-2.95.3/libstdc++/config/linux.mt gcc-2.95.3-no-mt/libstdc++/config/linux.mt
--- gcc-2.95.3/libstdc++/config/linux.mt	1998-02-01 13:38:27.000000000 +0100
+++ gcc-2.95.3-no-mt/libstdc++/config/linux.mt	2005-10-25 19:43:07.000000000 +0200
@@ -1,2 +1,3 @@
 # tell we want the mt-safe version
-MT_CFLAGS = -D_IO_MTSAFE_IO
+# MT_CFLAGS = -D_IO_MTSAFE_IO
+MT_CFLAGS =

--------------050404080205010108020808--

