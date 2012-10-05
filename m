Message-ID: <506F6283.2040901@xenomai.org>
Date: Sat, 06 Oct 2012 00:43:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>	
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>	
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>	
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>	
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>	
	<506F402A.9030102@xenomai.org>
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1349473634.26881.221.camel@ENG-09-LX.emacinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Warren <wwarren@emacinc.com>
Cc: xenomai@xenomai.org

On 10/05/2012 11:47 PM, Wayne Warren wrote:

> The impression I had from the wiki page was that earlyprintk and your
> advice has no arguments, but the Documentation/kernel-parameters.txt
> file confused me on that issue.


That is because it documents this option for x86, not ARM.

> 
> Something else I was looking at was attempting to hard code the
> omap_phys_addr and omap_virt_addr values in
> arch/arm/mach-omap2/include/mach/debug-macro.S--I know the first value
> from the technical reference manual, not sure about the other.


For the third time, see:
arch/arm/plat-omap/include/plat/uncompress.h
That is where the virtual and physical addresses are set for OMAP based
processors.

-- 
                                                                Gilles.

