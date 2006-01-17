Date: Tue, 17 Jan 2006 14:28:31 -0500
From: Kent Borg <kentborg@domain.hid>
Message-ID: <20060117142831.M15311@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] Debugging
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

It occurs to me I have been lax in my understanding of how debugging
works with Xenamai.

 - What happens if I just use gdb and pretend I am debugging a regular
   program?  (Seems scary, but it seems to work at least somewhat for
   me.)

 - What is UVM for?  Sounds interesting, but the "make xconfig" help
   for it says it is for legacy RTOS APIs and I am mostly doing native
   calls.  What is the difference?

 - How about MVM?  It sounds interesting too.  Do I just configure it
   in and grab it on with gdb??

I notice that the string "debug" doesn't seem to appear in the thread
indexes for this list, so I don't think I am asking a frequent
question...


Thanks,

-kb

