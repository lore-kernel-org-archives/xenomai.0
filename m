MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18342.13282.822800.458093@domain.hid>
Date: Sun, 3 Feb 2008 22:36:34 +0100
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3768BB@slcmail.slc.mew.int>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768BB@slcmail.slc.mew.int>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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

Steven Seeger wrote:
 > If I have a shadowed thread that was created with pthread_create() and
 > rt_task_shadow() that calls rt_queue_read() with an infinite timeout, is
 > there any reason it would not receive a cancellation point? I have an
 > intermittent lock in pthread_join() on that thread while it's blocked in
 > rt_queue_read(). I call pthread_cancel() on the thread first. I have the
 > rt_queue_read() call with a pthread_testcancel() before and after it. 

You do not need to call pthread_testcancel(): rt_task_shadow sets the
thread cancellation type to PTHREAD_CANCEL_ASYNCHRONOUS, which means
that pthread_cancel will send a signal to this thread to terminate
it. So, the reason for the deadlock is probably elsewhere. Could you
reduce your application to a small self-contained test which wouls show
us what you are observing ?

-- 


					    Gilles Chanteperdrix.

