Date: Fri, 28 Nov 2014 17:40:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141128164056.GM8051@hermes>
References: <20141127231527.GC24076@hermes> <5478430B.9030602@siemens.com>
 <20141128095038.GA3832@hermes> <547846AC.6070204@siemens.com>
 <20141128101605.GC3832@hermes>
 <208C6975C932E94F86239FEA59CCA632DCD4A13E@AUSMXMBX02.mrws.biz>
 <20141128124348.GF6395@hermes>
 <20141128161818.GU24110@csclub.uwaterloo.ca>
 <20141128162423.GJ8051@hermes>
 <20141128162919.GZ24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141128162919.GZ24110@csclub.uwaterloo.ca>
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

On Fri, Nov 28, 2014 at 11:29:19AM -0500, Lennart Sorensen wrote:
> On Fri, Nov 28, 2014 at 05:24:23PM +0100, Gilles Chanteperdrix wrote:
> > the integration of the xenomai package into the Debian repositories
> > is largely a failed experiment. I think the problem is that the
> > debian xenomai package does not have enough users for them to look
> > hard enough and report bugs to reach a good package quality. And
> > there will never be enough users for that, because real-time is a
> > niche, whether people want it or not. So, our goal should be to
> > not cut users from the project, and try and keep them reporting
> > back to us instead of downstream distributions, and to work for
> > these users, not to try and work with intermediates.
> 
> Getting a kernel chosen in Debian for which there is a working
> ipipe/xenomai patch is certainly a problem.

As soon as you start patching the kernel, it does not really make
sense to absolutely pick the same kernel version as Debian, you can
just as well compile a mainline version with a Debian-like
modularized configuration. Actually, I provided exactly that for one
version of Xenomai, but the amount of downloads was ridiculous, so I
do not believe this is what users are after, either.



-- 
					    Gilles.

