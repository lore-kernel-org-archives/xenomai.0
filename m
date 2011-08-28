MIME-Version: 1.0
In-Reply-To: <4E5A294C.1060205@domain.hid>
References: <CAKvQZ_06JKNPsiGeXOC1PEnc1Je5zSDSnX9AdOHT4eraggv7Eg@domain.hid>
	<4E5A294C.1060205@domain.hid>
Date: Sun, 28 Aug 2011 17:00:15 +0200
Message-ID: <CAKvQZ_0mw_WT4s29_1_BBvm0fpqAzw-gDNYj3Jk3UQKQbmc8yw@domain.hid>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: multipart/alternative; boundary=0016364eec683f93be04ab920924
Subject: Re: [Xenomai-help] CPU frequency of 0 in a Vmware with Xenomai
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

--0016364eec683f93be04ab920924
Content-Type: text/plain; charset=ISO-8859-1

2011/8/28 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 08/28/2011 12:28 PM, Willy Lambert wrote:
> > Hi all,
> >
> > I am trying to make xenomai running into a Debian Squeeze 32b with a
> custom
> > 2.6.38.8 kernel with xenomai among other things. I am running this into a
> > Vmware for testing this before going on my real target.
> >
> > I have a "CPU frequency of 0" Error at boot, which I think is "classic"
> with
> > Vmwares :
> > http://comments.gmane.org/gmane.linux.real-time.xenomai.devel/6632
> >
> > ard@domain.hid:~$ dmesg | grep Xenomai
> > [    0.559923] Xenomai has detected a CPU frequency of 0. Aborting.
> > [    0.560923] Xenomai: system init failed, code -19.
> > [    0.560923] Xenomai: native skin init failed, code -19.
> > [    0.560923] Xenomai: starting POSIX services.
> > [    0.561923] Xenomai: POSIX skin init failed, code -19.
> > [    0.561923] Xenomai: RTDM skin init failed, code -19.
> >
> > But search didn't help me for this. See inclosed my .config (sorry it's a
> > default-full option with initrd because I am failing on the "allnoconfig"
> > little kernel for now). See below some extra informations about my system
>
> Well, there is not much we can do except telling you to use another
> emulator than vmware. Such as qemu-kvm.
>
> You can try passing hardcoded frequencies to xenomai too, for instance,
> passing on the kernel command line:
>
> xeno_hal.clockfreq=1600000000 xeno_hal.cpufreq=1600000000
>
>
FYI, I tried this with 266666666 (my CPU is supposed to be 2.67 Ghz).  And
it seems to work :

ard@domain.hid:~$ dmesg | grep -i xenomai
[    0.551139] I-pipe: Domain Xenomai registered.
[    0.551925] Xenomai: hal/i386 started.
[    0.551925] Xenomai: scheduling class idle registered.
[    0.551925] Xenomai: scheduling class rt registered.
[    0.556205] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
[    0.556782] Xenomai: debug mode enabled.
[    0.557343] Xenomai: starting native API services.
[    0.557880] Xenomai: starting POSIX services.
[    0.557924] Xenomai: starting RTDM services.

then a latency test, seems very poor but I don't have crashes or freezes of
my vm, so it's maybe enougth for the little tests we do here

ard@domain.hid$ sudo ./latency
[sudo] password for ard:
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:08  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|-805238.860|     39.992| 805197.174|  199938|     0|-805238.860|
805197.174
RTD|-804923.379| -11601.685| 805161.400|  436830|     0|-805238.860|
805197.174
RTD|-805228.091|   5754.025| 805120.060|  634285|     0|-805238.860|
805197.174
RTD|-804943.151| -11031.596| 805040.854|  857872|     0|-805238.860|
805197.174
RTD|-805067.754|   5111.708| 805198.406| 1058578|     0|-805238.860|
805198.406
RTD|-805138.682|  11571.693| 805268.393| 1281938|     0|-805238.860|
805268.393
RTD|-805258.102|   4372.316| 805229.084| 1488745|     0|-805258.102|
805268.393
RTD|-805195.347|  -4897.305| 804407.977| 1718755|     0|-805258.102|
805268.393
RTD|-805239.455|   4819.596| 805186.410| 1931971|     0|-805258.102|
805268.393
RTD|-804500.728|   5805.781| 805119.827| 2133364|     0|-805258.102|
805268.393
RTD|-805301.779| -11341.706| 805049.471| 2348149|     0|-805301.779|
805268.393
RTD|-804906.062|  14233.529| 805299.154| 2564211|     0|-805301.779|
805299.154
RTD|-805291.106|  -9540.310| 805244.326| 2787008|     0|-805301.779|
805299.154
RTD|-805215.443|   4965.735| 805227.069| 3004799|     0|-805301.779|
805299.154
RTD|-804994.282| -12456.963| 805019.644| 3236682|     0|-805301.779|
805299.154
RTD|-805159.845|   8378.373| 805274.023| 3457140|     0|-805301.779|
805299.154
RTD|-805231.812|   8954.421| 805305.622| 3672699|     0|-805301.779|
805305.622
RTD|-805262.882|  -6408.532| 805285.071| 3896346|     0|-805301.779|
805305.622
RTD|-805162.284|  -3054.744| 805140.908| 4119673|     0|-805301.779|
805305.622
RTD|-805186.673|   3575.533| 805201.685| 4338069|     0|-805301.779|
805305.622
RTD|-805267.246|  -2612.777| 804800.811| 4575505|     0|-805301.779|
805305.622
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|-805301.779|    220.813| 805305.622| 4575505|     0|
00:01:38/00:01:38
ard@domain.hid$





> But I doubt it will work unless you pass the exact frequency vmware is
> simulating.
>
> >
> >
> -----------------------------------------------------------------------------------------------
> > I read this :
> > http://www.xenomai.org/index.php/Configuring_x86_kernels
> > Here is some results. I didn't found the "Usb legacy Emulation", but as I
> > don't have the proof it is disable, please let me know if you have a
> precise
> > CONFIG name option.
>
> All these options have nothing to do with the fact that cpu frequency is
> null with vmware.
>
> "Usb legacy emulation", is done by the bios, not the kernel.
>
> > Power management disabled :
> > ard@domain.hid$ cat .config | grep APM
> > # CONFIG_APM is not set
> > ard@domain.hid$ cat .config | grep ACP
> > # Power management and ACPI options
> > # CONFIG_ACPI is not set
> > # CONFIG_PNPACPI is not set
>
> You want CONFIG_ACPI enabled, only CONFIG_ACPI_PROCESSOR should be
> disabled.
>
>
> --
>                                                                 Gilles.
>

--0016364eec683f93be04ab920924
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/8/28 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On 08/28/2011 12:28 PM, Willy Lambert wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I am trying to make xenomai running into a Debian Squeeze 32b with a c=
ustom<br>
&gt; 2.6.38.8 kernel with xenomai among other things. I am running this int=
o a<br>
&gt; Vmware for testing this before going on my real target.<br>
&gt;<br>
&gt; I have a &quot;CPU frequency of 0&quot; Error at boot, which I think i=
s &quot;classic&quot; with<br>
&gt; Vmwares :<br>
&gt; <a href=3D"http://comments.gmane.org/gmane.linux.real-time.xenomai.dev=
el/6632" target=3D"_blank">http://comments.gmane.org/gmane.linux.real-time.=
xenomai.devel/6632</a><br>
&gt;<br>
&gt; ard@domain.hid:~$ dmesg | grep Xenomai<br>
&gt; [ =A0 =A00.559923] Xenomai has detected a CPU frequency of 0. Aborting=
.<br>
&gt; [ =A0 =A00.560923] Xenomai: system init failed, code -19.<br>
&gt; [ =A0 =A00.560923] Xenomai: native skin init failed, code -19.<br>
&gt; [ =A0 =A00.560923] Xenomai: starting POSIX services.<br>
&gt; [ =A0 =A00.561923] Xenomai: POSIX skin init failed, code -19.<br>
&gt; [ =A0 =A00.561923] Xenomai: RTDM skin init failed, code -19.<br>
&gt;<br>
&gt; But search didn&#39;t help me for this. See inclosed my .config (sorry=
 it&#39;s a<br>
&gt; default-full option with initrd because I am failing on the &quot;alln=
oconfig&quot;<br>
&gt; little kernel for now). See below some extra informations about my sys=
tem<br>
<br>
</div>Well, there is not much we can do except telling you to use another<b=
r>
emulator than vmware. Such as qemu-kvm.<br>
<br>
You can try passing hardcoded frequencies to xenomai too, for instance,<br>
passing on the kernel command line:<br>
<br>
xeno_hal.clockfreq=3D1600000000 xeno_hal.cpufreq=3D1600000000<br>
<br></blockquote><div><br>FYI, I tried this with 266666666 (my CPU is suppo=
sed to be 2.67 Ghz).=A0 And it seems to work :<br><br>ard@domain.hid:~$ dmesg=
 | grep -i xenomai<br>[=A0=A0=A0 0.551139] I-pipe: Domain Xenomai registere=
d.<br>
[=A0=A0=A0 0.551925] Xenomai: hal/i386 started.<br>[=A0=A0=A0 0.551925] Xen=
omai: scheduling class idle registered.<br>[=A0=A0=A0 0.551925] Xenomai: sc=
heduling class rt registered.<br>[=A0=A0=A0 0.556205] Xenomai: real-time nu=
cleus v2.5.6 (Wormhole Wizards) loaded.<br>
[=A0=A0=A0 0.556782] Xenomai: debug mode enabled.<br>[=A0=A0=A0 0.557343] X=
enomai: starting native API services.<br>[=A0=A0=A0 0.557880] Xenomai: star=
ting POSIX services.<br>[=A0=A0=A0 0.557924] Xenomai: starting RTDM service=
s.<br><br>then a latency test, seems very poor but I don&#39;t have crashes=
 or freezes of my vm, so it&#39;s maybe enougth for the little tests we do =
here<br>
<br>ard@domain.hid$ sudo ./latency <br>[sudo] password for a=
rd: <br>=3D=3D Sampling period: 100 us<br>=3D=3D Test mode: periodic user-m=
ode task<br>=3D=3D All results in microseconds<br>warming up...<br>RTT|=A0 =
00:00:08=A0 (periodic user-mode task, 100 us period, priority 99)<br>
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst<br>RTD|-805238.860|=A0=A0=A0=A0 39.992| 805197.174|=A0 199938|=A0=A0=
=A0=A0 0|-805238.860| 805197.174<br>RTD|-804923.379| -11601.685| 805161.400=
|=A0 436830|=A0=A0=A0=A0 0|-805238.860| 805197.174<br>
RTD|-805228.091|=A0=A0 5754.025| 805120.060|=A0 634285|=A0=A0=A0=A0 0|-8052=
38.860| 805197.174<br>RTD|-804943.151| -11031.596| 805040.854|=A0 857872|=
=A0=A0=A0=A0 0|-805238.860| 805197.174<br>RTD|-805067.754|=A0=A0 5111.708| =
805198.406| 1058578|=A0=A0=A0=A0 0|-805238.860| 805198.406<br>
RTD|-805138.682|=A0 11571.693| 805268.393| 1281938|=A0=A0=A0=A0 0|-805238.8=
60| 805268.393<br>RTD|-805258.102|=A0=A0 4372.316| 805229.084| 1488745|=A0=
=A0=A0=A0 0|-805258.102| 805268.393<br>RTD|-805195.347|=A0 -4897.305| 80440=
7.977| 1718755|=A0=A0=A0=A0 0|-805258.102| 805268.393<br>
RTD|-805239.455|=A0=A0 4819.596| 805186.410| 1931971|=A0=A0=A0=A0 0|-805258=
.102| 805268.393<br>RTD|-804500.728|=A0=A0 5805.781| 805119.827| 2133364|=
=A0=A0=A0=A0 0|-805258.102| 805268.393<br>RTD|-805301.779| -11341.706| 8050=
49.471| 2348149|=A0=A0=A0=A0 0|-805301.779| 805268.393<br>
RTD|-804906.062|=A0 14233.529| 805299.154| 2564211|=A0=A0=A0=A0 0|-805301.7=
79| 805299.154<br>RTD|-805291.106|=A0 -9540.310| 805244.326| 2787008|=A0=A0=
=A0=A0 0|-805301.779| 805299.154<br>RTD|-805215.443|=A0=A0 4965.735| 805227=
.069| 3004799|=A0=A0=A0=A0 0|-805301.779| 805299.154<br>
RTD|-804994.282| -12456.963| 805019.644| 3236682|=A0=A0=A0=A0 0|-805301.779=
| 805299.154<br>RTD|-805159.845|=A0=A0 8378.373| 805274.023| 3457140|=A0=A0=
=A0=A0 0|-805301.779| 805299.154<br>RTD|-805231.812|=A0=A0 8954.421| 805305=
.622| 3672699|=A0=A0=A0=A0 0|-805301.779| 805305.622<br>
RTD|-805262.882|=A0 -6408.532| 805285.071| 3896346|=A0=A0=A0=A0 0|-805301.7=
79| 805305.622<br>RTD|-805162.284|=A0 -3054.744| 805140.908| 4119673|=A0=A0=
=A0=A0 0|-805301.779| 805305.622<br>RTD|-805186.673|=A0=A0 3575.533| 805201=
.685| 4338069|=A0=A0=A0=A0 0|-805301.779| 805305.622<br>
RTD|-805267.246|=A0 -2612.777| 804800.811| 4575505|=A0=A0=A0=A0 0|-805301.7=
79| 805305.622<br>^C---|-----------|-----------|-----------|--------|------=
|-------------------------<br>RTS|-805301.779|=A0=A0=A0 220.813| 805305.622=
| 4575505|=A0=A0=A0=A0 0|=A0=A0=A0 00:01:38/00:01:38<br>
ard@domain.hid$ <br><br><br><br>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">
But I doubt it will work unless you pass the exact frequency vmware is<br>
simulating.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
-------------------------<br>
&gt; I read this :<br>
&gt; <a href=3D"http://www.xenomai.org/index.php/Configuring_x86_kernels" t=
arget=3D"_blank">http://www.xenomai.org/index.php/Configuring_x86_kernels</=
a><br>
&gt; Here is some results. I didn&#39;t found the &quot;Usb legacy Emulatio=
n&quot;, but as I<br>
&gt; don&#39;t have the proof it is disable, please let me know if you have=
 a precise<br>
&gt; CONFIG name option.<br>
<br>
</div>All these options have nothing to do with the fact that cpu frequency=
 is<br>
null with vmware.<br>
<br>
&quot;Usb legacy emulation&quot;, is done by the bios, not the kernel.<br>
<div class=3D"im"><br>
&gt; Power management disabled :<br>
&gt; ard@domain.hid$ cat .config | grep APM<br>
&gt; # CONFIG_APM is not set<br>
&gt; ard@domain.hid$ cat .config | grep ACP<br>
&gt; # Power management and ACPI options<br>
&gt; # CONFIG_ACPI is not set<br>
&gt; # CONFIG_PNPACPI is not set<br>
<br>
</div>You want CONFIG_ACPI enabled, only CONFIG_ACPI_PROCESSOR should be di=
sabled.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--0016364eec683f93be04ab920924--

