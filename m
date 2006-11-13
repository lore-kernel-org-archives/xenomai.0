Message-ID: <4546494d0611130201p6005d202j75aa51fe6f75e579@domain.hid>
Date: Mon, 13 Nov 2006 18:01:31 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
In-Reply-To: <4546494d0611130156n2ec81f51k20ec2dde1a50b8e5@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_106902_15345745.1163412091790"
References: <4546494d0609300059p2879d7bcwb9bc898f279df140@domain.hid>
	<45203E31.6050707@domain.hid>
	<4546494d0611100554h6dfee69boca6fa79978f1fac2@domain.hid>
	<4554A498.8030202@domain.hid>
	<4546494d0611121951n600c6a53pe3a08097e923435d@domain.hid>
	<4546494d0611130156n2ec81f51k20ec2dde1a50b8e5@domain.hid>
Subject: [Xenomai-core] Fwd: ipip tracer porting for blackfin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_106902_15345745.1163412091790
Content-Type: multipart/alternative; 
	boundary="----=_Part_106903_16576710.1163412091790"

------=_Part_106903_16576710.1163412091790
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry that due to mis-spell the "xenomai@xenomai.org" mail address, I will
resend this mail to xenomai-core mailing list - sorry about any duplication.

Regards,
-Yi

---------- Forwarded message ----------
From: Li Yi (Adam) <liyiadam@domain.hid>
Date: Nov 13, 2006 5:56 PM
Subject: Re: [Adeos-main] ipip tracer porting for blackfin
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Philippe Gerum <rpm@xenomai.org>, adeos-main@gna.org,
xenomai@xenomai.org

I tried to trace the maximum interrupt latency of the "latency" test case
furthur, and attached here two cases of the extra delay of hanlding Core
Timer interrupt.  Do you have any suggestions on how to make improvements?

Before doing that, I did a little hack to workaround the
__builtin_return_address(1) issue (just for test purpose) before the
bfin-gcc is ready to handle it correctly.
I also recored IMASK, ILAT, IPEND register in each fuction trace point.

--- linux-2.6.x-ipipe-orig/include/linux/ipipe.h        2006-11-10 21:04:
21.000000000 +0800
+++ linux-2.6.x-ipipe-1110/include/linux/ipipe.h        2006-11-13 13:20:
12.000000000 +0800
@@ -35,9 +35,29 @@
                                 (IPIPE_MINOR_NUMBER <<  8) | \
                                 (IPIPE_PATCH_NUMBER))

+#ifdef CONFIG_BFIN
+static inline unsigned long my_return_address1(void)
+{
+       unsigned long p_rets;
+       __asm__ __volatile__ ( " \
+               [--sp] = p0; \
+               p0 = [fp]; \
+               %0 = [p0 + 4]; \
+               p0 = [sp++]; \
+               ":"=d" (p_rets):);
+       return p_rets;
+}
+#endif
+
+
+
 #ifndef BROKEN_BUILTIN_RETURN_ADDRESS
 #define __BUILTIN_RETURN_ADDRESS0 ((unsigned
long)__builtin_return_address(0))
-#define __BUILTIN_RETURN_ADDRESS1 ((unsigned
long)__builtin_return_address(1))
+#ifdef CONFIG_BFIN
+       #define __BUILTIN_RETURN_ADDRESS1 (my_return_address1())
+#else
+       #define __BUILTIN_RETURN_ADDRESS1 ((unsigned
long)__builtin_return_address(1))
+#endif


ipipe-tarce-2.log
<snip>
========================================================================================
// During this period, the Core Timer interrupt and IRQ12 are latched, but
since IMASK=0x1F, they cannot be handled.

:|  *+func   (IMASK) 0x0000001f,  (ILAT) 0x00001040, (IPEND) 0x00008000
 -100+   2.592  _xnpod_schedule+0xa (_gatekeeper_thread+0x1ce)
:|  *+func    0x0000001f, 0x00001040, 0x00008000
  -97+   3.000  _ipipe_trigger_irq+0x12 (_xnpod_schedule+0x2e6)
:|  *+func    0x0000001f, 0x00001040, 0x00008000
  -94+   1.710  ___ipipe_handle_irq+0x1e (_ipipe_trigger_irq+0x86)
:|  *+func    0x0000001f, 0x00001040, 0x00008000
  -92+   2.460  ___ipipe_dispatch_wired+0x14 (___ipipe_handle_irq+0x190)
:|  *+func    0x0000001f, 0x00001040, 0x00008000
  -90+   1.860  ___ipipe_restore_pipeline_head+0xa
(_gatekeeper_thread+0x138)
:|   +func    0x0000001f, 0x00001040, 0x00008000
  -88+   1.990  ___ipipe_walk_pipeline+0x18
(___ipipe_restore_pipeline_head+0xd0)
:|  + func    0x0000001f, 0x00001040, 0x00008000
  -86+   2.300  _ipipe_suspend_domain+0xa (___ipipe_walk_pipeline+0xac)
:|  + func    0x0000001f, 0x00001040, 0x00008000
  -84+   5.018  ___ipipe_sync_stage+0xe (_ipipe_suspend_domain+0x4e)
:|  # func    0x0000001f, 0x00001040, 0x00008000
  -79+   1.942  _xnpod_schedule_handler+0xe (___ipipe_sync_stage+0x186)
:|  # func    0x0000001f, 0x00001040, 0x00008000
  -77+   2.310  _xnpod_schedule+0xa (_xnpod_schedule_handler+0x5c)
:|  # [    0] swapper -1   -74+   6.560  _xnpod_schedule+0x104
(_xnpod_schedule_handler+0x5c)
:|  # end     0x80000000   -68+   3.250  ___sched_text_start+0x5ca
(_xnshadow_harden+0xa8)

==========================================================================================

// The Core Timer Interrupt (0x6) is handled - but the interrupt handler
registered in Xenomai  is not called

:|  # func    0x0000001f, 0x00001000, 0x00008040
  -65    0.940  ___ipipe_grab_irq+0x22 (__common_int_entry+0x72)
:|  # begin   0x00000006   -64+   2.300  ___ipipe_grab_irq+0x34
(__common_int_entry+0x72)
:|  # func    0x0000001f, 0x00001000, 0x00008040
  -61+   1.650  ___ipipe_handle_irq+0x1e (___ipipe_grab_irq+0x3c)
:|  # func    0x0000001f, 0x00001000, 0x00008040
  -60+   1.508  _rthal_timer_ack+0x8 (___ipipe_handle_irq+0x178)
:|  # func    0x0000001f, 0x00001000, 0x00008040
  -58+   1.382  ___ipipe_dispatch_wired+0x14 (___ipipe_handle_irq+0x190)
:|  # end     0x00000006   -57+   3.060  ___ipipe_grab_irq+0x42
(__common_int_entry+0x72)

// The handling of Core Timer interrupt returned in __ipipe_dispatch_wired()
returns and it begins to handle IRQ12 - Is this expected behavior?

============================================================================================

// IRQ12 interrupts the handling of higher priority Core Timer IRQ (IRQ6).

:|  # func    0x0000001f, 0x00000000, 0x00009000
  -54+   2.670  ___ipipe_grab_irq+0x22 (__common_int_entry+0x72)
:|  # begin   0x0000001a   -51+   1.940  ___ipipe_grab_irq+0x34
(__common_int_entry+0x72)
:|  # func    0x0000001f, 0x00000000, 0x00009000
  -49+   3.540  ___ipipe_handle_irq+0x1e (___ipipe_grab_irq+0x3c)
:|  # func    0x0000001f, 0x00000000, 0x00009000
  -46+   2.310  ___ipipe_ack_irq+0x10 (___ipipe_handle_irq+0xee)
:|  # func    0x0000001f, 0x00000000, 0x00009000
  -43+   1.240  ___ipipe_walk_pipeline+0x18 (___ipipe_handle_irq+0x148)
:|  # end     0x0000001a   -42+   2.118  ___ipipe_grab_irq+0x42
(__common_int_entry+0x72)
:   # func    0x0000ffff, 0x00000000, 0x00008000
  -40+   1.242  _ipipe_unstall_pipeline_head+0x8 (_xnshadow_harden+0xce)
:|  # begin   0x80000001   -39+   2.870  _ipipe_unstall_pipeline_head+0x18
(_xnshadow_harden+0xce)
:|  + func    0x0000001f, 0x00000000, 0x00008000
  -36+   2.120  ___ipipe_sync_stage+0xe (_ipipe_unstall_pipeline_head+0x74)

=======================================================================================================

// The interrupt handler for Core Timer IRQ in Xenomai is called here.

:|  # func    0x0000001f, 0x00000000, 0x00008000
  -34+   1.360  _xnintr_clock_handler+0x10 (___ipipe_sync_stage+0x186)
:|  # func    0x0000001f, 0x00000000, 0x00008000
  -32+   1.710  _xnintr_irq_handler+0x18 (_xnintr_clock_handler+0x18)
:|  # func    0x0000001f, 0x00000000, 0x00008000
  -31+   1.870  _xnpod_announce_tick+0xc (_xnintr_irq_handler+0x2a)

<snip>

ipipe-trace-1.log
<snip>
:    +func    0x0000ffff, 0x00000800, 0x00008000
 -114+   5.020  _rw_verify_area+0xa (_vfs_write+0x136)

==========================================================================

// In this case, Core Timer IRQ (IRQ6) happens just after Adeos enters
__ipipe_grab_irq() to handle IRQ11. Since the IMASK=0x1F, the handling of
IRQ6 has to be delayed until lower priority interrupt IRQ11 is handled.

:|   +func    0x0000001f, 0x00000040, 0x00008800
 -109+   2.690  ___ipipe_grab_irq+0x22 (__common_int_entry+0x72)
:|   +begin   0x00000018  -107+   2.850  ___ipipe_grab_irq+0x34
(__common_int_entry+0x72)
:|   +func    0x0000001f, 0x00000040, 0x00008800
 -104+   3.960  ___ipipe_handle_irq+0x1e (___ipipe_grab_irq+0x3c)
:|   +func    0x0000001f, 0x00000040, 0x00008800
 -100+   1.760  ___ipipe_ack_irq+0x10 (___ipipe_handle_irq+0xee)
:|   +func    0x0000001f, 0x00000040, 0x00008800
  -98+   3.298  _ipipe_test_and_stall_pipeline_from+0xa
(___ipipe_ack_irq+0x20)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -95+   2.302  _bf533_internal_mask_irq+0xc (___ipipe_ack_irq+0x40)
:|   +func    0x0000001f, 0x00000040, 0x00008800
  -92+   3.290  ___ipipe_walk_pipeline+0x18 (___ipipe_handle_irq+0x148)
:|   +func    0x0000001f, 0x00000040, 0x00008800
  -89+   6.110  ___ipipe_sync_stage+0xe (___ipipe_walk_pipeline+0xde)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -83+   1.690  _kick_irqd+0x1c (___ipipe_sync_stage+0x290)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -81+   1.920  ___ipipe_test_and_stall_root+0xe (_kick_irqd+0x22)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -79+   1.710  ___ipipe_restore_root+0xa (_kick_irqd+0x32)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -78+   1.930  ___ipipe_stall_root+0xe (___ipipe_restore_root+0x10)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -76+   1.848  ___up+0x8 (_kick_irqd+0x62)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -74+   1.732  ___wake_up+0xa (___up+0x16)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -72+   1.880  ___ipipe_test_and_stall_root+0xe (___wake_up+0x14)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -70+   2.280  ___wake_up_common+0xc (___wake_up+0x3a)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -68+   1.780  _default_wake_function+0xa (___wake_up_common+0x38)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -66+   1.690  _try_to_wake_up+0xa (_default_wake_function+0x10)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -65+   1.810  ___ipipe_test_and_stall_root+0xe (_try_to_wake_up+0x14)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -63+   1.660  _sched_clock+0xc (_try_to_wake_up+0x7e)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -61+   2.548  ___muldi3+0xc (_sched_clock+0x26)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -59+   2.622  _enqueue_task+0xe (_try_to_wake_up+0xd2)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -56+   1.440  ___ipipe_restore_root+0xa (_try_to_wake_up+0x3c)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -54+   1.580  ___ipipe_stall_root+0xe (___ipipe_restore_root+0x10)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -53+   1.320  ___ipipe_restore_root+0xa (___wake_up+0x40)
:|   #func    0x0000001f, 0x00000040, 0x00008800
  -52+   1.700  ___ipipe_stall_root+0xe (___ipipe_restore_root+0x10)
:|   +end     0x00000018   -50+   2.980  ___ipipe_grab_irq+0x42
(__common_int_entry+0x72)
==============================================================================================

// Begin to handle IRQ6.

:|   +func    0x0000001f, 0x00000000, 0x00008040
  -47+   1.060  ___ipipe_grab_irq+0x22 (__common_int_entry+0x72)
:|   +begin   0x00000006   -46+   1.928  ___ipipe_grab_irq+0x34
(__common_int_entry+0x72)
:|   +func    0x0000001f, 0x00000000, 0x00008040
  -44+   2.532  ___ipipe_handle_irq+0x1e (___ipipe_grab_irq+0x3c)
:|   +func    0x0000001f, 0x00000000, 0x00008040
  -41+   1.640  _rthal_timer_ack+0x8 (___ipipe_handle_irq+0x178)
<snip>

Thanks,

-Yi

------=_Part_106903_16576710.1163412091790
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry that due to mis-spell the &quot;<a href="mailto:xenomai@xenomai.org">xenomai@xenomai.org</a>&quot; mail address, I will resend this mail to xenomai-core mailing list - sorry about any duplication.<br><br>Regards,<br>
-Yi<br><br>---------- Forwarded message ----------<br><span class="gmail_quote">From: <b class="gmail_sendername">Li Yi (Adam)</b> &lt;<a href="mailto:liyiadam@domain.hid">liyiadam@domain.hid</a>&gt;<br>Date: Nov 13, 2006 5:56 PM
<br>Subject: Re: [Adeos-main] ipip tracer porting for blackfin<br>To: Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;<br>Cc: Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>
&gt;, <a href="mailto:adeos-main@gna.org">adeos-main@gna.org</a>, <a href="mailto:xenomai@xenomai.org">xenomai@xenomai.org</a><br><br></span>I tried to trace the maximum interrupt latency of the &quot;latency&quot; test case furthur, and attached here two cases of the extra delay of hanlding Core Timer interrupt.&nbsp;  Do you have any suggestions on how to make improvements? 
<br><br>Before doing that, I did a little hack to workaround the __builtin_return_address(1) issue (just for test purpose) before the bfin-gcc is ready to handle it correctly.<br>I also recored IMASK, ILAT, IPEND register in each fuction trace point.
<br><br>--- linux-2.6.x-ipipe-orig/include/linux/ipipe.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-11-10 21:04:21.000000000 +0800<br>+++ linux-2.6.x-ipipe-1110/include/linux/ipipe.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-11-13 13:20:12.000000000 +0800<br>@@ -35,9 +35,29 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (IPIPE_MINOR_NUMBER &lt;&lt;&nbsp; 8) | \
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (IPIPE_PATCH_NUMBER))<br><br>+#ifdef CONFIG_BFIN<br>+static inline unsigned long my_return_address1(void)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long p_rets;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __asm__ __volatile__ ( &quot; \
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [--sp] = p0; \<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p0 = [fp]; \<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %0 = [p0 + 4]; \<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p0 = [sp++]; \<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;:&quot;=d&quot; (p_rets):);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return p_rets;<br>+}
<br>+#endif<br>+<br>+<br>+<br>&nbsp;#ifndef BROKEN_BUILTIN_RETURN_ADDRESS<br>&nbsp;#define __BUILTIN_RETURN_ADDRESS0 ((unsigned long)__builtin_return_address(0))<br>-#define __BUILTIN_RETURN_ADDRESS1 ((unsigned long)__builtin_return_address(1))
<br>+#ifdef CONFIG_BFIN<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define __BUILTIN_RETURN_ADDRESS1 (my_return_address1())<br>+#else<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define __BUILTIN_RETURN_ADDRESS1 ((unsigned long)__builtin_return_address(1))<br>+#endif<br><br><br>ipipe-tarce-2.log

<br>&lt;snip&gt;<br>========================================================================================<br>// During this period, the Core Timer interrupt and IRQ12 are latched, but since IMASK=0x1F, they cannot be handled.
<br><br>:|&nbsp; *+func&nbsp;&nbsp; (IMASK) 0x0000001f,&nbsp; (ILAT) 0x00001040, (IPEND) 0x00008000 <br>&nbsp;-100+&nbsp;&nbsp; 2.592&nbsp; _xnpod_schedule+0xa (_gatekeeper_thread+0x1ce)<br>:|&nbsp; *+func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001040, 0x00008000<br>&nbsp; -97+&nbsp;&nbsp; 3.000&nbsp; _ipipe_trigger_irq+0x12 (_xnpod_schedule+0x2e6)
<br>:|&nbsp; *+func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001040, 0x00008000<br>&nbsp; -94+&nbsp;&nbsp; 1.710&nbsp; ___ipipe_handle_irq+0x1e (_ipipe_trigger_irq+0x86)<br>:|&nbsp; *+func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001040, 0x00008000<br>&nbsp; -92+&nbsp;&nbsp; 2.460&nbsp; ___ipipe_dispatch_wired+0x14 (___ipipe_handle_irq+0x190)
<br>:|&nbsp; *+func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001040, 0x00008000<br>&nbsp; -90+&nbsp;&nbsp; 1.860&nbsp; ___ipipe_restore_pipeline_head+0xa (_gatekeeper_thread+0x138)<br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001040, 0x00008000<br>&nbsp; -88+&nbsp;&nbsp; 1.990&nbsp; ___ipipe_walk_pipeline+0x18 (___ipipe_restore_pipeline_head+0xd0)
<br>:|&nbsp; + func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001040, 0x00008000<br>&nbsp; -86+&nbsp;&nbsp; 2.300&nbsp; _ipipe_suspend_domain+0xa (___ipipe_walk_pipeline+0xac)<br>:|&nbsp; + func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001040, 0x00008000<br>&nbsp; -84+&nbsp;&nbsp; 5.018&nbsp; ___ipipe_sync_stage+0xe (_ipipe_suspend_domain+0x4e)
<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001040, 0x00008000<br>&nbsp; -79+&nbsp;&nbsp; 1.942&nbsp; _xnpod_schedule_handler+0xe (___ipipe_sync_stage+0x186)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001040, 0x00008000<br>&nbsp; -77+&nbsp;&nbsp; 2.310&nbsp; _xnpod_schedule+0xa (_xnpod_schedule_handler+0x5c)
<br>:|&nbsp; # [&nbsp;&nbsp;&nbsp; 0] swapper -1&nbsp;&nbsp; -74+&nbsp;&nbsp; 6.560&nbsp; _xnpod_schedule+0x104 (_xnpod_schedule_handler+0x5c)<br>:|&nbsp; # end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -68+&nbsp;&nbsp; 3.250&nbsp; ___sched_text_start+0x5ca (_xnshadow_harden+0xa8)<br><br>==========================================================================================
<br>// The Core Timer Interrupt (0x6) is handled - but the interrupt handler registered in Xenomai&nbsp; is not called<br><br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001000, 0x00008040<br>&nbsp; -65&nbsp;&nbsp;&nbsp; 0.940&nbsp; ___ipipe_grab_irq+0x22 (__common_int_entry+0x72)
<br>:|&nbsp; # begin&nbsp;&nbsp; 0x00000006&nbsp;&nbsp; -64+&nbsp;&nbsp; 2.300&nbsp; ___ipipe_grab_irq+0x34 (__common_int_entry+0x72)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001000, 0x00008040<br>&nbsp; -61+&nbsp;&nbsp; 1.650&nbsp; ___ipipe_handle_irq+0x1e (___ipipe_grab_irq+0x3c)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001000, 0x00008040
<br>&nbsp; -60+&nbsp;&nbsp; 1.508&nbsp; _rthal_timer_ack+0x8 (___ipipe_handle_irq+0x178)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00001000, 0x00008040<br>&nbsp; -58+&nbsp;&nbsp; 1.382&nbsp; ___ipipe_dispatch_wired+0x14 (___ipipe_handle_irq+0x190)<br>:|&nbsp; # end&nbsp;&nbsp;&nbsp;&nbsp; 0x00000006&nbsp;&nbsp; -57+&nbsp;&nbsp; 
3.060&nbsp; ___ipipe_grab_irq+0x42 (__common_int_entry+0x72)<br><br>// The handling of Core Timer interrupt returned in __ipipe_dispatch_wired() returns and it begins to handle IRQ12 - Is this expected behavior?<br><br>============================================================================================
<br>// IRQ12 interrupts the handling of higher priority Core Timer IRQ (IRQ6).<br><br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00009000<br>&nbsp; -54+&nbsp;&nbsp; 2.670&nbsp; ___ipipe_grab_irq+0x22 (__common_int_entry+0x72)<br>:|&nbsp; # begin&nbsp;&nbsp; 0x0000001a&nbsp;&nbsp; -51+&nbsp;&nbsp; 
1.940&nbsp; ___ipipe_grab_irq+0x34 (__common_int_entry+0x72)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00009000<br>&nbsp; -49+&nbsp;&nbsp; 3.540&nbsp; ___ipipe_handle_irq+0x1e (___ipipe_grab_irq+0x3c)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00009000
<br>&nbsp; -46+&nbsp;&nbsp; 2.310&nbsp; ___ipipe_ack_irq+0x10 (___ipipe_handle_irq+0xee)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00009000<br>&nbsp; -43+&nbsp;&nbsp; 1.240&nbsp; ___ipipe_walk_pipeline+0x18 (___ipipe_handle_irq+0x148)<br>:|&nbsp; # end&nbsp;&nbsp;&nbsp;&nbsp; 0x0000001a&nbsp;&nbsp; -42+&nbsp;&nbsp; 
2.118&nbsp; ___ipipe_grab_irq+0x42 (__common_int_entry+0x72)<br>:&nbsp;&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000ffff, 0x00000000, 0x00008000<br>&nbsp; -40+&nbsp;&nbsp; 1.242&nbsp; _ipipe_unstall_pipeline_head+0x8 (_xnshadow_harden+0xce)<br>:|&nbsp; # begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -39+&nbsp;&nbsp; 
2.870&nbsp; _ipipe_unstall_pipeline_head+0x18 (_xnshadow_harden+0xce)<br>:|&nbsp; + func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00008000<br>&nbsp; -36+&nbsp;&nbsp; 2.120&nbsp; ___ipipe_sync_stage+0xe (_ipipe_unstall_pipeline_head+0x74)<br><br>=======================================================================================================
<br>// The interrupt handler for Core Timer IRQ in Xenomai is called here.<br><br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00008000<br>&nbsp; -34+&nbsp;&nbsp; 1.360&nbsp; _xnintr_clock_handler+0x10 (___ipipe_sync_stage+0x186)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00008000
<br>&nbsp; -32+&nbsp;&nbsp; 1.710&nbsp; _xnintr_irq_handler+0x18 (_xnintr_clock_handler+0x18)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00008000<br>&nbsp; -31+&nbsp;&nbsp; 1.870&nbsp; _xnpod_announce_tick+0xc (_xnintr_irq_handler+0x2a)<br><br>&lt;snip&gt;<br>
<br>
ipipe-trace-1.log<br>&lt;snip&gt;<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000ffff, 0x00000800, 0x00008000<br>&nbsp;-114+&nbsp;&nbsp; 5.020&nbsp; _rw_verify_area+0xa (_vfs_write+0x136)<br><br>==========================================================================
<br><br>// In this case, Core Timer IRQ (IRQ6) happens just after Adeos enters __ipipe_grab_irq() to handle IRQ11. Since the IMASK=0x1F, the handling of IRQ6 has to be delayed until lower priority interrupt IRQ11 is handled.
<br><br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp;-109+&nbsp;&nbsp; 2.690&nbsp; ___ipipe_grab_irq+0x22 (__common_int_entry+0x72)<br>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x00000018&nbsp; -107+&nbsp;&nbsp; 2.850&nbsp; ___ipipe_grab_irq+0x34 (__common_int_entry+0x72)<br>

:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp;-104+&nbsp;&nbsp; 3.960&nbsp; ___ipipe_handle_irq+0x1e (___ipipe_grab_irq+0x3c)<br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp;-100+&nbsp;&nbsp; 1.760&nbsp; ___ipipe_ack_irq+0x10 (___ipipe_handle_irq+0xee)
<br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -98+&nbsp;&nbsp; 3.298&nbsp; _ipipe_test_and_stall_pipeline_from+0xa (___ipipe_ack_irq+0x20)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -95+&nbsp;&nbsp; 2.302&nbsp; _bf533_internal_mask_irq+0xc (___ipipe_ack_irq+0x40)
<br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -92+&nbsp;&nbsp; 3.290&nbsp; ___ipipe_walk_pipeline+0x18 (___ipipe_handle_irq+0x148)<br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -89+&nbsp;&nbsp; 6.110&nbsp; ___ipipe_sync_stage+0xe (___ipipe_walk_pipeline+0xde)
<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -83+&nbsp;&nbsp; 1.690&nbsp; _kick_irqd+0x1c (___ipipe_sync_stage+0x290)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -81+&nbsp;&nbsp; 1.920&nbsp; ___ipipe_test_and_stall_root+0xe (_kick_irqd+0x22)
<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -79+&nbsp;&nbsp; 1.710&nbsp; ___ipipe_restore_root+0xa (_kick_irqd+0x32)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -78+&nbsp;&nbsp; 1.930&nbsp; ___ipipe_stall_root+0xe (___ipipe_restore_root+0x10)
<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -76+&nbsp;&nbsp; 1.848&nbsp; ___up+0x8 (_kick_irqd+0x62)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -74+&nbsp;&nbsp; 1.732&nbsp; ___wake_up+0xa (___up+0x16)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800
<br>&nbsp; -72+&nbsp;&nbsp; 1.880&nbsp; ___ipipe_test_and_stall_root+0xe (___wake_up+0x14)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -70+&nbsp;&nbsp; 2.280&nbsp; ___wake_up_common+0xc (___wake_up+0x3a)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800
<br>&nbsp; -68+&nbsp;&nbsp; 1.780&nbsp; _default_wake_function+0xa (___wake_up_common+0x38)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -66+&nbsp;&nbsp; 1.690&nbsp; _try_to_wake_up+0xa (_default_wake_function+0x10)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800
<br>&nbsp; -65+&nbsp;&nbsp; 1.810&nbsp; ___ipipe_test_and_stall_root+0xe (_try_to_wake_up+0x14)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -63+&nbsp;&nbsp; 1.660&nbsp; _sched_clock+0xc (_try_to_wake_up+0x7e)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800
<br>&nbsp; -61+&nbsp;&nbsp; 2.548&nbsp; ___muldi3+0xc (_sched_clock+0x26)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -59+&nbsp;&nbsp; 2.622&nbsp; _enqueue_task+0xe (_try_to_wake_up+0xd2)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>

&nbsp; -56+&nbsp;&nbsp; 1.440&nbsp; ___ipipe_restore_root+0xa (_try_to_wake_up+0x3c)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -54+&nbsp;&nbsp; 1.580&nbsp; ___ipipe_stall_root+0xe (___ipipe_restore_root+0x10)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800
<br>&nbsp; -53+&nbsp;&nbsp; 1.320&nbsp; ___ipipe_restore_root+0xa (___wake_up+0x40)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000040, 0x00008800<br>&nbsp; -52+&nbsp;&nbsp; 1.700&nbsp; ___ipipe_stall_root+0xe (___ipipe_restore_root+0x10)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x00000018&nbsp;&nbsp; -50+&nbsp;&nbsp; 
2.980&nbsp; ___ipipe_grab_irq+0x42 (__common_int_entry+0x72)<br>==============================================================================================<br><br>// Begin to handle IRQ6.<br><br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00008040
<br>&nbsp; -47+&nbsp;&nbsp; 1.060&nbsp; ___ipipe_grab_irq+0x22 (__common_int_entry+0x72)<br>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x00000006&nbsp;&nbsp; -46+&nbsp;&nbsp; 1.928&nbsp; ___ipipe_grab_irq+0x34 (__common_int_entry+0x72)<br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00008040<br>&nbsp; -44+&nbsp;&nbsp; 
2.532&nbsp; ___ipipe_handle_irq+0x1e (___ipipe_grab_irq+0x3c)<br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp; 0x0000001f, 0x00000000, 0x00008040<br>&nbsp; -41+&nbsp;&nbsp; 1.640&nbsp; _rthal_timer_ack+0x8 (___ipipe_handle_irq+0x178)<br>&lt;snip&gt;<br><br>Thanks,<br><span class="sg">
<br>-Yi</span><div><span class="e" id="q_10ee0becbf476c69_2"><br>
</span></div><br clear="all">

------=_Part_106903_16576710.1163412091790--

------=_Part_106902_15345745.1163412091790
Content-Type: text/x-log; name=ipipe-trace-1.log; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eugoafee
Content-Disposition: attachment; filename="ipipe-trace-1.log"

cm9vdDp+PiAuL2xhdGVuY3kgLXQyIC1wNTAwIC1mCnJvb3Q6fj4gY2F0IC9wcm9jL2lwaXBlL3Ry
YWNlL2Zyb3plbgpJLXBpcGUgZnJvemVuIGJhY2stdHJhY2luZyBzZXJ2aWNlIG9uIDIuNi4xNi4y
Ny1BREktMjAwNlIyL2lwaXBlLTEuNS0wMAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRnJlZXplOiAxNTQxMjU5ODY0MjQwIGN5Y2xl
cywgVHJhY2UgUG9pbnRzOiAyMDAgKCsxMCkKCiArLS0tLS0gSGFyZCBJUlFzICgnfCc6IGxvY2tl
ZCkKIHwrLS0tLSA8dW51c2VkPgogfHwrLS0tIDx1bnVzZWQ+CiB8fHwrLS0gWGVub21haQogfHx8
fCstIExpbnV4ICgnKic6IGRvbWFpbiBzdGFsbGVkLCAnKyc6IGN1cnJlbnQsICcjJzogY3VycmVu
dCtzdGFsbGVkKQogfHx8fHwgICAgICAgICAgICAgICAgICAgICAgICArLS0tLS0tLS0tLSBEZWxh
eSBmbGFnICgnKyc6ID4gMSB1cywgJyEnOiA+IDEwIHVzKQogfHx8fHwgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAgICArLSBOTUkgbm9pc2UgKCdOJykKIHx8fHx8ICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgfAogICAgICBUeXBlICAgIFVzZXIgVmFsLiAgIFRpbWUgICAgRGVs
YXkgIEZ1bmN0aW9uIChQYXJlbnQpCjp8ICAgK2JlZ2luICAgMHg4MDAwMDAwMSAgLTM3NCsgICAy
LjE0MCAgX2RvX3NvZnRpbnQrMHgyMiAoX3J1bl93b3JrcXVldWUrMHhiNCkKOnwgICArZW5kICAg
ICAweDgwMDAwMDAwICAtMzcyKyAgIDEuMjcwICBfZG9fc29mdGludCsweDNjIChfcnVuX3dvcmtx
dWV1ZSsweGI0KQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0zNzArICAgMS4zMzAgIF9kb19z
b2Z0aW50KzB4NWMgKF9ydW5fd29ya3F1ZXVlKzB4YjQpCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAw
MCAgLTM2OSsgICAxLjE1MCAgX2RvX3NvZnRpbnQrMHg3NiAoX3J1bl93b3JrcXVldWUrMHhiNCkK
OnwgICArYmVnaW4gICAweDgwMDAwMDAxICAtMzY4KyAgIDEuODAwICBfZG9fc29mdGludCsweDk2
IChfcnVuX3dvcmtxdWV1ZSsweGI0KQo6fCAgICtlbmQgICAgIDB4ODAwMDAwMDAgIC0zNjYrICAg
Mi4xMDAgIF9kb19zb2Z0aW50KzB4YjAgKF9ydW5fd29ya3F1ZXVlKzB4YjQpCjogICAgK2Z1bmMg
ICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTM2NCsgICAyLjkzOCAgX2Rt
YV90cmFuc21pdF9jaGFycysweGMgKF9kb19zb2Z0aW50KzB4YzYpCjogICAgK2Z1bmMgICAgMHgw
MDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTM2MSsgICAxLjg4MiAgX2xvY2FsX3B1
dF9jaGFyKzB4MTIgKF9kbWFfdHJhbnNtaXRfY2hhcnMrMHg2NikKOiAgICArZnVuYyAgICAweDAw
MDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMzU5KyAgIDEuMjcwICBfX19pcGlwZV90
ZXN0X2FuZF9zdGFsbF9yb290KzB4ZSAoX2xvY2FsX3B1dF9jaGFyKzB4MTgpCjp8ICAgK2JlZ2lu
ICAgMHg4MDAwMDAwMSAgLTM1OCsgICAxLjUzMCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9v
dCsweDIyIChfbG9jYWxfcHV0X2NoYXIrMHgxOCkKOnwgICAjZW5kICAgICAweDgwMDAwMDAwICAt
MzU2KyAgIDIuMzYwICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4MzYgKF9sb2NhbF9w
dXRfY2hhcisweDE4KQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAw
MDgwMDAKIC0zNTQrICAgMS4zMDAgIF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweGEgKF9sb2NhbF9w
dXRfY2hhcisweDQ2KQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAw
MDgwMDAKIC0zNTMrICAgMS4wODAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDggKF9fX2lwaXBl
X3Jlc3RvcmVfcm9vdCsweDFhKQo6ICAgICNiZWdpbiAgIDB4ODAwMDAwMDAgIC0zNTIrICAgMS41
NTAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDFhIChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgx
YSkKOnwgICArZW5kICAgICAweDgwMDAwMDAwICAtMzUwKyAgIDIuMDg4ICBfX19pcGlwZV91bnN0
YWxsX3Jvb3QrMHg1OCAoX19faXBpcGVfcmVzdG9yZV9yb290KzB4MWEpCjogICAgK2Z1bmMgICAg
MHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTM0OCsgICAxLjc5MiAgX3NjaGVk
dWxlX3dvcmsrMHgxMCAoX2RtYV90cmFuc21pdF9jaGFycysweGIyKQo6ICAgICtmdW5jICAgIDB4
MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zNDYrICAgMS40NTAgIF9xdWV1ZV93
b3JrKzB4YSAoX3NjaGVkdWxlX3dvcmsrMHgxYykKOnwgICArYmVnaW4gICAweDgwMDAwMDAxICAt
MzQ1KyAgIDEuNzMwICBfcXVldWVfd29yaysweDFlIChfc2NoZWR1bGVfd29yaysweDFjKQo6fCAg
ICtlbmQgICAgIDB4ODAwMDAwMDAgIC0zNDMrICAgMS44MjAgIF9xdWV1ZV93b3JrKzB4MzIgKF9z
Y2hlZHVsZV93b3JrKzB4MWMpCjogICAgK2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwg
MHgwMDAwODAwMAogLTM0MSsgICAxLjY2MCAgX19fcXVldWVfd29yaysweGEgKF9xdWV1ZV93b3Jr
KzB4NzIpCjogICAgK2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAog
LTMzOSsgICAxLjAyMCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsweGUgKF9fX3F1ZXVl
X3dvcmsrMHgxMikKOnwgICArYmVnaW4gICAweDgwMDAwMDAxICAtMzM4KyAgIDEuNTMwICBfX19p
cGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4MjIgKF9fX3F1ZXVlX3dvcmsrMHgxMikKOnwgICAj
ZW5kICAgICAweDgwMDAwMDAwICAtMzM3KyAgIDIuNDQ4ICBfX19pcGlwZV90ZXN0X2FuZF9zdGFs
bF9yb290KzB4MzYgKF9fX3F1ZXVlX3dvcmsrMHgxMikKOiAgICAjZnVuYyAgICAweDAwMDBmZmZm
LCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMzM0KyAgIDEuNjEyICBfX193YWtlX3VwKzB4YSAo
X19fcXVldWVfd29yaysweDUwKQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAs
IDB4MDAwMDgwMDAKIC0zMzMrICAgMS4yOTAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3Qr
MHhlIChfX193YWtlX3VwKzB4MTQpCjp8ICAgI2JlZ2luICAgMHg4MDAwMDAwMSAgLTMzMisgICAx
LjU1MCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsweDIyIChfX193YWtlX3VwKzB4MTQp
Cjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMCAgLTMzMCsgICAxLjkwMCAgX19faXBpcGVfdGVzdF9h
bmRfc3RhbGxfcm9vdCsweDM2IChfX193YWtlX3VwKzB4MTQpCjogICAgI2Z1bmMgICAgMHgwMDAw
ZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTMyOCsgICAxLjM2MCAgX19fd2FrZV91cF9j
b21tb24rMHhjIChfX193YWtlX3VwKzB4M2EpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgw
MDAwMDAwMCwgMHgwMDAwODAwMAogLTMyNysgICAxLjM3MCAgX19faXBpcGVfcmVzdG9yZV9yb290
KzB4YSAoX19fd2FrZV91cCsweDQwKQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAw
MDAsIDB4MDAwMDgwMDAKIC0zMjUrICAgMS4wODAgIF9fX2lwaXBlX3N0YWxsX3Jvb3QrMHhlIChf
X19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxMCkKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAtMzI0
KyAgIDEuNTU4ICBfX19pcGlwZV9zdGFsbF9yb290KzB4MjIgKF9fX2lwaXBlX3Jlc3RvcmVfcm9v
dCsweDEwKQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0zMjMrICAgMS40ODIgIF9fX2lwaXBl
X3N0YWxsX3Jvb3QrMHgzMCAoX19faXBpcGVfcmVzdG9yZV9yb290KzB4MTApCjogICAgI2Z1bmMg
ICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTMyMSsgICAxLjc0MCAgX19f
aXBpcGVfcmVzdG9yZV9yb290KzB4YSAoX19fcXVldWVfd29yaysweDU2KQo6ICAgICNmdW5jICAg
IDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zMTkrICAgMS4wODAgIF9fX2lw
aXBlX3Vuc3RhbGxfcm9vdCsweDggKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDFhKQo6ICAgICNi
ZWdpbiAgIDB4ODAwMDAwMDAgIC0zMTgrICAgMS40ODAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsw
eDFhIChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOnwgICArZW5kICAgICAweDgwMDAwMDAw
ICAtMzE3KyAgIDEuNjQwICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHg1OCAoX19faXBpcGVfcmVz
dG9yZV9yb290KzB4MWEpCjogICAgK2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgw
MDAwODAwMAogLTMxNSsgICAxLjAyMCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsweGUg
KF9ydW5fd29ya3F1ZXVlKzB4YjgpCjp8ICAgK2JlZ2luICAgMHg4MDAwMDAwMSAgLTMxNCsgICAx
LjY1MCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsweDIyIChfcnVuX3dvcmtxdWV1ZSsw
eGI4KQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0zMTMrICAgMS42NTggIF9fX2lwaXBlX3Rl
c3RfYW5kX3N0YWxsX3Jvb3QrMHgzNiAoX3J1bl93b3JrcXVldWUrMHhiOCkKOiAgICAjZnVuYyAg
ICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMzExKyAgIDEuNDEyICBfX193
YWtlX3VwKzB4YSAoX3J1bl93b3JrcXVldWUrMHg0YykKOiAgICAjZnVuYyAgICAweDAwMDBmZmZm
LCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMzEwKyAgIDEuMjkwICBfX19pcGlwZV90ZXN0X2Fu
ZF9zdGFsbF9yb290KzB4ZSAoX19fd2FrZV91cCsweDE0KQo6fCAgICNiZWdpbiAgIDB4ODAwMDAw
MDEgIC0zMDgrICAgMS41NTAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgyMiAoX19f
d2FrZV91cCsweDE0KQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0zMDcrICAgMS43MDAgIF9f
X2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgzNiAoX19fd2FrZV91cCsweDE0KQo6ICAgICNm
dW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zMDUrICAgMS4zNjAg
IF9fX3dha2VfdXBfY29tbW9uKzB4YyAoX19fd2FrZV91cCsweDNhKQo6ICAgICNmdW5jICAgIDB4
MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zMDQrICAgMS4zNzAgIF9fX2lwaXBl
X3Jlc3RvcmVfcm9vdCsweGEgKF9fX3dha2VfdXArMHg0MCkKOiAgICAjZnVuYyAgICAweDAwMDBm
ZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMzAyKyAgIDEuMDgwICBfX19pcGlwZV9zdGFs
bF9yb290KzB4ZSAoX19faXBpcGVfcmVzdG9yZV9yb290KzB4MTApCjp8ICAgI2JlZ2luICAgMHg4
MDAwMDAwMSAgLTMwMSsgICAxLjU1OCAgX19faXBpcGVfc3RhbGxfcm9vdCsweDIyIChfX19pcGlw
ZV9yZXN0b3JlX3Jvb3QrMHgxMCkKOnwgICAjZW5kICAgICAweDgwMDAwMDAwICAtMzAwKyAgIDEu
NzAyICBfX19pcGlwZV9zdGFsbF9yb290KzB4MzAgKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDEw
KQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yOTgr
ICAgMS42NzAgIF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweGEgKF9ydW5fd29ya3F1ZXVlKzB4N2Ep
CjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTI5Nisg
ICAxLjA4MCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAoX19faXBpcGVfcmVzdG9yZV9yb290
KzB4MWEpCjogICAgI2JlZ2luICAgMHg4MDAwMDAwMCAgLTI5NSsgICAxLjQ4MCAgX19faXBpcGVf
dW5zdGFsbF9yb290KzB4MWEgKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDFhKQo6fCAgICtlbmQg
ICAgIDB4ODAwMDAwMDAgIC0yOTQrICAgMS4wNzAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDU4
IChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOnwgICArYmVnaW4gICAweDgwMDAwMDAxICAt
MjkzKyAgIDEuNDkwICBfcnVuX3dvcmtxdWV1ZSsweDkwIChfd29ya2VyX3RocmVhZCsweDEyYSkK
OnwgICArZW5kICAgICAweDgwMDAwMDAwICAtMjkxKyAgIDEuNjAwICBfcnVuX3dvcmtxdWV1ZSsw
eGEyIChfd29ya2VyX3RocmVhZCsweDEyYSkKOiAgICArZnVuYyAgICAweDAwMDBmZmZmLCAweDAw
MDAwMDAwLCAweDAwMDA4MDAwCiAtMjkwKyAgIDEuMDc4ICBfZG9fc29mdGludCsweGMgKF9ydW5f
d29ya3F1ZXVlKzB4YjQpCjp8ICAgK2JlZ2luICAgMHg4MDAwMDAwMSAgLTI4OCsgICAxLjUyMiAg
X2RvX3NvZnRpbnQrMHgyMiAoX3J1bl93b3JrcXVldWUrMHhiNCkKOnwgICArZW5kICAgICAweDgw
MDAwMDAwICAtMjg3KyAgIDEuOTEwICBfZG9fc29mdGludCsweDNjIChfcnVuX3dvcmtxdWV1ZSsw
eGI0KQo6ICAgICtmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0y
ODUrICAgMS40MDAgIF9fX3dha2VfdXArMHhhIChfZG9fc29mdGludCsweGY4KQo6ICAgICtmdW5j
ICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yODQgICAgMC45NzAgIF9f
X2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfX193YWtlX3VwKzB4MTQpCjp8ICAgK2Jl
Z2luICAgMHg4MDAwMDAwMSAgLTI4MysgICAxLjQzMCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxf
cm9vdCsweDIyIChfX193YWtlX3VwKzB4MTQpCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMCAgLTI4
MSsgICAxLjU5MCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsweDM2IChfX193YWtlX3Vw
KzB4MTQpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAog
LTI4MCsgICAxLjQ1MCAgX19fd2FrZV91cF9jb21tb24rMHhjIChfX193YWtlX3VwKzB4M2EpCjog
ICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTI3OCsgICAx
LjM5OCAgX19faXBpcGVfcmVzdG9yZV9yb290KzB4YSAoX19fd2FrZV91cCsweDQwKQo6ICAgICNm
dW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yNzcrICAgMS4wNzIg
IF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDggKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDFhKQo6
ICAgICNiZWdpbiAgIDB4ODAwMDAwMDAgIC0yNzYrICAgMS45MDAgIF9fX2lwaXBlX3Vuc3RhbGxf
cm9vdCsweDFhIChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOnwgICArZW5kICAgICAweDgw
MDAwMDAwICAtMjc0KyAgIDEuMzQwICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHg1OCAoX19faXBp
cGVfcmVzdG9yZV9yb290KzB4MWEpCjp8ICAgK2JlZ2luICAgMHg4MDAwMDAwMSAgLTI3MisgICAx
LjMzMCAgX2RvX3NvZnRpbnQrMHg1YyAoX3J1bl93b3JrcXVldWUrMHhiNCkKOnwgICArZW5kICAg
ICAweDgwMDAwMDAwICAtMjcxKyAgIDEuMDEwICBfZG9fc29mdGludCsweDc2IChfcnVuX3dvcmtx
dWV1ZSsweGI0KQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0yNzArICAgMS40OTAgIF9kb19z
b2Z0aW50KzB4OTYgKF9ydW5fd29ya3F1ZXVlKzB4YjQpCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAw
MCAgLTI2OSsgICAxLjQ4MCAgX2RvX3NvZnRpbnQrMHhiMCAoX3J1bl93b3JrcXVldWUrMHhiNCkK
OiAgICArZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMjY3KyAg
IDEuMTA4ICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4ZSAoX3J1bl93b3JrcXVldWUr
MHhiOCkKOnwgICArYmVnaW4gICAweDgwMDAwMDAxICAtMjY2KyAgIDEuNTIyICBfX19pcGlwZV90
ZXN0X2FuZF9zdGFsbF9yb290KzB4MjIgKF9ydW5fd29ya3F1ZXVlKzB4YjgpCjp8ICAgI2VuZCAg
ICAgMHg4MDAwMDAwMCAgLTI2NSsgICAxLjg2MCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9v
dCsweDM2IChfcnVuX3dvcmtxdWV1ZSsweGI4KQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4
MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yNjMrICAgMS40MjAgIF9fX3dha2VfdXArMHhhIChfcnVu
X3dvcmtxdWV1ZSsweDRjKQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4
MDAwMDgwMDAKIC0yNjErICAgMS4wMTAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhl
IChfX193YWtlX3VwKzB4MTQpCjp8ICAgI2JlZ2luICAgMHg4MDAwMDAwMSAgLTI2MCsgICAxLjU4
MCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsweDIyIChfX193YWtlX3VwKzB4MTQpCjp8
ICAgI2VuZCAgICAgMHg4MDAwMDAwMCAgLTI1OSsgICAxLjYwMCAgX19faXBpcGVfdGVzdF9hbmRf
c3RhbGxfcm9vdCsweDM2IChfX193YWtlX3VwKzB4MTQpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZm
ZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTI1NysgICAxLjQ1MCAgX19fd2FrZV91cF9jb21t
b24rMHhjIChfX193YWtlX3VwKzB4M2EpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAw
MDAwMCwgMHgwMDAwODAwMAogLTI1NisgICAxLjQxOCAgX19faXBpcGVfcmVzdG9yZV9yb290KzB4
YSAoX19fd2FrZV91cCsweDQwKQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAs
IDB4MDAwMDgwMDAKIC0yNTQrICAgMS4yODIgIF9fX2lwaXBlX3N0YWxsX3Jvb3QrMHhlIChfX19p
cGlwZV9yZXN0b3JlX3Jvb3QrMHgxMCkKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAtMjUzKyAg
IDEuNTkwICBfX19pcGlwZV9zdGFsbF9yb290KzB4MjIgKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsw
eDEwKQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0yNTErICAgMS45MjAgIF9fX2lwaXBlX3N0
YWxsX3Jvb3QrMHgzMCAoX19faXBpcGVfcmVzdG9yZV9yb290KzB4MTApCjogICAgI2Z1bmMgICAg
MHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTI0OSsgICAxLjMwMCAgX19faXBp
cGVfcmVzdG9yZV9yb290KzB4YSAoX3J1bl93b3JrcXVldWUrMHhlNikKOiAgICAjZnVuYyAgICAw
eDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMjQ4KyAgIDEuMDQwICBfX19pcGlw
ZV91bnN0YWxsX3Jvb3QrMHg4IChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOiAgICAjYmVn
aW4gICAweDgwMDAwMDAwICAtMjQ3KyAgIDEuNTAwICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHgx
YSAoX19faXBpcGVfcmVzdG9yZV9yb290KzB4MWEpCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAwMCAg
LTI0NisgICAxLjc4MCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4NTggKF9fX2lwaXBlX3Jlc3Rv
cmVfcm9vdCsweDFhKQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0yNDQrICAgMS44MDggIF93
b3JrZXJfdGhyZWFkKzB4ZDQgKF9rdGhyZWFkKzB4ZjApCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAw
MCAgLTI0MisgICAxLjYxMiAgX3dvcmtlcl90aHJlYWQrMHhlOCAoX2t0aHJlYWQrMHhmMCkKOiAg
ICArZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMjQwKyAgIDEu
ODIwICBfa3RocmVhZF9zaG91bGRfc3RvcCsweDEwIChfd29ya2VyX3RocmVhZCsweGY4KQo6ICAg
ICtmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yMzkrICAgMS40
MTAgIF9hZGRfd2FpdF9xdWV1ZSsweGUgKF93b3JrZXJfdGhyZWFkKzB4MTBhKQo6ICAgICtmdW5j
ICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yMzcgICAgMC45NjAgIF9f
X2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfYWRkX3dhaXRfcXVldWUrMHgxOCkKOnwg
ICArYmVnaW4gICAweDgwMDAwMDAxICAtMjM2KyAgIDEuNDkwICBfX19pcGlwZV90ZXN0X2FuZF9z
dGFsbF9yb290KzB4MjIgKF9hZGRfd2FpdF9xdWV1ZSsweDE4KQo6fCAgICNlbmQgICAgIDB4ODAw
MDAwMDAgIC0yMzUrICAgMS41OTAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgzNiAo
X2FkZF93YWl0X3F1ZXVlKzB4MTgpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAw
MCwgMHgwMDAwODAwMAogLTIzMysgICAxLjM5MCAgX19faXBpcGVfcmVzdG9yZV9yb290KzB4YSAo
X2FkZF93YWl0X3F1ZXVlKzB4M2UpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAw
MCwgMHgwMDAwODAwMAogLTIzMisgICAxLjA4OCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAo
X19faXBpcGVfcmVzdG9yZV9yb290KzB4MWEpCjogICAgI2JlZ2luICAgMHg4MDAwMDAwMCAgLTIz
MSsgICAxLjc1MiAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4MWEgKF9fX2lwaXBlX3Jlc3RvcmVf
cm9vdCsweDFhKQo6fCAgICtlbmQgICAgIDB4ODAwMDAwMDAgIC0yMjkrICAgMS45ODAgIF9fX2lw
aXBlX3Vuc3RhbGxfcm9vdCsweDU4IChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOiAgICAr
ZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMjI3KyAgIDEuNjUw
ICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4ZSAoX3dvcmtlcl90aHJlYWQrMHgxMTYpCjogICAgK2Z1
bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTIyNSsgICAxLjM2MCAg
X3Byb2ZpbGVfaGl0KzB4ZSAoX19fc2NoZWRfdGV4dF9zdGFydCsweDRjKQo6ICAgICtmdW5jICAg
IDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yMjQrICAgMS42MDAgIF9zY2hl
ZF9jbG9jaysweGMgKF9fX3NjaGVkX3RleHRfc3RhcnQrMHg3YykKOiAgICArZnVuYyAgICAweDAw
MDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMjIyKyAgIDIuNzMwICBfX19tdWxkaTMr
MHhjIChfc2NoZWRfY2xvY2srMHgyNikKOiAgICArZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAw
MDAwLCAweDAwMDA4MDAwCiAtMjIwKyAgIDEuMDYwICBfX19pcGlwZV9zdGFsbF9yb290KzB4ZSAo
X19fc2NoZWRfdGV4dF9zdGFydCsweGVjKQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0yMTgr
ICAgMS41MzggIF9fX2lwaXBlX3N0YWxsX3Jvb3QrMHgyMiAoX19fc2NoZWRfdGV4dF9zdGFydCsw
eGVjKQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0yMTcrICAgMi4wMDIgIF9fX2lwaXBlX3N0
YWxsX3Jvb3QrMHgzMCAoX19fc2NoZWRfdGV4dF9zdGFydCsweGVjKQo6ICAgICNmdW5jICAgIDB4
MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yMTUrICAgMS43MTAgIF9kZWFjdGl2
YXRlX3Rhc2srMHhlIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4NDY0KQo6ICAgICNmdW5jICAgIDB4
MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yMTMrICAgMi43MjAgIF9kZXF1ZXVl
X3Rhc2srMHhlIChfZGVhY3RpdmF0ZV90YXNrKzB4MWMpCjp8ICAgI2JlZ2luICAgMHg4MDAwMDAw
MSAgLTIxMSsgICAxLjQ2MCAgX19fc2NoZWRfdGV4dF9zdGFydCsweDFlNiAoX3dvcmtlcl90aHJl
YWQrMHgxMTYpCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMCAgLTIwOSsgICAyLjQ4MCAgX19fc2No
ZWRfdGV4dF9zdGFydCsweDFmNCAoX3dvcmtlcl90aHJlYWQrMHgxMTYpCjogICAgI2Z1bmMgICAg
MHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTIwNysgICAxLjA1MCAgX19faXBp
cGVfZGlzcGF0Y2hfZXZlbnQrMHhhIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MmRlKQo6fCAgICNi
ZWdpbiAgIDB4ODAwMDAwMDEgIC0yMDYrICAgMS43OTAgIF9fX2lwaXBlX2Rpc3BhdGNoX2V2ZW50
KzB4MjAgKF9fX3NjaGVkX3RleHRfc3RhcnQrMHgyZGUpCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAw
MCAgLTIwNCsgICAxLjU2OCAgX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHhjYyAoX19fc2NoZWRf
dGV4dF9zdGFydCsweDJkZSkKOiAgICAjZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAw
eDAwMDA4MDAwCiAtMjAyKyAgIDEuNTYyICBfc2NoZWR1bGVfZXZlbnQrMHgxNiAoX19faXBpcGVf
ZGlzcGF0Y2hfZXZlbnQrMHhlMikKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAtMjAxKyAgIDIu
MzIwICBfc2NoZWR1bGVfZXZlbnQrMHg3ZSAoX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHhlMikK
OnwgICojZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTk4KyAg
IDEuMjcwICBfeG5wb2Rfc2NoZWR1bGVfcnVubmFibGUrMHhjIChfc2NoZWR1bGVfZXZlbnQrMHhh
OCkKOnwgICojWyAgICAwXSBzd2FwcGVyICAwICAtMTk3KyAgIDIuMjYwICBfeG5wb2Rfc2NoZWR1
bGVfcnVubmFibGUrMHgyOCAoX3NjaGVkdWxlX2V2ZW50KzB4YTgpCjp8ICAqI2Z1bmMgICAgMHgw
MDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTE5NSsgICAxLjc0MCAgX19faXBpcGVf
cmVzdG9yZV9waXBlbGluZV9oZWFkKzB4YSAoX3NjaGVkdWxlX2V2ZW50KzB4MTAwKQo6fCAgICNl
bmQgICAgIDB4ODAwMDAwMDAgIC0xOTMrICAgMS4xODAgIF9fX2lwaXBlX3Jlc3RvcmVfcGlwZWxp
bmVfaGVhZCsweDk0IChfc2NoZWR1bGVfZXZlbnQrMHgxMDApCjp8ICAgI2JlZ2luICAgMHg4MDAw
MDAwMSAgLTE5MisgICAxLjY0MCAgX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHhmYSAoX19fc2No
ZWRfdGV4dF9zdGFydCsweDJkZSkKOnwgICAjZW5kICAgICAweDgwMDAwMDAwICAtMTkwKyAgIDEu
Mjg4ICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweDE3YSAoX19fc2NoZWRfdGV4dF9zdGFydCsw
eDJkZSkKOiAgICAjYmVnaW4gICAweDgwMDAwMDAwICAtMTg5KyAgIDQuMTEyICBfX19zY2hlZF90
ZXh0X3N0YXJ0KzB4MmYwIChfd29ya2VyX3RocmVhZCsweDExNikKOnwgICAjZW5kICAgICAweDgw
MDAwMDAwICAtMTg1KyAgIDEuOTUwICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4NWNhIChfc3lzdGVt
X2NhbGwrMHhiOCkKOiAgICAjZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4
MDAwCiAtMTgzKyAgIDEuMDgwICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHg4IChfX19zY2hlZF90
ZXh0X3N0YXJ0KzB4M2NlKQo6ICAgICNiZWdpbiAgIDB4ODAwMDAwMDAgIC0xODIrICAgMS41NzAg
IF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDFhIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4M2NlKQo6
fCAgICtlbmQgICAgIDB4ODAwMDAwMDAgIC0xODArICAgMS40NDAgIF9fX2lwaXBlX3Vuc3RhbGxf
cm9vdCsweDU4IChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4M2NlKQo6ICAgICtmdW5jICAgIDB4MDAw
MGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0xNzkrICAgMS4wMTAgIF9fX2lwaXBlX3Rl
c3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4M2Q4KQo6fCAgICti
ZWdpbiAgIDB4ODAwMDAwMDEgIC0xNzgrICAgMS41MzAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxs
X3Jvb3QrMHgyMiAoX19fc2NoZWRfdGV4dF9zdGFydCsweDNkOCkKOnwgICAjZW5kICAgICAweDgw
MDAwMDAwICAtMTc2KyAgIDEuNzI4ICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4MzYg
KF9fX3NjaGVkX3RleHRfc3RhcnQrMHgzZDgpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgw
MDAwMDAwMCwgMHgwMDAwODAwMAogLTE3NCsgICAxLjgxMiAgX19faXBpcGVfcmVzdG9yZV9yb290
KzB4YSAoX19fc2NoZWRfdGV4dF9zdGFydCsweDRlYykKOiAgICAjZnVuYyAgICAweDAwMDBmZmZm
LCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTczKyAgIDEuMTIwICBfX19pcGlwZV91bnN0YWxs
X3Jvb3QrMHg4IChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOiAgICAjYmVnaW4gICAweDgw
MDAwMDAwICAtMTcyKyAgIDEuNTUwICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHgxYSAoX19faXBp
cGVfcmVzdG9yZV9yb290KzB4MWEpCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAwMCAgLTE3MCEgIDE2
LjczMCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4NTggKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsw
eDFhKQo6ICAgICtmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0x
NTMrICAgMS42OTAgIF9fX2lwaXBlX3N5c2NhbGxfcm9vdCsweDE0IChfc3lzdGVtX2NhbGwrMHgy
ZSkKOiAgICArZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTUy
KyAgIDEuMDMwICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweGEgKF9fX2lwaXBlX3N5c2NhbGxf
cm9vdCsweDQwKQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0xNTErICAgMi4xMDAgIF9fX2lw
aXBlX2Rpc3BhdGNoX2V2ZW50KzB4MjAgKF9fX2lwaXBlX3N5c2NhbGxfcm9vdCsweDQwKQo6fCAg
KyBlbmQgICAgIDB4ODAwMDAwMDAgIC0xNDgrICAgMi4xOTggIF9fX2lwaXBlX2Rpc3BhdGNoX2V2
ZW50KzB4Y2MgKF9fX2lwaXBlX3N5c2NhbGxfcm9vdCsweDQwKQo6ICAgKyBmdW5jICAgIDB4MDAw
MGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0xNDYrICAgMi41MjIgIF9oaXN5c2NhbGxf
ZXZlbnQrMHgxMCAoX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHhlMikKOiAgICsgZnVuYyAgICAw
eDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTQ0KyAgIDEuNTgwICBfeG5wb2Rf
c2NoZWR1bGUrMHhhIChfaGlzeXNjYWxsX2V2ZW50KzB4YmUpCjp8ICArIGJlZ2luICAgMHg4MDAw
MDAwMSAgLTE0MisgICAxLjUzMCAgX3hucG9kX3NjaGVkdWxlKzB4NjQgKF9oaXN5c2NhbGxfZXZl
bnQrMHhiZSkKOnwgICsgZW5kICAgICAweDgwMDAwMDAwICAtMTQxICAgIDAuOTkwICBfeG5wb2Rf
c2NoZWR1bGUrMHg3MiAoX2hpc3lzY2FsbF9ldmVudCsweGJlKQo6fCAgKyBiZWdpbiAgIDB4ODAw
MDAwMDEgIC0xNDArICAgMS41MTAgIF94bnBvZF9zY2hlZHVsZSsweGM0IChfaGlzeXNjYWxsX2V2
ZW50KzB4YmUpCjp8ICAjIFsgICAgMF0gc3dhcHBlciAgMCAgLTEzOCsgICAxLjcxMCAgX3hucG9k
X3NjaGVkdWxlKzB4MTA0IChfaGlzeXNjYWxsX2V2ZW50KzB4YmUpCjp8ICAjIGZ1bmMgICAgMHgw
MDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTEzNisgICAxLjE2MCAgX19faXBpcGVf
cmVzdG9yZV9waXBlbGluZV9oZWFkKzB4YSAoX3hucG9kX3NjaGVkdWxlKzB4MmIwKQo6fCAgKyBl
bmQgICAgIDB4ODAwMDAwMDAgIC0xMzUrICAgMS45NDggIF9fX2lwaXBlX3Jlc3RvcmVfcGlwZWxp
bmVfaGVhZCsweDk0IChfeG5wb2Rfc2NoZWR1bGUrMHgyYjApCjp8ICArIGJlZ2luICAgMHg4MDAw
MDAwMSAgLTEzMysgICAxLjkzMiAgX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHhmYSAoX19faXBp
cGVfc3lzY2FsbF9yb290KzB4NDApCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAwMCAgLTEzMSsgICAy
LjAzMCAgX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHhjYyAoX19faXBpcGVfc3lzY2FsbF9yb290
KzB4NDApCjogICAgK2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAog
LTEyOSsgICAxLjI3MCAgX2xvc3lzY2FsbF9ldmVudCsweDE0IChfX19pcGlwZV9kaXNwYXRjaF9l
dmVudCsweGUyKQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0xMjgrICAgMS42MDAgIF9fX2lw
aXBlX2Rpc3BhdGNoX2V2ZW50KzB4ZmEgKF9fX2lwaXBlX3N5c2NhbGxfcm9vdCsweDQwKQo6fCAg
ICtlbmQgICAgIDB4ODAwMDAwMDAgIC0xMjYrICAgMi41MTAgIF9fX2lwaXBlX2Rpc3BhdGNoX2V2
ZW50KzB4MTdhIChfX19pcGlwZV9zeXNjYWxsX3Jvb3QrMHg0MCkKOiAgICArZnVuYyAgICAweDAw
MDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTI0KyAgIDEuNjIwICBfc3lzX3dyaXRl
KzB4YSAoX3N5c3RlbV9jYWxsKzB4ODYpCjogICAgK2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAw
MDAwMCwgMHgwMDAwODAwMAogLTEyMisgICAxLjU2MCAgX2ZnZXRfbGlnaHQrMHgxNiAoX3N5c193
cml0ZSsweDE2KQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0xMjErICAgMS42MjggIF9mZ2V0
X2xpZ2h0KzB4OGMgKF9zeXNfd3JpdGUrMHgxNikKOnwgICArZW5kICAgICAweDgwMDAwMDAwICAt
MTE5KyAgIDIuMjEyICBfZmdldF9saWdodCsweGE2IChfc3lzX3dyaXRlKzB4MTYpCjogICAgK2Z1
bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTExNysgICAyLjYzMCAg
X3Zmc193cml0ZSsweGMgKF9zeXNfd3JpdGUrMHgzNCkKOiAgICArZnVuYyAgICAweDAwMDBmZmZm
LCAweDAwMDAwODAwLCAweDAwMDA4MDAwCiAtMTE0KyAgIDUuMDIwICBfcndfdmVyaWZ5X2FyZWEr
MHhhIChfdmZzX3dyaXRlKzB4MTM2KQoKCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cgo6fCAgICtmdW5jICAg
IDB4MDAwMDAwMWYsIDB4MDAwMDAwNDAsIDB4MDAwMDg4MDAKIC0xMDkrICAgMi42OTAgIF9fX2lw
aXBlX2dyYWJfaXJxKzB4MjIgKF9fY29tbW9uX2ludF9lbnRyeSsweDcyKQo6fCAgICtiZWdpbiAg
IDB4MDAwMDAwMTggIC0xMDcrICAgMi44NTAgIF9fX2lwaXBlX2dyYWJfaXJxKzB4MzQgKF9fY29t
bW9uX2ludF9lbnRyeSsweDcyKQo6fCAgICtmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwNDAs
IDB4MDAwMDg4MDAKIC0xMDQrICAgMy45NjAgIF9fX2lwaXBlX2hhbmRsZV9pcnErMHgxZSAoX19f
aXBpcGVfZ3JhYl9pcnErMHgzYykKOnwgICArZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDQw
LCAweDAwMDA4ODAwCiAtMTAwKyAgIDEuNzYwICBfX19pcGlwZV9hY2tfaXJxKzB4MTAgKF9fX2lw
aXBlX2hhbmRsZV9pcnErMHhlZSkKOnwgICArZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDQw
LCAweDAwMDA4ODAwCiAgLTk4KyAgIDMuMjk4ICBfaXBpcGVfdGVzdF9hbmRfc3RhbGxfcGlwZWxp
bmVfZnJvbSsweGEgKF9fX2lwaXBlX2Fja19pcnErMHgyMCkKOnwgICAjZnVuYyAgICAweDAwMDAw
MDFmLCAweDAwMDAwMDQwLCAweDAwMDA4ODAwCiAgLTk1KyAgIDIuMzAyICBfYmY1MzNfaW50ZXJu
YWxfbWFza19pcnErMHhjIChfX19pcGlwZV9hY2tfaXJxKzB4NDApCjp8ICAgK2Z1bmMgICAgMHgw
MDAwMDAxZiwgMHgwMDAwMDA0MCwgMHgwMDAwODgwMAogIC05MisgICAzLjI5MCAgX19faXBpcGVf
d2Fsa19waXBlbGluZSsweDE4IChfX19pcGlwZV9oYW5kbGVfaXJxKzB4MTQ4KQo6fCAgICtmdW5j
ICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwNDAsIDB4MDAwMDg4MDAKICAtODkrICAgNi4xMTAgIF9f
X2lwaXBlX3N5bmNfc3RhZ2UrMHhlIChfX19pcGlwZV93YWxrX3BpcGVsaW5lKzB4ZGUpCjp8ICAg
I2Z1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDA0MCwgMHgwMDAwODgwMAogIC04MysgICAxLjY5
MCAgX2tpY2tfaXJxZCsweDFjIChfX19pcGlwZV9zeW5jX3N0YWdlKzB4MjkwKQo6fCAgICNmdW5j
ICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwNDAsIDB4MDAwMDg4MDAKICAtODErICAgMS45MjAgIF9f
X2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfa2lja19pcnFkKzB4MjIpCjp8ICAgI2Z1
bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDA0MCwgMHgwMDAwODgwMAogIC03OSsgICAxLjcxMCAg
X19faXBpcGVfcmVzdG9yZV9yb290KzB4YSAoX2tpY2tfaXJxZCsweDMyKQo6fCAgICNmdW5jICAg
IDB4MDAwMDAwMWYsIDB4MDAwMDAwNDAsIDB4MDAwMDg4MDAKICAtNzgrICAgMS45MzAgIF9fX2lw
aXBlX3N0YWxsX3Jvb3QrMHhlIChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxMCkKOnwgICAjZnVu
YyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDQwLCAweDAwMDA4ODAwCiAgLTc2KyAgIDEuODQ4ICBf
X191cCsweDggKF9raWNrX2lycWQrMHg2MikKOnwgICAjZnVuYyAgICAweDAwMDAwMDFmLCAweDAw
MDAwMDQwLCAweDAwMDA4ODAwCiAgLTc0KyAgIDEuNzMyICBfX193YWtlX3VwKzB4YSAoX19fdXAr
MHgxNikKOnwgICAjZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDQwLCAweDAwMDA4ODAwCiAg
LTcyKyAgIDEuODgwICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4ZSAoX19fd2FrZV91
cCsweDE0KQo6fCAgICNmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwNDAsIDB4MDAwMDg4MDAK
ICAtNzArICAgMi4yODAgIF9fX3dha2VfdXBfY29tbW9uKzB4YyAoX19fd2FrZV91cCsweDNhKQo6
fCAgICNmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwNDAsIDB4MDAwMDg4MDAKICAtNjgrICAg
MS43ODAgIF9kZWZhdWx0X3dha2VfZnVuY3Rpb24rMHhhIChfX193YWtlX3VwX2NvbW1vbisweDM4
KQo6fCAgICNmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwNDAsIDB4MDAwMDg4MDAKICAtNjYr
ICAgMS42OTAgIF90cnlfdG9fd2FrZV91cCsweGEgKF9kZWZhdWx0X3dha2VfZnVuY3Rpb24rMHgx
MCkKOnwgICAjZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDQwLCAweDAwMDA4ODAwCiAgLTY1
KyAgIDEuODEwICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4ZSAoX3RyeV90b193YWtl
X3VwKzB4MTQpCjp8ICAgI2Z1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDA0MCwgMHgwMDAwODgw
MAogIC02MysgICAxLjY2MCAgX3NjaGVkX2Nsb2NrKzB4YyAoX3RyeV90b193YWtlX3VwKzB4N2Up
Cjp8ICAgI2Z1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDA0MCwgMHgwMDAwODgwMAogIC02MSsg
ICAyLjU0OCAgX19fbXVsZGkzKzB4YyAoX3NjaGVkX2Nsb2NrKzB4MjYpCjp8ICAgI2Z1bmMgICAg
MHgwMDAwMDAxZiwgMHgwMDAwMDA0MCwgMHgwMDAwODgwMAogIC01OSsgICAyLjYyMiAgX2VucXVl
dWVfdGFzaysweGUgKF90cnlfdG9fd2FrZV91cCsweGQyKQo6fCAgICNmdW5jICAgIDB4MDAwMDAw
MWYsIDB4MDAwMDAwNDAsIDB4MDAwMDg4MDAKICAtNTYrICAgMS40NDAgIF9fX2lwaXBlX3Jlc3Rv
cmVfcm9vdCsweGEgKF90cnlfdG9fd2FrZV91cCsweDNjKQo6fCAgICNmdW5jICAgIDB4MDAwMDAw
MWYsIDB4MDAwMDAwNDAsIDB4MDAwMDg4MDAKICAtNTQrICAgMS41ODAgIF9fX2lwaXBlX3N0YWxs
X3Jvb3QrMHhlIChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxMCkKOnwgICAjZnVuYyAgICAweDAw
MDAwMDFmLCAweDAwMDAwMDQwLCAweDAwMDA4ODAwCiAgLTUzKyAgIDEuMzIwICBfX19pcGlwZV9y
ZXN0b3JlX3Jvb3QrMHhhIChfX193YWtlX3VwKzB4NDApCjp8ICAgI2Z1bmMgICAgMHgwMDAwMDAx
ZiwgMHgwMDAwMDA0MCwgMHgwMDAwODgwMAogIC01MisgICAxLjcwMCAgX19faXBpcGVfc3RhbGxf
cm9vdCsweGUgKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDEwKQo6fCAgICtlbmQgICAgIDB4MDAw
MDAwMTggICAtNTArICAgMi45ODAgIF9fX2lwaXBlX2dyYWJfaXJxKzB4NDIgKF9fY29tbW9uX2lu
dF9lbnRyeSsweDcyKQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgoKOnwg
ICArZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAgLTQ3KyAgIDEu
MDYwICBfX19pcGlwZV9ncmFiX2lycSsweDIyIChfX2NvbW1vbl9pbnRfZW50cnkrMHg3MikKOnwg
ICArYmVnaW4gICAweDAwMDAwMDA2ICAgLTQ2KyAgIDEuOTI4ICBfX19pcGlwZV9ncmFiX2lycSsw
eDM0IChfX2NvbW1vbl9pbnRfZW50cnkrMHg3MikKOnwgICArZnVuYyAgICAweDAwMDAwMDFmLCAw
eDAwMDAwMDAwLCAweDAwMDA4MDQwCiAgLTQ0KyAgIDIuNTMyICBfX19pcGlwZV9oYW5kbGVfaXJx
KzB4MWUgKF9fX2lwaXBlX2dyYWJfaXJxKzB4M2MpCjp8ICAgK2Z1bmMgICAgMHgwMDAwMDAxZiwg
MHgwMDAwMDAwMCwgMHgwMDAwODA0MAogIC00MSsgICAxLjY0MCAgX3J0aGFsX3RpbWVyX2Fjaysw
eDggKF9fX2lwaXBlX2hhbmRsZV9pcnErMHgxNzgpCjp8ICAgK2Z1bmMgICAgMHgwMDAwMDAxZiwg
MHgwMDAwMDAwMCwgMHgwMDAwODA0MAogIC00MCsgICAyLjU0MCAgX19faXBpcGVfZGlzcGF0Y2hf
d2lyZWQrMHgxNCAoX19faXBpcGVfaGFuZGxlX2lycSsweDE5MCkKOnwgICMgZnVuYyAgICAweDAw
MDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAgLTM3KyAgIDIuMDIwICBfeG5pbnRyX2Ns
b2NrX2hhbmRsZXIrMHgxMCAoX19faXBpcGVfZGlzcGF0Y2hfd2lyZWQrMHhiNikKOnwgICMgZnVu
YyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAgLTM1KyAgIDEuOTEwICBf
eG5pbnRyX2lycV9oYW5kbGVyKzB4MTggKF94bmludHJfY2xvY2tfaGFuZGxlcisweDE4KQo6fCAg
IyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKICAtMzMrICAgMS42
MTAgIF94bnBvZF9hbm5vdW5jZV90aWNrKzB4YyAoX3huaW50cl9pcnFfaGFuZGxlcisweDJhKQo6
fCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKICAtMzIrICAg
MS44MDAgIF94bnRpbWVyX2RvX3RpY2tfYXBlcmlvZGljKzB4MTQgKF94bnBvZF9hbm5vdW5jZV90
aWNrKzB4MTYpCjp8ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODA0
MAogIC0zMCsgICAyLjAzOCAgX3RpbWVyX3Byb2MrMHhjIChfeG50aW1lcl9kb190aWNrX2FwZXJp
b2RpYysweDFiMikKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4
MDQwCiAgLTI4KyAgIDIuNTYyICBfeG5wb2RfZ2V0X3RpbWUrMHhhIChfdGltZXJfcHJvYysweDEw
KQo6fCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKICAtMjUr
ICAgMS44MjAgIF9fX211bGRpMysweGMgKF94bnBvZF9nZXRfdGltZSsweDUyKQo6fCAgIyBmdW5j
ICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKICAtMjMrICAgMi4xMTAgIF9f
X211bGRpMysweGMgKF94bnBvZF9nZXRfdGltZSsweDZlKQo6fCAgIyBmdW5jICAgIDB4MDAwMDAw
MWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKICAtMjErICAgNS4wODAgIF9fX2RpdjY0XzMyKzB4
MTAgKF94bnBvZF9nZXRfdGltZSsweDFmMCkKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAw
MDAwMDAwLCAweDAwMDA4MDQwCiAgLTE2KyAgIDcuMTIwICBfX19kaXY2NF8zMisweDEwIChfeG5w
b2RfZ2V0X3RpbWUrMHgxZTQpCjp8ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwg
MHgwMDAwODA0MAogICAtOSsgICAyLjg1MCAgX2V2YWxfaW5uZXJfbG9vcCsweGUgKF90aW1lcl9w
cm9jKzB4MjQpCjp8ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODA0
MAogICAtNisgICAxLjU2MCAgX2lwaXBlX3RyYWNlX2Zyb3plbl9yZXNldCsweGEgKF9ldmFsX2lu
bmVyX2xvb3ArMHhlMCkKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAw
MDA4MDQwCiAgIC01KyAgIDQuMjM4ICBfX19pcGlwZV9nbG9iYWxfcGF0aF9sb2NrKzB4YSAoX2lw
aXBlX3RyYWNlX2Zyb3plbl9yZXNldCsweGUpCjx8ICAjIGZyZWV6ZSAgMHgwMDAxOTMzZSAgICAg
MSAgICAzLjEzMiAgX2V2YWxfaW5uZXJfbG9vcCsweGU2IChfdGltZXJfcHJvYysweDI0KQogfCAg
IyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKICAgIDQgICAgMS42
ODAgIF94bnBvZF9nZXRfdGltZSsweGEgKF90aW1lcl9wcm9jKzB4MmEpCiB8ICAjIGZ1bmMgICAg
MHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODA0MAogICAgNSAgICAxLjU3MCAgX19fbXVs
ZGkzKzB4YyAoX3hucG9kX2dldF90aW1lKzB4NTIpCiB8ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwg
MHgwMDAwMDAwMCwgMHgwMDAwODA0MAogICAgNyAgICAxLjUyMCAgX19fbXVsZGkzKzB4YyAoX3hu
cG9kX2dldF90aW1lKzB4NmUpCiB8ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwg
MHgwMDAwODA0MAogICAgOCAgICAzLjM5MCAgX19fZGl2NjRfMzIrMHgxMCAoX3hucG9kX2dldF90
aW1lKzB4MWYwKQogfCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgw
NDAKICAgMTIgICAgNS42NzAgIF9fX2RpdjY0XzMyKzB4MTAgKF94bnBvZF9nZXRfdGltZSsweDFl
NCkKIHwgICMgYmVnaW4gICAweDAwMDU5Nzk4ICAgIDE3ICAgIDIuMTEwICBfdGltZXJfcHJvYysw
eDQ0IChfeG50aW1lcl9kb190aWNrX2FwZXJpb2RpYysweDFiMikKIHwgICMgZnVuYyAgICAweDAw
MDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAgIDIwICAgIDIuNTU4ICBfeG50aW1lcl9z
dGFydCsweGEgKF90aW1lcl9wcm9jKzB4NzQpCiB8ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwgMHgw
MDAwMDAwMCwgMHgwMDAwODA0MAogICAyMiAgICAzLjU1MiAgX3hudGltZXJfZG9fc3RhcnRfYXBl
cmlvZGljKzB4YSAoX3hudGltZXJfc3RhcnQrMHg2MikKIHwgICMgZnVuYyAgICAweDAwMDAwMDFm
LCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAgIDI2ICAgIDEuNjMwICBfX19tdWxkaTMrMHhjIChf
eG50aW1lcl9kb19zdGFydF9hcGVyaW9kaWMrMHhkNikKIHwgICMgZnVuYyAgICAweDAwMDAwMDFm
LCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAgIDI3ICAgIDAuMDAwICBfX19tdWxkaTMrMHhjIChf
eG50aW1lcl9kb19zdGFydF9hcGVyaW9kaWMrMHhlZSkK
------=_Part_106902_15345745.1163412091790
Content-Type: text/x-log; name=ipipe-tarce-2.log; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eugoaq64
Content-Disposition: attachment; filename="ipipe-tarce-2.log"

cm9vdDp+PiAuL2xhdGVuY3kgLXQyIC1wMjAwIC1mCnJvb3Q6fj4gY2F0IC9wcm9jL2lwaXBlL3Ry
YWNlL2Zyb3plbgpJLXBpcGUgZnJvemVuIGJhY2stdHJhY2luZyBzZXJ2aWNlIG9uIDIuNi4xNi4y
Ny1BREktMjAwNlIyL2lwaXBlLTEuNS0wMAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRnJlZXplOiA5MDc4Njk1MzE1NSBjeWNsZXMs
IFRyYWNlIFBvaW50czogMjAwICgrMTApCgogKy0tLS0tIEhhcmQgSVJRcyAoJ3wnOiBsb2NrZWQp
CiB8Ky0tLS0gPHVudXNlZD4KIHx8Ky0tLSA8dW51c2VkPgogfHx8Ky0tIFhlbm9tYWkKIHx8fHwr
LSBMaW51eCAoJyonOiBkb21haW4gc3RhbGxlZCwgJysnOiBjdXJyZW50LCAnIyc6IGN1cnJlbnQr
c3RhbGxlZCkKIHx8fHx8ICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0gRGVsYXkg
ZmxhZyAoJysnOiA+IDEgdXMsICchJzogPiAxMCB1cykKIHx8fHx8ICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgKy0gTk1JIG5vaXNlICgnTicpCiB8fHx8fCAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgICAgIHwKICAgICAgVHlwZSAgICBVc2VyIFZhbC4gICBUaW1lICAgIERlbGF5
ICBGdW5jdGlvbiAoUGFyZW50KQo6ICAgICtmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAs
IDB4MDAwMDgwMDAKIC00MjkrICAgMy4zMTAgIF9fX211bGRpMysweGMgKF9zY2hlZF9jbG9jaysw
eDI2KQo6ICAgICtmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC00
MjYrICAgMS4wNjAgIF9fX2lwaXBlX3N0YWxsX3Jvb3QrMHhlIChfX19zY2hlZF90ZXh0X3N0YXJ0
KzB4ZWMpCjp8ICAgK2JlZ2luICAgMHg4MDAwMDAwMSAgLTQyNSsgICAxLjMzMCAgX19faXBpcGVf
c3RhbGxfcm9vdCsweDIyIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4ZWMpCjp8ICAgI2VuZCAgICAg
MHg4MDAwMDAwMCAgLTQyNCsgICAxLjcxMCAgX19faXBpcGVfc3RhbGxfcm9vdCsweDMwIChfX19z
Y2hlZF90ZXh0X3N0YXJ0KzB4ZWMpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAw
MCwgMHgwMDAwODAwMAogLTQyMisgICAxLjc1MCAgX2RlYWN0aXZhdGVfdGFzaysweGUgKF9fX3Nj
aGVkX3RleHRfc3RhcnQrMHg0NjQpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAw
MCwgMHgwMDAwODAwMAogLTQyMCsgICAzLjA0MCAgX2RlcXVldWVfdGFzaysweGUgKF9kZWFjdGl2
YXRlX3Rhc2srMHgxYykKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAtNDE3KyAgIDEuNzU4ICBf
X19zY2hlZF90ZXh0X3N0YXJ0KzB4MWU2IChfd29ya2VyX3RocmVhZCsweDExNikKOnwgICAjZW5k
ICAgICAweDgwMDAwMDAwICAtNDE2KyAgIDMuNDcyICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MWY0
IChfd29ya2VyX3RocmVhZCsweDExNikKOiAgICAjZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAw
MDAwLCAweDAwMDA4MDAwCiAtNDEyKyAgIDEuMzEwICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsw
eGEgKF9fX3NjaGVkX3RleHRfc3RhcnQrMHgyZGUpCjp8ICAgI2JlZ2luICAgMHg4MDAwMDAwMSAg
LTQxMSsgICAxLjc3MCAgX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHgyMCAoX19fc2NoZWRfdGV4
dF9zdGFydCsweDJkZSkKOnwgICAjZW5kICAgICAweDgwMDAwMDAwICAtNDA5KyAgIDEuNDkwICBf
X19pcGlwZV9kaXNwYXRjaF9ldmVudCsweGNjIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MmRlKQo6
ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC00MDcrICAg
MS41NzAgIF9zY2hlZHVsZV9ldmVudCsweDE2IChfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweGUy
KQo6fCAgICNiZWdpbiAgIDB4ODAwMDAwMDEgIC00MDYrICAgMi40NDAgIF9zY2hlZHVsZV9ldmVu
dCsweDdlIChfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweGUyKQo6fCAgKiNmdW5jICAgIDB4MDAw
MDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC00MDMrICAgMi4wMjAgIF94bnBvZF9zY2hl
ZHVsZV9ydW5uYWJsZSsweGMgKF9zY2hlZHVsZV9ldmVudCsweGE4KQo6fCAgKiNbICAgIDBdIHN3
YXBwZXIgIDAgIC00MDErICAgMi4yMjggIF94bnBvZF9zY2hlZHVsZV9ydW5uYWJsZSsweDI4IChf
c2NoZWR1bGVfZXZlbnQrMHhhOCkKOnwgICojZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAw
LCAweDAwMDA4MDAwCiAtMzk5KyAgIDEuODkyICBfX19pcGlwZV9yZXN0b3JlX3BpcGVsaW5lX2hl
YWQrMHhhIChfc2NoZWR1bGVfZXZlbnQrMHgxMDApCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMCAg
LTM5NysgICAxLjQ0MCAgX19faXBpcGVfcmVzdG9yZV9waXBlbGluZV9oZWFkKzB4OTQgKF9zY2hl
ZHVsZV9ldmVudCsweDEwMCkKOnwgICAjYmVnaW4gICAweDgwMDAwMDAxICAtMzk2KyAgIDEuNjQw
ICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweGZhIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MmRl
KQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0zOTQrICAgMS4wOTAgIF9fX2lwaXBlX2Rpc3Bh
dGNoX2V2ZW50KzB4MTdhIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MmRlKQo6ICAgICNiZWdpbiAg
IDB4ODAwMDAwMDAgIC0zOTMrICAgNC4yMjAgIF9fX3NjaGVkX3RleHRfc3RhcnQrMHgyZjAgKF93
b3JrZXJfdGhyZWFkKzB4MTE2KQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0zODkrICAgMS40
NzAgIF9fX3NjaGVkX3RleHRfc3RhcnQrMHg1Y2EgKF9zeXN0ZW1fY2FsbCsweGI4KQo6ICAgICNm
dW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zODcrICAgMS4wODAg
IF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDggKF9fX3NjaGVkX3RleHRfc3RhcnQrMHgzY2UpCjog
ICAgI2JlZ2luICAgMHg4MDAwMDAwMCAgLTM4NisgICAxLjU1OCAgX19faXBpcGVfdW5zdGFsbF9y
b290KzB4MWEgKF9fX3NjaGVkX3RleHRfc3RhcnQrMHgzY2UpCjp8ICAgK2VuZCAgICAgMHg4MDAw
MDAwMCAgLTM4NSsgICAxLjQ3MiAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4NTggKF9fX3NjaGVk
X3RleHRfc3RhcnQrMHgzY2UpCjogICAgK2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwg
MHgwMDAwODAwMAogLTM4MysgICAxLjQwMCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsw
eGUgKF9fX3NjaGVkX3RleHRfc3RhcnQrMHgzZDgpCjp8ICAgK2JlZ2luICAgMHg4MDAwMDAwMSAg
LTM4MisgICAxLjUzMCAgX19faXBpcGVfdGVzdF9hbmRfc3RhbGxfcm9vdCsweDIyIChfX19zY2hl
ZF90ZXh0X3N0YXJ0KzB4M2Q4KQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0zODArICAgMS40
NzAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgzNiAoX19fc2NoZWRfdGV4dF9zdGFy
dCsweDNkOCkKOiAgICAjZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAw
CiAtMzc5KyAgIDEuMzAwICBfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHhhIChfX19zY2hlZF90ZXh0
X3N0YXJ0KzB4NGVjKQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAw
MDgwMDAKIC0zNzgrICAgMS4wNDAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDggKF9fX2lwaXBl
X3Jlc3RvcmVfcm9vdCsweDFhKQo6ICAgICNiZWdpbiAgIDB4ODAwMDAwMDAgIC0zNzcrICAgMS42
NzAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDFhIChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgx
YSkKOnwgICArZW5kICAgICAweDgwMDAwMDAwICAtMzc1ISAgMTkuNTU4ICBfX19pcGlwZV91bnN0
YWxsX3Jvb3QrMHg1OCAoX19faXBpcGVfcmVzdG9yZV9yb290KzB4MWEpCjogICAgK2Z1bmMgICAg
MHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTM1NSsgICAxLjcyMiAgX19faXBp
cGVfc3lzY2FsbF9yb290KzB4MTQgKF9zeXN0ZW1fY2FsbCsweDJlKQo6ICAgICtmdW5jICAgIDB4
MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zNTQrICAgMS4yOTAgIF9fX2lwaXBl
X2Rpc3BhdGNoX2V2ZW50KzB4YSAoX19faXBpcGVfc3lzY2FsbF9yb290KzB4NDApCjp8ICAgK2Jl
Z2luICAgMHg4MDAwMDAwMSAgLTM1MisgICAyLjEwMCAgX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQr
MHgyMCAoX19faXBpcGVfc3lzY2FsbF9yb290KzB4NDApCjp8ICArIGVuZCAgICAgMHg4MDAwMDAw
MCAgLTM1MCsgICAxLjk1MCAgX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHhjYyAoX19faXBpcGVf
c3lzY2FsbF9yb290KzB4NDApCjogICArIGZ1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwg
MHgwMDAwODAwMAogLTM0OCsgICAxLjg2MCAgX2hpc3lzY2FsbF9ldmVudCsweDEwIChfX19pcGlw
ZV9kaXNwYXRjaF9ldmVudCsweGUyKQo6ICAgKyBmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAw
MDAsIDB4MDAwMDgwMDAKIC0zNDYrICAgMS45MDAgIF94bnBvZF9zY2hlZHVsZSsweGEgKF9oaXN5
c2NhbGxfZXZlbnQrMHhiZSkKOnwgICsgYmVnaW4gICAweDgwMDAwMDAxICAtMzQ1KyAgIDEuNjUw
ICBfeG5wb2Rfc2NoZWR1bGUrMHg2NCAoX2hpc3lzY2FsbF9ldmVudCsweGJlKQo6fCAgKyBlbmQg
ICAgIDB4ODAwMDAwMDAgIC0zNDMrICAgMS4xNTggIF94bnBvZF9zY2hlZHVsZSsweDcyIChfaGlz
eXNjYWxsX2V2ZW50KzB4YmUpCjp8ICArIGJlZ2luICAgMHg4MDAwMDAwMSAgLTM0MisgICAxLjc0
MiAgX3hucG9kX3NjaGVkdWxlKzB4YzQgKF9oaXN5c2NhbGxfZXZlbnQrMHhiZSkKOnwgICMgWyAg
ICAwXSBzd2FwcGVyICAwICAtMzQwKyAgIDEuODQwICBfeG5wb2Rfc2NoZWR1bGUrMHgxMDQgKF9o
aXN5c2NhbGxfZXZlbnQrMHhiZSkKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAw
LCAweDAwMDA4MDAwCiAtMzM4KyAgIDEuMzEwICBfX19pcGlwZV9yZXN0b3JlX3BpcGVsaW5lX2hl
YWQrMHhhIChfeG5wb2Rfc2NoZWR1bGUrMHgyYjApCjp8ICArIGVuZCAgICAgMHg4MDAwMDAwMCAg
LTMzNysgICAzLjQyMCAgX19faXBpcGVfcmVzdG9yZV9waXBlbGluZV9oZWFkKzB4OTQgKF94bnBv
ZF9zY2hlZHVsZSsweDJiMCkKOnwgICsgYmVnaW4gICAweDgwMDAwMDAxICAtMzMzKyAgIDEuNTYw
ICBfX19pcGlwZV9kaXNwYXRjaF9ldmVudCsweGZhIChfX19pcGlwZV9zeXNjYWxsX3Jvb3QrMHg0
MCkKOnwgICArZW5kICAgICAweDgwMDAwMDAwICAtMzMyKyAgIDEuOTUwICBfX19pcGlwZV9kaXNw
YXRjaF9ldmVudCsweGNjIChfX19pcGlwZV9zeXNjYWxsX3Jvb3QrMHg0MCkKOiAgICArZnVuYyAg
ICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMzMwKyAgIDIuNjEwICBfbG9z
eXNjYWxsX2V2ZW50KzB4MTQgKF9fX2lwaXBlX2Rpc3BhdGNoX2V2ZW50KzB4ZTIpCjogICAgK2Z1
bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTMyNysgICAxLjg4OCAg
X3N5c19ydGRtX2lvY3RsKzB4YSAoX2xvc3lzY2FsbF9ldmVudCsweDk0KQo6ICAgICtmdW5jICAg
IDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zMjUrICAgMi4xMjIgIF9fcnRk
bV9pb2N0bCsweGEgKF9zeXNfcnRkbV9pb2N0bCsweDFjKQo6ICAgICtmdW5jICAgIDB4MDAwMGZm
ZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zMjMrICAgMS40MjAgIF9ydGRtX2NvbnRleHRf
Z2V0KzB4MTAgKF9fcnRkbV9pb2N0bCsweDIwKQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0z
MjIrICAgMi43NjAgIF9ydGRtX2NvbnRleHRfZ2V0KzB4MjQgKF9fcnRkbV9pb2N0bCsweDIwKQo6
fCAgKitmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zMTkrICAg
MS45MjAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfcnRkbV9jb250ZXh0X2dl
dCsweDU4KQo6fCAgKiNmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAK
IC0zMTcrICAgMS40MTAgIF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweGEgKF9ydGRtX2NvbnRleHRf
Z2V0KzB4NmUpCjp8ICAqI2Z1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAw
MAogLTMxNisgICAxLjEzMCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAoX19faXBpcGVfcmVz
dG9yZV9yb290KzB4MWEpCjp8ICAqK2VuZCAgICAgMHg4MDAwMDAwMCAgLTMxNSsgICAxLjY4MCAg
X19faXBpcGVfdW5zdGFsbF9yb290KzB4NTggKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDFhKQo6
ICAgKitmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zMTMrICAg
MS4wODggIF9fX2lwaXBlX3Jlc3RvcmVfcGlwZWxpbmVfaGVhZCsweGEgKF9ydGRtX2NvbnRleHRf
Z2V0KzB4ODIpCjp8ICAqK2JlZ2luICAgMHg4MDAwMDAwMSAgLTMxMisgICAxLjU0MiAgX19faXBp
cGVfcmVzdG9yZV9waXBlbGluZV9oZWFkKzB4MWUgKF9ydGRtX2NvbnRleHRfZ2V0KzB4ODIpCjp8
ICAgK2VuZCAgICAgMHg4MDAwMDAwMCAgLTMxMCsgICAzLjM1MCAgX19faXBpcGVfcmVzdG9yZV9w
aXBlbGluZV9oZWFkKzB4OTQgKF9ydGRtX2NvbnRleHRfZ2V0KzB4ODIpCjogICAgK2Z1bmMgICAg
MHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTMwNysgICAxLjk2MCAgX3J0X3Rt
YmVuY2hfaW9jdGxfbnJ0KzB4MTYgKF9fcnRkbV9pb2N0bCsweDRhKQo6ICAgICtmdW5jICAgIDB4
MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0zMDUgICAgMC45NzAgIF9fX2lwaXBl
X3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHhlIChfX3J0ZG1faW9jdGwrMHg1MCkKOnwgICArYmVnaW4g
ICAweDgwMDAwMDAxICAtMzA0KyAgIDEuNDMwICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290
KzB4MjIgKF9fcnRkbV9pb2N0bCsweDUwKQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0zMDMr
ICAgMy4wMDAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgzNiAoX19ydGRtX2lvY3Rs
KzB4NTApCgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KOnwgICAj
ZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAtMzAwKyAgIDEuMzQw
ICBfX19pcGlwZV9ncmFiX2lycSsweDIyIChfX2NvbW1vbl9pbnRfZW50cnkrMHg3MikKOnwgICAj
YmVnaW4gICAweDAwMDAwMDA2ICAtMjk4KyAgIDIuNDg4ICBfX19pcGlwZV9ncmFiX2lycSsweDM0
IChfX2NvbW1vbl9pbnRfZW50cnkrMHg3MikKOnwgICAjZnVuYyAgICAweDAwMDAwMDFmLCAweDAw
MDAwMDAwLCAweDAwMDA4MDQwCiAtMjk2KyAgIDEuNjQyICBfX19pcGlwZV9oYW5kbGVfaXJxKzB4
MWUgKF9fX2lwaXBlX2dyYWJfaXJxKzB4M2MpCjp8ICAgI2Z1bmMgICAgMHgwMDAwMDAxZiwgMHgw
MDAwMDAwMCwgMHgwMDAwODA0MAogLTI5NCsgICAxLjgzMCAgX3J0aGFsX3RpbWVyX2FjaysweDgg
KF9fX2lwaXBlX2hhbmRsZV9pcnErMHgxNzgpCjp8ICAgI2Z1bmMgICAgMHgwMDAwMDAxZiwgMHgw
MDAwMDAwMCwgMHgwMDAwODA0MAogLTI5MisgICAyLjM0MCAgX19faXBpcGVfZGlzcGF0Y2hfd2ly
ZWQrMHgxNCAoX19faXBpcGVfaGFuZGxlX2lycSsweDE5MCkKOnwgICMqZnVuYyAgICAweDAwMDAw
MDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAtMjkwKyAgIDEuNTcwICBfeG5pbnRyX2Nsb2Nr
X2hhbmRsZXIrMHgxMCAoX19faXBpcGVfZGlzcGF0Y2hfd2lyZWQrMHhiNikKOnwgICMqZnVuYyAg
ICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAtMjg4KyAgIDEuNTQwICBfeG5p
bnRyX2lycV9oYW5kbGVyKzB4MTggKF94bmludHJfY2xvY2tfaGFuZGxlcisweDE4KQo6fCAgIypm
dW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKIC0yODcrICAgMS40NjAg
IF94bnBvZF9hbm5vdW5jZV90aWNrKzB4YyAoX3huaW50cl9pcnFfaGFuZGxlcisweDJhKQo6fCAg
IypmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKIC0yODUrICAgMi4w
NzAgIF94bnRpbWVyX2RvX3RpY2tfYXBlcmlvZGljKzB4MTQgKF94bnBvZF9hbm5vdW5jZV90aWNr
KzB4MTYpCjp8ICAjKmZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODA0MAog
LTI4MysgICAxLjg1OCAgX3RpbWVyX3Byb2MrMHhjIChfeG50aW1lcl9kb190aWNrX2FwZXJpb2Rp
YysweDFiMikKOnwgICMqZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQw
CiAtMjgyKyAgIDIuMDYyICBfeG5wb2RfZ2V0X3RpbWUrMHhhIChfdGltZXJfcHJvYysweDEwKQo6
fCAgIypmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKIC0yNzkrICAg
Mi4wMTAgIF9fX211bGRpMysweGMgKF94bnBvZF9nZXRfdGltZSsweDUyKQo6fCAgIypmdW5jICAg
IDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKIC0yNzcrICAgMi4xMzAgIF9fX211
bGRpMysweGMgKF94bnBvZF9nZXRfdGltZSsweDZlKQo6fCAgIypmdW5jICAgIDB4MDAwMDAwMWYs
IDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKIC0yNzUrICAgNC4wNzAgIF9fX2RpdjY0XzMyKzB4MTAg
KF94bnBvZF9nZXRfdGltZSsweDFmMCkKOnwgICMqZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAw
MDAwLCAweDAwMDA4MDQwCiAtMjcxKyAgIDYuMDIwICBfX19kaXY2NF8zMisweDEwIChfeG5wb2Rf
Z2V0X3RpbWUrMHgxZTQpCjp8ICAjKmZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgw
MDAwODA0MAogLTI2NSsgICAxLjk0MCAgX2V2YWxfaW5uZXJfbG9vcCsweGUgKF90aW1lcl9wcm9j
KzB4MjQpCjp8ICAjKmZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODA0MAog
LTI2MysgICAxLjY0MCAgX3hucG9kX2dldF90aW1lKzB4YSAoX3RpbWVyX3Byb2MrMHgyYSkKOnwg
ICMqZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAtMjYyKyAgIDEu
NTg4ICBfX19tdWxkaTMrMHhjIChfeG5wb2RfZ2V0X3RpbWUrMHg1MikKOnwgICMqZnVuYyAgICAw
eDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAtMjYwKyAgIDEuNjYyICBfX19tdWxk
aTMrMHhjIChfeG5wb2RfZ2V0X3RpbWUrMHg2ZSkKOnwgICMqZnVuYyAgICAweDAwMDAwMDFmLCAw
eDAwMDAwMDAwLCAweDAwMDA4MDQwCiAtMjU4KyAgIDMuMTEwICBfX19kaXY2NF8zMisweDEwIChf
eG5wb2RfZ2V0X3RpbWUrMHgxZjApCjp8ICAjKmZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAw
MCwgMHgwMDAwODA0MAogLTI1NSsgICA1LjM3MCAgX19fZGl2NjRfMzIrMHgxMCAoX3hucG9kX2dl
dF90aW1lKzB4MWU0KQo6fCAgIypiZWdpbiAgIDB4MDAwMjI3YWUgIC0yNTArICAgMS41MDAgIF90
aW1lcl9wcm9jKzB4NDQgKF94bnRpbWVyX2RvX3RpY2tfYXBlcmlvZGljKzB4MWIyKQo6fCAgIypm
dW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKIC0yNDgrICAgMS41OTAg
IF94bnRpbWVyX3N0YXJ0KzB4YSAoX3RpbWVyX3Byb2MrMHg3NCkKOnwgICMqZnVuYyAgICAweDAw
MDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAtMjQ3KyAgIDIuMTIwICBfeG50aW1lcl9k
b19zdGFydF9hcGVyaW9kaWMrMHhhIChfeG50aW1lcl9zdGFydCsweDYyKQo6fCAgIypmdW5jICAg
IDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKIC0yNDUrICAgMS42NjAgIF9fX211
bGRpMysweGMgKF94bnRpbWVyX2RvX3N0YXJ0X2FwZXJpb2RpYysweGQ2KQo6fCAgIypmdW5jICAg
IDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKIC0yNDMrICAgMS45MDggIF9fX211
bGRpMysweGMgKF94bnRpbWVyX2RvX3N0YXJ0X2FwZXJpb2RpYysweGVlKQo6fCAgIypmdW5jICAg
IDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwNDAKIC0yNDErICAgNC4yMTIgIF9fX2Rp
djY0XzMyKzB4MTAgKF94bnRpbWVyX2RvX3N0YXJ0X2FwZXJpb2RpYysweDVhZSkKOnwgICMqZnVu
YyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDQwCiAtMjM3KyAgIDEuODMwICBf
X19tdWxkaTMrMHhjIChfeG50aW1lcl9kb19zdGFydF9hcGVyaW9kaWMrMHgxYmMpCjp8ICAjKmZ1
bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODA0MAogLTIzNSsgICA2Ljc1MCAg
X19fbXVsZGkzKzB4YyAoX3hudGltZXJfZG9fc3RhcnRfYXBlcmlvZGljKzB4MWQwKQo6fCAgIypm
dW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yMjgrICAgMi4zMzAg
IF94bnBvZF9zY2hlZHVsZV9kZWZlcnJlZCsweGMgKF9fX2lwaXBlX2NhbGxfaXJxdGFpbCsweDFl
KQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMGMwMDAKIC0yMjYr
ICAgMS40NjAgIF9fX2lwaXBlX3dhbGtfcGlwZWxpbmUrMHgxOCAoX19faXBpcGVfaGFuZGxlX2ly
cSsweDEyNikKOiAgICAjZW5kICAgICAweDAwMDAwMDA2ICAtMjI1KyAgIDEuOTUwICBfX19pcGlw
ZV9ncmFiX2lycSsweDQyIChfX2NvbW1vbl9pbnRfZW50cnkrMHg3MikKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAw
MDAwMCwgMHgwMDAwODAwMAogLTIyMysgICAxLjM5MCAgX19faXBpcGVfcmVzdG9yZV9yb290KzB4
YSAoX19ydGRtX2lvY3RsKzB4NjQpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAw
MCwgMHgwMDAwODAwMAogLTIyMSsgICAxLjEzOCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAo
X19faXBpcGVfcmVzdG9yZV9yb290KzB4MWEpCjogICAgI2JlZ2luICAgMHg4MDAwMDAwMCAgLTIy
MCsgICAxLjU0MiAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4MWEgKF9fX2lwaXBlX3Jlc3RvcmVf
cm9vdCsweDFhKQo6fCAgICtlbmQgICAgIDB4ODAwMDAwMDAgIC0yMTkrICAgMi43MTAgIF9fX2lw
aXBlX3Vuc3RhbGxfcm9vdCsweDU4IChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOiAgICAr
ZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMjE2KyAgIDEuOTcw
ICBfeG5zaGFkb3dfaGFyZGVuKzB4MTIgKF9sb3N5c2NhbGxfZXZlbnQrMHhiMikKOiAgICArZnVu
YyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMjE0ICAgIDAuOTcwICBf
X19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4ZSAoX3huc2hhZG93X2hhcmRlbisweDNlKQo6
fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0yMTMrICAgMS41NzAgIF9fX2lwaXBlX3Rlc3RfYW5k
X3N0YWxsX3Jvb3QrMHgyMiAoX3huc2hhZG93X2hhcmRlbisweDNlKQo6fCAgICNlbmQgICAgIDB4
ODAwMDAwMDAgIC0yMTErICAgMS43MzAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgz
NiAoX3huc2hhZG93X2hhcmRlbisweDNlKQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAw
MDAwMDAsIDB4MDAwMDgwMDAKIC0yMTArICAgMS4zOTAgIF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsw
eGEgKF94bnNoYWRvd19oYXJkZW4rMHg1NikKOiAgICAjZnVuYyAgICAweDAwMDBmZmZmLCAweDAw
MDAwMDAwLCAweDAwMDA4MDAwCiAtMjA4KyAgIDEuMDg4ICBfX19pcGlwZV91bnN0YWxsX3Jvb3Qr
MHg4IChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOiAgICAjYmVnaW4gICAweDgwMDAwMDAw
ICAtMjA3KyAgIDEuNTQyICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHgxYSAoX19faXBpcGVfcmVz
dG9yZV9yb290KzB4MWEpCjp8ICAgK2VuZCAgICAgMHg4MDAwMDAwMCAgLTIwNisgICAxLjYwMCAg
X19faXBpcGVfdW5zdGFsbF9yb290KzB4NTggKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDFhKQo6
fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0yMDQrICAgMS43MzAgIF94bnNoYWRvd19oYXJkZW4r
MHg3NiAoX2xvc3lzY2FsbF9ldmVudCsweGIyKQo6fCAgICtlbmQgICAgIDB4ODAwMDAwMDAgIC0y
MDIrICAgMS44OTAgIF94bnNoYWRvd19oYXJkZW4rMHg4YyAoX2xvc3lzY2FsbF9ldmVudCsweGIy
KQo6ICAgICtmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0yMDAr
ICAgMS40OTAgIF9fX3dha2VfdXBfc3luYysweGMgKF94bnNoYWRvd19oYXJkZW4rMHhhNCkKOiAg
ICArZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTk5KyAgIDEu
MDQwICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4ZSAoX19fd2FrZV91cF9zeW5jKzB4
MTgpCjp8ICAgK2JlZ2luICAgMHg4MDAwMDAwMSAgLTE5OCsgICAxLjUzMCAgX19faXBpcGVfdGVz
dF9hbmRfc3RhbGxfcm9vdCsweDIyIChfX193YWtlX3VwX3N5bmMrMHgxOCkKOnwgICAjZW5kICAg
ICAweDgwMDAwMDAwICAtMTk2KyAgIDIuMDM4ICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290
KzB4MzYgKF9fX3dha2VfdXBfc3luYysweDE4KQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4
MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0xOTQrICAgMi4wODIgIF9fX3dha2VfdXBfY29tbW9uKzB4
YyAoX19fd2FrZV91cF9zeW5jKzB4MzgpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAw
MDAwMCwgMHgwMDAwODAwMAogLTE5MisgICAxLjg4MCAgX2RlZmF1bHRfd2FrZV9mdW5jdGlvbisw
eGEgKF9fX3dha2VfdXBfY29tbW9uKzB4MzgpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgw
MDAwMDAwMCwgMHgwMDAwODAwMAogLTE5MCsgICAxLjU0MCAgX3RyeV90b193YWtlX3VwKzB4YSAo
X2RlZmF1bHRfd2FrZV9mdW5jdGlvbisweDEwKQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4
MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0xODkrICAgMS4wMTAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0
YWxsX3Jvb3QrMHhlIChfdHJ5X3RvX3dha2VfdXArMHgxNCkKOnwgICAjYmVnaW4gICAweDgwMDAw
MDAxICAtMTg4KyAgIDEuNDYwICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4MjIgKF90
cnlfdG9fd2FrZV91cCsweDE0KQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0xODYrICAgMS44
NDAgIF9fX2lwaXBlX3Rlc3RfYW5kX3N0YWxsX3Jvb3QrMHgzNiAoX3RyeV90b193YWtlX3VwKzB4
MTQpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTE4
NCsgICAxLjY2MCAgX3NjaGVkX2Nsb2NrKzB4YyAoX3RyeV90b193YWtlX3VwKzB4N2UpCjogICAg
I2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTE4MysgICAyLjYx
OCAgX19fbXVsZGkzKzB4YyAoX3NjaGVkX2Nsb2NrKzB4MjYpCjogICAgI2Z1bmMgICAgMHgwMDAw
ZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTE4MCsgICAzLjIyMiAgX2VucXVldWVfdGFz
aysweGUgKF90cnlfdG9fd2FrZV91cCsweGQyKQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4
MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0xNzcrICAgMS42MjAgIF9fX2lwaXBlX3Jlc3RvcmVfcm9v
dCsweGEgKF90cnlfdG9fd2FrZV91cCsweDNjKQo6ICAgICNmdW5jICAgIDB4MDAwMGZmZmYsIDB4
MDAwMDAwMDAsIDB4MDAwMDgwMDAKIC0xNzUrICAgMS4wODAgIF9fX2lwaXBlX3N0YWxsX3Jvb3Qr
MHhlIChfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHgxMCkKOnwgICAjYmVnaW4gICAweDgwMDAwMDAx
ICAtMTc0KyAgIDEuNjIwICBfX19pcGlwZV9zdGFsbF9yb290KzB4MjIgKF9fX2lwaXBlX3Jlc3Rv
cmVfcm9vdCsweDEwKQo6fCAgICNlbmQgICAgIDB4ODAwMDAwMDAgIC0xNzMrICAgMS41MzAgIF9f
X2lwaXBlX3N0YWxsX3Jvb3QrMHgzMCAoX19faXBpcGVfcmVzdG9yZV9yb290KzB4MTApCjogICAg
I2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTE3MSsgICAxLjM1
MCAgX19faXBpcGVfcmVzdG9yZV9yb290KzB4YSAoX19fd2FrZV91cF9zeW5jKzB4M2UpCjogICAg
I2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTE3MCsgICAxLjA4
MCAgX19faXBpcGVfdW5zdGFsbF9yb290KzB4OCAoX19faXBpcGVfcmVzdG9yZV9yb290KzB4MWEp
CjogICAgI2JlZ2luICAgMHg4MDAwMDAwMCAgLTE2OSsgICAxLjU1OCAgX19faXBpcGVfdW5zdGFs
bF9yb290KzB4MWEgKF9fX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDFhKQo6fCAgICtlbmQgICAgIDB4
ODAwMDAwMDAgIC0xNjcrICAgMS41OTIgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDU4IChfX19p
cGlwZV9yZXN0b3JlX3Jvb3QrMHgxYSkKOiAgICArZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAw
MDAwLCAweDAwMDA4MDAwCiAtMTY2KyAgIDIuMDEwICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4ZSAo
X3huc2hhZG93X2hhcmRlbisweGE4KQo6ICAgICtmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAwMDAw
MDAsIDB4MDAwMDgwMDAKIC0xNjMrICAgMS45MTAgIF9wcm9maWxlX2hpdCsweGUgKF9fX3NjaGVk
X3RleHRfc3RhcnQrMHg0YykKOiAgICArZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAw
eDAwMDA4MDAwCiAtMTYyKyAgIDEuMzkwICBfc2NoZWRfY2xvY2srMHhjIChfX19zY2hlZF90ZXh0
X3N0YXJ0KzB4N2MpCjogICAgK2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAw
ODAwMAogLTE2MCsgICAzLjAzMCAgX19fbXVsZGkzKzB4YyAoX3NjaGVkX2Nsb2NrKzB4MjYpCjog
ICAgK2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogLTE1NysgICAx
LjAyMCAgX19faXBpcGVfc3RhbGxfcm9vdCsweGUgKF9fX3NjaGVkX3RleHRfc3RhcnQrMHhlYykK
OnwgICArYmVnaW4gICAweDgwMDAwMDAxICAtMTU2KyAgIDEuNTMwICBfX19pcGlwZV9zdGFsbF9y
b290KzB4MjIgKF9fX3NjaGVkX3RleHRfc3RhcnQrMHhlYykKOnwgICAjZW5kICAgICAweDgwMDAw
MDAwICAtMTU1KyAgIDEuNTc4ICBfX19pcGlwZV9zdGFsbF9yb290KzB4MzAgKF9fX3NjaGVkX3Rl
eHRfc3RhcnQrMHhlYykKOiAgICAjZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAw
MDA4MDAwCiAtMTUzKyAgIDEuNjYyICBfZGVhY3RpdmF0ZV90YXNrKzB4ZSAoX19fc2NoZWRfdGV4
dF9zdGFydCsweDQ2NCkKOiAgICAjZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAw
MDA4MDAwCiAtMTUxKyAgIDMuMzYwICBfZGVxdWV1ZV90YXNrKzB4ZSAoX2RlYWN0aXZhdGVfdGFz
aysweDFjKQo6fCAgICNiZWdpbiAgIDB4ODAwMDAwMDEgIC0xNDgrICAgMS43NTAgIF9fX3NjaGVk
X3RleHRfc3RhcnQrMHgxZTYgKF94bnNoYWRvd19oYXJkZW4rMHhhOCkKOnwgICAjZW5kICAgICAw
eDgwMDAwMDAwICAtMTQ2KyAgIDQuNDAwICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MWY0IChfeG5z
aGFkb3dfaGFyZGVuKzB4YTgpCjogICAgI2Z1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwg
MHgwMDAwODAwMAogLTE0MisgICAxLjAyMCAgX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHhhIChf
X19zY2hlZF90ZXh0X3N0YXJ0KzB4MmRlKQo6fCAgICNiZWdpbiAgIDB4ODAwMDAwMDEgIC0xNDEr
ICAgMS43MzAgIF9fX2lwaXBlX2Rpc3BhdGNoX2V2ZW50KzB4MjAgKF9fX3NjaGVkX3RleHRfc3Rh
cnQrMHgyZGUpCjp8ICAgI2VuZCAgICAgMHg4MDAwMDAwMCAgLTEzOSsgICAxLjc0MCAgX19faXBp
cGVfZGlzcGF0Y2hfZXZlbnQrMHhjYyAoX19fc2NoZWRfdGV4dF9zdGFydCsweDJkZSkKOiAgICAj
ZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTM3KyAgIDEuNTk4
ICBfc2NoZWR1bGVfZXZlbnQrMHgxNiAoX19faXBpcGVfZGlzcGF0Y2hfZXZlbnQrMHhlMikKOnwg
ICAjYmVnaW4gICAweDgwMDAwMDAxICAtMTM2KyAgIDEuNjMyICBfX19pcGlwZV9kaXNwYXRjaF9l
dmVudCsweGZhIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4MmRlKQo6fCAgICNlbmQgICAgIDB4ODAw
MDAwMDAgIC0xMzQrICAgMS4zNzAgIF9fX2lwaXBlX2Rpc3BhdGNoX2V2ZW50KzB4MTdhIChfX19z
Y2hlZF90ZXh0X3N0YXJ0KzB4MmRlKQo6ICAgICNiZWdpbiAgIDB4ODAwMDAwMDAgIC0xMzMrICAg
Mi4zMjAgIF9fX3NjaGVkX3RleHRfc3RhcnQrMHgyZjAgKF94bnNoYWRvd19oYXJkZW4rMHhhOCkK
OnwgICAjZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTMwKyAg
IDEuNjcwICBfX19pcGlwZV90ZXN0X2FuZF9zdGFsbF9yb290KzB4ZSAoX19fc2NoZWRfdGV4dF9z
dGFydCsweDY3OCkKOnwgICAjZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4
MDAwCiAtMTI5KyAgIDEuNDQwICBfX19pcGlwZV9yZXN0b3JlX3Jvb3QrMHhhIChfX19zY2hlZF90
ZXh0X3N0YXJ0KzB4NjhjKQo6fCAgICNmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4
MDAwMDgwMDAKIC0xMjcrICAgMy45MTAgIF9fX2lwaXBlX3N0YWxsX3Jvb3QrMHhlIChfX19pcGlw
ZV9yZXN0b3JlX3Jvb3QrMHgxMCkKOnwgICAjZW5kICAgICAweDgwMDAwMDAwICAtMTIzKyAgIDEu
ODYwICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4NWNhIChfZ2F0ZWtlZXBlcl90aHJlYWQrMHhlOCkK
OiAgICAjZnVuYyAgICAweDAwMDBmZmZmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTIyKyAg
IDEuMDQ4ICBfX19pcGlwZV91bnN0YWxsX3Jvb3QrMHg4IChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4
M2NlKQo6ICAgICNiZWdpbiAgIDB4ODAwMDAwMDAgIC0xMjErICAgMS41MTIgIF9fX2lwaXBlX3Vu
c3RhbGxfcm9vdCsweDFhIChfX19zY2hlZF90ZXh0X3N0YXJ0KzB4M2NlKQo6fCAgICtlbmQgICAg
IDB4ODAwMDAwMDAgIC0xMTkrICAgMi4zNDAgIF9fX2lwaXBlX3Vuc3RhbGxfcm9vdCsweDU4IChf
X19zY2hlZF90ZXh0X3N0YXJ0KzB4M2NlKQo6ICAgICtmdW5jICAgIDB4MDAwMGZmZmYsIDB4MDAw
MDAwMDAsIDB4MDAwMDgwMDAKIC0xMTcrICAgMS42MjAgIF9rdGhyZWFkX3Nob3VsZF9zdG9wKzB4
MTAgKF9nYXRla2VlcGVyX3RocmVhZCsweGVjKQo6fCAgICtiZWdpbiAgIDB4ODAwMDAwMDEgIC0x
MTUrICAgMy4zNzAgIF9nYXRla2VlcGVyX3RocmVhZCsweDEwMCAoX2t0aHJlYWQrMHhmMCkKOnwg
ICorZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAtMTEyKyAgIDIu
MDcwICBfeG5wb2RfcmVzdW1lX3RocmVhZCsweGEgKF9nYXRla2VlcGVyX3RocmVhZCsweDE4NikK
OnwgICorWyAgIDUxXSAtPD8+LSAgICAwICAtMTEwKyAgIDQuOTkwICBfeG5wb2RfcmVzdW1lX3Ro
cmVhZCsweDRhIChfZ2F0ZWtlZXBlcl90aHJlYWQrMHgxODYpCjp8ICAqK2Z1bmMgICAgMHgwMDAw
MDAxZiwgMHgwMDAwMTAwMCwgMHgwMDAwODAwMAogLTEwNSsgICAxLjM3MCAgX3hucG9kX3NjaGVk
dWxlX3J1bm5hYmxlKzB4YyAoX2dhdGVrZWVwZXJfdGhyZWFkKzB4MWJlKQo6fCAgKitbICAgIDBd
IHN3YXBwZXIgLTEgIC0xMDMrICAgMy43MzggIF94bnBvZF9zY2hlZHVsZV9ydW5uYWJsZSsweDI4
IChfZ2F0ZWtlZXBlcl90aHJlYWQrMHgxYmUpCgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Cgo6fCAgKitmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDEwNDAsIDB4MDAwMDgwMDAKIC0x
MDArICAgMi41OTIgIF94bnBvZF9zY2hlZHVsZSsweGEgKF9nYXRla2VlcGVyX3RocmVhZCsweDFj
ZSkKOnwgICorZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAxMDQwLCAweDAwMDA4MDAwCiAgLTk3
KyAgIDMuMDAwICBfaXBpcGVfdHJpZ2dlcl9pcnErMHgxMiAoX3hucG9kX3NjaGVkdWxlKzB4MmU2
KQo6fCAgKitmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDEwNDAsIDB4MDAwMDgwMDAKICAtOTQr
ICAgMS43MTAgIF9fX2lwaXBlX2hhbmRsZV9pcnErMHgxZSAoX2lwaXBlX3RyaWdnZXJfaXJxKzB4
ODYpCjp8ICAqK2Z1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMTA0MCwgMHgwMDAwODAwMAogIC05
MisgICAyLjQ2MCAgX19faXBpcGVfZGlzcGF0Y2hfd2lyZWQrMHgxNCAoX19faXBpcGVfaGFuZGxl
X2lycSsweDE5MCkKOnwgICorZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAxMDQwLCAweDAwMDA4
MDAwCiAgLTkwKyAgIDEuODYwICBfX19pcGlwZV9yZXN0b3JlX3BpcGVsaW5lX2hlYWQrMHhhIChf
Z2F0ZWtlZXBlcl90aHJlYWQrMHgxMzgpCjp8ICAgK2Z1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAw
MTA0MCwgMHgwMDAwODAwMAogIC04OCsgICAxLjk5MCAgX19faXBpcGVfd2Fsa19waXBlbGluZSsw
eDE4IChfX19pcGlwZV9yZXN0b3JlX3BpcGVsaW5lX2hlYWQrMHhkMCkKOnwgICsgZnVuYyAgICAw
eDAwMDAwMDFmLCAweDAwMDAxMDQwLCAweDAwMDA4MDAwCiAgLTg2KyAgIDIuMzAwICBfaXBpcGVf
c3VzcGVuZF9kb21haW4rMHhhIChfX19pcGlwZV93YWxrX3BpcGVsaW5lKzB4YWMpCjp8ICArIGZ1
bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMTA0MCwgMHgwMDAwODAwMAogIC04NCsgICA1LjAxOCAg
X19faXBpcGVfc3luY19zdGFnZSsweGUgKF9pcGlwZV9zdXNwZW5kX2RvbWFpbisweDRlKQo6fCAg
IyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDEwNDAsIDB4MDAwMDgwMDAKICAtNzkrICAgMS45
NDIgIF94bnBvZF9zY2hlZHVsZV9oYW5kbGVyKzB4ZSAoX19faXBpcGVfc3luY19zdGFnZSsweDE4
NikKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAxMDQwLCAweDAwMDA4MDAwCiAgLTc3
KyAgIDIuMzEwICBfeG5wb2Rfc2NoZWR1bGUrMHhhIChfeG5wb2Rfc2NoZWR1bGVfaGFuZGxlcisw
eDVjKQo6fCAgIyBbICAgIDBdIHN3YXBwZXIgLTEgICAtNzQrICAgNi41NjAgIF94bnBvZF9zY2hl
ZHVsZSsweDEwNCAoX3hucG9kX3NjaGVkdWxlX2hhbmRsZXIrMHg1YykKOnwgICMgZW5kICAgICAw
eDgwMDAwMDAwICAgLTY4KyAgIDMuMjUwICBfX19zY2hlZF90ZXh0X3N0YXJ0KzB4NWNhIChfeG5z
aGFkb3dfaGFyZGVuKzB4YTgpCgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KOnwg
ICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAxMDAwLCAweDAwMDA4MDQwCiAgLTY1ICAgIDAu
OTQwICBfX19pcGlwZV9ncmFiX2lycSsweDIyIChfX2NvbW1vbl9pbnRfZW50cnkrMHg3MikKOnwg
ICMgYmVnaW4gICAweDAwMDAwMDA2ICAgLTY0KyAgIDIuMzAwICBfX19pcGlwZV9ncmFiX2lycSsw
eDM0IChfX2NvbW1vbl9pbnRfZW50cnkrMHg3MikKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAw
eDAwMDAxMDAwLCAweDAwMDA4MDQwCiAgLTYxKyAgIDEuNjUwICBfX19pcGlwZV9oYW5kbGVfaXJx
KzB4MWUgKF9fX2lwaXBlX2dyYWJfaXJxKzB4M2MpCjp8ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwg
MHgwMDAwMTAwMCwgMHgwMDAwODA0MAogIC02MCsgICAxLjUwOCAgX3J0aGFsX3RpbWVyX2Fjaysw
eDggKF9fX2lwaXBlX2hhbmRsZV9pcnErMHgxNzgpCjp8ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwg
MHgwMDAwMTAwMCwgMHgwMDAwODA0MAogIC01OCsgICAxLjM4MiAgX19faXBpcGVfZGlzcGF0Y2hf
d2lyZWQrMHgxNCAoX19faXBpcGVfaGFuZGxlX2lycSsweDE5MCkKOnwgICMgZW5kICAgICAweDAw
MDAwMDA2ICAgLTU3KyAgIDMuMDYwICBfX19pcGlwZV9ncmFiX2lycSsweDQyIChfX2NvbW1vbl9p
bnRfZW50cnkrMHg3MikKCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cgo6fCAg
IyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDkwMDAKICAtNTQrICAgMi42
NzAgIF9fX2lwaXBlX2dyYWJfaXJxKzB4MjIgKF9fY29tbW9uX2ludF9lbnRyeSsweDcyKQo6fCAg
IyBiZWdpbiAgIDB4MDAwMDAwMWEgICAtNTErICAgMS45NDAgIF9fX2lwaXBlX2dyYWJfaXJxKzB4
MzQgKF9fY29tbW9uX2ludF9lbnRyeSsweDcyKQo6fCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4
MDAwMDAwMDAsIDB4MDAwMDkwMDAKICAtNDkrICAgMy41NDAgIF9fX2lwaXBlX2hhbmRsZV9pcnEr
MHgxZSAoX19faXBpcGVfZ3JhYl9pcnErMHgzYykKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAw
eDAwMDAwMDAwLCAweDAwMDA5MDAwCiAgLTQ2KyAgIDIuMzEwICBfX19pcGlwZV9hY2tfaXJxKzB4
MTAgKF9fX2lwaXBlX2hhbmRsZV9pcnErMHhlZSkKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAw
eDAwMDAwMDAwLCAweDAwMDA5MDAwCiAgLTQzKyAgIDEuMjQwICBfX19pcGlwZV93YWxrX3BpcGVs
aW5lKzB4MTggKF9fX2lwaXBlX2hhbmRsZV9pcnErMHgxNDgpCjp8ICAjIGVuZCAgICAgMHgwMDAw
MDAxYSAgIC00MisgICAyLjExOCAgX19faXBpcGVfZ3JhYl9pcnErMHg0MiAoX19jb21tb25faW50
X2VudHJ5KzB4NzIpCjogICAjIGZ1bmMgICAgMHgwMDAwZmZmZiwgMHgwMDAwMDAwMCwgMHgwMDAw
ODAwMAogIC00MCsgICAxLjI0MiAgX2lwaXBlX3Vuc3RhbGxfcGlwZWxpbmVfaGVhZCsweDggKF94
bnNoYWRvd19oYXJkZW4rMHhjZSkKOnwgICMgYmVnaW4gICAweDgwMDAwMDAxICAgLTM5KyAgIDIu
ODcwICBfaXBpcGVfdW5zdGFsbF9waXBlbGluZV9oZWFkKzB4MTggKF94bnNoYWRvd19oYXJkZW4r
MHhjZSkKOnwgICsgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAg
LTM2KyAgIDIuMTIwICBfX19pcGlwZV9zeW5jX3N0YWdlKzB4ZSAoX2lwaXBlX3Vuc3RhbGxfcGlw
ZWxpbmVfaGVhZCsweDc0KQoKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQoKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAw
CiAgLTM0KyAgIDEuMzYwICBfeG5pbnRyX2Nsb2NrX2hhbmRsZXIrMHgxMCAoX19faXBpcGVfc3lu
Y19zdGFnZSsweDE4NikKOnwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAw
MDA4MDAwCiAgLTMyKyAgIDEuNzEwICBfeG5pbnRyX2lycV9oYW5kbGVyKzB4MTggKF94bmludHJf
Y2xvY2tfaGFuZGxlcisweDE4KQo6fCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAs
IDB4MDAwMDgwMDAKICAtMzErICAgMS44NzAgIF94bnBvZF9hbm5vdW5jZV90aWNrKzB4YyAoX3hu
aW50cl9pcnFfaGFuZGxlcisweDJhKQo6fCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAw
MDAsIDB4MDAwMDgwMDAKICAtMjkrICAgMi40ODAgIF94bnRpbWVyX2RvX3RpY2tfYXBlcmlvZGlj
KzB4MTQgKF94bnBvZF9hbm5vdW5jZV90aWNrKzB4MTYpCjp8ICAjIGZ1bmMgICAgMHgwMDAwMDAx
ZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogIC0yNisgICAxLjY5OCAgX3RpbWVyX3Byb2MrMHhj
IChfeG50aW1lcl9kb190aWNrX2FwZXJpb2RpYysweDFiMikKOnwgICMgZnVuYyAgICAweDAwMDAw
MDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAgLTI1KyAgIDIuMDQyICBfeG5wb2RfZ2V0X3Rp
bWUrMHhhIChfdGltZXJfcHJvYysweDEwKQo6fCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAw
MDAwMDAsIDB4MDAwMDgwMDAKICAtMjIrICAgMS45OTAgIF9fX211bGRpMysweGMgKF94bnBvZF9n
ZXRfdGltZSsweDUyKQo6fCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAw
MDgwMDAKICAtMjArICAgMi4yMzAgIF9fX211bGRpMysweGMgKF94bnBvZF9nZXRfdGltZSsweDZl
KQo6fCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKICAtMTgr
ICAgNC4xNTAgIF9fX2RpdjY0XzMyKzB4MTAgKF94bnBvZF9nZXRfdGltZSsweDFmMCkKOnwgICMg
ZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAgLTE0KyAgIDYuMTIw
ICBfX19kaXY2NF8zMisweDEwIChfeG5wb2RfZ2V0X3RpbWUrMHgxZTQpCjp8ICAjIGZ1bmMgICAg
MHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogICAtOCsgICAxLjcxMCAgX2V2YWxf
aW5uZXJfbG9vcCsweGUgKF90aW1lcl9wcm9jKzB4MjQpCjp8ICAjIGZ1bmMgICAgMHgwMDAwMDAx
ZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogICAtNisgICAxLjU2MCAgX2lwaXBlX3RyYWNlX2Zy
b3plbl9yZXNldCsweGEgKF9ldmFsX2lubmVyX2xvb3ArMHhlMCkKOnwgICMgZnVuYyAgICAweDAw
MDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAgIC01KyAgIDQuMjE4ICBfX19pcGlwZV9n
bG9iYWxfcGF0aF9sb2NrKzB4YSAoX2lwaXBlX3RyYWNlX2Zyb3plbl9yZXNldCsweGUpCjx8ICAj
IGZyZWV6ZSAgMHgwMDAxN2NlNiAgICAgMSAgICAyLjE4MiAgX2V2YWxfaW5uZXJfbG9vcCsweGU2
IChfdGltZXJfcHJvYysweDI0KQogfCAgIyBmdW5jICAgIDB4MDAwMDAwMWYsIDB4MDAwMDAwMDAs
IDB4MDAwMDgwMDAKICAgIDMgICAgMS44NTAgIF94bnBvZF9nZXRfdGltZSsweGEgKF90aW1lcl9w
cm9jKzB4MmEpCiB8ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAw
MAogICAgNSAgICAxLjYxMCAgX19fbXVsZGkzKzB4YyAoX3hucG9kX2dldF90aW1lKzB4NTIpCiB8
ICAjIGZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogICAgNiAgICAx
LjUzMCAgX19fbXVsZGkzKzB4YyAoX3hucG9kX2dldF90aW1lKzB4NmUpCiB8ICAjIGZ1bmMgICAg
MHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogICAgOCAgICAyLjc0MCAgX19fZGl2
NjRfMzIrMHgxMCAoX3hucG9kX2dldF90aW1lKzB4MWYwKQogfCAgIyBmdW5jICAgIDB4MDAwMDAw
MWYsIDB4MDAwMDAwMDAsIDB4MDAwMDgwMDAKICAgMTAgICAgNS44MzAgIF9fX2RpdjY0XzMyKzB4
MTAgKF94bnBvZF9nZXRfdGltZSsweDFlNCkKIHwgICMgYmVnaW4gICAweDAwMDEyOWVjICAgIDE2
ICAgIDIuMTEwICBfdGltZXJfcHJvYysweDQ0IChfeG50aW1lcl9kb190aWNrX2FwZXJpb2RpYysw
eDFiMikKIHwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAg
IDE4ICAgIDIuMjQ4ICBfeG50aW1lcl9zdGFydCsweGEgKF90aW1lcl9wcm9jKzB4NzQpCiB8ICAj
IGZ1bmMgICAgMHgwMDAwMDAxZiwgMHgwMDAwMDAwMCwgMHgwMDAwODAwMAogICAyMSAgICAyLjcw
MiAgX3hudGltZXJfZG9fc3RhcnRfYXBlcmlvZGljKzB4YSAoX3hudGltZXJfc3RhcnQrMHg2MikK
IHwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAgIDIzICAg
IDEuODAwICBfX19tdWxkaTMrMHhjIChfeG50aW1lcl9kb19zdGFydF9hcGVyaW9kaWMrMHhkNikK
IHwgICMgZnVuYyAgICAweDAwMDAwMDFmLCAweDAwMDAwMDAwLCAweDAwMDA4MDAwCiAgIDI1ICAg
IDAuMDAwICBfX19tdWxkaTMrMHhjIChfeG50aW1lcl9kb19zdGFydF9hcGVyaW9kaWMrMHhlZSkK

------=_Part_106902_15345745.1163412091790--

