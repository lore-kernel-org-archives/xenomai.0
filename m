Message-ID: <499EA168.3000103@domain.hid>
Date: Fri, 20 Feb 2009 13:26:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Stall bit setting in __ipipe_handle_exception
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Hi Philippe,

as already indicated, I'm starting to understand the ipipe bug Roman
sees. It seems to melt down to the following path:

- exception raised over non-root domain (__rt_event_wait...)
- root domain is stalled on entry of __ipipe_handle_exception
- fault causing task is first relaxed, then scheduled away under Linux
- scheduled-in Linux task was interrupted in __ipipe_divert_exception,
  shortly before __fixup_if
- __fixup_if finds root domain stalled and propagates this to the
  register set of the interrupted context (user space task running on
  its first fpu instruction, having triggered device_not_available).
- return to user space task with irqs disable - bang!

Two ways to approach this:
1. Do we actually have to stall the root domain in
   __ipipe_handle_exception before ipipe_trap_notify? I don't see why we
   should be better off with doing this afterwards.
2. Avoid that __ipipe_divert_exception is interruptible and can pick up
   the stall flag from a different Linux task. But I don't know if there
   aren't more race windows like that.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

