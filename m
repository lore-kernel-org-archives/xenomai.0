Message-ID: <529DC67C.9080902@xenomai.org>
Date: Tue, 03 Dec 2013 12:54:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
In-Reply-To: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kurijn Buys <kurijn.buys@open.ac.uk>
Cc: Xenomai@xenomai.org

On 12/03/2013 12:38 PM, Kurijn Buys wrote:
> Hi all,
>
> New to Xenomai, and having passed the last few weeks on attempting to set it up on a Pentium 4 (see lower for hard-, software and config details), there seems to be something wrong, as I experience large latency spikes, especially under load.
> I searched in the archives, I followed the troubleshooting guide (notably the part on high latencies), but with no success...
> I ran the I-pipe tracer with latency -f (and
>   dohell in another terminal) and I pasted the frozen output at the end of this message.
> I googled for some terms to understand this log, but I can't figure out how to interpret it. I hope someone of you has some advice on that and/or sees potential problems in my set-up...
>
> Thanks in advance!
> ]{urijn
>
> Some tests I performed:
> -xenomai/bin/latency (priority 99) -> latency spike from time to time, especially under load they can be up to 400µs, but also without load they can be up to 200µs sometimes.
> -A similar test (from: http://www.blaess.fr/christophe/livres/solutions-temps-reel-sous-linux/) with a 3000 µs period, allowed to observe statistical output. While running the xenomai/bin/dohell program in parallel, I obtained a normal distribution, within the range [2913 - 3087]µs, except for about ten (out of 336688) measurements who occurred between 1µs and 400µs! (also tested with /proc/sys/kernel/sched_rt_runtime_us on -1)
>
> The kernel log looks normal to me...:
> [    1.973038] I-pipe: Domain Xenomai registered.
> [    1.973559] Xenomai: hal/i386 started.
> [    1.973949] Xenomai: scheduling class idle registered.
> [    1.974135] Xenomai: scheduling class rt registered.
> [    1.998987] Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.
> [    1.999195] Xenomai: debug mode enabled.
> [    2.000391] Xenomai: SMI-enabled chipset found
> [    2.000605] Xenomai: SMI workaround enabled
> [    2.001015] Xenomai: starting native API services.
> [    2.001198] Xenomai: starting POSIX services.
> [    2.001753] Xenomai: starting RTDM services.
>
> And the files in /proc/ipipe look how they should...
>
> Hardware: Pentium IV (lspci: 3,2GHz, i686, 32,64bit, 2 cpu's), 2Gb RAM
> Software: Ubuntu 10.04, kernel&patch 2.6.38.8, Xenomai 2.6.3
> Installation details:
> -kernel configuration options (starting from the kernel config that my machine was already using)
> -http://www.xenomai.org/index.php/Configuring_x86_kernels
> -http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/index.html#kconf
> -options for Analogy (as I want to use a National Instruments card): http://www.lara.unb.br/wiki/index.php/Data_Acquisition_Xenomai_Analogy
> -to avoid conflicts, I deactivated the Comedi drivers (Device drivers/Staging drivers/Exclude Staging drivers from being built/Data acquisition support (comedi) -> disabled)
> -as recommended by the book "Solutions temps réel sous Linux",
> -set "Processor type and features/Preemption Model" to "Preemptible Kernel (Low-Latency Desktop)
> -enable "Real-time sub-system/Priority Coupling Support"
> -I-pipe tracer options (http://www.xenomai.org/index.php/I-pipe:Tracer)
> -xenomai configuration options:  --enable-smp --enable-x86-sep --enable-x86-tsc --enable-debug
> (I chose to enable smp as I found smp enabled in the kernel options that worked with the original ubuntu install, however, I've tried also to install xenomai without this option here)
>
> Notes:
> -My processor seems to support both 32 as 64 bit, now I'm using 32 (but maybe I should have opted for 64?)
> -I've set the SMI workaround by adding "xeno_hal.smi=-1" on the kernel command line (http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/index.html#SMI), but maybe it makes a difference when it is set in the kernel config, as proposed here (http://www.xenomai.org/index.php/Configuring_x86_kernels), by setting the CONFIG_XENO_HW_SMI_WORKAROUND variable. However, I didn't find this variable in my kernel configuration...
> -I disabled the legacy USB switch at BIOS configuration level.

The least we can say is that it seems you have done your homework before 
posting to the list, congratulations, that is rather unusual. A few 
things to check:
- do you have ACPI enabled, if no, enable it;
- xeno_hal.smi=-1 normally disables the SMI workaround, the right option 
is xeno_hal.smi=1 to enable the workaround, but this may be a typo since 
the boot logs you show us show that you have the workaround enabled;
- if your processor has hyper-threading, have you tried disabling it?

Regards.

-- 
					    Gilles.

