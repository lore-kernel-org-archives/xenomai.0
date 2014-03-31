From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Mar 2014 17:25:34 -0400
Message-ID: <20140331212534.GW17765@csclub.uwaterloo.ca>
References: <20140331182404.GP17765@csclub.uwaterloo.ca>
 <20140331191502.GQ17765@csclub.uwaterloo.ca>
 <5339BF3C.8090906@xenomai.org>
 <20140331191849.GR17765@csclub.uwaterloo.ca>
 <20140331193742.GS17765@csclub.uwaterloo.ca>
 <5339C5AC.4040409@xenomai.org>
 <20140331204257.GT17765@csclub.uwaterloo.ca>
 <20140331205339.GU17765@csclub.uwaterloo.ca>
 <20140331205710.GV17765@csclub.uwaterloo.ca>
 <5339D8EB.3030702@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5339D8EB.3030702@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Mar 31, 2014 at 11:06:51PM +0200, Gilles Chanteperdrix wrote:
> On 03/31/2014 10:57 PM, Lennart Sorensen wrote:
> > On Mon, Mar 31, 2014 at 04:53:39PM -0400, Lennart Sorensen wrote:
> >> [341548.649928] =================================
> >> [341548.649934] [ INFO: inconsistent lock state ]
> >> [341548.649943] 3.12-1-dra7xx #1 Not tainted
> >> [341548.649950] ---------------------------------
> >> [341548.649957] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> 
> This looks fishy. It means that the root domain is not stalled while
> interrupt handler is called. This would need to be checked.
> 
> > No change in behaviour.  switchtest works, clocktest works, most other
> > things have illegal instruction.  Just waiting for the library and
> > runtime to recompile against 3.12's headers in case it matters.
> > After that it will be debug time.
> > 
> 
> Ok. You seem to have many debug options enabled. Please find attached
> the config I have used during my tests on omap5.

I will try and look through it and see which options to use.  This is
an omap57xx, not a 54xx, also known as the dra7xx.

-- 
Len Sorensen

