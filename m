Message-ID: <4BD18F49.9060206@domain.hid>
Date: Fri, 23 Apr 2010 14:15:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <loom.20100423T115628-343@domain.hid>
In-Reply-To: <loom.20100423T115628-343@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.1: trace_mark usable on 2.6.30.1
	without LTT patch?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joerg Albert <jal2@domain.hid>
Cc: xenomai@xenomai.org

Joerg Albert wrote:
> Hi,
> 
> I run Xenomai 2.5.1 on top of ipipe-2.6.30-powerpc-2.7-01 from
> http://git.denx.de/ipipe-2.6.git with Adeos updated from 2.7-01 to 2.7-06.
> Platform is a MPC8533.
> 
> In order to track down a problem I'd like to use trace_mark() (with my own probe
> function), but I'm a bit confused by the code in
> include/asm-generic/xenomai/wrappers.h:
> 
> #ifdef CONFIG_LTT
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,24)
> #define trace_mark(channel, ev, fmt, args...)	\
> 	MARK(channel##_##ev, fmt , ##args)
> #else /* >= 2.6.24 */
> #include <linux/marker.h>
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
> #undef trace_mark
> #define trace_mark(channel, ev, fmt, args...)	\
> 	__trace_mark(0, channel##_##ev, NULL, fmt, ## args)
> #endif /* < 2.6.27 */
> #endif /* >= 2.6.24 */
> 
> #else /* !CONFIG_LTT */
> #undef trace_mark
> #define trace_mark(channel, ev, fmt, args...)	do { } while (0)
> #endif /* !CONFIG_LTT */
> 
> 
> My kernel doesn't provide CONFIG_LTT and its trace_mark() implementation in
> include/linux/marker.h is:
> #define trace_mark(name, format, args...)
> 
> Does this imply that I have trace_mark inside the Xenomai code only after
> applying some additional LTT patch to the kernel?

Yes and no.

No, as you just have to register your tracing back-end with the marker
subsystem (and make sure that the latter is enabled). That's what LTT
did as well. Check linux/samples/markers.

Yes, because some bits of the LTT-for-Ipipe patch [1] perpare the marker
call path for use over Xenomai.

BTW, as trace_mark disappeared again with kernel 2.6.32, we have to
rework this in the near future, hopefully being able to exploit native
tracing (aka ftrace) this time.

Jan

[1]http://git.kiszka.org/?p=ipipe-2.6.git;a=commitdiff;h=c4574be8999093f556ae386fa299e05d72132543

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

