MIME-Version: 1.0
Date: Thu, 11 Feb 2010 03:09:33 -0500
Message-ID: <e325d111002110009x3d586e04h40487b06847237ce@domain.hid>
From: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] CONFIG_NR_CPUS is too large, please lower it.
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

May i know how to solve the following problem?

In file included from include/linux/sched.h:64,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from arch/x86/kernel/asm-o=
ffsets_32.c:8,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from arch/x86/kernel/asm-o=
ffsets.c:2:
include/linux/ipipe.h:76:2: error: #error "CONFIG_NR_CPUS is too
large, please lower it."
make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

the current CONFIG_NR_CPUS is set to 2 in .config file.

The following is my proc/cpuinfo


processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 10
cpu MHz		: 2400.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
constant_tsc pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
lahf_lm
bogomips	: 6000.64
clflush size	: 64
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 10
cpu MHz		: 2400.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 1
initial apicid	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
constant_tsc pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
lahf_lm
bogomips	: 6000.57
clflush size	: 64
power management:

