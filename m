Date: Tue, 18 Nov 2014 20:46:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141118194654.GF3177@sisyphus.hd.free.fr>
References: <20141117202754.GI31920@sisyphus.hd.free.fr>
 <20141117214734.GW24110@csclub.uwaterloo.ca>
 <20141117215458.GM31920@sisyphus.hd.free.fr>
 <20141117221001.GX24110@csclub.uwaterloo.ca>
 <20141117221542.GN31920@sisyphus.hd.free.fr>
 <20141118152422.GY24110@csclub.uwaterloo.ca>
 <20141118152649.GC26237@sisyphus.hd.free.fr>
 <20141118184843.GZ24110@csclub.uwaterloo.ca>
 <20141118191448.GD3177@sisyphus.hd.free.fr>
 <20141118192530.GC24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118192530.GC24110@csclub.uwaterloo.ca>
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

On Tue, Nov 18, 2014 at 02:25:30PM -0500, Lennart Sorensen wrote:
> On Tue, Nov 18, 2014 at 08:14:48PM +0100, Gilles Chanteperdrix wrote:
> > On Tue, Nov 18, 2014 at 01:48:43PM -0500, Lennart Sorensen wrote:
> > > On Tue, Nov 18, 2014 at 04:26:49PM +0100, Gilles Chanteperdrix wrote:
> > > > Ok, there is already code in the I-pipe for turning off smartidle
> > > > for other peripherals (like the hardware timer, the omap specific
> > > > one used on omap3, and SMP omap4 and 5 when in UP mode, not the
> > > > cortex a9 global timer), so, any patch to toggle this bit with 
> > > > if (IS_ENABLED(IPIPE))
> > > > will be accepted.
> > > 
> > > I am just adding 'ti,no-idle' to gpio7 in the dtb.  That appears to
> > > be right.  Building it now to test it.
> > > 
> > > The handling is of in omap-hwmod.c, not in gpio-omap.c so not sure how
> > > to make ipipe know that a given gpio bank is used for irq and should
> > > not idle.  At least not in a clean manner.
> > 
> > I am afraid this parameter can not be found in mainline kernel 3.16.
> > So, it must be a local addition of the kernel you use.
> 
> Yeah I am using the ti-linux tree since they are not done merging yet.
> 
> Not that it worked anyhow.

Just something to inform you. The status of Xenomai patches for
vendor forks are:
- imx6 using 3.0 fork, somewhat maintained: inexplicable hangups,
and a situation where it is hard not to suspect the young age of the
port in the kernel used;
- beaglebone using 3.8 fork: patch submitted, no feedback, no
further submission; considered bitroting now
- raspberry: same as beaglebone
- zynq: two patches submitted, one for 3.5 and one for 3.8, but
otherwise same as beaglebone and raspberry.

In my experience, when people choose a kernel version for an
industrial project, they tend to stick to that version for the
duration of the project, or even for all the projects they do with
the same processors. The result is that if they need an I-pipe patch
for their project, they need it for one kernel version, so their
contribution is of the "drop and go" kind. Simply because when this
project is finished, another starts, maybe using a newer processor,
and so they never get the time to upgrade the patch to a kernel
version they do not need.

So, it is much better to contribute I-pipe patches to the mainline
kernel I-pipe branch. Simply because, when I merge them, I
compile-test them for every following supported mainline kernel
release. So, even if some kernel change broke the patch without
breaking compilation (this happens, and not even rarely), you have
something from which you can start on a current release.

But my vendor fork supports hardware X or Y! Well, then port the
driver for hardware X or Y to the mainline kernel, this will not
take monthes to do (assuuming you will not try and get the drivers
merged into mainline, because THAT would cost you a lot of time,
there is a reason why vendors keep them in forks and do not try and
merge them).

-- 
					    Gilles.

