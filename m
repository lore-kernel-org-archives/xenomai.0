Message-ID: <5086FA29.6010008@xenomai.org>
Date: Tue, 23 Oct 2012 22:12:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
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
	<1351006344.2975.60.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1351006344.2975.60.camel@ENG-09-LX.emacinc.com>
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

On 10/23/2012 05:32 PM, Wayne Warren wrote:

> Yeah, this is actually an OMAP3 processor, except the kernel tree you
> are using (if it is the Adeos I-Pipe one) I think was branched from the
> vanilla kernel whereas the one we are using is branched from a TI kernel
> released specifically for the AM3517 (previously known as OMAP3517, I
> think? still confused about that).
> 
> The current problem is in __ipipe_stall_root(). After analyzing the
> GDB-disassembled function, I can see that there are three "ldr" and one
> "str" instructions that might be the cause of the Data Abort exception
> that leads into the kernel panic. These instructions all load or store
> values related to the __ipipe_percpu_darray variable. Specifically, they
> deal with the first entry in this array, clear the status member (ldr,
> bic) and write it back (str), check the value of irqpend_himap (ldr,
> cmp) to determine if __ipipe_sync_stage should be called (the answer is
> no), then try to re-enable interrupts using "cpsie"
> 
> The Data Abort exception actually occurs on the "cpsie" instruction, but
> according to the ARMv7-A/ARMv7-R architecture reference manual, the
> "CPS" type instructions do not generate any exceptions. However, the
> manual also indicates that in Debug mode the behavior of the processor
> when this instruction is called can be unpredictable.
> 
> Anyway, I am somewhat at a loss. The "ldr" and "str" instructions used
> perform the operations as expected according to printouts of
> __ipipe_cpu_darray.


Normally, if the kernel is not an SMP kernel, the root state is a simple
variable. The only reason I see why ldr or str could fail would be if
the address is invalid or not aligned correctly. Apart from that,
debugging this kind of issue remotely is a bit hard.

You can try another method, if the vanilla kernel from which the branch
you are working on is forked works on the processor you are using, and
works with xenomai, you can try a git bisect, to try and find which
commit exactly conflicts with the I-pipe patch.

Yet another method, you can try and reduce the kernel to the simplest
possible configuration which allows to boot your system (disabling NAND
and NOR, which should for instance remove the need for GPMC, and boot
using NFS), see if it works, and if it works, gradually add the options
until you find which option is a problem, then compare the code this
option enables with the vanilla linux code.

-- 
                                                                Gilles.

