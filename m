Message-ID: <4A6EECF1.9000103@domain.hid>
Date: Tue, 28 Jul 2009 14:20:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30907280509u685a18di730cc0b021ab06eb@domain.hid>
In-Reply-To: <b88603c30907280509u685a18di730cc0b021ab06eb@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Pagefaults during mlocked Realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Hi everyone,
> 
> I have a basic Xenomai realtime user task which does a read call to a
> basic RTDM driver. The problem is that the realtime task is generating
> pagefaults when the system is under heavy network load even while the
> current and future memory is locked with mlockall(MCL_CURRENT |
> MCL_FUTURE);. There should also be enough free memory.
> 
> Both the MSW and PF go up when showing the stat. So the realtime task
> switches to the secondary domain causing long latencies which we don't
> want.
> 
> (Aside from that I just want to mention that when we generate the high
> load on the usb-gadget ethernet interface (g_ether), the realtime task
> even gets defunct or generates a segfault. I first want to understand
> the pagefaults when using the normal ethernet interface, which might
> then later explain the things we are seeing using the usb-gadget
> interface.)
> 
> I used the sigxcpu.c example to try to find the root of the
> pagefaults, but that only provides me one address which seems to be on
> the [stack] according to the process maps. Running the app in the
> debugger halts when the signal triggers and the call stack shows it is
> at <rt_dev_read+60>: pop    {r4, r7, pc}
> I cannot really find anything in our driver code (rt_dev_read) or
> realtime app that would generate these pagefaults.
> 
> Any help to explain and get rid of the pagefaults is very welcome!
> 
> I am currently running a 2.6.28 linux kernel and Xenomai version 2.4.8
> on an ARM926EJ-S (at91sam9263ek) processor, using the EABI and
> -msoft-float cross compiled with CodeSourcery 2007q3.

Do you have the same behaviour while running the Xenomai latency test. 
If not, without seeing your code, there is not much we can tell. One 
thing to look for, however is the unaligned accesses. Also, do you have 
FCSE enabled?

-- 
                                           Gilles


