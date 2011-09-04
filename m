MIME-Version: 1.0
Date: Sun, 4 Sep 2011 21:05:40 +0200
Message-ID: <CAPRPZsCOSWYjHqGv0L+9ip+wkegMiV3GJBsGWtRjV2W=BsdOQw@domain.hid>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec520f71fd5b05d04ac22477e
Subject: [Xenomai-help] Build issue Linux kernel 2.6.38.8 - Xenomai 2.5.6
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

--bcaec520f71fd5b05d04ac22477e
Content-Type: text/plain; charset=ISO-8859-1

I have patched a 2.6.38.8 kernel with the Adeos 2.10-01 patch. All Xenomai
2.5.6 built-in in the kernel. The system boots properly on an Atom D525:


> [    0.510257] I-pipe: Domain Xenomai registered.
> [    0.510493] Xenomai: hal/i386 started.
> [    0.510626] Xenomai: scheduling class idle registered.
> [    0.510732] Xenomai: scheduling class rt registered.
> [    0.516816] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
> [    0.517216] Xenomai: SMI-enabled chipset found, but SMI workaround
> disabled
> [    0.517220]          (check CONFIG_XENO_HW_SMI_WORKAROUND). You may
> encounter
> [    0.517223]          high interrupt latencies!
> [    0.517643] Xenomai: starting native API services.
> [    0.517749] Xenomai: starting POSIX services.
> [    0.517906] Xenomai: starting RTDM services.
>

/proc also contains xenomai entry.

Whenever I run an API function (such as rt_task_create), I get -38 (-ENOSYS
/ Not Implemented) and nothing in dmesg. As such, none of the testsuite
programs can be run.

I have understood from previous posts that compiler options may cause
problems.

What I already tried:

Original:
- Linux kernel compiled for Atom. Stripped down to bare minimums (runs
diskless off NFS).
- scripts/prepare-kernel.sh --linux=../linux-2.6.38.8
--adeos=../adeos-ipipe-2.6.38.8-x86-2.10-01.patch --arch=i686
- ./configure --enable-x86-sep --enable-smp

Variant 1 (no effect):
- ./configure --enable-x86-sep --enable-smp CFLAGS="-m32 -O2" LDFLAGS="-m32"
Variant 2 (reason: kernel seems to be built with -O2 -fomit-frame-pointer
(unsure where to verify though), but no effect):
- ./configure --enable-x86-sep --enable-smp CFLAGS="-m32 -O2
-fomit-frame-pointer" LDFLAGS="-m32"
Variant 3 (no effect)
- Same .config Linux kernel compiled for Pentium Pro (i686)
- ./configure --enable-x86-sep --enable-smp

Since kernel compiles are a very time-costly way of debugging and I also do
not fully understand what I'm really doing when fiddling with gcc options,
it seems that help is now much appreciated.

Thanks,

--bcaec520f71fd5b05d04ac22477e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I have patched a 2.6.38.8 kernel with the Adeos 2.10-01 patch. All Xen=
omai 2.5.6 built-in in the kernel. The system boots properly on an Atom D52=
5:</div>
<div>=A0</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">[=A0=A0=A0 0.510257] I-pipe: Dom=
ain Xenomai registered.<br>[=A0=A0=A0 0.510493] Xenomai: hal/i386 started.<=
br>[=A0=A0=A0 0.510626] Xenomai: scheduling class idle registered.<br>
[=A0=A0=A0 0.510732] Xenomai: scheduling class rt registered.<br>[=A0=A0=A0=
 0.516816] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.<br>=
[=A0=A0=A0 0.517216] Xenomai: SMI-enabled chipset found, but SMI workaround=
 disabled<br>[=A0=A0=A0 0.517220]=A0=A0=A0=A0=A0=A0=A0=A0=A0 (check CONFIG_=
XENO_HW_SMI_WORKAROUND). You may encounter<br>
[=A0=A0=A0 0.517223]=A0=A0=A0=A0=A0=A0=A0=A0=A0 high interrupt latencies!<b=
r>[=A0=A0=A0 0.517643] Xenomai: starting native API services.<br>[=A0=A0=A0=
 0.517749] Xenomai: starting POSIX services.<br>[=A0=A0=A0 0.517906] Xenoma=
i: starting RTDM services.<br></blockquote>

<div>=A0</div>
<div>/proc also contains xenomai entry.</div>
<div>=A0</div>
<div>Whenever I run an API function (such as rt_task_create), I get -38 (-E=
NOSYS / Not Implemented) and=A0nothing in dmesg. As such, none of the tests=
uite programs can be run.</div>
<div>=A0</div>
<div>I have understood from previous posts that compiler options may cause =
problems.</div>
<div>=A0</div>
<div>What I already tried:</div>
<div>=A0</div>
<div>Original:</div>
<div>- Linux kernel compiled for Atom. Stripped down to bare minimums (runs=
 diskless off NFS).</div>
<div>- scripts/prepare-kernel.sh --linux=3D../linux-2.6.38.8 --adeos=3D../a=
deos-ipipe-2.6.38.8-x86-2.10-01.patch --arch=3Di686<br>- ./configure --enab=
le-x86-sep --enable-smp </div>
<div>=A0</div>
<div>Variant 1 (no effect):</div>
<div>- ./configure --enable-x86-sep --enable-smp CFLAGS=3D&quot;-m32 -O2&qu=
ot; LDFLAGS=3D&quot;-m32&quot;<br></div>
<div>Variant 2 (reason: kernel seems to be built with=A0-O2 -fomit-frame-po=
inter (unsure where to verify though), but=A0no effect):</div>
<div>- ./configure --enable-x86-sep --enable-smp CFLAGS=3D&quot;-m32 -O2 -f=
omit-frame-pointer&quot; LDFLAGS=3D&quot;-m32&quot;<br></div>
<div>Variant 3 (no effect)</div>
<div>- Same .config Linux kernel compiled for Pentium Pro (i686)</div>
<div>- ./configure --enable-x86-sep --enable-smp</div>
<div>=A0</div>
<div>Since kernel compiles are a very time-costly way of debugging and=A0I =
also do not fully understand what I&#39;m really doing when fiddling with g=
cc options, it seems that help is now much appreciated.</div>
<div>=A0</div>
<div>Thanks,</div>
<div>=A0</div>

--bcaec520f71fd5b05d04ac22477e--

