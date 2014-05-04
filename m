Message-ID: <53661901.8090400@cantastic.org>
Date: Sun, 04 May 2014 12:40:01 +0200
From: Ralf Roesch <xenomai@cantastic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  Testing on Freescale i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

based on your suggestions from thread "[Xenomai] ipipe-core-3.10 patch
for arm"
I started testing Xenomai on an i.MX6 board [1].

  * checked out branch imx_3.10.17_1.0.0_ga from linux-2.6-imx.git [2]
  * merged vanilla v3.10.32 tag
    resolved 3 conflicts:
    drivers/net/can/flexcan.c
    drivers/usb/host/ehci.h
    sound/soc/codecs/wm8962.c
  * applied ipipe-v3.10.32.patch
    resolved 4 conflicts:
    arch/arm/mach-imx/clk-imx6q.c
    arch/arm/mach-imx/mach-imx6q.c
    arch/arm/mach-imx/mm-imx27.c
    arch/arm/mach-imx/mm-imx3.c
  * applied xenomai-2.6 support (prepare-kernel.sh)

My box boots without errors and seems to be quiet stable at the first
glance.
Linux arm 3.10.32-xenomai-armv7-x1 #24 SMP Sun May 4 12:17:10 CEST 2014
armv7l GNU/Linux

The first thing I observed is a system time problem:
the RTC and system time clocks get out of phase very quickly.
I do compare the timers (end - start) on console by calling:
    - hwclock && date (start)
    - wait an hour or more
    - hwclock && date (end)
The hwclock time is always o.k. but the system time reported by date is
roughly 25% faster.
Do you have an idea what could go wrong here?

Many thanks for your great job and best regards
Ralf


[1] SABRE Lite, i.MX 6Quad development kit
http://www.element14.com/community/community/knode/single-board_computers/sabrelite
[2] Freescale i.MX Linux Tree
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/

