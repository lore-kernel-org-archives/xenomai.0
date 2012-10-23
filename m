From: Wayne Warren <wwarren@emacinc.com>
In-Reply-To: <5085B6BC.8060906@xenomai.org>
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
	<1350933768.17153.16.camel@ENG-09-LX.emacinc.com>
	<50859D99.5040009@xenomai.org>
	<1350934476.17153.20.camel@ENG-09-LX.emacinc.com>
	<5085B6BC.8060906@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Oct 2012 10:32:24 -0500
Message-ID: <1351006344.2975.60.camel@ENG-09-LX.emacinc.com>
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

Yeah, this is actually an OMAP3 processor, except the kernel tree you
are using (if it is the Adeos I-Pipe one) I think was branched from the
vanilla kernel whereas the one we are using is branched from a TI kernel
released specifically for the AM3517 (previously known as OMAP3517, I
think? still confused about that).

The current problem is in __ipipe_stall_root(). After analyzing the
GDB-disassembled function, I can see that there are three "ldr" and one
"str" instructions that might be the cause of the Data Abort exception
that leads into the kernel panic. These instructions all load or store
values related to the __ipipe_percpu_darray variable. Specifically, they
deal with the first entry in this array, clear the status member (ldr,
bic) and write it back (str), check the value of irqpend_himap (ldr,
cmp) to determine if __ipipe_sync_stage should be called (the answer is
no), then try to re-enable interrupts using "cpsie"

The Data Abort exception actually occurs on the "cpsie" instruction, but
according to the ARMv7-A/ARMv7-R architecture reference manual, the
"CPS" type instructions do not generate any exceptions. However, the
manual also indicates that in Debug mode the behavior of the processor
when this instruction is called can be unpredictable.

Anyway, I am somewhat at a loss. The "ldr" and "str" instructions used
perform the operations as expected according to printouts of
__ipipe_cpu_darray.

Wayne

On Mon, 2012-10-22 at 23:12 +0200, Gilles Chanteperdrix wrote:
> On 10/22/2012 09:34 PM, Wayne Warren wrote:
> 
> > 
> >>
> >> Chances are you are calling into Adeos code too early. Normally, the
> >> first call to local_irq_enable() happens in init/main.c, after the call
> >> to __ipipe_init() (you should see both in function start_kernel). I
> >> suspect you can not call services such as __set_irq_handler too early in
> >> the boot process.
> > 
> > In the code I am looking at, local_irq_enable() is called after
> > ipipe_init().
> > 
> > Are you saying that the __set_irq_handler() service should not be called
> > before ipipe_init() also? Cause it is called after ipipe_init_early()
> > but before ipipe_init().
> 
> 
> The same order happens on OMAP3 for the primary interrupt controller.
> So, that should work.
> 


