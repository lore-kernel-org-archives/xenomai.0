From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <468AA923.8030406@domain.hid>
References: <4688E0BD.40709@domain.hid>
	<1183377266.19565.14.camel@domain.hid>  <4689092B.6020903@domain.hid>
	<1183387687.19565.56.camel@domain.hid> <468AA923.8030406@domain.hid>
Content-Type: text/plain
Date: Tue, 03 Jul 2007 23:40:56 +0200
Message-Id: <1183498856.6049.110.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Switch to secondary mode
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
To: Jeff Koftinoff <jeffk@domain.hid>
Cc: Xenomai-help@domain.hid

On Tue, 2007-07-03 at 12:53 -0700, Jeff Koftinoff wrote:
> Philippe Gerum wrote:
> > In such a case, you have likely hit an illustration of the latter issue
> > which the I-pipe/ppc implementation still suffers from: some page table
> > entries are missed during real-time operations. As a consequence of
> > this, the nucleus catches page faults on behalf of RT threads in primary
> > mode, then switches these threads back to secondary in order to process
> > the faults, and eventually wire the missing PTEs in. This is something
> > calling mlockall() does not prevent the application from (like COW).
> >
> > The shared lib problem would be another issue, even if it relates to the
> > same general topic (i.e. lazy/on-demand mapping of memory resources the
> > kernel performs).
> >
> >   
> Hi Philippe.
> 
> Very soon I am going to be using Xenomai on PPC with SMP...

You mean ppc64?

> 
> Under what situations are 'page table entries missed'? what exactly does 
> that mean?
> 

For instance, the MMU service code constantly needs to populate an
internal cache holding the most recently used PTEs, but also to evict
some page table entries, when it is under pressure to get space into the
cache to hold other - hotter - entries. In that case, any subsequent
(virtual) memory reference which needs the missing PTE for translation
would cause a minor fault on a CPU with no hardware assistance for
handling PTE misses. This fault is intercepted by the kernel to fetch
back the needed PTE, and make the memory reference possible. The code
would resume at the faulted code location without even knowing of the
former issue.

The interrupt pipeline relays such fault event to Xenomai, which in turn
switches the faulting RT thread to plain Linux mode (i.e. "secondary"
mode from Xenomai's POV), so that Linux's fault handler may do the
housekeeping chores as needed (i.e. fetch the PTE back). We have to do
that because a RT thread might have preempted the vanilla kernel code in
the middle of nowhere, to serve a high priority RT interrupt. In such a
case, "nowhere" could be anywhere, including in some critical section
Linux-wise (but still preemptible by Xenomai threads), and we don't want
to re-enter Linux in an unsafe manner. By switching to secondary mode,
we ensure that the fault shall be processed only when Linux allows such
faults to be processed (i.e. outside of any critical section from its
own POV), because we restore the normal Linux execution flow before the
fault is handled by the kernel.

Even if I'm not satisfied with the current state of affairs regarding
this issue, PTE misses on PPC do not seem to bring unbearable latencies,
even if they do increase the wost-case latency. AFAICT, on a Freescale
lite5200/64mb for instance, PTE entries bring an additional jitter
estimated at ~20 us (~55 us instead of ~35 us when running a 10Khz loop
in user-space). On a mpc85xx/128Mb, worst-case is still in the 35 us
range in user-space context, which is quite acceptable. The same way,
the worst-case was quite low on x86, even before we did provide (Gilles
did actually) for pinning down ranges of PTE entries there, so that some
Linux tasks would never endure PTE misses anymore once they get promoted
to Xenomai RT threads. We likely benefit from the continuous effort the
upstream folks are making toward an always finer kernel granularity,
there - i.e. switching mode on recent kernels is becoming reasonably
short and bounded. Memory pressure is a significant factor increasing
the PTE issue too, which has more impact on low-end than mid-range or
high-end embedded hardware.

The proper cure - mainly for low-end hardware - would require to have
the I-pipe/ppc patch provide a particular feature the latest x86 and ARM
patches do, which basically makes sure that all on-demand memory
strategies (copy-on-write, lazy mapping of kernel memory resources etc.)
are fully disabled for a certain class of Linux tasks (which would need
to cover the PTE case too if possible). Probably non-trivial.

> Regards,
> Jeff Koftinoff
> 
> www.jdkoftinoff.com
> 
-- 
Philippe.



