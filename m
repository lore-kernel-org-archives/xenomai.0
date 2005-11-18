In-Reply-To: <OFC82948A5.5D809872-ONC12570BD.0030CA81-C12570BD.003576C6@domain.hid>
Subject: Re: [Xenomai-core] [pipe.c] hairy synchronization -> "flush the output
	queue upon closure"
Message-ID: <OF9CBDF2DC.75483853-ONC12570BD.0036121E-C12570BD.0036D59F@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Fri, 18 Nov 2005 10:58:56 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2EDFA5948E8f9e8a93df938690918c4EBBFA2EDFA5948E"
Content-Disposition: inline
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

--0__=4EBBFA2EDFA5948E8f9e8a93df938690918c4EBBFA2EDFA5948E
Content-type: text/plain; charset=US-ASCII


yep, it's a problem since data may be client-dependent. In such a case, for
a new client old messages are just irrelevant. And xnpipe_release() cleans
up the queus but, well, does it too earlier.

so,

1) should xnpipe_open_handler() and xnpipe_close_handler() be called
without holding a lock?

they are not used currently so I can't see.

I intend to make xnpipe_open() completely atomic.

2) the cleaning of the queues (inq, outq) must take place atomically at the
time when XNPIPE_USER_CONN is dropped.

it's about something like

lock();

__clrbits(state->status,XNPIPE_USER_CONN);

// clean up all the queues

unlock();

it looks like we can't make the whole xnpipe_release() atomic because of
PREEMPT_RT + wake_up_interruptible_all() things, right? Or no.


---

Dmitry
--0__=4EBBFA2EDFA5948E8f9e8a93df938690918c4EBBFA2EDFA5948E
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>yep, it's a problem since data may be client-dependent. In such a case, for a new client old messages are just irrelevant. And xnpipe_release() cleans up the queus but, well, does it too earlier.</tt><br>
<br>
<tt>so,</tt><br>
<br>
<tt>1) should </tt><tt>xnpipe_open_handler() and xnpipe_close_handler() be called without holding a lock?</tt><br>
<br>
<tt>they are not used currently so I can't see.</tt><br>
<br>
<tt>I intend to make xnpipe_open() completely atomic.</tt><br>
<br>
<tt>2) the cleaning of the queues (inq, outq) must take place atomically at the time when XNPIPE_USER_CONN is dropped.</tt><br>
<br>
<tt>it's about something like </tt><br>
<br>
<tt>lock();</tt><br>
<br>
<tt>__</tt><tt>clrbits(state-&gt;status,XNPIPE_USER_CONN);</tt><br>
<br>
<tt>// clean up all the queues</tt><br>
<br>
<tt>unlock();</tt><br>
<br>
<tt>it looks like we can't make the whole xnpipe_release() atomic because of </tt><tt>PREEMPT_RT + wake_up_interruptible_all() things, right? Or no.</tt><br>
<br>
<br>
<tt>---</tt><br>
<br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA2EDFA5948E8f9e8a93df938690918c4EBBFA2EDFA5948E--


