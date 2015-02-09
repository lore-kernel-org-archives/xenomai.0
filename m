Date: Mon, 9 Feb 2015 14:11:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150209131153.GB3200@hermes.click-hack.org>
References: <CA+HFbxCUGzFDzg8_GuJ=rEk1iC=NmLDeYW-AUAvg7_m0EcNBSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HFbxCUGzFDzg8_GuJ=rEk1iC=NmLDeYW-AUAvg7_m0EcNBSQ@mail.gmail.com>
Subject: Re: [Xenomai] error in xenomai porting to new arm soc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: satya patel <satya087@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Feb 09, 2015 at 10:44:07AM +0530, satya patel wrote:
> Hi,
> >
> >
> >
> > I am trying to port xenomai on an ARM A-9 based SOC (configured for
> single core processor).
> >
> > I need to use Linux kernel version 10.3.31.

This kernel version does not exist yet, unless maybe if you are
using ftp over IPOT. The latest kernel version is 3.19


> >
> > Hence I patched Xenomai as below:
> >
> >
> >
> > Linux 10.3.31 (LTSI version) + ipipe-core-3.10.32-arm-6.patch +
> xenomai-3.0-rc2.tar.bz2.
> >
> >
> >
> > 1.       Patching is successful. (few patching conflicts  are resolved
> manually in files - irq-gic.c, arm_arch_timer.c, irqdesc.c.
> >
> > 2.       Merged code is compiled successfully in all the three
> combinations:
> >
> > a.       CONFIG_IPIPE and XENOMAI disabled.
> >
> > b.      CONFIG_IPIPE Enabled and XENOMAI disabled.
> >
> > c.       CONFIG_IPIPE and XENOMAI Enabled.
> >
> > 3.       However kernel boots successfully only for the option “2.a”
> above (i.e. CONFIG_IPIPE and XENOMAI disabled).
> >
> > Below error is observed in option “2.b”:
> >
> >
> >
> > Switching to clocksource ipipe_tsc
> >
> >
> >
> > INFO: rcu_preempt self-detected stall on CPU { 0}  (t=27486 jiffies
> g=4294967038 c=4294967037 q=10)
> >
> >
> >
> > CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.31-ltsi-20141215 #17
> >
> >
> >
> > [<c0013818>] (unwind_backtrace+0x0/0x138) from [<c0011ea8>]
> (show_stack+0x10/0x14)
> >
> >
> >
> > 4.       Below changes are done apart from applying the ipipe patch:
> >
> > a.       Conflicts are resolved manually to keep latest ipipe code in
> files irq-gic.c, arm_arch_timer.c, irqdesc.c.
> >
> > b.      Enabled “IPIPE_ARM_KUSER_TSC” for target SoC in KConfig file
> >
> > c.       Set CONFIG_UIDGID_STRICT_TYPE_CHECKS=n
> >
> > d.      Modified timer.c file for ipipe_timer and tsc as per below link:
> >
> >
> https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#config-multi-irq-handler
> >
> >
> >
> > Please let me know how to avoid the above warning to boot the kernel.

Your tsc emulation probably has an issue.

-- 
					    Gilles.

