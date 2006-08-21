Message-ID: <b647ffbd0608210447m45704e2bhd1884bce9e6a2a66@domain.hid>
Date: Mon, 21 Aug 2006 13:47:00 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: [Xenomai-core] [patch,
	minor] xnpipe_recv and xntimer_get_timeout_periodic()
In-Reply-To: <b647ffbd0608210446v38656cecxc231dba4e8f55dc2@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_29284_9777557.1156160820117"
References: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
	<1156154538.4402.32.camel@domain.hid>
	<b647ffbd0608210347y4a863588r607c403de0640e74@domain.hid>
	<1156159631.4402.41.camel@domain.hid>
	<b647ffbd0608210446v38656cecxc231dba4e8f55dc2@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_29284_9777557.1156160820117
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 2006-08-21 at 12:47 +0200, Dmitry Adamushko wrote:
> >
> > what about pipe-related change (I mean timeslice updating in
> > xnpipe_recv()) ?
> >
>
> It's basically useless, since xnsynch_sleep_on() handles the resource
> stealing case internally, and the loop in xnpipe_recv is fake actually.
> Think of it as a goto statement in disguise.


It has nothing to do with "resource stealing" (in terms of synch.c). The
synch object is not PIP at all.

task1 : blocked in xnpipe_recv()

task2 : xnpipe_send() ---> wakes up task1 ---> task1 is waiting to be
scheduled in

task3 [prio > task2.prio] : gets CPU and calls xnpipe_recv()

   task3 gets a message so state->inq is empty now.

...

task2 : calls getq(&state->inq) which is NULL now (if there were no more
messages)

calls xnsynch_sleep_on() again with the initial "timeout".

No?



>
> > --


> Best regards,
> Dmitry Adamushko
--
Philippe.





-- 
Best regards,
Dmitry Adamushko

------=_Part_29284_9777557.1156160820117
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"><br><br></span><div><div></div><div><span class="q"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Mon, 2006-08-21 at 12:47 +0200, Dmitry Adamushko wrote:
<br>&gt;<br>&gt; what about pipe-related change (I mean timeslice updating in
<br>&gt; xnpipe_recv()) ?<br>&gt;<br><br>It's basically useless, since xnsynch_sleep_on() handles the resource<br>stealing case internally, and the loop in xnpipe_recv is fake actually.<br>Think of it as a goto statement in disguise.
</blockquote></span></div><div><div><br>
It has nothing to do with &quot;resource stealing&quot; (in terms of synch.c). The synch object is not PIP at all.<br>
<br>
task1 : blocked in xnpipe_recv()<br>
<br>
task2 : xnpipe_send() ---&gt; wakes up task1 ---&gt; task1 is waiting to be scheduled in<br>
<br>
task3 [prio &gt; task2.prio] : gets CPU and calls xnpipe_recv()<br>
<br>
&nbsp;&nbsp; task3 gets a message so state-&gt;inq is empty now.<br>
<br>
...<br>
<br>
task2 : calls getq(&amp;state-&gt;inq) which is NULL now (if there were no more messages)<br>
<br>
calls xnsynch_sleep_on() again with the initial &quot;timeout&quot;.<br>
&nbsp;<br>
No?<br>
<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br>&gt; --</blockquote></div><div><span class="q"><br>&gt; Best regards,<br>
&gt; Dmitry Adamushko<br>--<br>Philippe.
<br><br><br></span></div><div></div><br><br clear="all"><br>-- <br>Best regards,<br></div><div><span class="sg">Dmitry Adamushko

</span></div><br>

------=_Part_29284_9777557.1156160820117--

