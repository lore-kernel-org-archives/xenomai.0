Date: Sun, 7 Dec 2014 14:52:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141207135204.GT10014@hermes.click-hack.org>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Dec 07, 2014 at 01:50:02PM +0000, Stoidner, Christoph wrote:
> 
> 
> > From what I understand of Xenomai 2.6 code (if this is the version
> > you are using), 
> 
> Yes, I am using Xenomai 2.6
> 
> > normally, the apc should be invoked from the
> > rthal_apc_thread context, not from rthal_apc_handler.
> >
> > The virq handler should be rthal_apc_kicker, which wakes up the
> > process.
> >
> > This code is #ifdef CONFIG_PREEMPT_RT, is not CONFIG_PREEMPT_RT
> > defined in your kernel ?
> 
> In my kernel CONFIG_PREEMPT_RT is not defined but
> CONFIG_PREEMPT_RT_FULL. Moreover except in Xenomai code I did not
> find any CONFIG_PREEMPT_RT in kernel code or preempt RT
> patch-3.10.18-rt14. In older versions of preempt RT (e.g.
> patch-2.6.33.9-rt31) I can found such a define/configuration. It
> seems as it was removed.

Well, then you need to replace #ifdef CONFIG_PREEMPT_RT with
CONFIG_PREEMPT_RT_FULL, and test the kernel version in wrappers.h to
define CONFIG_PREEMPT_RT_FULL if CONFIG_PREEMPT_RT is dedined for
old kernels.

-- 
					    Gilles.

