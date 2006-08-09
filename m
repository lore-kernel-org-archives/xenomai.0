Message-ID: <b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
Date: Wed, 9 Aug 2006 11:35:13 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] -110 error on rt_task_send... bug?
In-Reply-To: <44D90C41.5070307@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_15873_10767008.1155116113407"
References: <44D7EDCF.9010409@domain.hid> <44D90C41.5070307@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, andrewg@domain.hid

------=_Part_15873_10767008.1155116113407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,


I'm not that deep into rt_task_send/receive design, but this problem
> seems to be related to some heavy disagree between xnsynch_sleep_on and
> rt_task_send about the correct ownership of the receiver's send queue.


Not transfering the ownership causes this problem, yes. But looking briefly
at the code... there is even yet another problem (if I haven't overlooked
something) that also exists in 2.1.

rt_task_reply() wakes up a sender with :

[code]

if (receiver->wait_args.mps.mcb_s.flowid == flowid) {
                        /* Note that the following will cause the receiver
to be
                           unblocked without transferring the ownership of
the
                           msendq object, since we want the sender to keep
it. */
                        xnpod_resume_thread(&receiver->thread_base, XNPEND);
                        break;

[/code]

Now let's suppose : sender.prio > recv.prio

so recv.prio is boosted when sender executes xnsynch_sleep_on().

The "recv" task (the one that calls rt_task_receive() and rt_task_reply())
doesn't use xnsynch_* functions (like xnsynch_wakeup_this_sleeper() ) to
actually wake up the sender. Therefore xnsynch_clear_boost() is never called
and "recv" keeps temporarily inhereted priority as a permanent one from now
on.

No?

I have a few ideas on how to fix it intelegently so if Philippe will not
come up with a quick solution, I may take a look?


-- 
Best regards,
Dmitry Adamushko

------=_Part_15873_10767008.1155116113407
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div><br>
Hello,<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I'm not that deep into rt_task_send/receive design, but this problem<br>seems to be related to some heavy disagree between xnsynch_sleep_on and
<br>rt_task_send about the correct ownership of the receiver's send queue.</blockquote><div><br>
</div>Not transfering the ownership causes this problem, yes. But
looking briefly at the code... there is even yet another problem (if I
haven't overlooked something) that also exists in 2.1.<br>
<br>
rt_task_reply() wakes up a sender with : <br>
<br>
[code]<br>
<br>
if (receiver-&gt;wait_args.mps.mcb_s.flowid == flowid) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/* Note that the following will cause the receiver to be<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
unblocked without transferring the ownership of the<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
msendq object, since we want the sender to keep it. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
xnpod_resume_thread(&amp;receiver-&gt;thread_base, XNPEND);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break;<br>
<br>
[/code]<br>
</div><br>
Now let's suppose : sender.prio &gt; recv.prio<br>
<br>
so recv.prio is boosted when sender executes xnsynch_sleep_on().<br>
<br>
The &quot;recv&quot; task (the one that calls rt_task_receive() and
rt_task_reply()) doesn't use xnsynch_* functions (like
xnsynch_wakeup_this_sleeper() ) to actually wake up the sender.
Therefore xnsynch_clear_boost() is never called and &quot;recv&quot; keeps
temporarily inhereted priority as a permanent one from now on.<br clear="all"><br>
No? <br>
<br>
I have a few ideas on how to fix it intelegently so if Philippe will not come up with a quick solution, I may take a look?<br>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_15873_10767008.1155116113407--

