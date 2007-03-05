Message-ID: <45EC2457.70100@domain.hid>
Date: Mon, 05 Mar 2007 15:08:23 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] catching CAN errors
References: <bc4264770703030554g658d3284y297b22af22375e0a@domain.hid>
	<E1HOBgg-0003Pi-DR@mailer.emlix.com> <45EC0970.1060606@domain.hid>
	<E1HODPx-0003WJ-5L@mailer.emlix.com>
In-Reply-To: <E1HODPx-0003WJ-5L@mailer.emlix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Hi,

>> the overflowing of the buffer.
> 
> CAN socket buffer overflow --> kernel prints warnings --> syslogd logs these 
> warnings
thanks this helps.

> As I stated in another mail you can silence the overflow message by 
> configuring it out. But ask yourself if this is really what you want. Losing 
> messages due to an overflowing buffer is nothing that should appear regularly 
> but rather as exception. The kernel message is meant to inform you of this 
> exceptional situation. If you lose messages under RT conditions you very 
> likely have more severe problems than a kernel printing out too much 
> information.
True. Very true. Well lets pursue this line of thought then. My node is 
set to sending 1 message every 1ms if the position changes. I am reading 
out the message buffer and it seems to work. But in theory I should only 
be findin 1 or zero messages in the buffer every time I read. Why don't 
I? Is the messagebuffer perhaps not cleaned out when I do a read? I only 
get an overflow when the sensor moves and emits readings. the readings 
are fine and I don;t have any masks set for errors anyway so I assume 
that my reads are not cleaning out the entire buffer. I have pasted in 
the code in which I do the reading. Am I doing something wrong?



	while(ret>=0){
		ret = rt_dev_recv (can_fd, (void *)&Rxframe, 			  			 
sizeof(can_frame_t), MSG_DONTWAIT);
		if (ret < 0) {
			switch (ret) {
			case -ETIMEDOUT:
				printf("rt_dev_recv: timed out");
				break;
			case -EBADF:
				printf("rt_dev_recv: aborted because
                                             socket was closed");
				break;
			}
		}

	}//while message buffer not empty
	//when exiting this loop the message buffer will be empty??????

I have cleared out some of the code in the loop for selecting the 
message I want and so on but it will in essence not influence the 
beahvior above.

> 
> Right. In fact, for the RAW protocol layer this is the very same situation as 
> with the error frames. In my opinion, a clean design approach is not to 
> silence the warnings because the discarding of CAN frames takes place 
> regardless of this. I think you have to options:
> 1. If messages are lost sporadically try to enlarge the socker buffer size.
Have considered this but it will slow down the reading routine (while 
loop in above snippet runs longer)

> 2. If messages are lost permanently your real-time task is overloaded. Try to 
> lower the baud rate, set an appropriate filter or, more likely, rethink your 
> whole system design. 
The design should be right. At the moment I am only looking for one 
message and only one message seems to be filling the message buffer. 
Filtering that will give me no reading.

If CAN frames are piling up in the socket buffer and
> your application isn't quick enough to read them out although it does nothing 
> else than receiving them, then there is something going wrong.
Probably. Hope you see something wrong in the reading loop.

According to the documentation a normal recv will remove the message 
from the buffer unless PEAK_something flag is used. So I assume that I 
am clearing out the buffer in the above code.

Regard,s

Roland

> 
> --
> Sebastian
> 

