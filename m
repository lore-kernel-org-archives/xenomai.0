From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 4 Sep 2012 11:53:39 -0400
Message-ID: <20120904155339.GZ1237@csclub.uwaterloo.ca>
References: <50461A66.6070805@ruggedcom.com>
 <504621AB.3000402@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504621AB.3000402@xenomai.org>
Subject: Re: [Xenomai] Powepc 8360 interrupt timing question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Sep 04, 2012 at 05:43:39PM +0200, Philippe Gerum wrote:
> - which I-pipe version exactly? Seven different patches were released
> for 3.0.x/powerpc over time.
> 
> - which Xenomai release? 2.6.0, 2.6.1, current HEAD?

xenomai 2.6.0, kernel 3.0.22, ipipe 3.0.8-powerpc-2.13-04

> You seem to be rehashing an old question. The answer at that time was:
> 
> - there was an issue with processing cascaded interrupts in the former
> pipeline architecture. This has been solved in recent patches with the
> introduction of the pipeline "core" series (core-3.2 and above, commit
> a4b909ccf80c5a).

Hmm, I wonder if that would apply reasonably cleanly on top of the
3.0.8 patch.  Might be worth a try.

> - handling level IRQs in userland is generally a bad idea.

Unfortunately edge IRQs don't really share well.

-- 
Len Sorensen

