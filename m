Date: Mon, 23 Feb 2015 19:34:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150223183443.GM22377@hermes.click-hack.org>
References: <54EB5D02.8080105@xenomai.org>
 <20150223171250.GE22377@hermes.click-hack.org>
 <20150223172146.GG22377@hermes.click-hack.org>
 <54EB66BB.2060703@siemens.com>
 <20150223175110.GI22377@hermes.click-hack.org>
 <54EB695C.4000909@siemens.com>
 <20150223180425.GJ22377@hermes.click-hack.org>
 <20150223181124.GK22377@hermes.click-hack.org>
 <54EB6E68.3010200@siemens.com> <54EB7235.4000401@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EB7235.4000401@siemens.com>
Subject: Re: [Xenomai] ipipe: issues with ARM exception handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Feb 23, 2015 at 07:32:21PM +0100, Jan Kiszka wrote:
> On 2015-02-23 19:16, Jan Kiszka wrote:
> > On 2015-02-23 19:11, Gilles Chanteperdrix wrote:
> >> On Mon, Feb 23, 2015 at 07:04:25PM +0100, Gilles Chanteperdrix wrote:
> >>> So, finally, I propose:
> >>
> >> Mmmm. try again.
> >>
> >>>
> >>> static inline unsigned long ipipe_fault_entry(void)
> >>> {
> >>> 	unsigned long flags;
> >>>
> >>> 	local_irq_save(flags);      /* Re-enables hw irqs */
> >>
> >> We need the explicit hard_local_irq_enable() here.
> 
> And we need to fix up regs->ARM_cpsr according to flags.

No, we have no reason to fix up regs->ARM_cpsr.

It has been saved when entering the exception, and contains the
state of the calling context. It needs to be restored exactly as it
is.

-- 
					    Gilles.

