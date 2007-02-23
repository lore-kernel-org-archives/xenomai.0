Message-ID: <45DF0833.9080907@domain.hid>
Date: Fri, 23 Feb 2007 16:28:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid> <45DF04F2.4020002@domain.hid>
	<45DF0702.6020400@domain.hid>
In-Reply-To: <45DF0702.6020400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4B3DCCDBA6D44DC4E94B6549"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B3DCCDBA6D44DC4E94B6549
Content-Type: multipart/mixed; boundary="------------000608010308070903010606"

This is a multi-part message in MIME format.
--------------000608010308070903010606
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Steven Scholz wrote:
>> Hi all,
>>
>>
>>> I am running 2.6.19 + adeos-ipipe-2.6.19-arm-1.6-02.patch + xenomai-s=
vn-2007-02-22
>>> on an AT91RM9200 (160MHz/80MHz).
>>>
>>> When starting "latency -p 200" it runs for a while printing
>>>
>>> RTT|  00:05:37  (periodic user-mode task, 200 us period, priority 99)=

>>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---l=
at worst
>>> RTD|      11.200|     139.200|     236.800|       1|      10.800|    =
 280.800
>>> RTD|      11.200|     146.400|     253.200|       1|      10.800|    =
 280.800
>>> RTD|      11.200|     144.400|     240.400|       1|      10.800|    =
 280.800
>>>
>>> but then hangs. The timer LED stops blinking. No "soft lockup detecte=
d" appears.
>>
>> After patching kernel/sched.c
>>
>>  #ifdef CONFIG_IPIPE
>> -       if (unlikely(!ipipe_root_domain_p))
>> -               return;
>> +       if (unlikely(!ipipe_root_domain_p)) {
>> +               ipipe_set_printk_sync(ipipe_current_domain);
>> +               ipipe_trace_panic_freeze();
>> +               ipipe_trace_panic_dump();
>> +               BUG();
>> +       }
>>  #endif /* CONFIG_IPIPE */
>>
>> ~ # cat /dev/zero > /dev/null &
>> ~ # latency -p 400
>> =3D=3D Sampling period: 400 us
>> =3D=3D Test mode: periodic user-mode task
>> =3D=3D All results in microseconds
>> warming up...
>> RTT|  00:00:01  (periodic user-mode task, 400 us period, priority 99)
>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---la=
t worst
>> RTD|     146.000|     187.200|     258.000|       0|     146.000|     =
258.000
>> ...
>> RTD|      72.400|     188.800|    3793.600|      97|      68.800|    4=
746.800
>> RTD|      70.800|     188.800|    3256.400|     107|      68.800|    4=
746.800
>> I-pipe tracer log (30 points):
>> func                    0 ipipe_trace_panic_freeze+0x10 (schedule+0x54=
)
>> func                   -2 schedule+0x14 (ret_slow_syscall+0x0)
>> func                   -6 __ipipe_walk_pipeline+0x10 (__ipipe_handle_i=
rq+0x190)
>> [  183] display- 0    -11 xnpod_schedule+0x60c (xnintr_irq_handler+0x1=
28)
>> [  184] samplin 99    -14 xnpod_schedule+0xb4 (xnpod_suspend_thread+0x=
178)
>> func                  -16 xnpod_schedule+0x14 (xnpod_suspend_thread+0x=
178)
>> func                  -18 xnpod_suspend_thread+0x14 (xnpod_wait_thread=
_period+0xb0)
>> func                  -21 xnpod_wait_thread_period+0x14 (rt_task_wait_=
period+0x4c)
>> func                  -23 rt_task_wait_period+0x10 (__rt_task_wait_per=
iod+0x54)
>> func                  -25 __rt_task_wait_period+0x14 (hisyscall_event+=
0x160)
>> func                  -27 hisyscall_event+0x14 (__ipipe_dispatch_event=
+0xc0)
>> func                  -29 __ipipe_dispatch_event+0x14 (__ipipe_syscall=
_root+0x88)
>> func                  -31 __ipipe_syscall_root+0x10 (vector_swi+0x68)
>> func                  -35 rt_timer_tsc+0x10 (__rt_timer_tsc+0x1c)
>> func                  -36 __rt_timer_tsc+0x14 (hisyscall_event+0x160)
>> func                  -39 hisyscall_event+0x14 (__ipipe_dispatch_event=
+0xc0)
>> func                  -40 __ipipe_dispatch_event+0x14 (__ipipe_syscall=
_root+0x88)
>> func                  -42 __ipipe_syscall_root+0x10 (vector_swi+0x68)
>> func                  -46 __ipipe_restore_pipeline_head+0x10 (xnpod_wa=
it_thread_period+0x1b4)
>> [  184] samplin 99    -49 xnpod_schedule+0x60c (xnpod_suspend_thread+0=
x178)
>> [  183] display- 0    -53 xnpod_schedule+0xb4 (xnintr_irq_handler+0x12=
8)
>> func                  -55 xnpod_schedule+0x14 (xnintr_irq_handler+0x12=
8)
>> func                  -60 __ipipe_mach_set_dec+0x10 (xntimer_tick_aper=
iodic+0x2fc)
>> [  184] samplin 99    -69 xnpod_resume_thread+0x5c (xnthread_periodic_=
handler+0x30)
>> func                  -71 xnpod_resume_thread+0x10 (xnthread_periodic_=
handler+0x30)
>> func                  -73 xnthread_periodic_handler+0x10 (xntimer_tick=
_aperiodic+0xcc)
>> func                  -77 xntimer_tick_aperiodic+0x14 (xnpod_announce_=
tick+0x14)
>> func                  -79 xnpod_announce_tick+0x10 (xnintr_irq_handler=
+0x54)
>> func                  -82 xnintr_irq_handler+0x14 (xnintr_clock_handle=
r+0x20)
>> func                  -84 xnintr_clock_handler+0x10 (__ipipe_dispatch_=
wired+0xe4)
>> kernel BUG at kernel/sched.c:3337!
>> Unable to handle kernel NULL pointer dereference at virtual address 00=
000000
>> pgd =3D c1a44000
>> [00000000] *pgd=3D21a1a031, *pte=3D00000000, *ppte=3D00000000
>> Internal error: Oops: 817 [#1]
>> Modules linked in:
>> CPU: 0
>> PC is at __bug+0x44/0x58
>> LR is at __ipipe_sync_stage+0x10/0x294
>> pc : [<c001ed08>]    lr : [<c0051414>]    Not tainted
>> sp : c1e8ff64  ip : 00000000  fp : c1e8ff74
>> r10: 003a5b10  r9 : c1e8e000  r8 : 00000000
>> r7 : 33333333  r6 : 00000000  r5 : c01ba860  r4 : 00000000
>> r3 : 00000000  r2 : c01ba880  r1 : 00000000  r0 : 00000001
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
>> Control: C000717F
>> Table: 21A44000  DAC: 00000015
>> Process display-181 (pid: 183, stack limit =3D 0xc1e8e250)
>> Stack: (0xc1e8ff64 to 0xc1e90000)
>> ff60:          ffffffff c1e8ffac c1e8ff78 c0181588 c001ecd4 c1e8ff84 c=
0020340
>> ff80: c002007c ffffffff fefff000 00000000 33333333 00000000 c1e8e000 0=
03a5b10
>> ffa0: 00000000 c1e8ffb0 c001ae04 c0181530 0011b333 33000000 07d00000 0=
0000000
>> ffc0: 20280000 03200000 00000000 33333333 0000b714 0002e180 003a5b10 0=
0011490
>> ffe0: 00800000 be7ffa4c fb500000 0000ace0 80000010 ffffffff d1208a16 0=
10582a6
>> Backtrace:
>> [<c001ecc4>] (__bug+0x0/0x58) from [<c0181588>] (schedule+0x68/0x86c)
>>  r4 =3D FFFFFFFF
>> [<c0181520>] (schedule+0x0/0x86c) from [<c001ae04>] (ret_slow_syscall+=
0x0/0x10)
>> Code: 1b0048fa e59f0014 eb0048f8 e3a03000 (e5833000)
>>
>>
>> Hope this helps!!!
>=20
> A litte more effort: could you set /proc/ipipe/trace/back_trace_points
> to a huge value like 16000 points.
>=20

But compress before submit...

The attached patch may help to increase the information of the trace.

Jan

--------------000608010308070903010606
Content-Type: message/rfc822;
 name="Nachricht als Anhang"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Nachricht als Anhang"

Received: from [88.191.250.45] (helo=gna.org)
	by mx28.web.de with esmtp (WEB.DE 4.107 #114) id 1HKbck-0006k3-00
	for jan.kiszka@domain.hid; Fri, 23 Feb 2007 15:42:14 +0100
Received: from localhost ([127.0.0.1] helo=bart.gna.org)
	by gna.org with esmtp (Exim 4.50)
	id 1HKbdC-0003zk-Ba; Fri, 23 Feb 2007 15:42:42 +0100
Received: from Debian-exim by gna.org with spam-scanned (Exim 4.50)
	id 1HKbd4-0003zN-Mt
	for adeos-main@gna.org; Fri, 23 Feb 2007 15:42:40 +0100
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-26) on mail.gna.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.3 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO,UPPERCASE_25_50 autolearn=ham version=3.1.4
Received: from fmmailgate01.web.de ([217.72.192.221])
	by gna.org with esmtp (Exim 4.50) id 1HKbd4-0003xp-Kk
	for adeos-main@gna.org; Fri, 23 Feb 2007 15:42:34 +0100
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 122416358CE6;
	Fri, 23 Feb 2007 15:40:20 +0100 (CET)
Received: from [130.75.137.37] (helo=[130.75.137.37])
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.107 #114)
	id 1HKbat-0002Kd-00; Fri, 23 Feb 2007 15:40:20 +0100
Message-ID: <45DEFCD1.1050505@domain.hid>
Date: Fri, 23 Feb 2007 15:40:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Philippe Gerum <rpm@xenomai.org>
X-Enigmail-Version: 0.94.2.0
X-Sender: jan.kiszka@domain.hid
Cc: adeos-main <adeos-main@gna.org>
Subject: [Adeos-main] [PATCH] include IRQ and domain states in panic dump
X-BeenThere: adeos-main@gna.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
Content-Type: multipart/mixed; boundary="===============0161630869=="
Mime-version: 1.0
Errors-To: adeos-main-bounces@domain.hid
Sender: adeos-main-bounces@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0161630869==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB7673CFB32A3C1058D692DCA"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7673CFB32A3C1058D692DCA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Index: linux-2.6.20.1/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.1.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20.1/kernel/ipipe/tracer.c
@@ -622,6 +622,18 @@ void ipipe_trace_panic_dump(void)
 		struct ipipe_trace_point *point =3D &panic_path->point[pos];
 		long time;
 		char buf[16];
+		int i;
+
+		printk(" %c", (point->flags & IPIPE_TFLG_HWIRQ_OFF) ?
+			       '|' : ' ');
+
+		for (i =3D IPIPE_TFLG_DOMSTATE_BITS; i >=3D 0; i--)
+			printk("%c",
+				(IPIPE_TFLG_CURRENT_DOMAIN(point) =3D=3D i) ?
+				(IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+					'#' : '+') :
+				(IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
+					'*' : ' '));
=20
 		if (!point->eip)
 			printk("-<invalid>-\n");=20



--------------enigB7673CFB32A3C1058D692DCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3vzRniDOoMHTA+kRAjHsAKCDi7RXvOQZ4+SZAuYWQBfFZGb2XgCeMMiH
DpM29YE2dXVzalzKXNFgFVg=
=HbwE
-----END PGP SIGNATURE-----

--------------enigB7673CFB32A3C1058D692DCA--


--===============0161630869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Adeos-main mailing list
Adeos-main@domain.hid
https://mail.gna.org/listinfo/adeos-main

--===============0161630869==--


--------------000608010308070903010606--

--------------enig4B3DCCDBA6D44DC4E94B6549
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3wgzniDOoMHTA+kRAooDAJ0aDkZuaAFMY7WQSNytmBOvE2WmZQCfcqBB
LS035BMOLVtvkoUF9lT8GyQ=
=cu0H
-----END PGP SIGNATURE-----

--------------enig4B3DCCDBA6D44DC4E94B6549--

