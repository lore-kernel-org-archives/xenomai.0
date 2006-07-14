Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<44B1FDBD.4060600@domain.hid>
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>
	<44B218C5.9000804@domain.hid>
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>
	<44B2216A.1060904@domain.hid>
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 10:37:34 +0200
Message-Id: <1152866254.5087.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Tue, 2006-07-11 at 12:25 +0800, Li Yi (Adam) wrote:
> Hi Jan,
> 
> Sometimes there is situation to  protect a  Non-real time task in
> kernel space NOT to be interrupted by Xenomai task.
> Is disabling HW interrupt the only way?

Or stalling the Xenomai stage in the interrupt pipeline. See
rthal_local_irq_* in asm-generic/hal.h. But at the very least, make sure
that no Linux rescheduling occurs during the critical section; this
includes disabling kernel preemption before stalling the Xenomai domain.

>  Can I stall Xenomai Domain from handling interrupt while let the
> Linux domain 
> handle interrupt normally?

No, this would make no sense. Interrupts are flowing down the Adeos
pipeline by domain priority order.

> 
> Thanks,
> 
> -Yi
> 
> 
> On 7/10/06, Jan Kiszka <jan.kiszka@domain.hid > wrote:
>         Li Yi (Adam) wrote:
>         > I searched the web and find these RTDM sample drivers
>         (Thanks for the 
>         > contributors):
>         >
>         > In Xenomai src tree: ksrc/drivers/16550A/16550A.c
>         
>         Also check the drivers/testing in recent Xenomai.
>         
>         > http://www.captain.at/xenomai-real-time-driver-example.php
>         >
>         http://www.rts.uni-hannover.de/rtnet/lxr/source/examples/xenomai/
>         > http://www.captain.at/xenomai-serial-port-example.php
>         
>         The last two are usage examples, not drivers. But RTnet is
>         indeed
>         another, more complex example, see these parts: 
>         
>         http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/packet/af_packet.c
>         http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/ipv4
>         http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/rtmac/tdma/tdma_dev.c
>         
>         >
>         > Just wondering are there more samples?
>         
>         http://svn.berlios.de/viewcvs/rack/trunk/rack/main/tims/driver
>         http://www.rts.uni-hannover.de/rtaddon
>         http://developer.berlios.de/projects/usb4rt
>         http://developer.berlios.de/projects/rtfirewire (only as API
>         user, not
>             as RTDM device provider)
>         
>         And a full CAN stack is on the way, may show up on the list
>         this week.
>         Hope I'm not forgetting anything right now.
>         
>         Jan
>         
>         
>         
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



