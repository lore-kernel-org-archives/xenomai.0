Message-ID: <bc4264770702281000g248e1964hba0ff19a0988f82f@domain.hid>
Date: Wed, 28 Feb 2007 18:00:39 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] warnings and tangled threads.
In-Reply-To: <45E5357B.4090107@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702271525q6d5d164lfa34b421a64eeb70@domain.hid>
	<45E5357B.4090107@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

HI

> That seems to be due to non-default -Wmissing-field-initializers, right?
> Will have a look if we can quiet gcc.
Possible.  I have received your patch. Will apply it (have to figure
out how first) later and give feedback.



> > If rtcanrecv is not running then my application has no problems. I can
> > see that it is writing by reading out /proc/rtcan/rtcan0/info looking
> > at TxCount.
> >
> > I call can_write() directly after rt_task_wait_period so i did not
> > think it necessary to use rt_task_shadow or such like in it.
>
> rt_task_shadow() is required if you call blocking services like
> rt_task_wait_period from a task AND you didn't create it via some other
> native service (rt_task_spawn or rt_task_create/start).
Well then my code should be correct.


> If the problem persists even with clean rt_task setup (rt_task_shadow
> etc.), I guess it's best you post your code.
Without changing my code I cannot repeat the behavior myself. Very
strange. I have tried just about everything but after starting up the
PC this morning there is no way I can repeat the behaviour I describe
above.

So the can_write seems to be working for now. If it happens again I
will post the code.


I have more of a problem with reading. I am doing something wrong. The
program does not return from the call rt_dev_recvfrom. Below is the
simple read function I am presuming that whatever I am doing wrong
will be blatantly obvious to all except me:)

void can_read(const char * device, can_frame_t * frame){

	int  ret;
    	struct ifreq ifr;
	struct sockaddr_can addr;
    	socklen_t addrlen = sizeof(addr);
	struct sockaddr_can recv_addr;

	strncpy(ifr.ifr_name, device, IFNAMSIZ);
	ret = rt_dev_ioctl(can_fd, SIOCGIFINDEX, &ifr);
	if (ret < 0) {
		fprintf(stderr, "rt_dev_ioctl get index: %s\n", strerror(-ret));
		return;
	}

	recv_addr.can_family = AF_CAN;
    	recv_addr.can_ifindex = ifr.ifr_ifindex;
    	ret = rt_dev_bind(can_fd, (struct sockaddr *)&recv_addr,
sizeof(struct sockaddr_can));

	if (ret < 0) {
		fprintf(stderr, "rt_dev_bind: %s\n", strerror(-ret));
		return;
	}
	
printf("going in");
	ret = rt_dev_recvfrom(can_fd, (void *)frame, sizeof(can_frame_t), 0,
(struct sockaddr *)&addr, &addrlen);
printf("coming out");


}//can_read


Regards,

Roland




>
> Jan
>
>
>

