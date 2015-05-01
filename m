Date: Fri, 1 May 2015 15:56:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150501135651.GE1993@hermes.click-hack.org>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430183147.GZ1993@hermes.click-hack.org>
 <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
 <20150430201409.GA1993@hermes.click-hack.org>
 <20150430212151.GD24389@csclub.uwaterloo.ca>
 <20150430212749.GB1993@hermes.click-hack.org>
 <20150501134547.GF24389@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150501134547.GF24389@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
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

On Fri, May 01, 2015 at 09:45:47AM -0400, Lennart Sorensen wrote:
> On Thu, Apr 30, 2015 at 11:27:49PM +0200, Gilles Chanteperdrix wrote:
> > The problem I see with the architected timer is the minimum wrap
> > time imposed by the specification, which forces a low resolution if
> > the implementer does not want to implement the full 64 bits. So, it
> > may be a good reason to propose another timer, with say nanosecond
> > resolution, but without a guaranteed large wrap time, especially
> > since then implementation can extend it to the full 64 its in
> > software and have both high resolution and long wrap time.
> 
> Well on the TI am572x it is 56 bits at about 6MHz, so it wraps every
> 2794 seconds according to the boot messages.  Would be nice if it was
> 64 bits, since that would avoid wrapping for quite a while.  And sure
> a timer with 1ns would be great.  This one only gets 162ns.

6MHz is still not a lot (even omap3 did better than that).

And no, a A 56 bits counter running at 6MHz does not wrap in 2794
seconds, it wraps in:

(2^56) / 6000000 = 12009599006 s

That is:
12009599006 / (365 * 24 * 3600) = 380 years

So, you are safe, it can be considered to avoid wrapping for a
reasonable amount of time.

Which means really, that I do not understand why the frequency is so
low.

56 bits at 1 GHz would wrap in two years using the same computation,
that clearly would violate ARM specs. But 60 MHz for instance would
wrap in 38 years, that would seem reasonable.

-- 
					    Gilles.

