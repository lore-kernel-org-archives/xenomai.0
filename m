From: Joerg Albert <jal2@domain.hid>
Date: Fri, 23 Apr 2010 10:17:55 +0000 (UTC)
Message-ID: <loom.20100423T115628-343@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] =?utf-8?q?Xenomai_2=2E5=2E1=3A_trace=5Fmark_usable?=
	=?utf-8?q?_on_2=2E6=2E30=2E1_without_LTT_patch=3F?=
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

Hi,

I run Xenomai 2.5.1 on top of ipipe-2.6.30-powerpc-2.7-01 from
http://git.denx.de/ipipe-2.6.git with Adeos updated from 2.7-01 to 2.7-06.
Platform is a MPC8533.

In order to track down a problem I'd like to use trace_mark() (with my own probe
function), but I'm a bit confused by the code in
include/asm-generic/xenomai/wrappers.h:

#ifdef CONFIG_LTT

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,24)
#define trace_mark(channel, ev, fmt, args...)	\
	MARK(channel##_##ev, fmt , ##args)
#else /* >= 2.6.24 */
#include <linux/marker.h>
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
#undef trace_mark
#define trace_mark(channel, ev, fmt, args...)	\
	__trace_mark(0, channel##_##ev, NULL, fmt, ## args)
#endif /* < 2.6.27 */
#endif /* >= 2.6.24 */

#else /* !CONFIG_LTT */
#undef trace_mark
#define trace_mark(channel, ev, fmt, args...)	do { } while (0)
#endif /* !CONFIG_LTT */


My kernel doesn't provide CONFIG_LTT and its trace_mark() implementation in
include/linux/marker.h is:
#define trace_mark(name, format, args...)

Does this imply that I have trace_mark inside the Xenomai code only after
applying some additional LTT patch to the kernel?


