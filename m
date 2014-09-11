Message-ID: <54115FD0.1030303@siemens.com>
Date: Thu, 11 Sep 2014 10:39:44 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe: Comment in __ipipe_handle_exception
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

Hi Philippe,

in 2338107647 I found this:

@@ -383,6 +380,8 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 			local_irq_disable();
 	}
 
+	/*
+	 * XXX: We don't trace page faults (yet?). */
 	if (vector == ex_do_page_fault)
 		cr2 = native_read_cr2();
 

What is the background? Any open issue?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

