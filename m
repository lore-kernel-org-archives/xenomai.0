MIME-Version: 1.0
Date: Mon, 9 Feb 2015 10:44:07 +0530
Message-ID: <CA+HFbxCUGzFDzg8_GuJ=rEk1iC=NmLDeYW-AUAvg7_m0EcNBSQ@mail.gmail.com>
From: satya patel <satya087@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] error in xenomai porting to new arm soc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
>
>
>
> I am trying to port xenomai on an ARM A-9 based SOC (configured for
single core processor).
>
> I need to use Linux kernel version 10.3.31.
>
> Hence I patched Xenomai as below:
>
>
>
> Linux 10.3.31 (LTSI version) + ipipe-core-3.10.32-arm-6.patch +
xenomai-3.0-rc2.tar.bz2.
>
>
>
> 1.       Patching is successful. (few patching conflicts  are resolved
manually in files - irq-gic.c, arm_arch_timer.c, irqdesc.c.
>
> 2.       Merged code is compiled successfully in all the three
combinations:
>
> a.       CONFIG_IPIPE and XENOMAI disabled.
>
> b.      CONFIG_IPIPE Enabled and XENOMAI disabled.
>
> c.       CONFIG_IPIPE and XENOMAI Enabled.
>
> 3.       However kernel boots successfully only for the option =E2=80=9C2=
.a=E2=80=9D
above (i.e. CONFIG_IPIPE and XENOMAI disabled).
>
> Below error is observed in option =E2=80=9C2.b=E2=80=9D:
>
>
>
> Switching to clocksource ipipe_tsc
>
>
>
> INFO: rcu_preempt self-detected stall on CPU { 0}  (t=3D27486 jiffies
g=3D4294967038 c=3D4294967037 q=3D10)
>
>
>
> CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.31-ltsi-20141215 #17
>
>
>
> [<c0013818>] (unwind_backtrace+0x0/0x138) from [<c0011ea8>]
(show_stack+0x10/0x14)
>
>
>
> 4.       Below changes are done apart from applying the ipipe patch:
>
> a.       Conflicts are resolved manually to keep latest ipipe code in
files irq-gic.c, arm_arch_timer.c, irqdesc.c.
>
> b.      Enabled =E2=80=9CIPIPE_ARM_KUSER_TSC=E2=80=9D for target SoC in K=
Config file
>
> c.       Set CONFIG_UIDGID_STRICT_TYPE_CHECKS=3Dn
>
> d.      Modified timer.c file for ipipe_timer and tsc as per below link:
>
>
https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#c=
onfig-multi-irq-handler
>
>
>
> Please let me know how to avoid the above warning to boot the kernel.
>
> Regards.
>
> Satya
