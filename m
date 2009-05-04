From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1241446936.26544.324.camel@domain.hid>
References: <200905041613.30996@domain.hid> <200905041614.26154@domain.hid>
	<200905041615.12763@domain.hid> <200905041616.11698@domain.hid>
	<200905041617.10314@domain.hid> <200905041618.6444@domain.hid>
	<200905041619.25024@domain.hid> <200905041620.27181@domain.hid>
	<200905041620.27243@domain.hid>  <1241446936.26544.324.camel@domain.hid>
Content-Type: text/plain
Date: Mon, 04 May 2009 16:29:02 +0200
Message-Id: <1241447342.26544.329.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-05-04 at 16:22 +0200, Philippe Gerum wrote:
> On Mon, 2009-05-04 at 16:20 +0200, Petr Cervenka wrote:
> > >Assuming you are using the native API (the POSIX interface would have to
> > >be adapted the same way), does the following patch help?
> > >
> > 
> > The patch doesn't make any difference. It could be because I use mostly rtdm skin in the driver, not native. And the native skin example already resets syscall (but with wrong timeout).
> > 
> > Meanwhile I have found out the type of the signal, which interrupts my syscalls. It's SIGWINCH (or perhaps SIGHARDEN). What is exactly this signal used for, should it be interrupting syscalls?
> 
> This is a signal internally used by skins to force a thread in primary
> mode; it should not do interrupt syscalls, provided we set the sigaction
> flags properly.
> 

Read: it must interrupt Xenomai syscalls internally but the latter
should always be silently restarted, by properly setting the SA_RESTART
bit in the sigaction flags for that signal.

Not allowing Linux to interrupt blocking Xenomai syscalls to process
pending signals would basically kill GDB support, and beyond this create
a very fragile situation wrt signal handling and Xenomai, which is the
last thing we would want to do.

> > 
> > Petr
> > 
-- 
Philippe.



