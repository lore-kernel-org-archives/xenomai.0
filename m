Message-ID: <534E926F.9090706@xenomai.org>
Date: Wed, 16 Apr 2014 16:23:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsAmXEyH4wcMeGcWPB3B-3=04DoS=K2k-QbQ+DidPcptAg@mail.gmail.com>	<534BD45B.8070402@xenomai.org>	<CAPRPZsDSg6Yb3w+UEktb+7AmdZ-7JngVQH4tBbxnk5EV04y0AA@mail.gmail.com>	<534D44CA.3000105@xenomai.org>
 <CAPRPZsD6r6y6UpYsN544WeLxYEnruKzjoHH4e33NPKEDCswJqQ@mail.gmail.com>
In-Reply-To: <CAPRPZsD6r6y6UpYsN544WeLxYEnruKzjoHH4e33NPKEDCswJqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Slow execution of RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/16/2014 11:43 AM, Jeroen Van den Keybus wrote:
>> Could you patch the code fragment in, enable CONFIG_IPIPE_TRACE, then get a
>> dump from /proc/ipipe/trace/frozen once the warning has triggered?
>> Maybe getting a bit more context by setting
>> /proc/ipipe/trace/backtrace_points to 2048 would help too. TIA,
>
> I've attached the (somewhat lengthy) trace.
>
> BTW I now loaded xeno_nucleus and xeno_native in succession. The
> modprobing of xeno_native again locked until a new ssh terminal was
> opened (typing chars in the waiting ssh client didn't help).
>

 From that trace, it looks like an initial warning is issued on the same 
CPU, before the second one (i.e. rcutree.c:480) is raised:

:    #func               -2040	  0.088  print_oops_end_marker+0x0 
(warn_slowpath_common+0x66)
:    #func               -2040	  0.090  printk+0x0 
(print_oops_end_marker+0x2e)
:|   #begin   0x80000001 -2040	  0.117  printk+0x66 
(print_oops_end_marker+0x2e)

The trace backlog is not deep enough to locate the offending spot, but 
the lines above typically close a WARN_ON() handling. Once this first 
warning is sent out, the CPU then waits for 2s before receiving a timer 
IRQ from the APIC:

:    #func               -2032! 1998.529  intel_idle+0x0 
(cpuidle_enter_state+0x40)
:|   #begin   0x000000ef   -34	  0.097  apic_timer_interrupt+0x6d 
(intel_idle+0xab)

Could you check your kernel logs for this initial warning? Maybe this 
would shed light, assuming the second bug may be a side-effect of the 
first one.

TIA,

-- 
Philippe.

