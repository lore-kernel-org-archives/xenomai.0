Message-ID: <5081FF74.4010109@xenomai.org>
Date: Sat, 20 Oct 2012 03:33:40 +0200
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
In-Reply-To: <1350681759.1282.88.camel@ENG-09-LX.emacinc.com>
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

On 10/19/2012 11:22 PM, Wayne Warren wrote:

> Just an update...
> 
> I currently have GDB connected to the unit using a BDI2000 JTAG
> debugger.
> 
> 
> (gdb) bt
> #0  __set_irq_handler (irq=395, handle=0xc00c3424 <handle_simple_irq>, is_chained=0, name=0x0) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/kernel/irq/chip.c:836


So what is the code at line 836 in kernel/irq/chip.c ?

-- 
                                                                Gilles.

