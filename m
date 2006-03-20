Message-ID: <441EBBE7.6060605@domain.hid>
Date: Mon, 20 Mar 2006 15:27:51 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up
References: <200603201434.15258@domain.hid> <441EB558.9040408@domain.hid>
In-Reply-To: <441EB558.9040408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

Jan Kiszka wrote:
> Petr Cervenka wrote:
> 
>>Hello,
>>I'm trying to port a  driver of a AD card to RTDM.
>>When I use rtdm_event_timedwait in IOCTL handler (called from NRT user app), the system will hang-up immediately.
>>Does it have something to do with: https://mail.gna.org/public/xenomai-help/2006-03/msg00035.html
>>, ie. it's not possible to call wait /caller blocking functions from non-real-time, is it?
> 
> 
> Yep, that's exactly the point, it's an illegal usage.
> 
> And the fact that this still causes a crash instead of some more
> graceful failure reminds me of one reason why I asked for the new
> XENO_ASSERT macro: adding debug checks for such mistakes to RTDM.
>

It would be nice to have all potentially blocking syscalls actively 
checking for invalid call context, so that we always get graceful 
returns. At least, I'm in the process of adding the missing checks to 
the traditional RTOS skins which I'm extending with a native syscall 
interface. The good news is that it's basically a matter of grepping 
xnsynch_sleep_on() in the codebase.

--- skins/rtdm/drvlib.c	(revision 765)
+++ skins/rtdm/drvlib.c	(working copy)
@@ -648,6 +648,11 @@
      else if (!__test_and_clear_bit(0, &event->pending)) {
          xnthread_t  *thread = xnpod_current_thread();

+	if (xnpod_unblockable_p()) {
+	    err = -EPERM;
+	    goto unlock_and_exit;
+	}
+
          xnsynch_sleep_on(&event->synch_base, XN_INFINITE);

          if (!xnthread_test_flags(thread, XNRMID|XNBREAK))
@@ -658,6 +663,7 @@
              err = -EINTR;
      }

+ unlock_and_exit:
      xnlock_put_irqrestore(&nklock, s);

      return err;
-- 

Philippe.

