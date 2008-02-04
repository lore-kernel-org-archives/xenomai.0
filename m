Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Feb 2008 10:01:37 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3768DF@slcmail.slc.mew.int>
In-Reply-To: <18342.46456.373177.86014@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768BB@slcmail.slc.mew.int><18342.13282.822800.458093@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D3768BC@slcmail.slc.mew.int>
	<18342.46456.373177.86014@domain.hid>
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

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Sunday, February 03, 2008 11:49 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
>
> Subject: RE: [Xenomai-help] rt_queue_read and pthread_cancel()
> PTHREAD_CANCEL_ASYNCHRONOUS is the way glibc makes a blocking call a
> cancellation point. And internally, the glibc uses a signal in this
> case. When running with Xenomai, the signal sent upon pthread_cancel
> will cause the target thread to switch to secondary mode and run its
> clean-ups from there. So, the exit should be clean when using this
> approach.

My understanding is that PTHREAD_CANCEL_ASYNCHRONOUS actually makes the
thread cancel immediately, while DEFERRED makes it wait for a
cancellation point. DEFERRED will also cause blocking calls to exit with
-EINTR I believe it is. That's why you put pthread_testcancel() after
blocking calls before proceeding. This is safer because you test for
cancellation when you've released resources. (You can also use cleanup
handlers, but that can get annoying.)

>=20
> Now about your problems, are you fiddling with signals ? Like blocking
> them, or doing things in signal handlers ?

I am not doing anything at all with signals except a single handler in
the main thread which catches SIGINT. This allows it to cleanup cleanly
when ctrl-C is pressed. Is that a problem?

> I do not know about that. I would have expected rt_task_delete to work
> with a task shadowed with rt_task_shadow. Especially since
> rt_task_delete runs pthread_cancel under the hood.

As I mentioned, calling rt_task_delete() caused problems. If a thread is
in primary mode and a signal comes in, does it really cause a switch to
secondary? What if I am blocked inside rt_queue_read() and the cancel
comes in? Will the routine exit at this point?

Perhaps I should change my example I sent (qt.c) and not have the writer
thread send anything, and see if it still joins. I don't have access to
the system right at the moment, though.

Steven


