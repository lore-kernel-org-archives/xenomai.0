Message-ID: <bc4264770703060750v171e9c23kd79de79dcdec3169@domain.hid>
Date: Tue, 6 Mar 2007 15:50:14 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
In-Reply-To: <E1HObh1-0008VE-H3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HObQ1-00073u-B9@domain.hid>
	<bc4264770703060723i66a0fa71sb138c0f2c839b314@domain.hid>
	<E1HObh1-0008VE-H3@domain.hid>
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

Hi

> So let me summarise:
> - With rtcansend/rtcanrecv and without your application the communication with
> the node is perfect (overflows?)
No more overflows. Nowhere. Have the debug messaging back on,
everything is quiet. Especially witht he blocking mode construction
overflowing should (and is) be impossible.

> - With your application running you state that the real-time behaviour of the
> system is bad. How do you detect this?
I measure the period times. Here is the snippet


void cyclicloop(void *arg)
{
	RTIME now, previous;

	/*
	 * Arguments: &task (NULL=self),
	 *            start time,
	 *            period (here: 1 ms=1000000)
	 */
	rt_task_set_periodic(NULL, TM_NOW, TASK_PERIOD);
	previous = rt_timer_read();

	while (!TasksHalt) {
		rt_task_wait_period(NULL);
		now = rt_timer_read();
		//Read inputs here
		atm60_configure(can_device);	
		//Set analog output here
		//Do controller calculations here
		

		
		
		//Get time period
		double TimeVarTemp=(double)(now - previous);
		Task1Period=TimeVarTemp/ 1000000;
		//printf("Time since last turn: %f ms\n",Task1Period);
		previous = now;

		/*
		 * NOTE: printf may have unexpected impact on the timing of
		 *       your program. It is used here in the critical loop
		 *       only for demonstration purposes.
		*/
		
	}
}//cyclicloop

void catch_signal(int sig)
{
}


void task1(void)
{
	signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);

	// Avoids memory swapping for this program
	//Not necessary here because QTThread must take care of this.Only
needed once inthe entire program (multithread) Jan Kizka email
	//Apparently IS necessary application otherwise seems to crash.
placed in main()
	//mlockall(MCL_CURRENT|MCL_FUTURE);

	//
	 // Arguments: &task,
	 //            name,  [Name must be unique for each task]
	 //            stack size (0=default),
	 //            priority,
	 //            mode (FPU, start suspended, ...)
	 //
	rt_task_create(&rt_task_1, "rt_task1", 0, 99, 0);

	//
	 // Arguments: &task,
	 //            task function,
	 //            function argument
	 //
	rt_task_start(&rt_task_1, &cyclicloop, NULL);

	//if(!Task1Halt)
	//	pause();

	//rt_task_delete(&rt_task_1);

}

its actually straight from the trivial task example. The TaskPeriod1
is a global variable which is displayed in another thread every 0.5
seconds.

Roland


>
> --
> Sebastian
>

