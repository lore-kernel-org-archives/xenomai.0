Date: Wed, 18 Jan 2006 16:24:07 -0500
From: Kent Borg <kentborg@domain.hid>
Message-ID: <20060118162407.A28495@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] Signals
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

Thanks for the news that gdb should just work.

Now I am wondering about signals.  I want to be able to send a regular
Linux signal to a userland realtime process.  Do I use the regular
signal() to install a signal handler?  When would I use
rt_task_catch() and rt_task_notify()?

What about multiple threads?  I have 2 threads running.  It seems that
the thread that called signal() is the one landing in the handler
routine.  I would like to set some flags for the second thread to see,
so it can cleanup things before quiting, but it seems that my second
thread isn't running after I send the signal.  I also think I am
corrupting something, because if I set up a loop that launches and
kills my program, my machine freezes up after a dozen cycles.  I
commented out most of my guts and it still freezes up.


Thanks,

-kb

