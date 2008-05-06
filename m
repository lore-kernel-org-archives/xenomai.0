Message-ID: <48200CD1.1060809@domain.hid>
Date: Tue, 06 May 2008 09:46:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F73@domain.hid>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F73@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue overruns
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

Karch, Joshua wrote:
> 
> Hello,
> 
> I have tasks that normally run at 50 Hz dealing with serial ports.    I
> have a command task which sends queue messages to a receive task that
> communicates with the serial port. The receive task waits indefinitely
> for a message over rt_queue (with TM_INFINITE) and then proceeds to
> write to the serial port, then reads a response from the RT serial
> port.  Occasionally, the device on the receiving end of the port takes
> longer than the expected 20 msec,( 50Hz response) as I've set the RTSER
> CONFIG struct to look for a 100 msec timeout.  As a result, the number
> of queued messages quickly build up.  After that, I run out of
> allocation space with rt_queue_alloc.
> 
> Is there some way to check to make sure I am receiving the most current
> message, and if not, flush all of the queued up messages with
> rt_queue_free so I can send the latest data to the serial port and not
> encounter message "buffer" overruns? With the exception of datalogging
> to disk, I'm very interested in getting to the most current message in a
> timely manner.

Maybe a queue is not the right tool to use in your case, you don't seem to
really need message buffering. From your description, I would rather think of
some kind of "blackboard" abstraction, something that holds a single data with a
validity stamp (time-based or not) for instance. There is no such object
available in the native API, but this could be easily built out of a semaphore
and common memory, using a shared counter to hold the transmit sequence number.

If you actually don't care for buffering, the other way is to use the message
passing API (i.e. rt_task_send, rt_task_receive, rt_task_reply) to get
synchronous messaging. In that case, the sender would be able to wait for the
receiver to get the status from the serial link. The receiver would send that
answer back to the initiator using rt_task_reply.
This needs XENO_OPT_NATIVE_MPS to be switched on in the kernel config.

-- 
Philippe.

