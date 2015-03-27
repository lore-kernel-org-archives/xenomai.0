Date: Fri, 27 Mar 2015 08:55:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150327075557.GB27713@hermes.click-hack.org>
References: <CAJqUr7w6OZ+kcYp7mFg9OPD0AKuXXDDdLQBCAHQiuxKcG5A=hA@mail.gmail.com>
 <20150327001331.GB29558@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150327001331.GB29558@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
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

On Thu, Mar 26, 2015 at 08:13:31PM -0400, Lennart Sorensen wrote:
> On Thu, Mar 26, 2015 at 03:58:12PM -0700, Don Mahurin wrote:
> > Another basic question regarding this porting effort:
> > 
> > Before any arm64 specific changes or platform specific changes, would
> > just merging the i-pipe patch/tree (merging ipipe-3.10 into the vendor
> > kernel for instance) be expected to boot, with CONFIG_IPIPE not set?
> > Or will that lead to undefined results?
> 
> I have yet to ever have a kernel with ipipe patches applied that could
> be compiled with CONFIG_IPIPE disabled.  I always have to remove the
> ipipe and xenomai patches if I want to test without them.  I imagine
> that for some architectures with some kernel versions it had worked,
> but it seems in general it doesn't.  It just isn't a priority to test
> that configuration I suspect.

Normally, this is a configuration which is supported and tested. It
may happen that a patch is released without having tested it on all
platforms I guess, so, if you find a problem with that, please send
a report. Or a patch, because such problems are usually not hard to
fix.

-- 
					    Gilles.

