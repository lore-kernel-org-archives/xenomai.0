From: Wayne Warren <wwarren@emacinc.com>
In-Reply-To: <506F402A.9030102@xenomai.org>
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
	<506DC2DA.5000105@xenomai.org>  <506E9510.7090105@xenomai.org>
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>
	<506F402A.9030102@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Oct 2012 16:47:14 -0500
Message-ID: <1349473634.26881.221.camel@ENG-09-LX.emacinc.com>
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

Sorry,

I did put a call to printascii() in arch/arm/kernel/setup.c right before
the only call I could find to "paging_init()" per the comments in
arch/arm/plat-omap/include/plat/serial.h.

Still, this is not quite what you said so I have just now included the
same lines in several places throughout our board file's init function
just to see if calls before or after the omap_serial_init() function
would make a different. Each time, the kernel hangs--and during
compilation I always see "warning: 'printascii' used but never
defined". 

Does this warning mean that the "printascii" symbol is not exported
properly by the PROC() macro? Or does it indicate that I am doing
something wrong with the printascii declaration which I must always
insert in whatever file I include a call for the function? I guess this
also touches on my lack of understanding of what the PROC() macro is
doing--I have been assuming that it sets the enclosed symbol up to be
available globally for the executable. I picked up a book Understanding
the Linux Kernel today, but it is pretty old and x86 specific.

The impression I had from the wiki page was that earlyprintk and your
advice has no arguments, but the Documentation/kernel-parameters.txt
file confused me on that issue.

Something else I was looking at was attempting to hard code the
omap_phys_addr and omap_virt_addr values in
arch/arm/mach-omap2/include/mach/debug-macro.S--I know the first value
from the technical reference manual, not sure about the other.

Wayne

On Fri, 2012-10-05 at 22:16 +0200, Gilles Chanteperdrix wrote:
> On 10/05/2012 08:47 PM, Wayne Warren wrote:
> 
> > Cool,
> > 
> > First off, thanks again for the help and...my wiki account does not seem
> > to have edit privileges on the page I was referring to in my previous
> > e-mail.
> 
> 
> That should be fixed by that.
> 
> > 
> > Second, I have confirmed that the TI code we originally modified for our
> > product does boot. However! Whenever I pass in
> > "earlyprink=ttyO2,115200n8" the kernel seems to hang. Adding this
> > parameter seems to be the only difference between the kernel that boots
> > properly and the one that does not in this branch. 
> 
> 
> That is what I told you: you should validate earlyprintk, starting by
> validating printascii alone, that is, compile a kernel with
> CONFIG_DEBUG_LL, without CONFIG_EARLY_PRINTK, and add a call to
> printascii somewhere in the boot process, not in vprintk implementation.
> 
> earlyprintk is a module parameter with no argument: what uart is used by
> printascii is determined, as I also told you, by the code in
> arch/arm/plat-omap/include/plat/uncompress.h, it is not a dynamic parameter.
> 


