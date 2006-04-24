Message-ID: <3e9157940604240829u22307f54v2108ff8744c4ebeb@domain.hid>
Date: Mon, 24 Apr 2006 20:59:16 +0530
From: "Deepak Joglekar" <joglekar.deepak@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_28056_7283620.1145892556199"
Subject: [Xenomai-help] Error while running test suit (required="sep tsc",
	present="sep", missing="tsc").
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

------=_Part_28056_7283620.1145892556199
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am using kernel 2.6.15.7 and Xenomai 2.1

While writing this mail I noticed the probable reason.
parameter
#define CONFIG_X86_TSC 1 should be
#define CONFIG_XENO_X86_TSC 1

I changed this in src/include/xeno_config.h

After recompile testsuit worked.

I changed the same in
src/include/xeno_config.h.in

original line
#undef CONFIG_X86_TSC
changed to.
#undef CONFIG_XENO_X86_TSC

Then normal ./configure ... make etc.

It worked.

Thanks,

Deepak Joglekar

--------------------------------------------------------

I get following error while running test suit.


Xenomai: incompatible feature set
(required=3D"sep tsc", present=3D"sep", missing=3D"tsc").

I configured the xenomai with
./configure --enable-x86-tsc --enable-x86-sep


config.log file entries

configure:20569: checking for x86 TSC support
configure:20579: result: y
#define CONFIG_X86_TSC 1

configure:20556: checking for x86 SEP instructions in syscalls
configure:20566: result: y
#define CONFIG_XENO_X86_SEP 1


cat /proc/cpuinfo shows sep and tsc.

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm pni
monitor ds_cpl est cid cx16 xtpr

---------------------------

------=_Part_28056_7283620.1145892556199
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br>I am using kernel <a href=3D"http://2.6.15.7/" target=3D"_blank"=
 onclick=3D"return top.js.OpenExtLink(window,event,this)">2.6.15.7</a> and =
Xenomai 2.1<br><br>While writing this mail I noticed the probable reason.<b=
r>parameter=20
<br>#define CONFIG_X86_TSC 1 should be<br>#define CONFIG_XENO_X86_TSC 1=20
<br><br>I changed this in src/include/xeno_config.h<br><br>After recompile =
testsuit worked.<br><br>I changed the same in <br>src/include/xeno_config.h=
.in<br><br>original line<br>#undef CONFIG_X86_TSC<br>changed to.<br>#undef =
CONFIG_XENO_X86_TSC
<br><br>Then normal ./configure ... make etc.<br><br>It worked.<br><br>Than=
ks,<br><br>Deepak Joglekar<br><br>------------------------------<div style=
=3D"direction: ltr;">--------------------------<br><br>I get following erro=
r while running test suit.
<br><br><br>Xenomai: incompatible feature set<br>(required=3D&quot;sep tsc&=
quot;, present=3D&quot;sep&quot;, missing=3D&quot;tsc&quot;).<br><br>I conf=
igured the xenomai with<br>./configure --enable-x86-tsc --enable-x86-sep<br=
>
<br>
<br>config.log file entries<br><br>configure:20569: checking for x86 TSC su=
pport<br>configure:20579: result: y<br>#define CONFIG_X86_TSC 1<br><br>conf=
igure:20556: checking for x86 SEP instructions in syscalls<br>configure:205=
66: result: y
<br>#define CONFIG_XENO_X86_SEP 1<br><br><br>cat /proc/cpuinfo shows sep an=
d tsc.<br><br>flags&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm pni monitor
ds_cpl est cid cx16 xtpr
<br><br>---------------------------<br></div>

------=_Part_28056_7283620.1145892556199--

