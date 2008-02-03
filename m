Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 3 Feb 2008 15:14:17 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3768BD@slcmail.slc.mew.int>
In-Reply-To: <18342.13282.822800.458093@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768BB@slcmail.slc.mew.int>
	<18342.13282.822800.458093@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I seem to have gotten rid of the problem by forcing a switch to the
secondary domain before and after the call to rt_queue_read(). Calling
rt_task_delete() caused the app to crash and then a subsequent kernel
panic on the next run.

I'll see if I can write a small example to demonstrate the issue.

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Sunday, February 03, 2008 2:37 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rt_queue_read and pthread_cancel()
> You do not need to call pthread_testcancel(): rt_task_shadow sets the
> thread cancellation type to PTHREAD_CANCEL_ASYNCHRONOUS, which means
> that pthread_cancel will send a signal to this thread to terminate
> it. So, the reason for the deadlock is probably elsewhere. Could you
> reduce your application to a small self-contained test which wouls
show
> us what you are observing ?

