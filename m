Message-ID: <e39c9190708130557k45492c82qb226a6b760567bc3@domain.hid>
Date: Mon, 13 Aug 2007 14:57:55 +0200
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <46C0368A.2080207@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_55347_17815002.1187009875333"
References: <e39c9190708121709u765ab036w242c0c846c9c82f5@domain.hid>
	<46C01909.5020308@domain.hid>
	<e39c9190708130254x421a54b8le92acbf974a6fa58@domain.hid>
	<46C0368A.2080207@domain.hid>
Subject: Re: [Xenomai-core] RTDM 82527 Xenomai driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_55347_17815002.1187009875333
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/13/07, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> juanba romance wrote:
> > On 8/13/07, *Jan Kiszka* <jan.kiszka@domain.hid <mailto:jan.kiszka@domain.hid>>
> > wrote:
> >
> >     juanba romance wrote:
> [...]
>       That was discussed before in the context of Socket-CAN. My feeling
> is
> >     that it /could/ be useful in case you have to issue longer streams
> of
> >     CAN frames at high rates, and specifically if your CAN hardware can
> >     handle these streams autonomously. Is the 82527 able to do so?
> >
> >     In any case, this would complicate the existing stack and driver and
> >     would first require careful evaluation of the achievable improvement
> >     (lower latency, lower system load?).
> >
> > The i82527 has 15 mailboxes with fixed priority, the lowest one is
> > hardwared to the RX operation. So theoretically  you can pipeline up to
> > 14 TX messages. When the stuff is full, we are labeled it as a
> > "pileup"  because the hardware handler has to wait up to get some free
> > one, this operation is performed in our case through the either the
> > mailbox-alarm mechanism or the ISR transmission side . I have mention
>
> To be more precise, you have to wait that the object with the lowest
> priority, #14 has sent it's message, otherwise messages will be sent
> out-of-order.

Obviously if the pipe is full and the last activated one was the #14; We
have not take in care in a first approach the message identifier priority,
so the bunch sucked from the user ring is downloaded sequentially on the
free mailboxes starting from the #0 up to get the #14. A better approach to
be implemented in the TX thread would be to sample the current
free/available mailboxes, suck the ring and perform over there some ordering
before be attached to the chipset.  In fact, the mailboxes pool is shared
with the static message user map which is always allocated in the top area,
so the it's ACK is guaranteed at least for the auto-replier ones.

Another issue is the fact that to block a CANbus network transaction(so the
full pipe) any node should provide the ACK bit which is OR-wired. This
situation means that all the network devices have the RX line broken. This
unusual cause means likely a fully broken system, anyway if it is sampled I
think that the case must be traced without the hardware feedback; the i82527
has a 96 try mechanism to provide a status interrupt to monitor the fault.
This counter may be too later, using 1 Mbit bus rate, take the worst case in
terms of message size which is ~100bits, 100usec/message *96 tries, then up
to ~9.6ms be the pipe blocked, this is traced in our case through the alarm
mechanism but we have decreased the timeout up to 2msec, without have to
wait any IRQ flow. The ISR is also coded to have in care about this
situation but theoretically the alarm should be triggered before.. Of course
decreasing the bus speed the stuff get worse..


> > the "low latency" term, cause i have decoupled the loopback-tx feedback
> > from the ISR to a kernel RT thread/task so the ISR only cleans/stops the
> > mailbox software/hardware resources. The user call is only blocked the
> > time required to push the message bunch into the transmission ring. The
> > physical user transmission is performed in open-loop if no error/alarm
> > is sampled..
>
> Note that in RT-Socket-CAN messages are not queued in software nor in
> hardware for the sake of real-time. Just one message object will be used
> for sending. I also doubt, that there is a notable performance benefit
> from sophisticated TX queuing.
>
> Wolfgang.
>
I will provide some measures related on

Juanba

------=_Part_55347_17815002.1187009875333
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/13/07, <b class="gmail_sendername">Wolfgang Grandegger</b> &lt;<a href="mailto:wg@domain.hid">wg@domain.hid</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
juanba romance wrote:<br>&gt; On 8/13/07, *Jan Kiszka* &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a> &lt;mailto:<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;&gt;<br>&gt; wrote:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; juanba romance wrote:
<br>[...]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;That was discussed before in the context of Socket-CAN. My feeling is<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; that it /could/ be useful in case you have to issue longer streams of<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; CAN frames at high rates, and specifically if your CAN hardware can
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; handle these streams autonomously. Is the 82527 able to do so?<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; In any case, this would complicate the existing stack and driver and<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; would first require careful evaluation of the achievable improvement
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; (lower latency, lower system load?).<br>&gt;<br>&gt; The i82527 has 15 mailboxes with fixed priority, the lowest one is<br>&gt; hardwared to the RX operation. So theoretically&nbsp;&nbsp;you can pipeline up to<br>&gt; 14 TX messages. When the stuff is full, we are labeled it as a
<br>&gt; &quot;pileup&quot;&nbsp;&nbsp;because the hardware handler has to wait up to get some free<br>&gt; one, this operation is performed in our case through the either the<br>&gt; mailbox-alarm mechanism or the ISR transmission side . I have mention
<br><br>To be more precise, you have to wait that the object with the lowest<br>priority, #14 has sent it&#39;s message, otherwise messages will be sent<br>out-of-order.</blockquote><div>Obviously if the pipe is full and the last activated one was the #14; We have not take in care in a first approach the message identifier priority, so the bunch sucked from the user ring is downloaded sequentially on the free mailboxes starting from the #0 up to get the #14. A better approach to be implemented in the TX thread would be to sample the current free/available mailboxes, suck the ring and perform over there some ordering before be attached to the chipset.&nbsp;  In fact, the mailboxes pool is shared with the static message user map which is always allocated in the top area, so the it&#39;s ACK is guaranteed at least for the auto-replier ones.
<br>&nbsp;<br>Another issue is the fact that to block a CANbus network transaction(so the full pipe) any node should provide the ACK bit which is OR-wired. This situation means that all the network devices have the RX line broken. This unusual cause means likely a fully broken system, anyway if it is sampled I think that the case must be traced without the hardware feedback; the i82527 has a 96 try mechanism to provide a status interrupt to monitor the fault. This counter may be too later, using 1 Mbit bus rate, take the worst case in terms of message size which is ~100bits, 100usec/message *96 tries, then up to ~9.6ms be the pipe blocked, this is traced in our case through the alarm mechanism but we have decreased the timeout up to 2msec, without have to wait any IRQ flow. The ISR is also coded to have in care about this situation but theoretically the alarm should be triggered before.. Of course decreasing the bus speed the stuff get worse..
<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; the &quot;low latency&quot; term, cause i have decoupled the loopback-tx feedback
<br>&gt; from the ISR to a kernel RT thread/task so the ISR only cleans/stops the<br>&gt; mailbox software/hardware resources. The user call is only blocked the<br>&gt; time required to push the message bunch into the transmission ring. The
<br>&gt; physical user transmission is performed in open-loop if no error/alarm<br>&gt; is sampled..<br><br>Note that in RT-Socket-CAN messages are not queued in software nor in<br>hardware for the sake of real-time. Just one message object will be used
<br>for sending. I also doubt, that there is a notable performance benefit<br>from sophisticated TX queuing.<br><br>Wolfgang.<br></blockquote></div>I will provide some measures related on<br><br>Juanba<br>

------=_Part_55347_17815002.1187009875333--

