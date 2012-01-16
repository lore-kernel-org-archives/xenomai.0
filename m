MIME-Version: 1.0
Date: Mon, 16 Jan 2012 21:03:07 +0100
Message-ID: <CAP1XtZzB34=+B+fwWpswhqfFVMd3YmU4etoYOSxXFOMbEH7myg@domain.hid>
From: Santiago Focke <focke.85@domain.hid>
Content-Type: multipart/alternative; boundary=f46d04478c17fc222f04b6aab34e
Subject: [Xenomai-help] Processor type for installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--f46d04478c17fc222f04b6aab34e
Content-Type: text/plain; charset=ISO-8859-1

Dear all

I've been trying to install Xenomai but I haven't been able to do it
right.  After being able of building and installin the kernel and Xenomai,
I tried to run the example program trivial-periodic, I got the following
error

/usr/src/xenomai-2.6/examples/native$ ./trivial-periodic
Xenomai: incompatible feature set
(userland requires "tsc fastsynch", kernel provides "sep fastsynch smp",
missing="tsc").

I read that the reason for this is that I didn't configure correctly the
processor family (with xconfig). Is that the reason? Also, I've been trying
to know which option should I choose (I chose CONFIG_M586 at the
beggining), but I don't know were to get that information. The CPU info
goes as follows:

/proc/cpuinfo

processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 37
model name    : Intel(R) Core(TM) i7 CPU       M 620  @ 2.67GHz
stepping    : 5
cpu MHz        : 2666.417
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf pni
pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1
sse4_2 popcnt aes lahf_lm ida arat dts tpr_shadow vnmi flexpriority ept vpid
bogomips    : 5332.83
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:


sudo dmidecode -t 4
# dmidecode 2.9
SMBIOS 2.6 present.

Handle 0x0004, DMI type 4, 42 bytes
Processor Information
    Socket Designation: CPU 1
    Type: Central Processor
    Family: <OUT OF SPEC>
    Manufacturer: Intel
    ID: 55 06 02 00 FF FB EB BF
    Version: Intel(R) Core(TM) i7 CPU M 620 @ 2.67GHz
    Voltage: 0.0 V
    External Clock: 532 MHz
    Max Speed: 4000 MHz
    Current Speed: 2660 MHz
    Status: Populated, Enabled
    Upgrade: Other
    L1 Cache Handle: 0x0005
    L2 Cache Handle: 0x0006
    L3 Cache Handle: 0x0007
    Serial Number: To Be Filled By O.E.M.
    Asset Tag: To Be Filled By O.E.M.
    Part Number: To Be Filled By O.E.M.
    Core Count: 2
    Core Enabled: 1
    Thread Count: 2
    Characteristics:
        64-bit capable

Which one of the list should I select?? Thanks in advance

BR

-- 
Ing. Santiago Focke

--f46d04478c17fc222f04b6aab34e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all<br><br>I&#39;ve been trying to install Xenomai but I haven&#39;t b=
een able to do it right.=A0 After being able of building and installin the =
kernel and Xenomai, I tried to run the example program trivial-periodic, I =
got the following error<br>
<br><div style=3D"margin-left:40px">/usr/src/xenomai-2.6/examples/native$ .=
/trivial-periodic <br>Xenomai: incompatible feature set<br>(userland requir=
es &quot;tsc fastsynch&quot;, kernel provides &quot;sep fastsynch smp&quot;=
, missing=3D&quot;tsc&quot;).<br>
<br></div>I read that the reason for this is that I didn&#39;t configure co=
rrectly the processor family (with xconfig). Is that the reason? Also, I&#3=
9;ve been trying to know which option should I choose (I chose CONFIG_M586 =
at the beggining), but I don&#39;t know were to get that information. The C=
PU info goes as follows:<br>
<br><div style=3D"margin-left:40px">/proc/cpuinfo<br><br>processor=A0=A0=A0=
 : 0<br>vendor_id=A0=A0=A0 : GenuineIntel<br>cpu family=A0=A0=A0 : 6<br>mod=
el=A0=A0=A0 =A0=A0=A0 : 37<br>model name=A0=A0=A0 : Intel(R) Core(TM) i7 CP=
U=A0=A0=A0=A0=A0=A0 M 620=A0 @ 2.67GHz<br>stepping=A0=A0=A0 : 5<br>
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2666.417<br>cache size=A0=A0=A0 : 4096 KB<br>p=
hysical id=A0=A0=A0 : 0<br>siblings=A0=A0=A0 : 4<br>core id=A0=A0=A0 =A0=A0=
=A0 : 0<br>cpu cores=A0=A0=A0 : 2<br>apicid=A0=A0=A0 =A0=A0=A0 : 0<br>initi=
al apicid=A0=A0=A0 : 0<br>fdiv_bug=A0=A0=A0 : no<br>hlt_bug=A0=A0=A0 =A0=A0=
=A0 : no<br>
f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 =
: yes<br>fpu_exception=A0=A0=A0 : yes<br>cpuid level=A0=A0=A0 : 11<br>wp=A0=
=A0=A0 =A0=A0=A0 : yes<br>flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr=
 pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr=
 sse sse2 ss ht tm pbe nx rdtscp lm constant_tsc arch_perfmon pebs bts xtop=
ology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx es=
t tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat dts tp=
r_shadow vnmi flexpriority ept vpid<br>
bogomips=A0=A0=A0 : 5332.83<br>clflush size=A0=A0=A0 : 64<br>cache_alignmen=
t=A0=A0=A0 : 64<br>address sizes=A0=A0=A0 : 36 bits physical, 48 bits virtu=
al<br>power management:<br><br><br>sudo dmidecode -t 4 <br># dmidecode 2.9<=
br>SMBIOS 2.6 present.<br>
<br>Handle 0x0004, DMI type 4, 42 bytes<br>Processor Information<br>=A0=A0=
=A0 Socket Designation: CPU 1<br>=A0=A0=A0 Type: Central Processor<br>=A0=
=A0=A0 Family: &lt;OUT OF SPEC&gt;<br>=A0=A0=A0 Manufacturer: Intel=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0 ID: 55 06 02 00 FF FB EB BF<br>
=A0=A0=A0 Version: Intel(R) Core(TM) i7 CPU M 620 @ 2.67GHz=A0=A0=A0=A0=A0=
=A0 <br>=A0=A0=A0 Voltage: 0.0 V<br>=A0=A0=A0 External Clock: 532 MHz<br>=
=A0=A0=A0 Max Speed: 4000 MHz<br>=A0=A0=A0 Current Speed: 2660 MHz<br>=A0=
=A0=A0 Status: Populated, Enabled<br>=A0=A0=A0 Upgrade: Other<br>
=A0=A0=A0 L1 Cache Handle: 0x0005<br>=A0=A0=A0 L2 Cache Handle: 0x0006<br>=
=A0=A0=A0 L3 Cache Handle: 0x0007<br>=A0=A0=A0 Serial Number: To Be Filled =
By O.E.M.<br>=A0=A0=A0 Asset Tag: To Be Filled By O.E.M.<br>=A0=A0=A0 Part =
Number: To Be Filled By O.E.M.<br>
=A0=A0=A0 Core Count: 2<br>=A0=A0=A0 Core Enabled: 1<br>=A0=A0=A0 Thread Co=
unt: 2<br>=A0=A0=A0 Characteristics:<br>=A0=A0=A0 =A0=A0=A0 64-bit capable<=
br clear=3D"all"></div><br>Which one of the list should I select?? Thanks i=
n advance<br><br>BR<br><br>-- <br>
Ing. Santiago Focke<br>

--f46d04478c17fc222f04b6aab34e--

