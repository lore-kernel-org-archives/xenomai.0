From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] Re: [Adeos-main] Re: Heads up: Xenomai port over
	x86_64 has started
Date: Sun, 25 Feb 2007 00:18:16 +0000
References: <1170205077.21219.67.camel@domain.hid>
	<1172357204.2161.67.camel@domain.hid>
	<200702250015.35735.paul_c@domain.hid>
In-Reply-To: <200702250015.35735.paul_c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702250018.16829.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On Sunday 25 February 2007 00:15, Paul wrote:
> Hi Philippe
>
> On Saturday 24 February 2007 22:46, Philippe Gerum wrote:
> > Added to the fact that I've just fixed the CONFIG_SMP
> > +CONFIG_PREEMPT issue [1], what remains to get a fully functional
> > preliminary x86_64 port is to solve the CONFIG_SMP+CONFIG_IPIPE_TRACE,
> > and we should be done.
>
> If CONFIG_PREEMPT is not enabled, the kernel compile fails with:
>
> arch/x86_64/kernel/built-in.o: In function `__ipipe_preempt_schedule_irq':
> arch/x86_64/kernel/ipipe.c:471: undefined reference to
> `preempt_schedule_irq' make[1]: *** [.tmp_vmlinux1] Error 1
> make[1]: Leaving directory `/var/tmp/linux-2.6.19.3'
> make: *** [debian/stamp-build-kernel] Error 2
>
> The attached patch addresses the problem..

Scrub that - It exposes another problem in thunk.S which I missed...


Regards, Paul.

