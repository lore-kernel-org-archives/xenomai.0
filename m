MIME-Version: 1.0
Date: Thu, 6 Feb 2014 14:36:41 +0100
Message-ID: <CAKc2HpZ+zHoF22BjPKj_x0V+oOX9ZcLpU-N1jNv1pjq6sQhsqQ@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Xenomai-forge pSOS t_start followed by t_suspend does not
	work
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I believe there is a problem in Xenomai-forge when doing a pSOS
t_suspend() call right after a t_start() call.
It looks like the task does not get suspended in some cases. The
return value of t_suspend() is 0 however.

I suspect that this happens when the threadobj_prologue() is not
finished yet at the moment that the notifier_sighandler() is called.
In this case it could be that the notifier_init() did not run yet. If
this is the case, then the notifier_sighandler() will not do any
notifier callback and thus the task will not be suspended. Additional
t_suspend() calls will not work as the "notified" flag has been set
already.
Is this possible?

If I enable debug (--enable-debug), then sometimes the assertion in
the notifier_callback() occurs. I think this might happen if the
notifier_init() has run already however the threadobj_set_current()
has not yet before the callback is run. I am unsure if this case
causes any actual problems.

It is difficult to debug all this with GDB as when I do so, the
notifier_sighandler() runs very often on the wrong thread. This then
causes the owner check in the notifier_sighandler() to fail. I don't
know why it behaves like this when being debugged but that is probably
a GDB thing.

Thanks in advance for any help!

Regards,
Kim

