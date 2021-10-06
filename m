MIME-Version: 1.0
References: <CAJPpvENYmUPowOQcjU+2FHtdkGz8p0+GgXbWcYRyDPrST+tMew@mail.gmail.com>
In-Reply-To: <CAJPpvENYmUPowOQcjU+2FHtdkGz8p0+GgXbWcYRyDPrST+tMew@mail.gmail.com>
From: Andrew Tannenbaum <atannbis@gmail.com>
Date: Wed, 6 Oct 2021 16:31:39 -0400
Message-ID: <CAJPpvEML7_3H1b+k-xN0+kK5JWWQ7g1ZP6Y8q1kq+GQKqpisPA@mail.gmail.com>
Subject: Re: problem starting web browsers, running EVL kernel
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This is a follow up to a note I posted here a week ago, saying that I was
not able to run a kernel that I compiled from the EVL tree.
(I did not receive a reply.)
To review, I'm running an Intel i5-10400 with Ubuntu Studio distro 20.04.3.

I am able to compile an EVL 5.14.0 kernel, I can configure two versions,
neither version is a full solution.

1) When I compile the kernel with EVL/Dovetail turned off, the Linux boots
and runs normally, though (of course) EVL doesn't run.
2) When I compile the kernel with EVL/Dovetail turned on, Linux boots, and
EVL runs ok, but graphical web browsers crash.

With CONFIG_EVL=y, Firefox, Chromium, and Google Chrome crash or hang.
(I only turn EVL on and off in make nconfig, I don't change other settings.)
There seem to be errors in syslog that say apparmor and snap are getting
upset, apparmor=DENIED, etc.
I can run the /usr/bin/lynx text-based web browser ok, so it's not web
browsing or networking that is the problem.
I think the problem might be with the kernel's interaction with snap and/or
apparmor.
I am not familiar with these subsystems, so I don't know.

I'm looking for advice to fix my problem.
I don't know whether my problem is only in the kernel .config file or
whether I need to reconfigure something else like apparmor or snap.

Related questions:
Are other people running EVL on Ubuntu Studio (or other Ubuntu) on an x86?
Is there a best way to get a .config to start with?
The EVL build-steps mostly assume that it will just work (if you follow the
Caveat).
I made a .config with: make LSMOD=lsmod-output localmodconfig
but I'm not sure that's best.
Noting that I feel like I'm having problems configuring the kernel, I was
hoping to find an existing .config that was better for EVL than the plain
Linux ones.
But I'm not sure whether the problem is in my kernel or elsewhere like
snap/apparmor.

Thanks,
-Andy

On Wed, Sep 29, 2021 at 6:11 PM Andrew Tannenbaum <atannbis@gmail.com>
wrote:

> I'm trying to compile and run a kernel from the EVL git tree
> commit 5ca8de72d28ad03ec59c71bc05b6452abd9376dd (HEAD -> v5.14-evl-rebase,
> origin/v5.14-evl-rebase)rum <rpm@xenomai.org>
>
> I'm on an Intel x86 desktop with an i5-10400, nothing unusual, I think.
> The kernel compiles and runs fine with EVL/dovetail turned off.
> Web browsers crash when I run the kernel with CONFIG_EVL=y.
> With CONFIG_EVL=y, the kernel boots, and latmus runs fine:
>
> # ./latmus
> warming up on CPU0 (not isolated)...
> RTT|  00:00:01  (user, 1000 us period, priority 98, CPU0-noisol)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
> worst
> RTD|     -1.443|      1.671|      4.003|       0|     0|     -1.443|
>  4.003
> RTD|     -1.459|      1.553|      2.853|       0|     0|     -1.459|
>  4.003
> RTD|     -1.444|      1.681|     12.087|       0|     0|     -1.459|
> 12.087
> RTD|     -1.542|      1.619|     18.907|       0|     0|     -1.542|
> 18.907
> RTD|     -1.539|      1.605|      3.789|       0|     0|     -1.542|
> 18.907
>
> I'm not clear on the negative lat mins, but that's not my main concern.
>
> (evl check doesn't print anything.)
>
> when I try to run chromium browser (which is in a snap) on the EVL=y
> kernel, it fails with what seem to be apparmor complaints.
> (but really I don't know, I'm confused about what's wrong, other apps seem
> ok, but I don't run it for long, I am debugging on my main PC, so I prefer
> to run a kernel with a working web browser).
>
> Chromium crashes and exits.
> Chromium errors look like this in /var/log:
>
> syslog:
> Sep 29 13:43:47 jambi systemd[1382]: Started
> snap.chromium.chromium.08244a19-cf68-494f-9fad-d3be2d610151.scope.
> Sep 29 13:43:49 jambi kernel: [  173.158619] audit: type=1400
> audit(1632937429.782:42): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c505:0" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.167794] audit: type=1400
> audit(1632937429.791:43): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c504:0" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.171860] audit: type=1400
> audit(1632937429.796:44): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:4" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.171904] audit: type=1400
> audit(1632937429.796:45): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:2" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.171954] audit: type=1400
> audit(1632937429.796:46): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:0" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.172006] audit: type=1400
> audit(1632937429.796:47): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:3" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.172056] audit: type=1400
> audit(1632937429.796:48): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:1" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:58 jambi systemd[1382]:
> snap.chromium.chromium.08244a19-cf68-494f-9fad-d3be2d610151.scope:
> Succeeded.
>
> apport.log
> ERROR: apport (pid 3482) Wed Sep 29 13:43:47 2021: host pid 3474 crashed
> in a separate mount namespace, ignoring
> ERROR: apport (pid 3566) Wed Sep 29 13:43:47 2021: host pid 3553 crashed
> in a separate mount namespace, ignoring
> ERROR: apport (pid 3585) Wed Sep 29 13:43:47 2021: host pid 3580 crashed
> in a separate mount namespace, ignoring
> ERROR: apport (pid 3591) Wed Sep 29 13:43:47 2021: host pid 3586 crashed
> in a separate mount namespace, ignoring
>
> kern.log
> Sep 29 13:43:49 jambi kernel: [  173.171860] audit: type=1400
> audit(1632937429.796:44): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:4" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.171904] audit: type=1400
> audit(1632937429.796:45): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:2" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.171954] audit: type=1400
> audit(1632937429.796:46): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:0" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.172006] audit: type=1400
> audit(1632937429.796:47): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:3" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:43:49 jambi kernel: [  173.172056] audit: type=1400
> audit(1632937429.796:48): apparmor="DENIED" operation="open"
> profile="snap.chromium.chromium" name="/run/udev/data/c502:1" pid=3375
> comm="ThreadPoolForeg" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> Sep 29 13:44:02 jambi kernel: [  186.225025] show_signal: 1 callbacks
> suppressed
> Sep 29 13:44:02 jambi kernel: [  186.225027] traps: Chrome_IOThread[3719]
> trap int3 ip:560dd1aded45 sp:7f9e8d7f8390 error:0 in
> chrome[560dd19b6000+7e29000]
> Sep 29 13:44:10 jambi kernel: [  193.455568] traps: Chrome_IOThread[3961]
> trap int3 ip:55c6a5e98d45 sp:7f55fd7f8390 error:0 in
> chrome[55c6a5d70000+7e29000]
> Sep 29 13:44:49 jambi kernel: [  233.258235] traps: Chrome_IOThread[4224]
> trap int3 ip:55e958b99d45 sp:7face2ffb390 error:0 in
> chrome[55e958a71000+7e29000]
> Sep 29 13:45:05 jambi kernel: [  248.843560] traps: Chrome_IOThread[4480]
> trap int3 ip:559d7599dd45 sp:7f4d849bb390 error:0 in
> chrome[559d75875000+7e29000]
> Sep 29 13:45:21 jambi kernel: [  264.906554] traps: Chrome_IOThread[4731]
> trap int3 ip:559028d68d45 sp:7fbf3fffd390 error:0 in
> chrome[559028c40000+7e29000]
>
> When I run firefox browser, it  won't open pages and the tabs crash though
> the firefox window stays present.
>
> Firefox errors look like this on stderr:
>
> ###!!! [Parent][RunMessage] Error: Channel error: cannot send/recv
>
> Here are the only differences between the linux kernel .config files (I
> think)
> I sorted the .configs with LC_ALL=C, deleted comments,
> ran /bin/comm -3 .config-without-evl-set .config-with-evl-set
> (deleting lines in common to both files)
> and changed the tabs in the comm output to "evl-on:" because gmail eats
> tabs on input.
> So, lines with evl-on are from the CONFIG_EVL=y version, and lines with
> spaces are from no CONFIG_EVL (but they are both compiled in the same
> git/evl-linux source tree).
> It looks like mostly it's turning off XEN hypervisor stuff and turning on
> EVL stuff.  I don't get it.
> (I'm not sure whether this is enough, but I didn't want to post two full
> config files here.)
>
> comm -3 output:
> evl-on:  CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM=y
> evl-on:  CONFIG_DOVETAIL=y
> evl-on:  CONFIG_EVL=y
> evl-on:  CONFIG_EVL_COREMEM_SIZE=2048
> evl-on:  CONFIG_EVL_HECTIC=y
> evl-on:  CONFIG_EVL_LATENCY_IRQ=0
> evl-on:  CONFIG_EVL_LATENCY_KERNEL=0
> evl-on:  CONFIG_EVL_LATENCY_USER=0
> evl-on:  CONFIG_EVL_LATMUS=y
> evl-on:  CONFIG_EVL_NR_CLOCKS=8
> evl-on:  CONFIG_EVL_NR_MONITORS=512
> evl-on:  CONFIG_EVL_NR_OBSERVABLES=64
> evl-on:  CONFIG_EVL_NR_PROXIES=64
> evl-on:  CONFIG_EVL_NR_THREADS=256
> evl-on:  CONFIG_EVL_NR_XBUFS=16
> evl-on:  CONFIG_EVL_RUNSTATS=y
>          CONFIG_HVC_IRQ=y
>          CONFIG_HVC_XEN=y
>          CONFIG_HVC_XEN_FRONTEND=y
> evl-on:  CONFIG_IRQ_DOMAIN_NOMAP=y
> evl-on:  CONFIG_IRQ_PIPELINE=y
>          CONFIG_PAGE_POOL=y
>          CONFIG_PARAVIRT_XXL=y
>          CONFIG_PCI_XEN=y
>          CONFIG_SWIOTLB_XEN=y
>          CONFIG_SYS_HYPERVISOR=y
>          CONFIG_XEN=y
>          CONFIG_XEN_512GB=y
>          CONFIG_XEN_ACPI=y
>          CONFIG_XEN_ACPI_PROCESSOR=y
>          CONFIG_XEN_AUTO_XLATE=y
>          CONFIG_XEN_BACKEND=y
>          CONFIG_XEN_BALLOON=y
>          CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
>          CONFIG_XEN_BLKDEV_FRONTEND=y
>          CONFIG_XEN_DOM0=y
>          CONFIG_XEN_EFI=y
>          CONFIG_XEN_GRANT_DMA_ALLOC=y
>          CONFIG_XEN_HAVE_PVMMU=y
>          CONFIG_XEN_HAVE_VPMU=y
>          CONFIG_XEN_MCE_LOG=y
>          CONFIG_XEN_MEMORY_HOTPLUG_LIMIT=512
>          CONFIG_XEN_NETDEV_FRONTEND=y
>          CONFIG_XEN_PRIVCMD=m
>          CONFIG_XEN_PV=y
>          CONFIG_XEN_PVH=y
>          CONFIG_XEN_PVHVM=y
>          CONFIG_XEN_PVHVM_GUEST=y
>          CONFIG_XEN_PVHVM_SMP=y
>          CONFIG_XEN_PV_SMP=y
>          CONFIG_XEN_SAVE_RESTORE=y
>          CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
>          CONFIG_XEN_SYS_HYPERVISOR=y
>          CONFIG_XEN_UNPOPULATED_ALLOC=y
>          CONFIG_XEN_XENBUS_FRONTEND=y
>
> -Andy
>
