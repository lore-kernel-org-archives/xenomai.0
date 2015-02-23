Date: Mon, 23 Feb 2015 21:46:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150223204618.GT22377@hermes.click-hack.org>
References: <54E78F62.9040505@xenomai.org> <54E79086.8030801@xenomai.org>
 <54EB5021.3030508@siemens.com> <54EB5638.3050805@xenomai.org>
 <20150223163743.GA22377@hermes.click-hack.org>
 <54EB5A45.9000002@siemens.com>
 <20150223165549.GC22377@hermes.click-hack.org>
 <54EB5D02.8080105@xenomai.org>
 <20150223171250.GE22377@hermes.click-hack.org>
 <54EB90EA.4030401@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EB90EA.4030401@xenomai.org>
Subject: Re: [Xenomai] ipipe: issues with ARM exception handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Mon, Feb 23, 2015 at 09:43:22PM +0100, Philippe Gerum wrote:
> On 02/23/2015 06:12 PM, Gilles Chanteperdrix wrote:
> > On Mon, Feb 23, 2015 at 06:01:54PM +0100, Philippe Gerum wrote:
> 
> >>> hard_local_irq_disable() should always be called in case entry.S
> >>> expects us to return as we entered: with hw irqs off
> >>
> >> Which is what ipipe_fault_exit() does by testing the mangled state. If
> >> the fault entered with virtual IRQs on, then you must exit with both the
> >> stall bit and CPSR_I bit cleared.
> > 
> > Absolutely not. Imagine a Linux task, with root unstalled
> > experiencing a fault. entry.S is entered root is still unstalled,
> > with hardware irqs off. On fault entry, we must reflect this
> > hardware irq state on the stall bit and enable hw irqs. Then when
> > the fault is handled, undo that, unstall the root stage, disable hw
> > irqs and return to entry.S, so that it may resume the execution of
> > the Linux task. If it returns quickly to user-space, a stalled root
> > at this point would be a disaster, because nothing, certainly not
> > entry.S will unstall the root stage.
> > 
> > Then there is the case where Linux re-enables irqs in the course of
> > the handler, in that case, we should not return to entry.S with hw
> > irqs off.
> > 
> 
> Since Linux re-enables hw irqs in the course of the handler

in the course of some handlers, as far as I understood, not all of
them. Which is why I propose to only redisable irqs before returning
to entry.S if the root domain is stalled on exception exit (because
this indicates that Linux wants to return to entry.S with irqs off).

-- 
					    Gilles.

