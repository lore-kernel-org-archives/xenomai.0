From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 21 May 2015 15:04:34 -0400
Message-ID: <20150521190434.GT6169@csclub.uwaterloo.ca>
References: <20150521190024.GA20676@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150521190024.GA20676@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] [PATCH] Fix arm GIC irq mask calculations on complex
	arm devices
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thu, May 21, 2015 at 03:00:24PM -0400, Lennart Sorensen wrote:
> Complex arm devices like the TI AM572x have IRQ crossbars that can make
> interrupt numbers map to just about anything you want.  This means that
> the value of d->irq and d->hwirq do not have to have anything to do with
> each other.  The unpatched kernel uses the inline function gic_irq() to
> get this mapping, rather than d->irq.  Restore the code to the unpatched
> kernel state, and update the ipipe gic_hold_irq/gic_release_irq functions
> to use gic_irq() too.
> 
> This fixes booting with 3.14.39 on the TI AM572x.

This applies cleanly to ipipe-3.14 and ipipe-3.16 and with a 1 line
offset to ipipe-3.18 and master.

-- 
Len Sorensen

