Date: Wed, 25 May 2016 16:13:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160525141353.GP13609@hermes.click-hack.org>
References: <CAJ2oMh+KSW=wGadQ079T+e7M1E3=UG5GY=J8ih61Ez6UHENzWQ@mail.gmail.com>
 <20160525092316.GF13609@hermes.click-hack.org>
 <CAJ2oMhLJdUfizqQ_8m=7LQ3D4SaH06FtLV_oL55MokT=C5PDAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhLJdUfizqQ_8m=7LQ3D4SaH06FtLV_oL55MokT=C5PDAg@mail.gmail.com>
Subject: Re: [Xenomai] Oops "undefined instruction: 0 [#1] PREEMPT SMP ARM"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Wed, May 25, 2016 at 05:10:21PM +0300, Ran Shalit wrote:
> On Wed, May 25, 2016 at 12:23 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Wed, May 25, 2016 at 11:55:25AM +0300, Ran Shalit wrote:
> >> Hello,
> >>
> >> I hope someone can have a hint on the following.
> >> I use xenomai 2.6.3 patched with kernel 3.8.0 on zynq.
> >
> > There is no reason to start working on a new project with Xenomai
> > 2.6.3. For this reason, switch to Xenomai 2.6.4, or even better
> > Xenomai 3.0.2
> >
> >>  ./configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t"
> >> --build=i686-pc-linux-gnu --host=arm-xilinx-linux-gnueabi
> >
> > The zynq is an armv7; not an armv4. You have no reason whatsoever to
> > use such compilation flags.
> >
> > --
> I suspect that it is related to something illegal maybe that I'm doing
> in driver, but I still don't understand what it is.
> Even if I just load the the driver and then write
> cat /proc/xenomai/stat then I recieve this oops.
> 
> The driver does ioremap and the rtdm_request_irq both in module
> initialization, maybe it is not correct with rtdm?

It is pointless to even look at your issue as long as you use an
outdated version.

-- 
					    Gilles.
https://click-hack.org

