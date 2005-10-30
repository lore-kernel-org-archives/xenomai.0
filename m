Message-ID: <4364A1DD.2060603@domain.hid>
Date: Sun, 30 Oct 2005 11:35:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] UVM bugfix for RTAI/fusion and Xenomai 2.0
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


People depending on the UVM support as available with RTAI/fusion should apply 
the following patch (against v0.9.1); it solves a serious bug which usually 
bites at thread creation time. The bug affects Xenomai 2.0 as well, so this fix 
will be part of Xenomai 2.0.1.

--- fusion-0.9.1/skins/uvm/syscall.c~	2005-09-09 18:16:02.000000000 +0200
+++ fusion-0.9.1/skins/uvm/syscall.c	2005-10-30 11:22:35.000000000 +0100
@@ -315,8 +315,9 @@

      if (!testbits(next->status,XNSTARTED))
  	{
+	/* First, make sure it won't preempt us. */
+	xnpod_suspend_thread(next,XNSUSP,XN_INFINITE,NULL);
  	err = xnpod_start_thread(next,0,0,XNPOD_ALL_CPUS,NULL,NULL);
-	goto out;
  	}

      xnpod_resume_thread(next,XNSUSP);
-- 

Philippe.

