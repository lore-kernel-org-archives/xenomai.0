From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 8 Oct 2015 11:51:52 -0400
Message-ID: <20151008155152.GH21923@csclub.uwaterloo.ca>
References: <B89CCBE86D4F62448EE4F6367C6D3C89221E4503@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221EA9F2@USMLVA0EM24MSX.ww017.siemens.net>
 <561568AE.30109@xenomai.org> <56156AB4.2080705@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221ECA2A@USMLVA0EM24MSX.ww017.siemens.net>
 <56161232.50803@xenomai.org>
 <20151008144340.GE21923@csclub.uwaterloo.ca>
 <5616838F.7030507@xenomai.org>
 <20151008151744.GG21923@csclub.uwaterloo.ca>
 <56168EB5.10104@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56168EB5.10104@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 08, 2015 at 05:41:41PM +0200, Philippe Gerum wrote:
> No guarantee, I only had a quick look at this, but AFAICS:
> 
> - the irqchip from the PCA953X gpio extender module does not seem to
> have any requirement for running over a regular kernel context

Our board doesn't have that device, so no problem there.

> - the main GIC IRQ controller is fine, since the fast ack code we use
> over the head domain is shared with the IRQ enabling/disabling support.
> 
> So this should be ok (famous last words).

Well could always just give it a try.

-- 
Len Sorensen

