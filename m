From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] catching CAN errors
Date: Mon, 5 Mar 2007 15:39:37 +0100
References: <bc4264770703030554g658d3284y297b22af22375e0a@domain.hid>
	<E1HODPx-0003WJ-5L@mailer.emlix.com> <45EC2457.70100@domain.hid>
In-Reply-To: <45EC2457.70100@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOELY-0008UB-JZ@mailer.emlix.com>
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
> True. Very true. Well lets pursue this line of thought then. My node is
> set to sending 1 message every 1ms if the position changes. I am reading
> out the message buffer and it seems to work. But in theory I should only
> be findin 1 or zero messages in the buffer every time I read. Why don't
> I?

How many messages are you receiving? What are their contents compared to the 
messages sent? Are there also overflows if you use rtcanrecv shipped with 
Xenomai instead of your app?

> Is the messagebuffer perhaps not cleaned out when I do a read?

The message buffer is cleared unless you use MSG_PEEK.

> I only  
> get an overflow when the sensor moves and emits readings.

Hm, maybe you have another socket bound which you don't read from?

> the readings 
> are fine and I don;t have any masks set for errors anyway so I assume
> that my reads are not cleaning out the entire buffer. I have pasted in
> the code in which I do the reading. Am I doing something wrong?
>
>
>
> 	while(ret>=0){
> 		ret = rt_dev_recv (can_fd, (void *)&Rxframe,
> sizeof(can_frame_t), MSG_DONTWAIT);
> 		if (ret < 0) {
> 			switch (ret) {
> 			case -ETIMEDOUT:
> 				printf("rt_dev_recv: timed out");
> 				break;
> 			case -EBADF:
> 				printf("rt_dev_recv: aborted because
>                                              socket was closed");
> 				break;
> 			}
> 		}
>
> 	}//while message buffer not empty
> 	//when exiting this loop the message buffer will be empty??????

Are you sure this loop gets executed more than a few times? The flag 
MSG_DONTWAIT indicates that rt_dev_recv shall return with -EAGAIN if the 
socket buffer is empty. If this is the case the while-loop is left. Further 
CAN messages would not be read. Maybe this is the reason for the overflows 
which appear *after* you read a message for the last time.

--
Sebastian

