Message-ID: <2ff1a98a0802040921u290e2e44sc7b026d2f924aeb2@domain.hid>
Date: Mon, 4 Feb 2008 18:21:14 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3768DF@slcmail.slc.mew.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D3768BB@slcmail.slc.mew.int>
	<18342.13282.822800.458093@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3768BC@slcmail.slc.mew.int>
	<18342.46456.373177.86014@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3768DF@slcmail.slc.mew.int>
Subject: Re: [Xenomai-help] rt_queue_read and pthread_cancel()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

On Mon, Feb 4, 2008 at 6:01 PM, Steven Seeger
<sseeger@domain.hid> wrote:
> > -----Original Message-----
>  > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>
> > Sent: Sunday, February 03, 2008 11:49 PM
>  > To: Steven Seeger
>  > Cc: xenomai@xenomai.org
>  >
>
> > Subject: RE: [Xenomai-help] rt_queue_read and pthread_cancel()
>  > PTHREAD_CANCEL_ASYNCHRONOUS is the way glibc makes a blocking call a
>  > cancellation point. And internally, the glibc uses a signal in this
>  > case. When running with Xenomai, the signal sent upon pthread_cancel
>  > will cause the target thread to switch to secondary mode and run its
>  > clean-ups from there. So, the exit should be clean when using this
>  > approach.
>
>  My understanding is that PTHREAD_CANCEL_ASYNCHRONOUS actually makes the
>  thread cancel immediately, while DEFERRED makes it wait for a
>  cancellation point. DEFERRED will also cause blocking calls to exit with
>  -EINTR I believe it is. That's why you put pthread_testcancel() after
>  blocking calls before proceeding. This is safer because you test for
>  cancellation when you've released resources. (You can also use cleanup
>  handlers, but that can get annoying.)

Except patent bug, calling pthread_testcancel after a blocking call is
useless: the libc and kernel cooperate to allow cancellation of a
thread blocked in a blocking call. The way they cooperate to do this
is by setting the cancellation type to
PTHREAD_CANCEL_ASYNCHRONOUS before calling the blocking
service and restoring the cancellation type after. And no, if the libc
did not do that, the cancellation would not interrupt the blocking call.
Do not trust me, read the glibc and xenomai code and do your own
testing. To get cancellation to run with xenomai posix skin, we had
to do the same trick as glibc, with the native skin, we set all threads
cancellation type to asynchronous since the user is not expected to
fiddle with the cancellation type bit himself, and we want the thread
to be cancelable at any time.

>
>
>  >
>  > Now about your problems, are you fiddling with signals ? Like blocking
>  > them, or doing things in signal handlers ?
>
>  I am not doing anything at all with signals except a single handler in
>  the main thread which catches SIGINT. This allows it to cleanup cleanly
>  when ctrl-C is pressed. Is that a problem?

Yes, it may cause deadlock if the signal handler conflicts with the
interrupted code. Not all services may be called from a signal
handler, only "async signal safe" ones may be called, you will find
the (rather short) list of such calls at the bottom of the following
page:
http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_04.html

>
>
>  > I do not know about that. I would have expected rt_task_delete to work
>  > with a task shadowed with rt_task_shadow. Especially since
>  > rt_task_delete runs pthread_cancel under the hood.
>
>  As I mentioned, calling rt_task_delete() caused problems. If a thread is
>  in primary mode and a signal comes in, does it really cause a switch to
>  secondary? What if I am blocked inside rt_queue_read() and the cancel
>  comes in? Will the routine exit at this point?

Yes, it will exit and return -ERESTARTSYS to user-space, the signal
will be handled on the way back to user-space.

-- 
                                               Gilles Chanteperdrix

