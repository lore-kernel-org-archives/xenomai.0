Date: Tue, 18 Nov 2014 23:05:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141118220521.GN3177@sisyphus.hd.free.fr>
References: <20141118185131.GB3177@sisyphus.hd.free.fr>
 <20141118185657.GA24110@csclub.uwaterloo.ca>
 <20141118190014.GC3177@sisyphus.hd.free.fr>
 <20141118192437.GB24110@csclub.uwaterloo.ca>
 <20141118192846.GE3177@sisyphus.hd.free.fr>
 <20141118202833.GH3177@sisyphus.hd.free.fr>
 <20141118205303.GD24110@csclub.uwaterloo.ca>
 <20141118205624.GK3177@sisyphus.hd.free.fr>
 <20141118211713.GL3177@sisyphus.hd.free.fr>
 <20141118213931.GE24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118213931.GE24110@csclub.uwaterloo.ca>
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

On Tue, Nov 18, 2014 at 04:39:31PM -0500, Lennart Sorensen wrote:
> On Tue, Nov 18, 2014 at 10:17:13PM +0100, Gilles Chanteperdrix wrote:
> > It is not just TI. I believe all vendor forks have the same issue:
> > they are not written by people well versed into paying attention to
> > the kind of issue you have to pay attention to with Linux. Once
> > their patches get reviewed, of course they improve. But this takes a
> > lot of time, and for some drivers, they will not even make the
> > effort.
> 
> Certainly true.
> 
> > That being said, the last two vendor forks I used are for TI DM8148,
> > and Xilinx Zynq, and I have to admit that the TI DM8148 fork  code
> > is much much worse than the Xilinx one.
> > 
> > Ok, it seems the TI mainline maintainers are less sloppy, the kernel
> > compiles and boot on both platforms. Less sloppy only because on my
> > OMAP3 board, the USB controller does not get initialized.
> 
> TI seems to be on a 'Get it mainlined' kick lately, so perhaps they are
> being more careful as a result.

>From what I was told by someone who knew  someone who talked to
someone, this was actually actually a two step process (I do not
know whether this changed).

An team did the work that went into the kernel fork that was
delivered to customers, with rapid delivery date as the priority
goal.

Then in a second time, a different team started writing the code
that went into mainline, I am not even sure it used the code of the
first team.

> 
> > Anyway, this is not a good solution, this is clearly something that
> > nobody tests, thre is no reason to expect it what we would expect to
> > dot. 
> 
> I see this 'hack' in the omap timer code:
> 
> +#ifdef CONFIG_IPIPE
> +       if (ipipe) {
> +               u32 l;
> +
> +               l = __raw_readl(timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
> +               l = (0x3 << 8) | (l & (1 << 5)) | (0x1 << 3) | (1 << 2);
> +               __raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
> +       }
> +#endif
> 
> Sure would be nice if someone had actually defined what those bits are,
> although it appears to be setting wakeup on, and idle mode to 'no idle',
> and I didn't look up the 5 and 8 bits yet.

I did that. And I prefer explicit bit numbers, because they match
the datasheet, which is the ultimate reference.

With code relying on defines, you have to trust the define names to
match what you think they do. And I have learned to never trust
identifier names, so I want to check the datasheet anyway, and the
defines do not help, because now instead of having just 4 fields to
check from the same line of code in the documentation of one
register, you have to find the 4 fields definitions in the
middle of a whole bunch of definitions in a separate header file,
and move back and forth.

So, the bottom line is, while I understand the values of defines to
provide the same name to the same bit, when used in several places,
as would be the case for software bitfield, I do not see the value
of it for register values.

-- 
					    Gilles.

