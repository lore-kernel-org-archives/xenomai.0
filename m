From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 22 May 2015 09:59:48 -0400
Message-ID: <20150522135948.GX6169@csclub.uwaterloo.ca>
References: <20150521190024.GA20676@csclub.uwaterloo.ca>
 <20150521215553.GS10686@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150521215553.GS10686@hermes.click-hack.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, May 21, 2015 at 11:55:53PM +0200, Gilles Chanteperdrix wrote:
> On Thu, May 21, 2015 at 03:00:24PM -0400, Lennart Sorensen wrote:
> > Complex arm devices like the TI AM572x have IRQ crossbars that can make
> > interrupt numbers map to just about anything you want.
> 
> The difference between d->hwirq and d->irq has nothing to do with
> any crossbar. It is simply a relatively recent evolution of the
> Linux kernel where the space for software interrupts is separated
> from the space for hardware interrupts. Not all interrupt
> controllers have been converted from a version to the next, so the
> I-pipe patch has to play catch-up with each version converting more
> interrupt controllers. Business as usual.

OK.  Want an update with a simpler commit message, or will you clean
it up?

-- 
Len Sorensen

