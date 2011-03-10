MIME-Version: 1.0
Sender: madjsw@domain.hid
Date: Thu, 10 Mar 2011 17:21:32 -0600
Message-ID: <AANLkTik+Mm_0Xn4kAOs-9B-AGVi0+G8k+ZJUd4LTAJ-j@domain.hid>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d972bf1fdb16049e291baf
Subject: [Xenomai-help] removing Xenomai modules hangs system
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

--0016e6d972bf1fdb16049e291baf
Content-Type: text/plain; charset=ISO-8859-1

When I remove a skin module for the second time, my system hangs.  I get the
same results with Xenomai-2.5.5.2 and -2.5.6.  I get the same results
removing either xeno_rtdm and xeno_native the second time.  This problem
occurs if all I do is load and unload Xenomai modules, and never load other
modules, or start applications.  Hardware is Intel(R) Core(TM)2 Duo CPU .

xeno2:~ # modprobe -v xeno_rtdm
insmod
/lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko
xenomai_gid=1000
insmod
/lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko

xeno2:~ # modprobe -v -r xeno_rtdm
rmmod
/lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko
rmmod
/lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko

xeno2:~ # insmod
/lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko
xenomai_gid=1000

xeno2:~ # insmod
/lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko

xeno2:~ # rmmod -v
/lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko
rmmod xeno_rtdm, wait=no

<system hangs here>


Here's the kernel log before the hang:

[   56.244307] I-pipe: Domain Xenomai registered.
[   56.244363] Xenomai: hal/i386 started.
[   56.244389] Xenomai: scheduling class idle registered.
[   56.244393] Xenomai: scheduling class rt registered.
[   56.258394] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
[   56.258400] Xenomai: debug mode enabled.
[   56.323052] Xenomai: SMI-enabled chipset found
[   56.323067] Xenomai: SMI workaround enabled
[   56.323116] Xenomai: starting RTDM services.
[   63.556015] Xenomai: stopping RTDM services.
[   63.606033] Xenomai: SMI configuration restored
[   63.608524] I-pipe: Domain Xenomai unregistered.
[   63.608529] Xenomai: hal/i386 stopped.
[   63.610270] Xenomai: real-time nucleus unloaded.
[  130.440143] I-pipe: Domain Xenomai registered.
[  130.440198] Xenomai: hal/i386 started.
[  130.440239] Xenomai: scheduling class idle registered.
[  130.440244] Xenomai: scheduling class rt registered.
[  130.453914] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
[  130.453921] Xenomai: debug mode enabled.
[  143.967395] Xenomai: SMI-enabled chipset found
[  143.967411] Xenomai: SMI workaround enabled
[  143.967467] Xenomai: starting RTDM services.

--0016e6d972bf1fdb16049e291baf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

When I remove a skin module for the second time, my system hangs.=A0 I get =
the same results with Xenomai-2.5.5.2 and -2.5.6.=A0 I get the same results=
 removing either xeno_rtdm and xeno_native the second time.=A0 This problem=
 occurs if all I do is load and unload Xenomai modules, and never load othe=
r modules, or start applications.=A0 Hardware is Intel(R) Core(TM)2 Duo CPU=
 .<br>
<br>xeno2:~ # modprobe -v xeno_rtdm<br>insmod /lib/modules/2.6.37.3-xeno-2.=
5.6-smp/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko xenomai_gid=3D1000<br=
>insmod /lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/skins/rt=
dm/xeno_rtdm.ko<br>
<br>xeno2:~ # modprobe -v -r xeno_rtdm<br>rmmod /lib/modules/2.6.37.3-xeno-=
2.5.6-smp/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko<br>rmmod /lib/modul=
es/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko<br=
>
<br>xeno2:~ # insmod /lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xen=
omai/nucleus/xeno_nucleus.ko xenomai_gid=3D1000<br><br>xeno2:~ # insmod /li=
b/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/xenomai/skins/rtdm/xeno_rtd=
m.ko<br>
<br>xeno2:~ # rmmod -v /lib/modules/2.6.37.3-xeno-2.5.6-smp/kernel/kernel/x=
enomai/skins/rtdm/xeno_rtdm.ko<br>rmmod xeno_rtdm, wait=3Dno<br><br>&lt;sys=
tem hangs here&gt;<br><br><br>Here&#39;s the kernel log before the hang:<br=
>
<br>[=A0=A0 56.244307] I-pipe: Domain Xenomai registered.<br>[=A0=A0 56.244=
363] Xenomai: hal/i386 started.<br>[=A0=A0 56.244389] Xenomai: scheduling c=
lass idle registered.<br>[=A0=A0 56.244393] Xenomai: scheduling class rt re=
gistered.<br>
[=A0=A0 56.258394] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loa=
ded.<br>[=A0=A0 56.258400] Xenomai: debug mode enabled.<br>[=A0=A0 56.32305=
2] Xenomai: SMI-enabled chipset found<br>[=A0=A0 56.323067] Xenomai: SMI wo=
rkaround enabled<br>
[=A0=A0 56.323116] Xenomai: starting RTDM services.<br>[=A0=A0 63.556015] X=
enomai: stopping RTDM services.<br>[=A0=A0 63.606033] Xenomai: SMI configur=
ation restored<br>[=A0=A0 63.608524] I-pipe: Domain Xenomai unregistered.<b=
r>[=A0=A0 63.608529] Xenomai: hal/i386 stopped.<br>
[=A0=A0 63.610270] Xenomai: real-time nucleus unloaded.<br>[=A0 130.440143]=
 I-pipe: Domain Xenomai registered.<br>[=A0 130.440198] Xenomai: hal/i386 s=
tarted.<br>[=A0 130.440239] Xenomai: scheduling class idle registered.<br>[=
=A0 130.440244] Xenomai: scheduling class rt registered.<br>
[=A0 130.453914] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loade=
d.<br>[=A0 130.453921] Xenomai: debug mode enabled.<br>[=A0 143.967395] Xen=
omai: SMI-enabled chipset found<br>[=A0 143.967411] Xenomai: SMI workaround=
 enabled<br>
[=A0 143.967467] Xenomai: starting RTDM services.<br><br>

--0016e6d972bf1fdb16049e291baf--

