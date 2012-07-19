From: Michael Lausch <michael.lausch@omicron.at>
Date: Thu, 19 Jul 2012 13:27:51 +0200
Message-ID: <6B3AC2788014DD49B43AF9611365BBAA21B0B94DE9@mary.at.omicron.at>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] xenomai 2.6.1 on ixp4xx hangs on boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
I'm trying to get xenomai-2.6.1 running on an ixp4xx board
with kernel 3.2.21.

The kernel boots with Xenomai and IPIPE disabled in the kernel configuratio=
n.

The kernel also boots with Xenmai disabled and IPIPE enabled.

But the kernel does not boot correctly with both, Xenomai and IPIPE enabled=
.

Using a JTAG debugger i found that the kernel always hits a breakpoint
On xnintr_clock_handler() with this backtrace:

 #1  0xc00516b8 in __ipipe_dispatch_irq_fast (irq=3D5) at kernel/ipipe/core=
.c:1272
#2  0xc00083b0 in __ipipe_grab_irq (irq=3D<optimized out>, regs=3D0xc381ff3=
0) at arch/arm/kernel/ipipe.c:458
#3  0xc0008db0 in __irq_svc () at arch/arm/kernel/entry-armv.S:216

The last line is repeated very often, but i think this is just a gdb artefa=
ct.
The kernel seems to loop in __irq_svc->__ipipe_grab_irq->__irq_svc.
Maybe the timer interrupt is not cleared and therefore executed as soon as =
the
IRQ service function finishes?





