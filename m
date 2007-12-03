Message-ID: <2ff1a98a0712030218y28b259b4jdee0db97df5ec567@domain.hid>
Date: Mon, 3 Dec 2007 11:18:04 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
	<2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375D71@domain.hid>
	<18259.5205.292521.503167@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int>
Subject: Re: [Xenomai-help] wathcdog
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

On Dec 3, 2007 12:55 AM, Steven Seeger
<sseeger@domain.hid> wrote:
> Hi Gilles. I wonder if it might be possible for a userspace program to
> register its own handler with the watchdog for a thread? If so, then it
> would be beneficial to have this handler also pass an argument that was
> included with the register so that the user program's handler can
> identify the thread and handle things appropriately. This method handles
> the notification problem, but doesn't handle the problem of knowing
> which thread it was that was killed. As a result, it will be impossible
> to recover from this error or simply log the offending thread and shut
> down gracefully.
>
> What do you think?

With the patch I sent, you can register a handler for SIGRTMAX, and
this handler will be called when the watchdog kills a thread. Note
that it is impossible to notify precisely the thread to be killed, so
the thread notified is the one who called pthread_set_mode_np or
rt_task_set_mode. What we can do, however, is to pass a siginfo with
the signal containing the pid of the thread which the watchdog killed.

-- 
                                               Gilles Chanteperdrix

