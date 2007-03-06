From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
Date: Tue, 6 Mar 2007 17:17:52 +0100
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HObh1-0008VE-H3@domain.hid>
	<bc4264770703060750v171e9c23kd79de79dcdec3169@domain.hid>
In-Reply-To: <bc4264770703060750v171e9c23kd79de79dcdec3169@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOcMA-000340-MK@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:

>
> > - With your application running you state that the real-time behaviour of
> > the system is bad. How do you detect this?
>
> I measure the period times. Here is the snippet
>
>
> void cyclicloop(void *arg)
> {
> 	RTIME now, previous;
>
> 	/*
> 	 * Arguments: &task (NULL=self),
> 	 *            start time,
> 	 *            period (here: 1 ms=1000000)
> 	 */
> 	rt_task_set_periodic(NULL, TM_NOW, TASK_PERIOD);
> 	previous = rt_timer_read();
>
> 	while (!TasksHalt) {
> 		rt_task_wait_period(NULL);
> 		now = rt_timer_read();
> 		//Read inputs here
> 		atm60_configure(can_device);

What does this function do?

> 		//Set analog output here
> 		//Do controller calculations here
>
>
>
>
> 		//Get time period
> 		double TimeVarTemp=(double)(now - previous);
> 		Task1Period=TimeVarTemp/ 1000000;
> 		//printf("Time since last turn: %f ms\n",Task1Period);
> 		previous = now;
>
> 		/*
> 		 * NOTE: printf may have unexpected impact on the timing of
> 		 *       your program. It is used here in the critical loop
> 		 *       only for demonstration purposes.
> 		*/
>
> 	}
> }//cyclicloop

-- 
Sebastian

