Date: Fri, 28 Nov 2014 17:24:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141128162423.GJ8051@hermes>
References: <20141127203400.GP7842@hermes> <54778CF6.6000909@siemens.com>
 <20141127231527.GC24076@hermes> <5478430B.9030602@siemens.com>
 <20141128095038.GA3832@hermes> <547846AC.6070204@siemens.com>
 <20141128101605.GC3832@hermes>
 <208C6975C932E94F86239FEA59CCA632DCD4A13E@AUSMXMBX02.mrws.biz>
 <20141128124348.GF6395@hermes>
 <20141128161818.GU24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141128161818.GU24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
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

On Fri, Nov 28, 2014 at 11:18:18AM -0500, Lennart Sorensen wrote:
> On Fri, Nov 28, 2014 at 01:43:48PM +0100, Gilles Chanteperdrix wrote:
> > The problem is not why not? The problem is why. A mount point was
> > chosen, which is not stupid, documentation and web contents were
> > written, people have started getting used to it. So, why changing it
> > now ? So from my point of view, Jan patch looks like a patch that
> > has been submitted without thinking to the consequences, and changes
> > things for bad reasons.
> 
> The original choice of /mnt does not consider the consequences. 
> 
> > The sentence you quote does not really apply to xenomai, since
> > xenomai is not an "installation program". The standard basically
> > says that software installed by the distribution has no business
> > messing with /mnt. But Xenomai is not installed by a distribution.
> > If distibutions want to change this directory when they make xenomai
> > their own package, they will apply patches, they do this all the
> > time, and document the difference in
> > /usr/share/doc/xenomai/README.Debian
> 
> Debian includes xenomai packages.  So yes it can be installed by a
> distribution.

the integration of the xenomai package into the Debian repositories
is largely a failed experiment. I think the problem is that the
debian xenomai package does not have enough users for them to look
hard enough and report bugs to reach a good package quality. And
there will never be enough users for that, because real-time is a
niche, whether people want it or not. So, our goal should be to
not cut users from the project, and try and keep them reporting
back to us instead of downstream distributions, and to work for
these users, not to try and work with intermediates.

> 
> Make the mount point a configurable option (compile time is fine) so
> at least when building packages for a distribution the location can be
> changed to something sane.

Ok, we agree at last, it seems.

-- 
					    Gilles.

