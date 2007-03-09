From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
Date: Fri, 9 Mar 2007 10:47:05 +0100
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<!&!AAAAAAAAAAAYAAAAAAAAAOtQApUEfglBvKTF3jr1t1bigwAAEAAAALx+DKgbdNVEi6wAAVh/Ga4BAAAAAA==@ac6.fr>
	<45F05EC7.6070907@domain.hid>
In-Reply-To: <45F05EC7.6070907@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HPbgo-0001DJ-EN@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

Roland Tollenaar wrote:
> Hi,
>
> Thanks for the input. Much appreciated from my side. I cannot comment on
> your question
>
>  > The net result was that we had to add quite a lot of udelay() calls
>
> to >slow down the driver to the senator's pace of the SJA1000... Are you
>
>  >sure you're not running in this kind of problem?

There are no delay calls inside the interrupt handler. If the handler would be 
too fast for the SJA1000 it would immediately return.

> I do have a question which may be a bit early or out of context but if
> it turns out without question that the delay IS in the
>
> rtcan_sja_interrupt
>
> routine (is it a routine? A function call? )

As the name states it, this is the RTCAN interrupt handler for the SJA1000 
driver.

> would it be possible to 
> split the function up into smaller parts (is this what they call
> granularity?) so that the RT tasks can return to themselves before
> running out of time while stuck in the rtcan_sja_interrupt call. ?
>
> Or am I missing the point entirely?

If an RX interrupt appears it it necessary to read out up to 14 SJA1000 regs 
and write one register before a CAN message can be distributed to the 
sockets. Do you really suggest that the reading of the SJA1000 registers 
should be interruptible? One step towards chaos, I would say.

-- 
Sebastian

