From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 8 Oct 2015 11:17:44 -0400
Message-ID: <20151008151744.GG21923@csclub.uwaterloo.ca>
References: <B89CCBE86D4F62448EE4F6367C6D3C89221E435B@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4474@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4503@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221EA9F2@USMLVA0EM24MSX.ww017.siemens.net>
 <561568AE.30109@xenomai.org> <56156AB4.2080705@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221ECA2A@USMLVA0EM24MSX.ww017.siemens.net>
 <56161232.50803@xenomai.org>
 <20151008144340.GE21923@csclub.uwaterloo.ca>
 <5616838F.7030507@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5616838F.7030507@xenomai.org>
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

On Thu, Oct 08, 2015 at 04:54:07PM +0200, Philippe Gerum wrote:
> I could not find one that would not look weird. That logic is deeply
> buried in kernel space, and introducing a dynamic dependency on whether
> e.g. the PCI layer has to be traversed for carrying out such ops would
> be rather confusing for the end user, especially when porting the
> application code over different SoCs.

Yep, that sounds ugly.

> Likely, yes. The relevant handlers dealing with the interrupt controller
> of the QUICC Engine do not tread on problematic code, so this should be
> ok for this platform.

Then I have the icky situation that we want the same kernel source to
run on arm.  I wonder if the am572x would care.  I guess I could #ifdef
it for powerpc only and leave the new way on arm.

-- 
Len Sorensen

