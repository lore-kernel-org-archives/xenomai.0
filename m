MIME-Version: 1.0
In-Reply-To: <4F1493B5.1000501@domain.hid>
References: <CAP1XtZzB34=+B+fwWpswhqfFVMd3YmU4etoYOSxXFOMbEH7myg@domain.hid>
	<4F1493B5.1000501@domain.hid>
Date: Tue, 17 Jan 2012 21:19:01 +0100
Message-ID: <CAP1XtZyPdegxcce3Xv4mKCbrjspQPQKCL4jeqrVRzubadqX_vg@domain.hid>
From: Santiago Focke <focke.85@domain.hid>
Content-Type: multipart/alternative; boundary=f46d0447a071b826f004b6bf0afc
Subject: Re: [Xenomai-help] Processor type for installation
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

--f46d0447a071b826f004b6bf0afc
Content-Type: text/plain; charset=ISO-8859-1

Thanks Gilles for the replay

2012/1/16 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
> On 01/16/2012 09:03 PM, Santiago Focke wrote:
> > Dear all
> >
> > I've been trying to install Xenomai but I haven't been able to do it
> > right.  After being able of building and installin the kernel and
Xenomai,
> > I tried to run the example program trivial-periodic, I got the following
> > error
>
> We do not know which kernel version, which xenomai version, which adeos
> I-pipe version.
>

Sorry I didn't write the kernel + xenomai specifications. I'm using
linux-2.6.38.8 and xenomai 2.6. About Adeos and I-pipe, should I do any
kind of installation of the before installing Xenomai??

> >
> > /usr/src/xenomai-2.6/examples/native$ ./trivial-periodic
> > Xenomai: incompatible feature set
> > (userland requires "tsc fastsynch", kernel provides "sep fastsynch smp",
> > missing="tsc").
> >
> > I read that the reason for this is that I didn't configure correctly the
> > processor family (with xconfig). Is that the reason? Also, I've been
trying
> > to know which option should I choose (I chose CONFIG_M586 at the
> > beggining), but I don't know were to get that information. The CPU info
> > goes as follows:
> >
> > /proc/cpuinfo
> >
> > processor    : 0
> > vendor_id    : GenuineIntel
> > cpu family    : 6
> > model        : 37
> > model name    : Intel(R) Core(TM) i7 CPU       M 620  @ 2.67GHz
>
> So, you have a core i7, anything newer than "pentium pro" (an older than
> ten years old architecture) should do, but better select the processor
> you actually have or the nearest substitute: so, assuming you are
> compiling a 2.6.38 kernel, "core 2/newer xeon" should do. Also note that
> a core i7 is able to run in 64 bits mode, so running it in 32 bits mode
> is a bit a pity.
>
Regarding the processor family, i selected 'core 2/newer xeon', and tried
to build a 64-bits kernel. But when I tried to boot the new patched kernel,
I got the following error and get stacked in the booting:

[     0.051013] ..MP_BIOS bug: 8254 timer not conncted to IO-APIC
[     2.338200] EXT3-fs (sda1) error: couldn't mount because of unsupported
optional features (240)
[     2.362370] EXT3-fs (sda1) error: couldn't mount because of unsupported
optional features (240)
[     2.400400] request_module: runaway loop modprobebinfmt-464c
[     2.400449] request_module: runaway loop modprobebinfmt-464c
[     2.400570] request_module: runaway loop modprobebinfmt-464c
[     2.400612] request_module: runaway loop modprobebinfmt-464c
[     2.400755] request_module: runaway loop modprobebinfmt-464c

I don't know if I did something wrong in the installation process. These
were my steps:

1.   sudo git clone http://git.xenomai.org/xenomai-2.6.git/usr/src/xenomai-2.6

2.   /usr/src/xenomai-2.6/scripts/prepare-kernel.sh
--linux=/home/corbys/linux-2.6.38.8/
--adeos=/usr/src/xenomai-2.6/ksrc/arch/x86/patches/adeos-ipipe-2.6.38.8-x86-2.11-01.patch
--arch=x86_64

3.   cd ~/linux-2.6.38.8/

4.   make ARCH=x86 xconfig

   #I had to put ARCH=x86 because otherwise it didn't let me select
CONFIG_64BIT

   #Set 64-bits option
   * CONFIG_64BIT

   #Select the processor family
   * CONFIG_MCORE2

   #Be sure the following kernel settings were unmarked:
    * CONFIG_CPU_FREQ
    * CONFIG_APM
    * CONFIG_ACPI_PROCESSOR
    * CONFIG_INTEL_IDLE
    * CONFIG_PCI_MSI

5.   make ARCH=x86 bzImage modules

6.   mkdir ~/build/linux-2.6.38.8 && cd ~/build/linux-2.6.38.8

7.   /usr/src/xenomai-2.6/configure

8.   sudo make install

9.   sudo cp /home/corbys/linux-2.6.38.8/arch/x86/boot/bzImage
/boot/vmlinuz-2.6.38.8-xenomai-2.6

10.
   sudo addgroup xenomai
    sudo usermod -a -G xenomai user1
    sudo usermod -a -G xenomai user2

11. sudo update-grub

12. Restart computer and boot in new kernel

>
> --
>                                                                Gilles.


-- 
Santiago Focke

--f46d0447a071b826f004b6bf0afc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks Gilles for the replay<br><br><span style=3D"color:rgb(0,102,0)">2012=
/1/16 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
ai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br style=3D"color:r=
gb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt;</span><br style=3D"color:rgb(0,102,=
0)"><span style=3D"color:rgb(0,102,0)">&gt; On 01/16/2012 09:03 PM, Santiag=
o Focke wrote:</span><br style=3D"color:rgb(0,102,0)"><span style=3D"color:=
rgb(0,102,0)">&gt; &gt; Dear all</span><br style=3D"color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt;</span><br style=3D"color:rgb(0=
,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; &gt; I&#39;ve been trying =
to install Xenomai but I haven&#39;t been able to do it</span><br style=3D"=
color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt; right. =A0After being able of =
building and installin the kernel and Xenomai,</span><br style=3D"color:rgb=
(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; &gt; I tried to run the =
example program trivial-periodic, I got the following</span><br style=3D"co=
lor:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt; error</span><br style=3D"color=
:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt;</span><br style=3D"c=
olor:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; We do not know w=
hich kernel version, which xenomai version, which adeos</span><br style=3D"=
color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; I-pipe version.</span><br style=3D"=
color:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt;</span><br><br>S=
orry I didn&#39;t write the kernel + xenomai specifications. I&#39;m using=
=20
linux-2.6.38.8 and xenomai 2.6. About Adeos and I-pipe, should I do any=20
kind of installation of the before installing Xenomai??<br><br style=3D"col=
or:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; &gt;</span><br sty=
le=3D"color:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; &gt; /usr=
/src/xenomai-2.6/examples/native$ ./trivial-periodic</span><br style=3D"col=
or:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt; Xenomai: incompatible feature =
set</span><br style=3D"color:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0=
)">&gt; &gt; (userland requires &quot;tsc fastsynch&quot;, kernel provides =
&quot;sep fastsynch smp&quot;,</span><br style=3D"color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt; missing=3D&quot;tsc&quot;).</s=
pan><br style=3D"color:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt=
; &gt;</span><br style=3D"color:rgb(0,102,0)"><span style=3D"color:rgb(0,10=
2,0)">&gt; &gt; I read that the reason for this is that I didn&#39;t config=
ure correctly the</span><br style=3D"color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt; processor family (with xconfig=
). Is that the reason? Also, I&#39;ve been trying</span><br style=3D"color:=
rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; &gt; to know which op=
tion should I choose (I chose CONFIG_M586 at the</span><br style=3D"color:r=
gb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt; beggining), but I don&#39;t kn=
ow were to get that information. The CPU info</span><br style=3D"color:rgb(=
0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; &gt; goes as follows:</sp=
an><br style=3D"color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt;</span><br style=3D"color:rgb(0=
,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; &gt; /proc/cpuinfo</span><=
br style=3D"color:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; &gt=
;</span><br style=3D"color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt; processor =A0 =A0: 0</span><br=
 style=3D"color:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; &gt; =
vendor_id =A0 =A0: GenuineIntel</span><br style=3D"color:rgb(0,102,0)"><spa=
n style=3D"color:rgb(0,102,0)">&gt; &gt; cpu family =A0 =A0: 6</span><br st=
yle=3D"color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; &gt; model =A0 =A0 =A0 =A0: 37</spa=
n><br style=3D"color:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; =
&gt; model name =A0 =A0: Intel(R) Core(TM) i7 CPU =A0 =A0 =A0 M 620 =A0@ 2.=
67GHz</span><br style=3D"color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt;</span><br style=3D"color:rgb(0,102,=
0)"><span style=3D"color:rgb(0,102,0)">&gt; So, you have a core i7, anythin=
g newer than &quot;pentium pro&quot; (an older than</span><br style=3D"colo=
r:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; ten years old architecture) should =
do, but better select the processor</span><br style=3D"color:rgb(0,102,0)">=
<span style=3D"color:rgb(0,102,0)">&gt; you actually have or the nearest su=
bstitute: so, assuming you are</span><br style=3D"color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; compiling a 2.6.38 kernel, &quot;co=
re 2/newer xeon&quot; should do. Also note that</span><br style=3D"color:rg=
b(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; a core i7 is able to ru=
n in 64 bits mode, so running it in 32 bits mode</span><br style=3D"color:r=
gb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt; is a bit a pity.</span><br style=3D=
"color:rgb(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt;</span><br>Rega=
rding the processor family, i selected &#39;core 2/newer xeon&#39;, and=20
tried to build a 64-bits kernel. But when I tried to boot the new=20
patched kernel, I got the following error and get stacked in the=20
booting:<br>
<br>
<div style=3D"margin-left:40px">[=A0=A0=A0=A0 0.051013] ..MP_BIOS bug: 8254=
 timer not conncted to IO-APIC<br>
[=A0=A0=A0=A0 2.338200] EXT3-fs (sda1) error: couldn&#39;t mount because of=
 unsupported optional features (240)<br>

[=A0=A0=A0=A0 2.362370] EXT3-fs (sda1) error:  couldn&#39;t mount because o=
f unsupported optional features (240)<br>
[=A0=A0=A0=A0 2.400400] request_module: runaway loop modprobebinfmt-464c<br=
>

[=A0=A0=A0=A0 2.400449] request_module: runaway  loop modprobebinfmt-464c<b=
r>

[=A0=A0=A0=A0 2.400570] request_module: runaway  loop modprobebinfmt-464c<b=
r>

[=A0=A0=A0=A0 2.400612] request_module: runaway  loop modprobebinfmt-464c<b=
r>

[=A0=A0=A0=A0 2.400755] request_module: runaway  loop modprobebinfmt-464c<b=
r><br></div>I don&#39;t know if I did something wrong in the installation p=
rocess. These were my steps:<br><br>1.=A0=A0 sudo git clone <a href=3D"http=
://git.xenomai.org/xenomai-2.6.git">http://git.xenomai.org/xenomai-2.6.git<=
/a> /usr/src/xenomai-2.6<br>
<br>2.=A0=A0 /usr/src/xenomai-2.6/scripts/prepare-kernel.sh --linux=3D/home=
/corbys/linux-2.6.38.8/ --adeos=3D/usr/src/xenomai-2.6/ksrc/arch/x86/patche=
s/adeos-ipipe-2.6.38.8-x86-2.11-01.patch --arch=3Dx86_64<br><br>3.=A0=A0 cd=
 ~/linux-2.6.38.8/<br>
<br>4.=A0=A0 make ARCH=3Dx86 xconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br><br>=
=A0=A0 #I had to put ARCH=3Dx86 because otherwise it didn&#39;t let me sele=
ct CONFIG_64BIT<br><br>=A0=A0 #Set 64-bits option<br>=A0=A0 * CONFIG_64BIT<=
br><br>=A0=A0 #Select the processor family<br>
=A0=A0 * CONFIG_MCORE2<br><br>=A0=A0 #Be sure the following kernel settings=
 were unmarked:<br>=A0=A0=A0 * CONFIG_CPU_FREQ <br>=A0=A0=A0 * CONFIG_APM <=
br>=A0=A0=A0 * CONFIG_ACPI_PROCESSOR <br>=A0=A0=A0 * CONFIG_INTEL_IDLE <br>=
=A0=A0=A0 * CONFIG_PCI_MSI <br><br>
5.=A0=A0 make ARCH=3Dx86 bzImage modules<br><br>6.=A0=A0 mkdir ~/build/linu=
x-2.6.38.8 &amp;&amp; cd ~/build/linux-2.6.38.8<br><br>7. =A0 /usr/src/xeno=
mai-2.6/configure<br><br>8. =A0 sudo make install<br><br>9. =A0 sudo cp /ho=
me/corbys/linux-2.6.38.8/arch/x86/boot/bzImage /boot/vmlinuz-2.6.38.8-xenom=
ai-2.6<br>
<br>10. <br>=A0=A0 sudo addgroup xenomai<br>=A0=A0=A0 sudo usermod -a -G xe=
nomai user1<br>=A0=A0=A0 sudo usermod -a -G xenomai user2<br><br>11. sudo u=
pdate-grub<br><br>12. Restart computer and boot in new kernel<br><br style=
=3D"color:rgb(0,102,0)">
<span style=3D"color:rgb(0,102,0)">&gt;</span><br style=3D"color:rgb(0,102,=
0)"><span style=3D"color:rgb(0,102,0)">&gt; --</span><br style=3D"color:rgb=
(0,102,0)"><span style=3D"color:rgb(0,102,0)">&gt; =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.</span><br>
<br clear=3D"all"><br>-- <br>Santiago Focke<br>

--f46d0447a071b826f004b6bf0afc--

