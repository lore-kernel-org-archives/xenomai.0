From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 8 Oct 2015 16:41:10 -0400
Message-ID: <20151008204110.GK21923@csclub.uwaterloo.ca>
References: <B89CCBE86D4F62448EE4F6367C6D3C89221EA9F2@USMLVA0EM24MSX.ww017.siemens.net>
 <561568AE.30109@xenomai.org> <56156AB4.2080705@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221ECA2A@USMLVA0EM24MSX.ww017.siemens.net>
 <56161232.50803@xenomai.org>
 <20151008144340.GE21923@csclub.uwaterloo.ca>
 <20151008145214.GF8324@hermes.click-hack.org>
 <20151008151549.GF21923@csclub.uwaterloo.ca>
 <20151008201952.GI21923@csclub.uwaterloo.ca>
 <20151008203102.GJ8324@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151008203102.GJ8324@hermes.click-hack.org>
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

On Thu, Oct 08, 2015 at 10:31:02PM +0200, Gilles Chanteperdrix wrote:
> I am talking about that line:
> http://git.xenomai.org/ipipe.git/tree/kernel/irq/chip.c?h=ipipe-3.18#n893

OK, so that was in the patch I had found, I just hadn't noticed
the difference with the root_only check.  Of course without
CONFIG_IPIPE_DEBUG_CONTEXT, that is a noop and hence wouldn't do anything
as far as I can tell.

-- 
Len Sorensen

