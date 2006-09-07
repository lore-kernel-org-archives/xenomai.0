Message-ID: <45007DF6.1030807@domain.hid>
Date: Thu, 07 Sep 2006 15:15:50 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Porting / API Questions
References: <44FF3C26.10501@domain.hid> <200609071112.28817.schwab@domain.hid>
In-Reply-To: <200609071112.28817.schwab@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ulrich Schwab <schwab@domain.hid>
Cc: xenomai@xenomai.org

Ulrich Schwab wrote:
> When I did the same switch (9 month ago now) I choose to combine
> the kernel / user space split in one application and switched to the native 
> API at the same time.
> I think it was a good decision, since now the application is independent of 
> the exact kernel version and is easier to debug.
> Only the driver for the analog and digital I/O is still a kernel module (RTDM)
> 
> The RT kernel threads of the original version are now threads of the user 
> space app running in primary mode. This means the split between RT/non-RT
> is basically the same as before, but now they all run in user space.

I'm glad to hear that you were successful with porting your application!  I plan to take a similar approach eventually, but I want to do things one small step at a time.

> Why do You need a FIFO this large ?

I have a whole lot of data coming over the FIFO at a very high rate.  The user-space side also has some graphics routines that have a long latency in certain situations.  The amount of data transferred could be reduced substantially, but not without major changes to the simulation, which I cannot afford to do at the moment.

> Why not using shared memory for the data, and the FIFO for passing
> signals/commands ?

I need to log data, plot, and do other things at certain exact simulation times.  Using shared memory, I cannot guarantee that I will be able to get data with the timestamp I need.  The real-time/user-space partitioning of our simulation is not at all optimal.  Switching to userspace real-time will allow me to do things in a much cleaner way.

Thanks for your input,

Jeff


