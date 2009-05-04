From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <ff1d78710905040459u56772812kb95fb6083a2ee0c5@domain.hid>
References: <ff1d78710905040459u56772812kb95fb6083a2ee0c5@domain.hid>
Content-Type: text/plain
Date: Mon, 04 May 2009 15:29:36 +0200
Message-Id: <1241443776.26544.321.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel lockup when shared IRQ is enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Kauffmann <steven.kauffmann@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-05-04 at 13:59 +0200, Steven Kauffmann wrote:
> Hi all,
> 
> As some other people on this mailing list, we also have system lockups
> with the latest 2.4 branch. For some people the problems seems to be
> solved when using the adeos-ipipe-2.6.28.9-x86-2.2-07.patch.

The issue you are facing has nothing to do with the discussion and fix
mentioned above.

>  So we
> tried that but the system still freezes. The console output on another
> machine reports nothing when the system freezes but at computer
> startup we found this line:
> 
> Xenomai: xnintr_shirq_handler: IRQ11 not handled. Disabling IRQ line.
> 
> lspci shows us that the peak CAN card and the ethernet controller use
> the same IRQ.
> 
> $ lspci -v
> 
> 02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
> Controller
>         Subsystem: Intel Corporation Unknown device 0000
>         Flags: bus master, fast devsel, latency 0, IRQ 11
>         Memory at d0000000 (32-bit, non-prefetchable) [size=128K]
>         I/O ports at c000 [size=32]
>         Capabilities: <access denied>
> 
> 04:05.0 Network controller: Unknown device 001c:0001 (rev 02)
>         Subsystem: Unknown device 001c:0004
>         Flags: medium devsel, IRQ 11
>         Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
>         Memory at d0110000 (32-bit, non-prefetchable) [size=64K]
> 
> Every time we try to bring up the ethernet device the system freezes.
> Is this related with the above kernel log message and that both cards
> use the same IRQ?
> 

Yes. Don't share RT and non-RT (i.e. plain Linux handled) interrupts.
This is a major design flaw.

> Disabling the shared IRQ option (XENO_OPT_SHIRQ) solved the problem of
> the system lockups but this option is required in order to use the
> peak CAN card.

XENO_OPT_SHIRQ is only there to share a single interrupt channel between
multiple RT sources, and _not_ to enable RT and non-RT interrupt sources
to share a single IRQ. Again, that will _never_ work properly with
respect to latency issues. The lockup you see is caused by the Xenomai
RT handler starving the Linux ethernet IRQ handler from interrupts; this
is expected. Working around this is possible, but will not solve the
latency issue, introduced by the initial design flaw.

> 
> 
> Regards
> 
> Steven
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



