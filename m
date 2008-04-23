MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18446.32522.986935.299094@domain.hid>
Date: Wed, 23 Apr 2008 02:12:58 +0200
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or
	xeno--	(xenomm-0.0.1) install problem
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
 > I recently installed Xenomai on a PC/104 and began writing a C++ program that makes use of the serial port.  I tried using the Xenomai Serial port example program cross-link.c and I was successful in getting that to run. I edited cross-link.c to read only from a device running at 115200 on the serial port.  I have found the standard /dev/ttyS0 serial port to be useless for my application since I get overrun errors on my system.  
 > 
 > My C++ program reads byte at a time from a serial port, processes the byte, then repeats until a checksummed packet is received.  I have two specific questions as to how to get the serial port to work under Xenomai with c++
 > 
 > The way I understand port reading is as follows:
 > 
 > 1) Open device using read_fd = rt_dev_open( READ_FILE, 0 ) and set it up
 >     err = rt_dev_ioctl(read_fd, RTSER_RTIOC_SET_CONFIG, &read_config);
 > 2) It is necessary to create an RT_TASK analogous to a thread to service the serial port task
 >     err = rt_task_create(&read_task, "read_task", 0, 51, 0);
 > 3) for each byte read, activate the read task with rt_task_start
 >     err = rt_task_start(&read_task,&read_task_proc,NULL);

I do not think it is a good idea to call rt_task_start for each byte
read. At least, I do not think it is what rt_task_start was initially
designed for.

 >     4) Within the Real Time read_task_proc, request one byte at a time within the rt_task_process using
 >         err = rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);
 >         read = rt_dev_read(read_fd, buffer, 1);

What is the point of waiting for an event before reading ? If you read
directly, it will make one less system call, and rt_dev_read will
block just like rt_dev_ioctl.

 > 5)  read from the buffer into the user application in non-real time mode
 > 
 > 6)  close when done
 > 
 > The problem I am having with this method is that 
 > int 	rt_task_start (RT_TASK *task, void(*fun)(void *cookie), void *cookie)
 > won't accept a pointer to an object method and requires a pointer to an instance to map into the void(*fun)(void *cookie), void *cookie section.
 > 
 > With Pthreads, I instantiate a threaded main loop within an object as follows:
 > void * serial::thunk(void * param)
 > {
 > 	serial *instance = (serial *) param;
 > 	instance->read_task_proc();
 > 
 > }

 > 
 > Is there a similar way to do this with rt_tasks?  In particular, if a c++ based serial read example were available for byte-at-a-time, that would be very useful.

There is no difference between pthread_create and rt_task_start. The
usual trick is to pass them a pointer to a class static method: a class
static method pointer is a valid C function pointer.

 > 
 > Also, xenomm-0.0.1 failed under ./configure with "checking value of TM_UNSET in native/timer.h"-- any ideas on how to get xenomm (xeno--) working?

Maybe xenomm was made for an earlier version of xenomai and has not been
updated since Xenomai was updated ?

 >  Is it useful?

I guess it has a nice C++ wrapper class to rt_task_create/rt_task_start.

-- 


					    Gilles.

