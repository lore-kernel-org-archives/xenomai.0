Message-ID: <519D4262.2070206@free.fr>
Date: Thu, 23 May 2013 00:10:42 +0200
From: CF <cfoissac@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RTDM for a GPIO line in RT mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Despite my munerous reading, i'm locked in how to perform a basic RTDM
for a simple ppc board.

This is a simple pin level setting. The linux kernel module i developped
follow theses steps:
-reading DTS for IOCTL et GPIOCTL base adress registers
- out_be32(addr, value) at theses register to set line as an output and
then set the logical level with setbits32(addr, bit) or clrbits32(addr,bit)

Basically, it works but in NRT  ops modes, so i'm unable (or at least i
lack indication) to do this in RT ops mode (i don't think it is
important, but i use ioctl to make my changes). I based my work on
tut01/tut02 drivers, except i end up in using ioctl instead or
read/write in the RTDM driver.

I guess i still could read the DTS in nrt mode (because it is done at
rtdm_dev_register() time and won't interfere with RT task), but how can
i drive the hardware directly in RT op mode ?

Thanks you for your help,
JG

