From: Stephan Zimmermann <s.zimmermann@domain.hid>
Date: Tue, 5 Dec 2006 15:57:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612051557.44787.s.zimmermann@domain.hid>
Subject: [Xenomai-help] Crash using userspace interrupts
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

Hello List,
I am facing a crashing kernel when I use some rt_interupt_xxx funtions in my application.

System: Dualcore AMD with Debian 3.1, kernel 2.7.17.14 with Xenomai SVN rev 1920. 

Kernel crashes, leaving the following last words in syslog, the system keeps responding, 
but I am unable to restart my application.

<syslog>
I-pipe: Domain Xenomai registered.
Dec  5 15:24:07 localhost kernel: Xenomai: hal/x86 started.
Dec  5 15:24:07 localhost kernel: Xenomai: real-time nucleus v2.3-rc1 (Baroque) loaded.
Dec  5 15:24:07 localhost kernel: Xenomai: starting native API services.
Dec  5 15:26:21 localhost kernel:        waiter = kernel/xenomai/nucleus/intr.c:627 (xnintr_attach(), CPU #1)
Dec  5 15:26:21 localhost kernel:        owner  = <NULL>:0 (<NULL>(), CPU #0)
Dec  5 15:26:21 localhost kernel:        e0201e88 c02d426e c02dfcdd f96a9379 00000000 00000000 00000000 00000000
Dec  5 15:26:21 localhost kernel:        00000000 c03bf080 dfbe2124 00000000 f9670f7b dfbe212c dfbe2120 00000000
Dec  5 15:26:21 localhost kernel:        00000001 00000000 00000001 00000000 00000000 00000000 dfbe2120 00000007
Dec  5 15:26:21 localhost kernel: Call Trace:
Dec  5 15:26:21 localhost kernel:  <f96a9379> xnintr_attach+0xd1/0x287 [xeno_nucleus]  <f9670f7b> rt_intr_create+0x941/0x988 [xeno_native]
Dec  5 15:26:21 localhost kernel:  <f9664fba> __rt_intr_create+0xaf/0xf6 [xeno_native]  <f9664ec5> rt_intr_handler+0x0/0x46 [xeno_native]
Dec  5 15:26:21 localhost kernel:  <f966a227> rt_mutex_release+0x323/0x32f [xeno_native]  <f96ce7a7> hisyscall_event+0x13e/0x251 [xeno_nucleus]
Dec  5 15:26:21 localhost kernel:  <f96ce669> hisyscall_event+0x0/0x251 [xeno_nucleus]  <c0135c55> __ipipe_dispatch_event+0xd6/0x1dc
Dec  5 15:26:21 localhost kernel:  <c011075a> __ipipe_syscall_root+0x9e/0x147  <c0102ad6> sysenter_past_esp+0x3b/0x67
Dec  5 15:26:21 localhost kernel: Xenomai: watchdog triggered -- killing runaway thread 'CAN-ISR-2'
</syslog>

Something similar just happened, I don't know if it's related (will try to reproduce it and let you know). I tried to 'cat /proc/xenomai/irq', 
witch lead me to the following entry in syslog and a "BUG: soft lockup detected on CPU#0!" on my console.

<syslog>
Dec  5 15:33:32 localhost kernel: I-pipe: Domain Xenomai registered.
Dec  5 15:33:32 localhost kernel: Xenomai: hal/x86 started.
Dec  5 15:33:32 localhost kernel: Xenomai: real-time nucleus v2.3-rc1 (Baroque) loaded.
Dec  5 15:33:32 localhost kernel: Xenomai: starting native API services.
Dec  5 15:34:36 localhost kernel:        waiter = kernel/xenomai/nucleus/intr.c:801 (xnintr_irq_proc(), CPU #1)
Dec  5 15:34:36 localhost kernel:        owner  = <NULL>:0 (<NULL>(), CPU #0)
Dec  5 15:34:36 localhost kernel:        ee5e7ed4 c02d426e c02dfcdd f96af8fc 00000000 00000000 00000000 002dc6c0
Dec  5 15:34:36 localhost kernel:        00000000 eebf9039 00000008 eebf9039 00000007 c03c3888 f96b2028 00000007
Dec  5 15:34:36 localhost kernel:        eebf9039 00000000 eeede380 eebf9000 00001000 c0182283 eebf9000 ee5e7f58
Dec  5 15:34:36 localhost kernel: Call Trace:
Dec  5 15:34:36 localhost kernel:  <f96af8fc> xnintr_irq_proc+0x11d/0x2de [xeno_nucleus]  <f96b2028> irq_read_proc+0xbc/0x122 [xeno_nucleus]
Dec  5 15:34:36 localhost kernel:  <c0182283> proc_file_read+0x10c/0x22a  <c015185c> vfs_read+0xa6/0x13d
Dec  5 15:34:36 localhost kernel:  <c0151b5e> sys_read+0x3b/0x63  <c0102b82> syscall_call+0x7/0xb
Dec  5 15:34:56 localhost shutdown[6836]: shutting down for system reboot
Dec  5 15:37:20 localhost syslogd 1.4.1#17: restart.
</syslog>

Any hint's? 

Thanks, Stephan

