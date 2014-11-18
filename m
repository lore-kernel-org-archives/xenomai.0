From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 18 Nov 2014 16:48:54 -0500
Message-ID: <20141118214854.GG24110@csclub.uwaterloo.ca>
References: <20141117214734.GW24110@csclub.uwaterloo.ca>
 <20141117215458.GM31920@sisyphus.hd.free.fr>
 <20141117221001.GX24110@csclub.uwaterloo.ca>
 <20141117221542.GN31920@sisyphus.hd.free.fr>
 <20141118152422.GY24110@csclub.uwaterloo.ca>
 <20141118152649.GC26237@sisyphus.hd.free.fr>
 <20141118184843.GZ24110@csclub.uwaterloo.ca>
 <20141118191448.GD3177@sisyphus.hd.free.fr>
 <20141118192530.GC24110@csclub.uwaterloo.ca>
 <20141118194654.GF3177@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118194654.GF3177@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
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

On Tue, Nov 18, 2014 at 08:46:54PM +0100, Gilles Chanteperdrix wrote:
> Just something to inform you. The status of Xenomai patches for
> vendor forks are:
> - imx6 using 3.0 fork, somewhat maintained: inexplicable hangups,
> and a situation where it is hard not to suspect the young age of the
> port in the kernel used;
> - beaglebone using 3.8 fork: patch submitted, no feedback, no
> further submission; considered bitroting now
> - raspberry: same as beaglebone
> - zynq: two patches submitted, one for 3.5 and one for 3.8, but
> otherwise same as beaglebone and raspberry.
> 
> In my experience, when people choose a kernel version for an
> industrial project, they tend to stick to that version for the
> duration of the project, or even for all the projects they do with
> the same processors. The result is that if they need an I-pipe patch
> for their project, they need it for one kernel version, so their
> contribution is of the "drop and go" kind. Simply because when this
> project is finished, another starts, maybe using a newer processor,
> and so they never get the time to upgrade the patch to a kernel
> version they do not need.

We make products for the long term (in production for 10+ years) with
new features and support along the way.  We try to keep up with updates.
We will be moving our powerpc systems from 3.0 to 3.14 pretty soon.

> So, it is much better to contribute I-pipe patches to the mainline
> kernel I-pipe branch. Simply because, when I merge them, I
> compile-test them for every following supported mainline kernel
> release. So, even if some kernel change broke the patch without
> breaking compilation (this happens, and not even rarely), you have
> something from which you can start on a current release.
> 
> But my vendor fork supports hardware X or Y! Well, then port the
> driver for hardware X or Y to the mainline kernel, this will not
> take monthes to do (assuuming you will not try and get the drivers
> merged into mainline, because THAT would cost you a lot of time,
> there is a reason why vendors keep them in forks and do not try and
> merge them).

Well TI is working on mainlining support for the am572x at the moment,
but it looks like at best that will be in 3.19 at this point.  They will
probably also "officially" announce the am572x sometime soon, not that
it isn't mentioned in many places, including lots of public git trees
for linux.

There is a 3.8, 3.12 and 3.14 tree from ti at the moment.  3.12 works
quite well, although it has no dma controller driver.  3.14 has dma,
but is tricky to get to boot (have to get the config just right) and
is still under development.  The 3.8 tree just crashes user space apps
randomly and is useless.  So at the moment we use 3.12 with ipipe for
3.14 backported (was pretty simple to do), with the intent to go to 3.14
as soon as we get that working.

-- 
Len Sorensen

