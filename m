MIME-Version: 1.0
In-Reply-To: <4D222F88.9000905@domain.hid>
References: <AANLkTin3RZggnBPuFzfWgLiaARBJQE+u0iN-+m=Z80j9@domain.hid>
	<AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>
	<4D1F4BA4.6090000@domain.hid>
	<AANLkTik-H5J-Wp=6Oc8ne_G+m=qzWyUTDTNdUiLjUJPt@domain.hid>
	<4D1FA645.1000101@domain.hid>
	<AANLkTim1wpPyNNUFWot0KRVZoQTz1fwxuyP259VrkHiU@mail.gmail.com>
	<1294068560.1837.72.camel@domain.hid>
	<1294069047.1837.79.camel@domain.hid>
	<AANLkTinfZLuYCBuqiUZLBoRYagwu0S6q9DSESouWFZrP@mail.gmail.com>
	<4D222F88.9000905@domain.hid>
Date: Tue, 4 Jan 2011 22:29:55 -0200
Message-ID: <AANLkTi=9y6c=pmS1jg3xNTbzygUjMDBJOfoudhLTTAtw@domain.hid>
From: Alexandre Oliveira <alexandrenagy@domain.hid>
Content-Type: multipart/alternative; boundary=001636c931e4f7867804990e7b79
Subject: Re: [Xenomai-help] Problems with Installation. Error message in
 xeno-test: "Xenomai: /dev/rtheap is missing".
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--001636c931e4f7867804990e7b79
Content-Type: text/plain; charset=ISO-8859-1

Well, I did some changes and the problem still remain. I'm posting for
updating.

I installed Ubuntu 10.10, just to see if the pure system identify the
processor correctly. The answer is yes.

====
phall@domain.hid:~$ cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 15
model        : 4
model name    : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping    : 3
cpu MHz        : 2999.838
cache size    : 2048 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 1
apicid        : 0
initial apicid    : 0
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 5
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc pebs
bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
bogomips    : 5999.67
clflush size    : 64
cache_alignment    : 128
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 15
model        : 4
model name    : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping    : 3
cpu MHz        : 2999.838
cache size    : 2048 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 1
apicid        : 1
initial apicid    : 1
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 5
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc pebs
bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
bogomips    : 6000.61
clflush size    : 64
cache_alignment    : 128
address sizes    : 36 bits physical, 48 bits virtual
power management:
=====

So, I looked in the original configure file of the kernel and it is compiled
with 'Pentium Pro' processor.

Ok, then I restart to compile the kernel, by checking all issues at:
http://www.xenomai.org/index.php/Configuring_x86_kernels

I choosed Pentium 4 processor.

CONFIG_APM disable.
CONFIG_ACPI_PROCESSOR disable.
CONFIG_CPU_FREQ disable.
CONFIG_INPUT_PCSPKR disable.
SMI disable (like before).

The difference between the later ones is:
Before, I disabled all ACPI. Now, I just disabled that ones at the FAQ.
CONFIG_CPU_FREQ was disabled.

So, when I boot the new kernel, the /proc/cpuinfo returns 0.00 of CPU
Frequency again...

The problem is the error at identifying the processor.
The new /proc/cpuinfo returns only one processor... not the both nucleus,
like that one up here.
I really didn't could identify what option could do this.
I compile the kernel with the PENTIUM PRO type... and the same bug occurs.

At my house, worked in a Atlhon X2 4400+.

I'm testing now at another computer of the Laboratory with a Intel Core 2
Duo.

I'm going to continue the tries. I realy intend to send another e-mail with
the solution. :)

Another time, I really thank you all for the help. Let's keep going.

Att.
Alexandre.


2011/1/3 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Alexandre Oliveira wrote:
> > root@domain.hid# cpufreq-set -f 3.0Ghz
> > No cpufreq support
> > root@domain.hid#
>
> That is normal, cpufreq support should be disabled if you intend Xenomai
> to work correctly.
>
> --
>                                                                 Gilles.
>

--001636c931e4f7867804990e7b79
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Well, I did some changes and the problem still remain. I&#39;m posting for =
updating.<br><br>I installed Ubuntu 10.10, just to see if the pure system i=
dentify the processor correctly. The answer is yes.<br><br>=3D=3D=3D=3D<br>=
phall@domain.hid:~$ cat /proc/cpuinfo <br>



processor=A0=A0=A0 : 0<br>vendor_id=A0=A0=A0 : GenuineIntel<br>cpu family=
=A0=A0=A0 : 15<br>model=A0=A0=A0 =A0=A0=A0 : 4<br>model name=A0=A0=A0 : Int=
el(R) Pentium(R) 4 CPU 3.00GHz<br>stepping=A0=A0=A0 : 3<br>cpu MHz=A0=A0=A0=
 =A0=A0=A0 : 2999.838<br>cache size=A0=A0=A0 : 2048 KB<br>



physical id=A0=A0=A0 : 0<br>siblings=A0=A0=A0 : 2<br>core id=A0=A0=A0 =A0=
=A0=A0 : 0<br>cpu cores=A0=A0=A0 : 1<br>apicid=A0=A0=A0 =A0=A0=A0 : 0<br>in=
itial apicid=A0=A0=A0 : 0<br>fdiv_bug=A0=A0=A0 : no<br>hlt_bug=A0=A0=A0 =A0=
=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=A0 : no<br>fpu=A0=
=A0=A0 =A0=A0=A0 : yes<br>



fpu_exception=A0=A0=A0 : yes<br>cpuid level=A0=A0=A0 : 5<br>wp=A0=A0=A0 =A0=
=A0=A0 : yes<br>flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce c=
x8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss h=
t tm pbe lm constant_tsc pebs bts pni dtes64 monitor ds_cpl est cid cx16 xt=
pr<br>



bogomips=A0=A0=A0 : 5999.67<br>clflush size=A0=A0=A0 : 64<br>cache_alignmen=
t=A0=A0=A0 : 128<br>address sizes=A0=A0=A0 : 36 bits physical, 48 bits virt=
ual<br>power management:<br><br>processor=A0=A0=A0 : 1<br>vendor_id=A0=A0=
=A0 : GenuineIntel<br>cpu family=A0=A0=A0 : 15<br>



model=A0=A0=A0 =A0=A0=A0 : 4<br>model name=A0=A0=A0 : Intel(R) Pentium(R) 4=
 CPU 3.00GHz<br>stepping=A0=A0=A0 : 3<br>cpu MHz=A0=A0=A0 =A0=A0=A0 : 2999.=
838<br>cache size=A0=A0=A0 : 2048 KB<br>physical id=A0=A0=A0 : 0<br>sibling=
s=A0=A0=A0 : 2<br>core id=A0=A0=A0 =A0=A0=A0 : 0<br>cpu cores=A0=A0=A0 : 1<=
br>



apicid=A0=A0=A0 =A0=A0=A0 : 1<br>initial apicid=A0=A0=A0 : 1<br>fdiv_bug=A0=
=A0=A0 : no<br>hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br=
>coma_bug=A0=A0=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=A0=
=A0=A0 : yes<br>cpuid level=A0=A0=A0 : 5<br>wp=A0=A0=A0 =A0=A0=A0 : yes<br>=
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge=
 mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm cons=
tant_tsc pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr<br>



bogomips=A0=A0=A0 : 6000.61<br>clflush size=A0=A0=A0 : 64<br>cache_alignmen=
t=A0=A0=A0 : 128<br>address sizes=A0=A0=A0 : 36 bits physical, 48 bits virt=
ual<br>power management:<br>=3D=3D=3D=3D=3D<br><br>So, I looked in the orig=
inal configure file of the kernel and it is compiled with &#39;Pentium Pro&=
#39; processor.<br>



<br>Ok, then I restart to compile the kernel, by checking all issues at:<br=
><a href=3D"http://www.xenomai.org/index.php/Configuring_x86_kernels" targe=
t=3D"_blank">http://www.xenomai.org/index.php/Configuring_x86_kernels</a><b=
r>


<br>I choosed Pentium 4 processor.<br>
<br>CONFIG_APM disable.<br>CONFIG_ACPI_PROCESSOR
disable.<br>CONFIG_CPU_FREQ disable.<br>CONFIG_INPUT_PCSPKR disable.<br>SMI=
 disable (like before).<br><br>The difference between the later ones is:<br=
>Before, I disabled all ACPI. Now, I just disabled that ones at the FAQ.<br=
>



CONFIG_CPU_FREQ was disabled.<br><br>So, when I boot the new kernel, the /p=
roc/cpuinfo returns 0.00 of CPU Frequency again...<br><br>The problem is th=
e error at identifying the processor.<br>The new /proc/cpuinfo returns only=
 one processor... not the both nucleus, like that one up here.<br>
I really didn&#39;t could identify what option could do this.<br>I compile =
the kernel with the PENTIUM PRO type... and the same bug occurs.<br><br>At =
my house, worked in a Atlhon X2 4400+. <br><br>I&#39;m testing now at anoth=
er computer of the Laboratory with a Intel Core 2 Duo.<br>
<br>I&#39;m going to continue the tries. I realy intend to send another e-m=
ail with the solution. :)<br><br>Another time, I really thank you all for t=
he help. Let&#39;s keep going.<br><br>Att.<br>Alexandre.<br><br><br><div cl=
ass=3D"gmail_quote">
2011/1/3 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gille=
s.chanteperdrix@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org=
.org</a>&gt;</span><br>


<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div>Alexandre Ol=
iveira wrote:<br>
&gt; root@domain.hid# cpufreq-set -f 3.0Ghz<br>
&gt; No cpufreq support<br>
&gt; root@domain.hid#<br>
<br>
</div>That is normal, cpufreq support should be disabled if you intend Xeno=
mai<br>
to work correctly.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--001636c931e4f7867804990e7b79--

