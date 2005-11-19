Message-ID: <437F6EBD.5040705@domain.hid>
Date: Sat, 19 Nov 2005 19:28:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] v2.1 status
References: <437CB8BA.8040902@domain.hid> <437F6273.1050601@domain.hid>
In-Reply-To: <437F6273.1050601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> Philippe Gerum wrote:
> 
>>
>> Here is an update regarding the way things progress on the v2.1 branch:
>>
>> o The build system has been deeply revamped, so that we now fully 
>> leave the burden of building Xenomai's kernel support to Linux. To 
>> this end, the code tree has been reorganized in two major sections, 
>> the first one contains the kernel-related sources (ksrc/), the other 
>> is hosting the user-space support (src/). Since the user-space portion 
>> does not need to know about the kernel sources anymore, several issues 
>> have been solved in the same move. All in all, things are way simpler 
>> than before, which seems to indicate that we are heading to the right 
>> direction. The documentation for the installation process needs to be 
>> updated though.
> 
> 
> I like it a lot.
> 
>> o Also as a matter of build system (and a bit more), v2.1 has been 
>> backported to Linux 2.4, starting with the ppc32 support. We rely on 
>> Denx's 2_4-devel tree as our 2.4 kernel of reference for this port 
>> [1]. A second backport to 2.4/x86 will happen when this combo is 
>> I-pipe ready. We are ahead of schedule regarding this backport, since 
>> it was initially planned for Q12006, but since we are going to add 
>> more supported architectures in the next months, it's better to have a 
>> stable build system for that.
> 
> 
> Just tested Xenomai with adeos-ipipe-2.4.25-ppc-denx-0.9-02.patch on a 
> recent DENX kernel tree. MPC 8xx support was missing. I have attached
> the patch to fix it. Furthermore I have not found the "Machine" options 

Applied, thanks. 0.9-03 contains this fix.

> (here from 2.6):
> 
>  #
>  # Machine
>  #
>  # CONFIG_XENO_HW_FPU is not set
>  CONFIG_XENO_HW_PERIODIC_TIMER=y
>  CONFIG_XENO_HW_TIMER_LATENCY=1
>  CONFIG_XENO_HW_SCHED_LATENCY=1
> 

Now fixed.

> 
> The latency figures on my TQM860L board with Xenomai 2.1 and Liunx 2.4 
> are close to the one I measured with Xenomail 2.0 with Linux 2.6:
> 
> LATENCY with load on TQM860L:
> 
> Linux   |-----lat min|-----lat avg|-----latmax|-overrun|---test-time
> 2.6.13  |       60480|      120960|     224320|       0|    00:09:46
> 2.4.25  |       64080|       95120|     225040|       0|    00:10:00
> 
> 

Same observation here on a Freescale Icecube. I will reactivate the 
kernel-space latency test in order to have the full picture.

Thanks,

-- 

Philippe.

