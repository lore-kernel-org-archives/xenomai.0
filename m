MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.11276.526008.229326@domain.hid>
Date: Thu, 24 Apr 2008 08:43:24 +0200
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<18446.32522.986935.299094@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>
	<2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>
	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
	<18447.31623.723753.421351@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
	<18447.43488.713144.166771@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK
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
 > Gilles, (and anyone else who has had overrun errors or has experience with the Xenomai serial port driver)
 > 
 > It seems that even though I turned off fprintf and even though I stopped logging to disk, I still get the same number of overrun errors.  I broke the loop down to the bare basics.
 > 
 > my task now consists of the following
 > 
 > Task was launched as follows:rt_task_create(&read_task, "read_task", 0, 51, 0);
 > 
 > 
 > void sensor::mainloop()
 > {
 > 
 > 
 > 	//set up serial read
 > 	struct rtser_event rx_event;
 > 	rtser_status_t serstatus;
 > 	int numread,err;
 > 
 > 		 while(1)
 > 		 {
 > 			if(exitprogram)		//
 > 				 break;
 > 
 > 			err = rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);
 > 

As I already said, using read with timeout directly without first
calling ioctl leads to a better latency because of the fewer system
calls.

 > 			if (err)
 > 			{
 > 				printf(RTASK_PREFIX
 > 					       "error on RTSER_RTIOC_WAIT_EVENT, %s\n",
 > 				  strerror(-err));
 > 				err = rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatus);
 > 				printf(RTASK_PREFIX "Error code line_status=%d modem_status=%d\n",serstatus.line_status, serstatus.modem_status);
 > 
 > 			}
 > 
 > 			else
 > 			{
 > 				numread = rt_dev_read(read_fd, buf, 1);
 > 				{
 > 					printf(RTASK_PREFIX "error on rt_dev_read, code %d %s\n",numread,
 > 					       strerror(-numread));
 > 					err = rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatus);
 > 					printf(RTASK_PREFIX "Error code line_status=%d modem_status=%d\n",serstatus.line_status, serstatus.modem_status);
 > 					continue;
 > 				}
 > 			else
 > 			{
 > 				err = rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatus);  //if data received normally, make sure 96 was received, 98 = overrun
 > 				if(!serstatus.line_status==96)
 > 				printf(RTASK_PREFIX "Error code line_status=%d modem_status=%d\n",serstatus.line_status, serstatus.modem_status);
 > 			}

On compilers I know if () { } else { } else {} does not even
compile. Are you sure you are showing us the code you are really running
? Have you tried T_WARNSW as I suggested in a previous mail ?

At what frequency do characters arrive on the serial line ? Did you try
to run the latency test with the same frequency to see if Xenomai on
your hardware is able to support this frequency ? Try latency -t 1 or -t
2 to see if switching to kernel-space would improve situation. Do you
observe unexpected peaks (such as those caused by SMIs) when running
latency ?

Is not it possible to enable hardware buffering so as to receive more
than one character at a time when overflow occurs ?

If you need ultra-high frequencies, you should probably write some part
of your application (at least the real-time control loop) in
kernel-space.

-- 


					    Gilles.

