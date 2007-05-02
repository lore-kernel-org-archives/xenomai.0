From: Sebastian Smolorz <ssm@domain.hid>
Date: Wed, 2 May 2007 10:43:11 +0200
References: <46359B2C.3000206@domain.hid>
In-Reply-To: <46359B2C.3000206@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HjAQH-00053y-95@domain.hid>
Subject: Re: [Xenomai-help] timing within a task and assessing the timing of
	CAN messages
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
Cc: xenomai@xenomai.org

Roland Tollenaar wrote:
> Hello,
>
> I have three questions I would like to pose here.
>
> 1-Is it possible to subdivide a task to control at what time a certain
> command is executed within the task? Example: I have a 1ms task. I send
> a CAN sync message at the beginning of the task but I would like to wait
> about 300us before performing a read to ensure that all the messages
> emitted as a result of this sync have come in.

If you know the number of answering messages why don't you use blocking reads? 
In this way you would implicitely wait the right time.

> Now I will have an odd 
> 700us to use the data that has come in to calculate outputs. However I
> want the output to be put out as close as possible to the end of the
> task time. Is there an elegant manner to delay the read and the write to
> give me this kind of control within a taks. If not any suggestions as to
> how I should tackle this.

Maybe you are looking for rt_task_sleep_until()?

> 2-For development I am still using the PEAK CAN dongle. We have
> establisched that the ISR responding to an incoming message interrupt
> takes 200us to complete. Is anything known about how long it takes
> before a message that has been sent is put on the bus? How does this
> happen? Reason I ask is to know what kind of variance I can expect in
> time between the moment I send the output values and the moment it is on
> the bus. If there are routines between those to points that allow
> themselves to be pre-empted or for some other reason have varying
> execution times my control performance will be badly degraded.

The sendmsg routine of the SJA1000 driver programs the TX registers and then 
exits (if the TX registers are not occupied by a precedent sendmsg). The 
SJA1000 then is responsible to put the message on the bus. If the TX 
registers are free again the driver receives an interrupt. You could extend 
the interrupt handler with a rtdm_printk(actual_time) for your purpose.

> 3-How do I interpret the relative time stamps that can be made visible
> with rtcanrev ? IS the time indicated the time between each message and
> the last time the message was posted? Or between the message and its
> direct predecessor?

The latter one.


-- 
Sebastian

