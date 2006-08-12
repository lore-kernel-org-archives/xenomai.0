Message-ID: <b647ffbd0608120333j7cd4ef35q7ed00bafab35753d@domain.hid>
Date: Sat, 12 Aug 2006 12:33:24 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] -110 error on rt_task_send... bug?
In-Reply-To: <1155247988.4297.52.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_40358_15559832.1155378804509"
References: <44D7EDCF.9010409@domain.hid> <44D90C41.5070307@domain.hid>
	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
	<1155247988.4297.52.camel@domain.hid>
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_40358_15559832.1155378804509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
>
> The problem is triggered by synch->owner being cleared in
> xnsynch_flush(), as a result of the receiver task to exit (called from
> the native task deletion hook, i.e. xnsynch_destroy(&task->msendq)).



As I understood it didn't work in all cases and not only when a receiver
exits. What's wrong with the case Jan revealed?

I mean rt_task_reply() makes use of a direct call to xnpod_resume_thread()
to avoid a change of the owner while a sender finds itself being woken up in
xnsynch_sleep_on() - the PRIO + PIP branch - and the first thing it does is
a check for (synch->owner != thread) and it's obviously that the sender is
not the owner (but the receiver).

No?

> --
>
> Philippe.

-- 
Best regards,
Dmitry Adamushko

------=_Part_40358_15559832.1155378804509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>The problem is triggered by synch-&gt;owner being cleared in<br>xnsynch_flush(), as a result of the receiver task to exit (called from
<br>the native task deletion hook, i.e. xnsynch_destroy(&amp;task-&gt;msendq)).</blockquote>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>As I understood it didn't work in all cases and not only when a receiver exits. What's wrong with the case&nbsp;Jan revealed?</div>
<div>&nbsp;</div>
<div>I mean rt_task_reply() makes use of a direct call to xnpod_resume_thread() to avoid a change of the owner&nbsp;while a sender finds itself being woken up in xnsynch_sleep_on() - the PRIO + PIP branch - and&nbsp;the first thing it does is a check&nbsp;for (synch-&gt;owner != thread) and it's obviously that the sender is not the&nbsp;owner (but the receiver).
</div>
<p>No?</p>
<div>&nbsp;</div>
<div>&gt; --</div>
<div>&gt;<br>&gt; Philippe.<br>&nbsp;</div>
<div>-- <br>Best regards,<br>Dmitry Adamushko </div>

------=_Part_40358_15559832.1155378804509--

