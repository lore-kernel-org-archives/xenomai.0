Date: Wed, 16 Mar 2016 05:04:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160316040403.GA6555@hermes.click-hack.org>
References: <1458099705.9868.11.camel@henry-ThinkCentre-M93p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458099705.9868.11.camel@henry-ThinkCentre-M93p>
Subject: Re: [Xenomai] ARM LS1021A SMP Floating point Interrupt Service
 Routine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henry Bausley <hbausley@deltatau.com>
Cc: xenomai@xenomai.org

On Tue, Mar 15, 2016 at 08:41:45PM -0700, Henry Bausley wrote:
> How does one properly permit floating point operations in an ISR in a
> kernel driver running on an ARM CPU.  Our ISR is on cpu 0 and I thought
> that the code below would work.  However sometimes the userspace
> application using the floating point unit will get a segmentation fault.
> The kernel driver running floating point does not have a problem.  I am
> sure I am missing something here since I can use floating point in
> xenomai kernel threads without a problem.

That is because Xenomai takes care of handling the FPU context for
kernel threads. On the other hand, for irqs, you are on your own.

> 
> int FloatingPointISR()
> {
>   rthal_vfp_save((union vfp_state*)x, rthal_enable_fpu());
> 
>    // A bunch of floating point stuff
> 
>   rthal_vfp_load((union vfp_state*)x, 0);
> }

I guess the problem is that you do not restore at the end of the
isr, the fpu context as it was at the beginning. You can try:

int FloatingPointISR()
{
	unsigned fpexc = rthal_vfp_fmrx(FPEXC);
	rthal_vfp_save((union vfp_state*)x, rthal_enable_fpu());
 
	// A bunch of floating point stuff
 
	rthal_vfp_load((union vfp_state*)x, 0);
	rthal_vfp_fmxr(FPEXC, fpexc);
}

ALso note that x can not be a thread backup area. It must be an area
specific to your ISR. And cpu, you can not share the area between
two cpus either. And if the ISR is still reentrant, you have to shut
irqs off around this piece of code, in order to avoid a context
switch (for instance by the timer irq) in the middle.

-- 
					    Gilles.
https://click-hack.org

