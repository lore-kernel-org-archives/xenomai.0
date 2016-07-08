MIME-Version: 1.0
From: Eder Alves de Moura <edermoura@gmail.com>
Date: Fri, 8 Jul 2016 16:30:17 -0300
Message-ID: <CAPXCTbbQ1Lo7voRB1sVOtnZ0yjwhZBgUnzi1YX2rv_CL1z8f0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Compiling testsuite and utils
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dears,

I am starting with Xenomai and rt systems and I want to compile it for
a raspberry pi 2/3 and beaglebone black but first I compiled it to a
PC and, apparently it is working fine.

$ dmesg | grep -i xenomai
[    3.224489] [Xenomai] scheduling class idle registered.
[    3.224491] [Xenomai] scheduling class rt registered.
[    3.224515] [Xenomai] disabling automatic C1E state promotion on
Intel processor
[    3.224521] [Xenomai] SMI-enabled chipset found, but SMI workaround disa=
bled
                         (see xenomai.smi parameter). You might encounter
[    3.224592] I-pipe: head domain Xenomai registered.
[    3.224916] [Xenomai] Cobalt v3.0.2 (Exact Zero)



But after install I could not compile the tools for xenomai, running

$ mkdir $build_root && cd $build_root
$ $xenomai_root/configure --with-core=3Dcobalt --enable-smp --enable-pshare=
d \
  --host=3Di686-linux CFLAGS=3D"-m32 -O2" LDFLAGS=3D"-m32"

I am receiving the following message

checking whether we build for Cobalt or Mercury core... cobalt
checking build system type... x86_64-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking for i686-linux-gcc... no
checking for gcc... gcc
checking whether the C compiler works... no
configure: error: in `/home/pc/tools/xenomai-3-3.0.2':
configure: error: C compiler cannot create executables
See `config.log' for more details



My machine is running an Ubuntu Mate

$ uname -a
Linux my-pc 4.1.18 #1 SMP PREEMPT Mon Jun 27 16:53:25 BRT 2016 x86_64
x86_64 x86_64 GNU/Linux

and its configuration is

lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                2
On-line CPU(s) list:   0,1
Thread(s) per core:    1
Core(s) per socket:    2
Socket(s):             1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 42
Model name:            Intel(R) Core(TM) i3-2120 CPU @ 3.30GHz
Stepping:              7
CPU MHz:               3292.343
BogoMIPS:              6584.68
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              3072K
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64
monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2
popcnt tsc_deadline_timer xsave avx lahf_lm arat epb pln pts dtherm
tpr_shadow vnmi flexpriority ept vpid xsaveopt




--=20
--------------------------------------------------
=C3=89der Moura

