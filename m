From: Wayne Warren <wwarren@emacinc.com>
In-Reply-To: <5081FF74.4010109@xenomai.org>
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>
	<506F402A.9030102@xenomai.org>
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>
	<506F6283.2040901@xenomai.org>
	<5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>
	<506FFDDC.60104@xenomai.org>
	<1349816136.25350.426.camel@ENG-09-LX.emacinc.com>
	<50749349.5070900@xenomai.org>
	<1350681759.1282.88.camel@ENG-09-LX.emacinc.com>
	<5081FF74.4010109@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Oct 2012 14:22:48 -0500
Message-ID: <1350933768.17153.16.camel@ENG-09-LX.emacinc.com>
Mime-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This code is the __set_irq_handler function which, given an interrupt
number/id, appears to set up an entry in an irq_desc array. This
structure (irq_desc) appears to be the place to go for information
related to a given IRQ id.

We seem to have discovered the problem, which was that this array was
not initialized with enough slots...in
arch/arm/plat-omap/include/play/irqs.h OMAP_GPMC_NR_IRQS was defined as
7 rather than 8 (there are actually 8 GPMC chip selects). In a
roundabout way, this macro is used to calculate the array size for
irq_desc.

Since gpmc_init() was using GPMC_CS_NUM as a bound in the for loop that
was calling __set_irq_handler and the "irq" variable in that same
function was initialized using OMAP_GPMC_IRQ_BASE, it seems like:

  - OMAP_GPMC_NR_IRQS should be used in the for loop instead of
GPMC_CS_NUM,
  - GPMC_CS_NUM should be used to define OMAP_GPMC_NR_IRQS,
  - or at the very least, GPMC_CS_NUM and OMAP_GPMC_NR_IRQS should be
set to the same constant value (8).

I think maybe the first two of those together should be the fix, but I
am still fairly lost here. Temporarily, we have set OMAP_GPMC_NR_IRQS to
8 which eliminates the data abort exception that was occurring in
__set_irq_handler.

But we still have a kernel panic. Stepping further through the
start_kernel function in GDB leads to local_irq_enable() which after
some investigation is preprocessed into __ipipe_unstall_root().

It is the last line of this function, "local_irq_enable_hw()" where the
next data abort exception occurs. This line translates into the
assembler instruction "cpsie i" which is the last instruction before
__dabt_svc(). Any idea what might be going on there? 

Thanks again for your help and prompt replies, they are very helpful.

Wayne

On Sat, 2012-10-20 at 03:33 +0200, Gilles Chanteperdrix wrote:
> On 10/19/2012 11:22 PM, Wayne Warren wrote:
> 
> > Just an update...
> > 
> > I currently have GDB connected to the unit using a BDI2000 JTAG
> > debugger.
> > 
> > 
> > (gdb) bt
> > #0  __set_irq_handler (irq=395, handle=0xc00c3424 <handle_simple_irq>, is_chained=0, name=0x0) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/kernel/irq/chip.c:836
> 
> 
> So what is the code at line 836 in kernel/irq/chip.c ?
> 


