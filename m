Message-ID: <b647ffbd0608110050p24303b2bhef5e4223190acd0e@domain.hid>
Date: Fri, 11 Aug 2006 09:50:11 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] -110 error on rt_task_send... bug?
In-Reply-To: <1155247988.4297.52.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_36833_9486874.1155282611502"
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
Cc: xenomai@xenomai.org, andrewg@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_36833_9486874.1155282611502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

No. xnpod_resume_thread() detects that the sender is pending on the
> msendq, and eventually calls xnsynch_forget_sleeper(), which removes the
> sender from the pend queue, then clears the boost.


I overlooked it indeed.


The problem is triggered by synch->owner being cleared in
> xnsynch_flush(), as a result of the receiver task to exit (called from
> the native task deletion hook, i.e. xnsynch_destroy(&task->msendq)).
> The problem to fix is indeed in xnsynch_sleep_on(), but it's rather a
> matter of making sure that the awakened thread is not going to check the
> owner field of a synch object that has just been destroyed.
>
>
and moreover I was completely wrong. So the reputation of 2.1 is restored
and that's more important indeed than err... mine own :o)


-- 
Best regards,
Dmitry Adamushko

------=_Part_36833_9486874.1155282611502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div><br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">No. xnpod_resume_thread() detects that the sender is pending on the<br>msendq, and eventually calls xnsynch_forget_sleeper(), which removes the
<br>sender from the pend queue, then clears the boost.</blockquote><div><br>
I overlooked it indeed.<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The problem is triggered by synch-&gt;owner being cleared in<br>xnsynch_flush(), as a result of the receiver task to exit (called from
<br>the native task deletion hook, i.e. xnsynch_destroy(&amp;task-&gt;msendq)).<br>The problem to fix is indeed in xnsynch_sleep_on(), but it's rather a<br>matter of making sure that the awakened thread is not going to check the
<br>owner field of a synch object that has just been destroyed.<br><br></blockquote></div><br>
and moreover I was completely wrong. So the reputation of 2.1 is
restored and that's more important indeed than err... mine own :o)<br clear="all"><br>
<br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>

------=_Part_36833_9486874.1155282611502--

