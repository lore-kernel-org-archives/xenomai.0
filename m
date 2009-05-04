Date: Mon, 04 May 2009 18:11:53 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200905041811.11867@domain.hid>
References: <200905041613.30996@domain.hid> <200905041614.26154@domain.hid>
	<1241446936.26544.324.camel@domain.hid>
	<1241447342.26544.329.camel@domain.hid>
In-Reply-To: <1241447342.26544.329.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

>
>Read: it must interrupt Xenomai syscalls internally but the latter
>should always be silently restarted, by properly setting the SA_RESTART
>bit in the sigaction flags for that signal.
>
>Not allowing Linux to interrupt blocking Xenomai syscalls to process
>pending signals would basically kill GDB support, and beyond this create
>a very fragile situation wrt signal handling and Xenomai, which is the
>last thing we would want to do.
>
>Philippe.
>

I have found following problems / errors:
--------------------------------------------------------------
1) rtdm_event_timedwait() in ioctl handler is not automatically internally restarted (driver: rtdm, app. tasks: native)

2) computer hangs, when I call in ioctl handler something like:
do {
  res = rtdm_event_timedwait(&event, timeout, NULL);
} while (res == -EINTR);
this could have perhaps some relevance: https://mail.gna.org/public/xenomai-help/2008-11/msg00025.html

3) rt_event_wait() in application is restarted always with the same relative timeout. it could run forever.

problems with version 2.5-rc1:
-----------------------------------------------
1) function rt_task_shadow always returns -EFAULT

2) when resizing window with latency test running, it prints out "Not SIGSHADOW !". But it should be SIGSHADOW (in my opinion).

Petr


