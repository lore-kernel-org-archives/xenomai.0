From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JtqYz6HmH9"
Content-Transfer-Encoding: 7bit
Message-ID: <17448.11404.631925.760580@domain.hid>
Date: Mon, 27 Mar 2006 20:18:52 +0200
Subject: Re: [Xenomai-core] errors to console when running xeno-test (latency
	-t 1)
In-Reply-To: <44280C96.1030608@domain.hid>
References: <44280C96.1030608@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org


--JtqYz6HmH9
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jim Cromie wrote:
 > hello xenophiles,
 > 
 > Im getting errors to the console when running latency -t 1.
 > they also appear in dmesg output

The attached patch seems to solve the issue here, but I am not sure it
should...

-- 


					    Gilles Chanteperdrix.

--JtqYz6HmH9
Content-Type: text/plain
Content-Disposition: inline;
	filename="enable_fpu.patch"
Content-Transfer-Encoding: 7bit

Index: include/asm-i386/system.h
===================================================================
--- include/asm-i386/system.h	(revision 806)
+++ include/asm-i386/system.h	(working copy)
@@ -422,7 +422,7 @@
 {
     struct task_struct *task = tcb->user_task;
 
-    if (task && !wrap_test_fpu_used(task))
+    if (task && !xnarch_fpu_init_p(task))
         return;
 
     clts();

--JtqYz6HmH9--

