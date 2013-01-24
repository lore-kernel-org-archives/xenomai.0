Message-ID: <5100F8FA.9000104@xenomai.org>
Date: Thu, 24 Jan 2013 10:03:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>	<50F3DD9A.9050306@gmail.com>	<OF5CF00330.868585F8-ON85257AFA.00801D57-85257AFB.00000E92@aanddtech.com>	<50FE45E9.1040909@xenomai.org>	<OF518EBAA9.1B02356C-ON85257AFC.00002A9B-85257AFC.00028E23@aanddtech.com>	<50FF4434.7030405@xenomai.org>
	<CAFVR4DVpsR026fvgybs91iC7-gDLVvBS8wsXBRO0XdzLBcXzpg@mail.gmail.com>
	<50FF8B16.3060100@xenomai.org>
	<OFC84FDBBF.88E9186F-ON85257AFC.007B4CC3-85257AFC.008309FB@aanddtech.com>
In-Reply-To: <OFC84FDBBF.88E9186F-ON85257AFC.007B4CC3-85257AFC.008309FB@aanddtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfornero@aanddtech.com
Cc: Xenomai@xenomai.org

On 01/24/2013 12:51 AM, mfornero@aanddtech.com wrote:>

> Things of note:
> twd is the (per cpu) timer used by the ipipe
> xttcpss is a triple timer counter within the SoC, which appears to only
> be used until the twd timer is setup-- this timer is *not* ported to the
> Ipipe, which I assumed was okay because the twd is used-- is this
> assumption correct?


You need to register this timer with the I-pipe if not compiling for
SMP, as in this case, Linux does not start the TWD.

>> Each platform defines its own irqchips for multiplexed GPIOs. If you
>> want to track all invalid GPIO demuxers, you can enable ipipe debugging
>> and add ipipe_root_only() inside "generic_handle_irq".
> 
> I tested this, and never triggered the debug code-- I assume this means
> no calls to generic_handle_irq were made in the head domain?


Indeed, as /proc/interrupts show, you are not using any GPIO multiplexed
interrupt.

>> Right, you need to use EXPORT_PER_CPU_SYMBOL_GPL(current_mm).
> 
> Thanks-- this let me compile Xenomai as a module, which may help with
> debugging.
> 
> I found that the hang seems to occur when a skin is loaded, not nucleus.
> Something seems to happen at this point that prevents further SDHC
> interrupts.
> It's not clear, but it also may have some effect on the UART (maybe
> all?) interrupt as well-- I observed a printk stop partway through a
> string as the nucleus module was loaded [note-- I am running through a
> serial console, and have MMC_DEBUG turned on] -- see timestamp 151.49


As said in the porting guide, it means that you have a timer issue. What
happens when you load a skin module is that Xenomai takes over the
control of the timer. So, that is where you should look. Do not assume
anything about the TWD code, it is not because it works on other
platforms that it works on this one.

-- 
                                                                Gilles.

