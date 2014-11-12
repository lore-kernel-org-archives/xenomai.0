Date: Wed, 12 Nov 2014 17:12:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112161201.GZ17476@sisyphus.hd.free.fr>
References: <1415807162.916828670@apps.rackspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415807162.916828670@apps.rackspace.com>
Subject: Re: [Xenomai] Feasibility: Xenomai support/integration on msm
 targets (APQ8060 dragonboard)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mayank.chopra@smartplayin.com
Cc: xenomai@xenomai.org

On Wed, Nov 12, 2014 at 09:16:02PM +0530, mayank.chopra@smartplayin.com wrote:
> Hi Experts,
> 
> Its been a day exploring whether Xenomai is/could be supported on
> msm based chipsets specifically APQ8060. I could not find much
> support for msm platforms, so putting up this request to help me
> understand what all it takes to support Xenomai on these
> platforms. Going by the porting guide, it seems Xenomai is tightly
> coupled with ARM instruction set 

I do not know what you mean by that. Xenomai is very much decoupled
from the underlying architecture, and in fact supports (and has
supported) many architectures:
- arm
- blackfin
- ia64 (abandoned) 
- nios (not supported by latest versions of the I-pipe patch)
- powerpc 32 and 64
- x86 32 and 64

So no, Xenomai is not tightly coupled with ARM instruction set.

> as well as ARM architecture versions.

ARM architecture versions are mostly irrelevant. The only thing that
depend on the ARM architecture is support for the FCSE,
which has been deprecated with ARMv6, so is only enabled for some
ARMv4 or ARMv5 cores (it does not make sense to use FCSE with arm
architecture versions which do not use VIVT cache anyway).

The rest pretty much depends on the ARM SOC you want to support,
because ARM does not impose a particular timer or interrupt
controller before cortex a9, every vendor implemented its own. Some
implementations are common to several SOCs, and when that happens,
the I-pipe patch shares the same implementation. Xenomai has very
little knowledge of the SOC itself, because the I-pipe patch
abstracts this.

The porting guide, yes, is made for ARM only, because I found myself
porting the I-pipe patch to several ARM boards, and found it useful
to summarize the work that needed to be done, and have a checklist
for future reference.

> Appreciate if someone can help me answer below queries:
> 1. Does Xenomai support Krait CPU architecture which msm chipsets
> like APQ8060 are based on? 

No.

> 2. I am looking for kernel 3.0
> (customized to the target) support. I got below ipipe patches:
> adeos-ipipe-3.0.13-arm-1.18-05.patch
> adeos-ipipe-3.0.13-arm-1.18-09.patch
> adeos-ipipe-3.0.36-arm-1.18-11.patch
> 
> But, the patches (tried all 3 one by one) did not go well, as they
> ended up in "unexpected end of file in patch" error.

I would say you have not downloaded the patch correctly, maybe an
issue with MS ftp changing the end of lines because it uses "text
mode", and your version of patch not supporting MS end of lines?
Other than that a patch is meant to be applied to the exact version
it mentions (so 3.0.13 or 3.0.36), any other version will cause
conflict.

> 
> I understand it is not so straight forward to apply above patches
> and make it work. I need some guidance to first complete the
> feasibility part and then jumping on to try support Xenomai on
> APQ8060 target. Any help is appreciated.

Well, everything I know is contained in the porting guide:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

I do not see any more help I can give you, except if you have
precise questions.

-- 
					    Gilles.

