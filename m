MIME-Version: 1.0
Date: Mon, 22 Feb 2010 21:13:39 -0500
Message-ID: <e325d111002221813u2c09b82r904c91b95f4b61b7@domain.hid>
From: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Xenomai: incompatible feature set
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

I followed the guide available at
http://www.captain.at/xenomai-2.1-installation.php for installing
Xenomai.

May i know why the feature "tsc" is available in my cpuinfo but it
said it is missing when i execute the Xenomai example program?

How should i fix this issue?

./trivial-periodic
Xenomai: incompatible feature set
(userland requires "tsc fastsynch", kernel provides "sep fastsynch
smp", missing="tsc").

cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 10
cpu MHz		: 3000.304
cache size	: 2048 KB
physical id	: 0
siblings	: 1
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
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
constant_tsc up pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
lahf_lm
bogomips	: 6000.60
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:

BTW, i have 2 CPUs before installing Xenomai. One of them is missing
at the moment.

