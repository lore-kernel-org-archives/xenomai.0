Message-ID: <510249E7.3040904@xenomai.org>
Date: Fri, 25 Jan 2013 10:01:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>	<50F3DD9A.9050306@gmail.com>	<OF5CF00330.868585F8-ON85257AFA.00801D57-85257AFB.00000E92@aanddtech.com>	<50FE45E9.1040909@xenomai.org>	<OF518EBAA9.1B02356C-ON85257AFC.00002A9B-85257AFC.00028E23@aanddtech.com>	<50FF4434.7030405@xenomai.org>
	<CAFVR4DVpsR026fvgybs91iC7-gDLVvBS8wsXBRO0XdzLBcXzpg@mail.gmail.com>
	<50FF8B16.3060100@xenomai.org>
	<OFC84FDBBF.88E9186F-ON85257AFC.007B4CC3-85257AFC.008309FB@aanddtech.com>
	<5100F8FA.9000104@xenomai.org>
	<OF3C3DF41E.C733E3A5-ON85257AFD.00809CA9-85257AFD.0083A303@aanddtech.com>
In-Reply-To: <OF3C3DF41E.C733E3A5-ON85257AFD.00809CA9-85257AFD.0083A303@aanddtech.com>
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

On 01/25/2013 12:57 AM, mfornero@aanddtech.com wrote:

> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote on
> 01/24/2013 04:03:54 AM:
> 
>> As said in the porting guide, it means that you have a timer issue. What
>> happens when you load a skin module is that Xenomai takes over the
>> control of the timer. So, that is where you should look. Do not assume
>> anything about the TWD code, it is not because it works on other
>> platforms that it works on this one.
> 
> I modified the xttcpss code to support the ipipe_timer structure and got
> some interesting results:
> 
> If I simply register this device with ipipe, there is largely no
> difference-- this is because the twd timer has a higher rating, and is
> registered by the time xenomai loads
> 
> If I increase the rating of the xttcpss timer, the system is able to
> boot and run the xenomai sample applications
>         CPU0 uses the xttcpss timer as it's timer
>         CPU1 uses the twd timer as it's timer
> 
>         latency test is able to run on both cores (though CPU1 gets
> considerably better numbers-- likely because the twd timer runs at a
> much higher frequency)


I would say the difference is probably the timer programming latency.

> 
> This seems to indicate there is some problem on this platform with the
> twd code (maybe the sharing of the twd interrupt between linux and
> xenomai?).


The twd interrupt is not shared between linux and xenomai, only xenomai
sees it, the linux timer interrupt then become a sort of soft interrupt
triggered by Xenomai.

> 
> Of note-- when both cores are using the twd (the still broken case), if
> I turn on CONFIG_IPIPE_DEBUG_INTERNAL and enable the
> __ipipe_serial_debug message in twd_hrtimer_debug, I see far more
> interrupts on CPU1 than on CPU0. Is this to be expected?
> 
> In general, do is there any advice for debugging where the twd_smp.c
> code is falling over on my platform?


No, unfortunately there is no magic recipe, you have to add traces
around to understand what happens.

-- 
                                                                Gilles.

