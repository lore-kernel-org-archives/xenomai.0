Date: Tue, 18 Nov 2014 16:26:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141118152649.GC26237@sisyphus.hd.free.fr>
References: <545D12D2.2020104@xenomai.org>
 <20141117191237.GS24110@csclub.uwaterloo.ca>
 <20141117201435.GH31920@sisyphus.hd.free.fr>
 <20141117202425.GU24110@csclub.uwaterloo.ca>
 <20141117202754.GI31920@sisyphus.hd.free.fr>
 <20141117214734.GW24110@csclub.uwaterloo.ca>
 <20141117215458.GM31920@sisyphus.hd.free.fr>
 <20141117221001.GX24110@csclub.uwaterloo.ca>
 <20141117221542.GN31920@sisyphus.hd.free.fr>
 <20141118152422.GY24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118152422.GY24110@csclub.uwaterloo.ca>
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

On Tue, Nov 18, 2014 at 10:24:22AM -0500, Lennart Sorensen wrote:
> On Mon, Nov 17, 2014 at 11:15:42PM +0100, Gilles Chanteperdrix wrote:
> > On Mon, Nov 17, 2014 at 05:10:01PM -0500, Lennart Sorensen wrote:
> > > Not sure anything there looks that big.  I wonder if the gpio bank is
> > > just slow to generate the IRQ in the first place for some reason.
> 
> And yes it was.
> 
> > No, I do not see anything wrong either. One thing that could delay
> > gpio irq delivery is PIC muting, if it has a bug with this SOC, so I
> > strongly suggest (once again) that you comment out PIC muting as
> > long as you have issues. Anyway, I do not think that is the case
> > here.
> > 
> > If the latency is not always off, you should trigger a trace only
> > when you detect that the latency is to large.
> 
> OK, found the problem.  The GPIO bank is by default (in the kernel,
> not hardware) configured for 'SmartIdle' which apparently means it goes
> to sleep and first has to wake up, power everything up, start the clock,
> then measure the state of the pin for a couple of clocks before generating
> an IRQ.  Turning off idle support entirely on the GPIO bank makes it
> consistently about 30us response time, so that is great.

Ok, there is already code in the I-pipe for turning off smartidle
for other peripherals (like the hardware timer, the omap specific
one used on omap3, and SMP omap4 and 5 when in UP mode, not the
cortex a9 global timer), so, any patch to toggle this bit with 
if (IS_ENABLED(IPIPE))
will be accepted.

-- 
					    Gilles.

