Subject: Re: [Xenomai-help] Kernel panic with Xenomai SMP kernel
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44FF2E2C.9050209@domain.hid>
References: <44F6E774.2000701@domain.hid>
	<44F72F35.4070109@domain.hid>	<44F75C54.90608@domain.hid>
	<17655.28122.163232.842311@domain.hid>
	<44F84C23.9070105@domain.hid>
	<17656.30980.846435.69720@domain.hid>
	<44F8B112.9070203@domain.hid> <1157182863.4967.2.camel@domain.hid>
	<44FF2E2C.9050209@domain.hid>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 00:24:18 +0200
Message-Id: <1157581459.5064.128.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-09-06 at 15:23 -0500, Jeff Webb wrote:
> Philippe Gerum wrote:
> > Could you try specifically enabling/disabling CONFIG_PCI_MSI? TIA,
> 
> The CONFIG_PCI_MSI does not seem to be causing this particular kernel panic, but it does cause another.  If I enable this option on the working (but buggy) kernel, it boots and gets almost all the way through the init scripts before the kernel panics in move_native_irq with:
> 
>  <3> BUG: sleeping function called from invalid context at include/liux/rwsem.h: 43
> 

This one is an Adeos bug likely triggered by CONFIG_GENERIC_PENDING_IRQ
(CONFIG_IRQBALANCE would cause the same issue). We have a problem
dealing properly with IRQ migration over the IO-APIC ack code. This must
be fixed.

> So I continued my search for the other nasty config option.  After many recompiles, I discovered the source of the original kernel panic was setting CONFIG_HOTPLUG_CPU.  (The non-patched vanilla kernel works fine with CONFIG_HOTPLUG_CPU set.)  I realize that it does not make sense to have this set for a real-time system, but this is the sort of thing that is in the default fedora kernel config.
> 

I suspect some kernel code which has to be run over the real-time
context and spuriously invokes lock/unlock_cpu_hotplug() calls. This
must be fixed too.

> I was happy to discover the source of the kernel panic, but the SMP kernel was still not quite right (... strange pauses and repeated keystrokes, as I mentioned in a previous email).  I proceed to go through the kernel options in great detail and disable options that I thought were unnecessary.  After doing this, I finally ended up with an SMP xenomai kernel that appears to function properly.  I am now trying to find the option that caused the strange behavior.  I will let you know which option it is, if I can track it down.
> 

Thanks.

> I think my problem is solved, since I now have a working SMP kernel.  Now the question is, is there something we can do to keep this problem from biting others?  It seems to me that I took a reasonable approach:
> 

You did, and the cure is to fix Adeos/x86 in the SMP case.

>   Download a vanilla kernel from kernel.org.
>   Use the xenomai prepare-kernel script to apply the adeos patch.
>   Load the default (working) fedora config file.
>   Turn off the troublesome config options listed in the TROUBLESHOOTING file.
>   Build the kernel as an RPM.
> 
> This approach has worked well in the past with many version of RTLinux (and even Xenomai / Linux 2.4/2.6 uniprocessor).  I'm not sure why the SMP build caused so many problems, but it would be nice to fix things up a bit.
>   

Adeos/x86 has more issues running in SMP mode over the latest kernels on
recent hardware, because the implementation of the interrupt subsystem
is a moving target on the former, and I don't have regular access to the
latter.

> Is the adeos patch supposed to work with any set of config options?

So far, yes. No particular option should crash the system or cause it to
misbehave blatantly, even if it doesn't make much sense to enable it in
a real-time context (I'm excluding options which are known to induce
latency here, this is no bug Linux-wise).

I don't like letting cheap exception cases slip into the code and accept
that some options remain unsupported (*), this would be just asking for
troubles long after we forgot them, so the move_native_irq() and
CONFIG_HOTPLUG_CPU have to be fixed.

(*) Unless the option could not be supported because of some weird
incompatibility reason with the Adeos design, that is. But I don't think
the ones we are talking about belong to this category.

-- 
Philippe.



