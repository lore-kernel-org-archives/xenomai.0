Message-ID: <437DA982.3040603@domain.hid>
Date: Fri, 18 Nov 2005 11:14:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [pipe.c] hairy synchronization -> "flush the output
	queue upon closure"
References: <OF9CBDF2DC.75483853-ONC12570BD.0036121E-C12570BD.0036D59F@datacon.at>
In-Reply-To: <OF9CBDF2DC.75483853-ONC12570BD.0036121E-C12570BD.0036D59F@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Dmitry Adamushko wrote:
> yep, it's a problem since data may be client-dependent. In such a case, 
> for a new client old messages are just irrelevant. And xnpipe_release() 
> cleans up the queus but, well, does it too earlier.
> 
> so,
> 
> 1) should xnpipe_open_handler() and xnpipe_close_handler() be called 
> without holding a lock?
> 

Yes, it on purpose. I know this make things a bit trickier since this breaks the overall 
atomicity of the caller, but open/close hooks are expected to initiate/finalize 
communication sessions, and that may take an unbounded amount of time, so we definitely 
don't want to do this with the superlock being held.

> they are not used currently so I can't see.
> 
> I intend to make xnpipe_open() completely atomic.
> 
> 2) the cleaning of the queues (inq, outq) must take place atomically at 
> the time when XNPIPE_USER_CONN is dropped.
> 
> it's about something like
> 
> lock();
> 
> __clrbits(state->status,XNPIPE_USER_CONN);
> 
> // clean up all the queues
> 
> unlock();
> 
> it looks like we can't make the whole xnpipe_release() atomic because of 
> PREEMPT_RT + wake_up_interruptible_all() things, right? Or no.

You must _never_ _ever_ reschedule with the nucleus lock held; this is a major cause of 
jittery I recently stumbled upon that was induced by xnpipe_read_wait() at that time. So 
indeed, xnpipe_release() cannot be made atomic this way under a fully preemptible kernel.

> 
> 
> ---
> 
> Dmitry
> 


-- 

Philippe.

