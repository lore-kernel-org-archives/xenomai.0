From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] catching CAN errors
Date: Mon, 5 Mar 2007 16:18:14 +0100
References: <bc4264770703030554g658d3284y297b22af22375e0a@domain.hid>
	<E1HOELY-0008UB-JZ@mailer.emlix.com> <45EC2F61.2060307@domain.hid>
In-Reply-To: <45EC2F61.2060307@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOEww-0003QC-3Z@mailer.emlix.com>
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
> Hi,
>
> Sebastian Smolorz wrote:
> > How many messages are you receiving?
>
> How do I count them?

Can you make your sending node send only, let's say, 10 messages and no more? 
Then print out the number of received messages by your application and 
compare.


> > messages sent? Are there also overflows if you use rtcanrecv shipped with
> > Xenomai instead of your app?
>
> Still overflows. I know because I have had it receiving while my
> application was running and when I first picked up the RT degradation I
> turned it off just to see if rtcanrecv was not causing the problem.

Eh ... and what is the situation if you run rtcanrecv without your app?

> >> Is the messagebuffer perhaps not cleaned out when I do a read?
> >
> > The message buffer is cleared unless you use MSG_PEEK.
>
> Ok so we agree that my code snippet as posed should clear out the
> buffer. That doubt is eliminated then.

Yes.

>
> >> I only
> >> get an overflow when the sensor moves and emits readings.
> >
> > Hm, maybe you have another socket bound which you don't read from?
>
> No. I am 100% certain that I only call rt_dev_bind (if it is called
> that) once for my entire application in a kind of init routine. Ah sorry
> I see what you are saying. Well I would have to have another bind to
> rtcan2 as well I presume. And as I say, I only call bind once. But let
> me understand this properly, does that mean that every socket created
> has its own buffer ring?

You got it. And for this reason there can be more than one buffer that 
overflows.

>
> >> the readings
> >> are fine and I don;t have any masks set for errors anyway so I assume
> >> that my reads are not cleaning out the entire buffer. I have pasted in
> >> the code in which I do the reading. Am I doing something wrong?
> >>
> >>
> >>
> >> 	while(ret>=0){
> >> 		ret = rt_dev_recv (can_fd, (void *)&Rxframe,
> >> sizeof(can_frame_t), MSG_DONTWAIT);
> >> 		if (ret < 0) {
> >> 			switch (ret) {
> >> 			case -ETIMEDOUT:
> >> 				printf("rt_dev_recv: timed out");
> >> 				break;
> >> 			case -EBADF:
> >> 				printf("rt_dev_recv: aborted because
> >>                                              socket was closed");
> >> 				break;
> >> 			}
> >> 		}
> >>
> >> 	}//while message buffer not empty
> >> 	//when exiting this loop the message buffer will be empty??????
> >
> > Are you sure this loop gets executed more than a few times? The flag
> > MSG_DONTWAIT indicates that rt_dev_recv shall return with -EAGAIN if the
> > socket buffer is empty. If this is the case the while-loop is left.
> > Further CAN messages would not be read. Maybe this is the reason for the
> > overflows which appear *after* you read a message for the last time.
>
> Sorry Sebastian, I lose you here. I know that -EAGAIN is returned if hte
> socket buffer is empty. But that is the point. I read all messages in
> the buffer until ret=-EAGAIN and that clears out the message buffer.
> Indeed after I have read for the last time my application waits 1ms (or
> what is left of it) then only reads again.

The code above does not state this. I assume this only is the inner snippet 
and the outer loop is missing?

> If my node sends so many 
> messages that I get an overflow in the mean time I will get a syslog
> telling me the buffer is overflowing. This is what I assumed was
> happening. This is what SEEMS to be happening. The thing is that the
> node is supposed to only send one message every ms itself. I will have
> to validate that somehow,

I have another suspicion. Maybe the sending node does not get an acknowledge? 
You don't run the CAN controller in listen only mode, do you? And what about 
termination of your CAN bus?

-- 
Sebastian

