From: Henry Bausley <hbausley@deltatau.com>
In-Reply-To: <51CB1E2C.2000302@xenomai.org>
References: <1372258188.12144.161.camel@lx-henry>
	<51CB1E2C.2000302@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 27 Jun 2013 15:24:28 -0700
Message-ID: <1372371868.3416.14.camel@lx-henry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel Panic not syncing kernel stack overflow on
 AMCC PowerPC 460EX upon upgrade
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


Same issue with 3.4 and 3.5 kernels.  I'll work on reducing my code size
to something small that can be replicated.  Thanks for the ideas I'll
see if I can find what is trashing the linux interrupt state.


On Wed, 2013-06-26 at 19:00 +0200, Philippe Gerum wrote:
> On 06/26/2013 04:49 PM, Henry Bausley wrote:
> >
> >
> > I am attempting to upgrade to Xeno 2.6.2.1 / Ipipe 3.2.21 from
> > a working Xeno 2.5.6 / Ipipe 2.6.30.3 configuration
> >
> > I am getting a Kernel Panic not syncing kernel stack overflow errors
> > with the new kernel.
> >
> > The application is a kernel module that operates soley from interrupts
> > and communicates to user space with applications with shared memory.  It
> > has been running with the earlier kernels without issues for many years.
> > Below are the messages I get when the system crashes.
> >
> > If anyone has any hints based upon the data when it crashes  below it
> > would be greatly appreciated.
> >
> >
> 
> <snip>
> 
> > Call
> > Trace:
> > [8049bef0] [80006c00] show_stack+0x54/0x154
> > (unreliable)
> > [8049bf30] [8001a26c] __schedule_bug
> > +0x68/0x6c
> > [8049bf40] [80372b1c] __schedule
> > +0x3e8/0x430
> > [8049bf90] [80007738] cpu_idle
> > +0xd8/0xdc
> > [8049bfb0] [80001bd4] rest_init
> > +0x64/0x78
> > [8049bfc0] [8044a770] start_kernel
> > +0x2d0/0x2e4
> > [8049bff0] [80000044] _start
> > +0x44/0x88
> > Kernel panic - not syncing: kernel stack overflow
> 
> This is typical of some code badly trashing the linux interrupt state 
> when running in primary domain. The idle loop breakage may be a 
> collateral damage of such issue.
> 
> Could you tell us a bit more about your kernel config, e.g.
> 
> - which preemption model?
> - did you enable CONFIG_IPIPE_DEBUG_INTERNAL? otherwise, do you have any 
> warning notice when set?
> 





Outbound scan for Spam or Virus by Barracuda at Delta Tau


