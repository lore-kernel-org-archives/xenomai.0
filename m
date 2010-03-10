Message-ID: <4B97BA0C.9000702@domain.hid>
Date: Wed, 10 Mar 2010 16:26:04 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Analogy cmd_write example explanation
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

Hello. I'm looking into the analogy cmd_write example.

I'm not sure I understand the reason for the rt_task_set_mode() function
call into the data acquisition loop (lines 413 or 464 in the code
shipped with xenomai 2.5.1).

I do not understand why we have to set the primary mode at every
iteration, when we set it before for the task (line 380).

Is it because the dump_function() uses system calls that can make the
task to switch to secondary mode, or there is a deeper reason I'm missing?

Thanks. Cheers,
-- 
Daniele


