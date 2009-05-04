MIME-Version: 1.0
Date: Mon, 4 May 2009 13:59:00 +0200
Message-ID: <ff1d78710905040459u56772812kb95fb6083a2ee0c5@domain.hid>
From: Steven Kauffmann <steven.kauffmann@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Kernel lockup when shared IRQ is enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

As some other people on this mailing list, we also have system lockups
with the latest 2.4 branch. For some people the problems seems to be
solved when using the adeos-ipipe-2.6.28.9-x86-2.2-07.patch. So we
tried that but the system still freezes. The console output on another
machine reports nothing when the system freezes but at computer
startup we found this line:

Xenomai: xnintr_shirq_handler: IRQ11 not handled. Disabling IRQ line.

lspci shows us that the peak CAN card and the ethernet controller use
the same IRQ.

$ lspci -v

02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
Controller
        Subsystem: Intel Corporation Unknown device 0000
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at d0000000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at c000 [size=32]
        Capabilities: <access denied>

04:05.0 Network controller: Unknown device 001c:0001 (rev 02)
        Subsystem: Unknown device 001c:0004
        Flags: medium devsel, IRQ 11
        Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
        Memory at d0110000 (32-bit, non-prefetchable) [size=64K]

Every time we try to bring up the ethernet device the system freezes.
Is this related with the above kernel log message and that both cards
use the same IRQ?

Disabling the shared IRQ option (XENO_OPT_SHIRQ) solved the problem of
the system lockups but this option is required in order to use the
peak CAN card.


Regards

Steven

