From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 8 Oct 2015 16:19:52 -0400
Message-ID: <20151008201952.GI21923@csclub.uwaterloo.ca>
References: <B89CCBE86D4F62448EE4F6367C6D3C89221E4474@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4503@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221EA9F2@USMLVA0EM24MSX.ww017.siemens.net>
 <561568AE.30109@xenomai.org> <56156AB4.2080705@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221ECA2A@USMLVA0EM24MSX.ww017.siemens.net>
 <56161232.50803@xenomai.org>
 <20151008144340.GE21923@csclub.uwaterloo.ca>
 <20151008145214.GF8324@hermes.click-hack.org>
 <20151008151549.GF21923@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151008151549.GF21923@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai
	2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 08, 2015 at 11:15:49AM -0400, Lennart Sorensen wrote:
> On Thu, Oct 08, 2015 at 04:52:14PM +0200, Gilles Chanteperdrix wrote:
> > On Thu, Oct 08, 2015 at 10:43:40AM -0400, Lennart Sorensen wrote:
> > > On Thu, Oct 08, 2015 at 08:50:26AM +0200, Philippe Gerum wrote:
> > > > This is a recent change (d818ed7d0a4682) after it became clear that
> > > > dealing with some interrupt types for enabling/disabling IRQ lines would
> > > > require this.
> > > 
> > > Well at least that is an excellent explanation for the change in
> > > behaviour.
> > > 
> > > Too bad that it has to be done for everything, just because some types
> > > require it, but there almost certainly isn't any nice way to do it
> > > otherwise.
> > > 
> > > And as you said, xenomai 3 doesn't even allow doing interrupt handling
> > > from userspace the way we have been trying to do it.
> > > 
> > > I suppose we could revert that patch for now until we can fix the real
> > > problem.
> > 
> > If you revert that patch, you will also have to remove some context
> > checks in the recent I-pipe patches.
> 
> Not sure I grabbed that patch yet, but good to know.
> 
> Happen to know the commit number or title of that one?
> 
> Do you mean fb919529?

Just reverting the xenomai patch seems to have resolved part of the issue,
but not all of it, so perhaps the suggested ipipe bit is needed too,
if only I could find it.

-- 
Len Sorensen

