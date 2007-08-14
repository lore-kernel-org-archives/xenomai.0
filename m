Message-ID: <2862c2c80708140315y6cb029e4j8b5f7e9d95ae2bf1@domain.hid>
Date: Tue, 14 Aug 2007 18:15:49 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_26438_26498190.1187086549897"
Subject: [Xenomai-help] Kernel Opps calling rtdm_irq_request
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_26438_26498190.1187086549897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

I have try to attach a AT91 TC hardware interrupt using rtdm_irq_request.

Whenever the rtdm_irq_request is called, the kernel Oops occurs.

Any ideas on the problem?

Please help. Thanks

Regards,
chun yeow

Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = c3564000
[00000010] *pgd=234da031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
Modules linked in: rtdm_test
CPU: 0
PC is at xnintr_init+0x18/0x5c
LR is at 0x194
pc : [<c0079974>]    lr : [<00000194>]    Tainted: P
sp : c3553e0c  ip : c0367804  fp : c3553e20
r10: 00000018  r9 : c03e7ac0  r8 : 00000000
r7 : bf003880  r6 : 00000001  r5 : 00000000  r4 : 00000000
r3 : bf003090  r2 : 00000012  r1 : bf003174  r0 : 00000000
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 317F
Table: 23564000  DAC: 00000015
Process user (pid: 265, stack limit = 0xc3552258)
Stack: (0xc3553e0c to 0xc3554000)
3e00:                            bf003090 00000000 c3553e40 c3553e24
c00abab4
3e20: c007996c 00000000 00000000 00000000 c0672600 c3553e60 c3553e44
bf003078
3e40: c00aba8c bf003174 00000000 c03e7ac0 00000000 c3553e98 c3553e64
c00aa83c
3e60: bf00304c 00000001 c00accb8 c07943e0 c0400cf0 ffffffff c3553e9c
00000000
3e80: c0672600 c3553fb0 c3553fb0 c3553ed8 c3553e9c c00acccc c00aa734
6f6d6564
3ea0: 30766564 00000000 276e6163 706f2074 25206e65 00000a73 00fff6e4
00000050
3ec0: 00000000 c3552000 00000008 c3553f08 c3553edc c0086b58 c00acc74
c3553f08
3ee0: 00000000 00000100 00000000 c03b5b20 20000013 c0086a8c c03b5b20
c3553f58
3f00: c3553f0c c0074aa0 c0086a9c c03b5aa4 00000000 00000020 c3553fb0
00000008
3f20: c03b5aa4 00000001 c03b5b20 c3553f58 40023e08 00000000 00000000
000f0042
3f40: c00256a8 c3553fb0 c3552000 c3553f90 c3553f5c c002c098 c0074a20
00000000
3f60: 00000000 00000000 40023e08 00000000 00000000 000f0042 c00256a8
c3552000
3f80: 009f0042 00000000 c3553f94 c0024fd4 c002c034 0103022b 00009038
00000000
3fa0: 00009038 00000000 40023e08 00000000 0103022b 00009038 00000000
00009038
3fc0: 40023e08 00000000 00000000 000f0042 00000000 00000000 40024000
bec17d64
3fe0: 400527b8 bec17d44 00008d5c 400527f8 20000010 0103022b 20002031
20002431
Backtrace:
[<c007995c>] (xnintr_init+0x0/0x5c) from [<c00abab4>]
(rtdm_irq_request+0x38/0x74)
 r4 = 00000000
[<c00aba7c>] (rtdm_irq_request+0x0/0x74) from [<bf003078>]
(demo_open_rt+0x3c/0x54 [rtdm_test])
 r5 = C0672600  r4 = 00000000
[<bf00303c>] (demo_open_rt+0x0/0x54 [rtdm_test]) from [<c00aa83c>]
(_rtdm_open+0x118/0x144)
 r4 = 00000000
[<c00aa724>] (_rtdm_open+0x0/0x144) from [<c00acccc>]
(sys_rtdm_open+0x68/0x70)
 r8 = C3553FB0  r7 = C3553FB0  r6 = C0672600  r5 = 00000000
 r4 = C3553E9C
[<c00acc64>] (sys_rtdm_open+0x0/0x70) from [<c0086b58>]
(losyscall_event+0xcc/0x1e0)
 r7 = 00000008  r6 = C3552000  r5 = 00000000  r4 = 00000050
[<c0086a8c>] (losyscall_event+0x0/0x1e0) from [<c0074aa0>]
(__ipipe_dispatch_event+0x90/0x23c)
[<c0074a10>] (__ipipe_dispatch_event+0x0/0x23c) from [<c002c098>]
(__ipipe_syscall_root+0x74/0x170)
[<c002c024>] (__ipipe_syscall_root+0x0/0x170) from [<c0024fd4>]
(vector_swi+0x74/0xb0)
Code: e24cb004 e24dd004 ebfeca1e e59fc03c (e5802010)
I-pipe tracer log (30 points):
     +func                    0 ipipe_trace_panic_freeze+0x14
(bust_spinlocks+0x20)
     +func                   -5 bust_spinlocks+0x14 (__do_kernel_fault+0x38)
     +func                  -13 ipipe_check_context+0x14
(search_module_extables+0xcc)
     +func                  -19 sub_preempt_count+0x10
(search_module_extables+0xc4)
     +func                  -25 ipipe_check_context+0x14
(search_module_extables+0xbc)
 |   +end     0x80000000    -31 __ipipe_unstall_root+0x4c
(__ipipe_restore_root+0x70)
 |   #begin   0x80000000    -37 __ipipe_unstall_root+0x70
(__ipipe_restore_root+0x70)
     #func                  -43 __ipipe_unstall_root+0x10
(__ipipe_restore_root+0x70)
     #func                  -48 __ipipe_restore_root+0x10
(search_module_extables+0xb4)
     #func                  -60 add_preempt_count+0x10
(search_module_extables+0x50)
     #func                  -66 ipipe_check_context+0x14
(search_module_extables+0x48)
     +func                  -73 search_module_extables+0x14
(search_exception_tables+0x38)
     +func                  -86 search_extable+0x14
(search_exception_tables+0x28)
     +func                  -92 search_exception_tables+0x14
(fixup_exception+0x20)
     +func                  -99 fixup_exception+0x14
(__do_kernel_fault+0x28)
     +func                 -105 __do_kernel_fault+0x10 (do_page_fault+0x1b0)
     +func                 -112 ipipe_check_context+0x14 (__up_read+0x90)
     +func                 -118 sub_preempt_count+0x10 (__up_read+0x88)
     +func                 -124 ipipe_check_context+0x14 (__up_read+0x80)
 |   +end     0x80000000   -130 __ipipe_unstall_root+0x4c
(__ipipe_restore_root+0x70)
 |   #begin   0x80000000   -136 __ipipe_unstall_root+0x70
(__ipipe_restore_root+0x70)
     #func                 -144 __ipipe_unstall_root+0x10
(__ipipe_restore_root+0x70)
     #func                 -149 __ipipe_restore_root+0x10 (__up_read+0x78)
     #func                 -155 add_preempt_count+0x10 (__up_read+0x4c)
     #func                 -161 ipipe_check_context+0x14 (__up_read+0x44)
     +func                 -167 __up_read+0x10 (up_read+0x14)
     +func                 -172 up_read+0x10 (do_page_fault+0x120)
     +func                 -182 find_vma+0x14 (do_page_fault+0xe0)
     +func                 -190 ipipe_check_context+0x14
(__down_read_trylock+0x94)
     +func                 -196 sub_preempt_count+0x10
(__down_read_trylock+0x8c)
 Segmentation fault

------=_Part_26438_26498190.1187086549897
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,<br><br>I have try to attach a AT91 TC hardware interrupt using rtdm_irq_request.<br><br>Whenever the rtdm_irq_request is called, the kernel Oops occurs.<br><br>Any ideas on the problem? <br><br>Please help. Thanks
<br><br>Regards,<br>chun yeow<br><br>Unable to handle kernel NULL pointer dereference at virtual address 00000010<br>pgd = c3564000<br>[00000010] *pgd=234da031, *pte=00000000, *ppte=00000000<br>Internal error: Oops: 817 [#1]
<br>Modules linked in: rtdm_test<br>CPU: 0<br>PC is at xnintr_init+0x18/0x5c<br>LR is at 0x194<br>pc : [&lt;c0079974&gt;]&nbsp;&nbsp;&nbsp; lr : [&lt;00000194&gt;]&nbsp;&nbsp;&nbsp; Tainted: P<br>sp : c3553e0c&nbsp; ip : c0367804&nbsp; fp : c3553e20<br>r10: 00000018&nbsp; r9 : c03e7ac0&nbsp; r8 : 00000000
<br>r7 : bf003880&nbsp; r6 : 00000001&nbsp; r5 : 00000000&nbsp; r4 : 00000000<br>r3 : bf003090&nbsp; r2 : 00000012&nbsp; r1 : bf003174&nbsp; r0 : 00000000<br>Flags: nZcv&nbsp; IRQs on&nbsp; FIQs on&nbsp; Mode SVC_32&nbsp; Segment user<br>Control: 317F<br>Table: 23564000&nbsp; DAC: 00000015
<br>Process user (pid: 265, stack limit = 0xc3552258)<br>Stack: (0xc3553e0c to 0xc3554000)<br>3e00:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bf003090 00000000 c3553e40 c3553e24 c00abab4<br>3e20: c007996c 00000000 00000000 00000000 c0672600 c3553e60 c3553e44 bf003078
<br>3e40: c00aba8c bf003174 00000000 c03e7ac0 00000000 c3553e98 c3553e64 c00aa83c<br>3e60: bf00304c 00000001 c00accb8 c07943e0 c0400cf0 ffffffff c3553e9c 00000000<br>3e80: c0672600 c3553fb0 c3553fb0 c3553ed8 c3553e9c c00acccc c00aa734 6f6d6564
<br>3ea0: 30766564 00000000 276e6163 706f2074 25206e65 00000a73 00fff6e4 00000050<br>3ec0: 00000000 c3552000 00000008 c3553f08 c3553edc c0086b58 c00acc74 c3553f08<br>3ee0: 00000000 00000100 00000000 c03b5b20 20000013 c0086a8c c03b5b20 c3553f58
<br>3f00: c3553f0c c0074aa0 c0086a9c c03b5aa4 00000000 00000020 c3553fb0 00000008<br>3f20: c03b5aa4 00000001 c03b5b20 c3553f58 40023e08 00000000 00000000 000f0042<br>3f40: c00256a8 c3553fb0 c3552000 c3553f90 c3553f5c c002c098 c0074a20 00000000
<br>3f60: 00000000 00000000 40023e08 00000000 00000000 000f0042 c00256a8 c3552000<br>3f80: 009f0042 00000000 c3553f94 c0024fd4 c002c034 0103022b 00009038 00000000<br>3fa0: 00009038 00000000 40023e08 00000000 0103022b 00009038 00000000 00009038
<br>3fc0: 40023e08 00000000 00000000 000f0042 00000000 00000000 40024000 bec17d64<br>3fe0: 400527b8 bec17d44 00008d5c 400527f8 20000010 0103022b 20002031 20002431<br>Backtrace:<br>[&lt;c007995c&gt;] (xnintr_init+0x0/0x5c) from [&lt;c00abab4&gt;] (rtdm_irq_request+0x38/0x74)
<br>&nbsp;r4 = 00000000<br>[&lt;c00aba7c&gt;] (rtdm_irq_request+0x0/0x74) from [&lt;bf003078&gt;] (demo_open_rt+0x3c/0x54 [rtdm_test])<br>&nbsp;r5 = C0672600&nbsp; r4 = 00000000<br>[&lt;bf00303c&gt;] (demo_open_rt+0x0/0x54 [rtdm_test]) from [&lt;c00aa83c&gt;] (_rtdm_open+0x118/0x144)
<br>&nbsp;r4 = 00000000<br>[&lt;c00aa724&gt;] (_rtdm_open+0x0/0x144) from [&lt;c00acccc&gt;] (sys_rtdm_open+0x68/0x70)<br>&nbsp;r8 = C3553FB0&nbsp; r7 = C3553FB0&nbsp; r6 = C0672600&nbsp; r5 = 00000000<br>&nbsp;r4 = C3553E9C<br>[&lt;c00acc64&gt;] (sys_rtdm_open+0x0/0x70) from [&lt;c0086b58&gt;] (losyscall_event+0xcc/0x1e0)
<br>&nbsp;r7 = 00000008&nbsp; r6 = C3552000&nbsp; r5 = 00000000&nbsp; r4 = 00000050<br>[&lt;c0086a8c&gt;] (losyscall_event+0x0/0x1e0) from [&lt;c0074aa0&gt;] (__ipipe_dispatch_event+0x90/0x23c)<br>[&lt;c0074a10&gt;] (__ipipe_dispatch_event+0x0/0x23c) from [&lt;c002c098&gt;] (__ipipe_syscall_root+0x74/0x170)
<br>[&lt;c002c024&gt;] (__ipipe_syscall_root+0x0/0x170) from [&lt;c0024fd4&gt;] (vector_swi+0x74/0xb0)<br>Code: e24cb004 e24dd004 ebfeca1e e59fc03c (e5802010)<br>I-pipe tracer log (30 points):<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 ipipe_trace_panic_freeze+0x14 (bust_spinlocks+0x20)
<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5 bust_spinlocks+0x14 (__do_kernel_fault+0x38)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -13 ipipe_check_context+0x14 (search_module_extables+0xcc)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -19 sub_preempt_count+0x10 (search_module_extables+0xc4)
<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -25 ipipe_check_context+0x14 (search_module_extables+0xbc)<br>&nbsp;|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp;&nbsp; -31 __ipipe_unstall_root+0x4c (__ipipe_restore_root+0x70)<br>&nbsp;|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80000000&nbsp;&nbsp;&nbsp; -37 __ipipe_unstall_root+0x70 (__ipipe_restore_root+0x70)
<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -43 __ipipe_unstall_root+0x10 (__ipipe_restore_root+0x70)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -48 __ipipe_restore_root+0x10 (search_module_extables+0xb4)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -60 add_preempt_count+0x10 (search_module_extables+0x50)
<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -66 ipipe_check_context+0x14 (search_module_extables+0x48)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -73 search_module_extables+0x14 (search_exception_tables+0x38)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -86 search_extable+0x14 (search_exception_tables+0x28)
<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -92 search_exception_tables+0x14 (fixup_exception+0x20)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -99 fixup_exception+0x14 (__do_kernel_fault+0x28)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -105 __do_kernel_fault+0x10 (do_page_fault+0x1b0)
<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -112 ipipe_check_context+0x14 (__up_read+0x90)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -118 sub_preempt_count+0x10 (__up_read+0x88)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -124 ipipe_check_context+0x14 (__up_read+0x80)
<br>&nbsp;|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -130 __ipipe_unstall_root+0x4c (__ipipe_restore_root+0x70)<br>&nbsp;|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -136 __ipipe_unstall_root+0x70 (__ipipe_restore_root+0x70)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -144 __ipipe_unstall_root+0x10 (__ipipe_restore_root+0x70)
<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -149 __ipipe_restore_root+0x10 (__up_read+0x78)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -155 add_preempt_count+0x10 (__up_read+0x4c)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -161 ipipe_check_context+0x14 (__up_read+0x44)
<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -167 __up_read+0x10 (up_read+0x14)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -172 up_read+0x10 (do_page_fault+0x120)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -182 find_vma+0x14 (do_page_fault+0xe0)<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -190 ipipe_check_context+0x14 (__down_read_trylock+0x94)
<br>&nbsp;&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -196 sub_preempt_count+0x10 (__down_read_trylock+0x8c)<br>&nbsp;Segmentation fault<br><br>

------=_Part_26438_26498190.1187086549897--

