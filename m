Message-ID: <47985F53.8010603@domain.hid>
Date: Thu, 24 Jan 2008 10:50:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BF58A8AFB316514587D61EADBFBF4C41017466AD@Alpha1>
	<479774E9.3080405@domain.hid>
In-Reply-To: <479774E9.3080405@domain.hid>
Content-Type: multipart/mixed; boundary="------------020706060109000208030602"
Subject: Re: [Xenomai-help] x86_64 user/system process accounting
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kyle Howell <khowell@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020706060109000208030602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Kyle Howell wrote:
>>> Jan Kiszka wrote:
>>>> Kyle Howell wrote:
>>>>>> Kyle Howell wrote:
>>>>>>> I'm running Xenomai 2.4.1 against Linux 2.6.23.12 on an
>>>>>> x86_64 (Core2)
>>>>>>> system. I'm finding that all of my CPU cycles are being accounted
>>>>>>> as kernel time rather than user time. The correct processes are 
>>>>>>> still billed, but the system is always 0% user. I'm wondering if
>>>>>> this problem
>>>>>>> is specific to my setup, or if it is a real bug. Can anyone else 
>>>>>>> out there running x86_64 confirm or deny this behavior?
>>> I currently have my fingers on a box with 2.6.23.14 with 
>>> Xenomai 2.4.1 and I-pipe 1.4-01 (all standard), but I'm not 
>>> able to reproduce your effect. Some simple shell loop nicely 
>>> loads one CPU at 100%, and /proc/stat looks like this:
>>>
>>> cpu  38794 0 6325 411304 2882 0 3265 0
>>> cpu0 34786 0 3094 189892 413 0 2716 0
>>> cpu1 4007 0 3231 221411 2468 0 548 0
>> Well, I'm not sure whether to be happy or sad. Thanks for checking. 
>>
>>> Could you send me your full .config?
>> I've attached my latest .config.
> 
> That one makes the difference: it's reproducible on some test box! /me
> has to find the magic switch now...

And here comes a fix:

In rthal_timer_set_oneshot() we assume that the hijacked APIC timer will
also be used to for emulating host ticks, thus __ipipe_tick_irq is set
accordingly. But this is not true for x86-64 over non-clockevent kernels
(2.6.23...), so we have to fixup __ipipe_tick_irq with the correct
number (first patch).

While reading the related code, I also noticed that we may better
reorder the initialization and reconfigure the APIC _after_ we have
allocated all required IRQs, at least for the sake of clean error
handling (second patch).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------020706060109000208030602
Content-Type: text/x-patch;
 name="fixup-ipipe_tick_irq-for-legacy-x86.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixup-ipipe_tick_irq-for-legacy-x86.patch"

---
 ksrc/arch/x86/hal-common.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: xenomai/ksrc/arch/x86/hal-common.c
===================================================================
--- xenomai.orig/ksrc/arch/x86/hal-common.c
+++ xenomai/ksrc/arch/x86/hal-common.c
@@ -236,6 +236,12 @@ int rthal_timer_request(void (*tick_hand
 			       "rthal_broadcast_timer",
 			       &rthal_broadcast_to_local_timers);
 
+	/*
+	 * rthal_timer_set_oneshot assumes the host tick flows via
+	 * RTHAL_TIMER_IRQ, but that's not the case for legacy x86_64.
+	 */
+	__ipipe_tick_irq = RTHAL_BCAST_TICK_IRQ;
+
 	rthal_nmi_init(&rthal_latency_above_max);
 out:
 	return 0;

--------------020706060109000208030602
Content-Type: text/x-patch;
 name="reorder-apic-setup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reorder-apic-setup.patch"

---
 ksrc/arch/x86/hal-common.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: xenomai/ksrc/arch/x86/hal-common.c
===================================================================
--- xenomai.orig/ksrc/arch/x86/hal-common.c
+++ xenomai/ksrc/arch/x86/hal-common.c
@@ -183,14 +183,14 @@ int rthal_timer_request(
 	if (cpu > 0)
 		goto out;
 
-	rthal_timer_set_oneshot(1);
-
 	err = rthal_irq_request(RTHAL_APIC_TIMER_IPI,
 				(rthal_irq_handler_t) tick_handler, NULL, NULL);
 
 	if (err)
 		return err;
 
+	rthal_timer_set_oneshot(1);
+
 	rthal_nmi_init(&rthal_latency_above_max);
 out:
 	return tickval;
@@ -223,8 +223,6 @@ int rthal_timer_request(void (*tick_hand
 	if (cpu > 0)
 		goto out;
 
-	rthal_timer_set_oneshot(1);
-
 	err = rthal_irq_request(RTHAL_APIC_TIMER_IPI,
 			  (rthal_irq_handler_t) tick_handler, NULL, NULL);
 
@@ -236,6 +234,8 @@ int rthal_timer_request(void (*tick_hand
 			       "rthal_broadcast_timer",
 			       &rthal_broadcast_to_local_timers);
 
+	rthal_timer_set_oneshot(1);
+
 	/*
 	 * rthal_timer_set_oneshot assumes the host tick flows via
 	 * RTHAL_TIMER_IRQ, but that's not the case for legacy x86_64.

--------------020706060109000208030602--

