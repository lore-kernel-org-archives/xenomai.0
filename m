Date: Tue, 18 Nov 2014 22:17:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141118211713.GL3177@sisyphus.hd.free.fr>
References: <20141118152649.GC26237@sisyphus.hd.free.fr>
 <20141118184843.GZ24110@csclub.uwaterloo.ca>
 <20141118185131.GB3177@sisyphus.hd.free.fr>
 <20141118185657.GA24110@csclub.uwaterloo.ca>
 <20141118190014.GC3177@sisyphus.hd.free.fr>
 <20141118192437.GB24110@csclub.uwaterloo.ca>
 <20141118192846.GE3177@sisyphus.hd.free.fr>
 <20141118202833.GH3177@sisyphus.hd.free.fr>
 <20141118205303.GD24110@csclub.uwaterloo.ca>
 <20141118205624.GK3177@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118205624.GK3177@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Tue, Nov 18, 2014 at 09:56:24PM +0100, Gilles Chanteperdrix wrote:
> On Tue, Nov 18, 2014 at 03:53:03PM -0500, Lennart Sorensen wrote:
> > On Tue, Nov 18, 2014 at 09:28:33PM +0100, Gilles Chanteperdrix wrote:
> > > On Tue, Nov 18, 2014 at 08:28:46PM +0100, Gilles Chanteperdrix wrote:
> > > > What if you remove SYSC_HAS_SIDLEMODE here ?
> > 
> > I suspect that would work, but I was trying not to mess with the hwmod
> > if I could.  I am trying the ti,no-idle again since I screwed up the
> > test and it might actually work.
> > 
> > > Another thing, what if you remove PM_RUNTIME in the kernel
> > > configuration completely? On my omap3 and omap4 boards, this results
> > > in some stupid warnings at boot time, but the system runs just fine.
> > > And maybe this bypasses all that hwmod awful stuff.
> > 
> > TI is so sloppy that doing that causes a ton of compile errors. 

It is not just TI. I believe all vendor forks have the same issue:
they are not written by people well versed into paying attention to
the kind of issue you have to pay attention to with Linux. Once
their patches get reviewed, of course they improve. But this takes a
lot of time, and for some drivers, they will not even make the
effort.

That being said, the last two vendor forks I used are for TI DM8148,
and Xilinx Zynq, and I have to admit that the TI DM8148 fork  code
is much much worse than the Xilinx one.

> Half the
> > power management code is wrapped in CONFIG_PM and the other half is not.
> 
> You are right. My configurations have PM_RUNTIME enabled both on
> OMAP3 and OMAP4. I am almost sure I used to turn it off. But it may
> be a while since I tested it.

Ok, it seems the TI mainline maintainers are less sloppy, the kernel
compiles and boot on both platforms. Less sloppy only because on my
OMAP3 board, the USB controller does not get initialized.

Anyway, this is not a good solution, this is clearly something that
nobody tests, thre is no reason to expect it what we would expect to
dot. 
> 
> -- 
> 					    Gilles.
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

-- 
					    Gilles.

