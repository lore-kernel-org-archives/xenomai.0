MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18447.31623.723753.421351@domain.hid>
Date: Wed, 23 Apr 2008 20:10:15 +0200
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<18446.32522.986935.299094@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>
	<2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>
	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or
	xeno--(xenomm-0.0.1) install problem
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
Cc: xenomai-help <xenomai@xenomai.org>

Karch, Joshua wrote:
 > Gilles,
 > 
 > I've attached my old serial port code that uses the /dev/ttyS0 port.
 > What I have here is a "read byte on demand" function that uses the
 > select statement to block until data is ready.  My initial goal was
 > to replicate this functionality using the Xenomai Serial Driver.  It
 > seems, however, that the following is not possible under Xenomai.

It is possible, the serial driver has two things that may help you:
the RTSER_RTIOC_WAIT_EVENT ioctl, which will work like select.
the RTSER_SET_TIMEOUT_RX configuration bit, that will let you define a
timeout for data reception. 
If you wonder where these things are documented, have a look at:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.html

With a timeout on reception, you can call read directly, this will save
you a system call, this matters for latency.

 > What I'm starting to conclude is that I can only receive data from a
 > serial port within the context of a task, and that printing error
 > codes from strerr produce "Operation not permitted" If I directly call
 > read in a manner similar to the linux serial port code (posted below)
 > by requesting a read from my sensor packet processing thread without
 > using an RT_TASK.  Here is what my sensor thread used to do to get
 > data from /dev/ttyS0 
 > 
 > 
 > in the Pthread sensor processing thread...
 > 
 > void sensorthreadmainloop()
 > {
 >     while(1)
 >     {
 > 
 > 	if(serialport->readbyte())
 > 			{
 > 				SENSORID=sensorpacket->processChar(ser->getreadbyte());
 > 			}
 > 			else
 > 			{
 > 				printf("One Second timeout detected on serial port, sensor data not received\n");
 > 			}
 > 			
 >                         // measure timestamp, process byte, checksum, etc, if timestamp is too
 >                         //great an error has occurred, etc.  If valid packet is received, send a
 >                         //condition variable signal to the main loop that data is available
 >                         //break out of loop if the application requests thread termination
 >                         .
 >                         .
 >                         .
 >                         //
 >     }
 > }
 > 
 > It appears that I have to do something else with Xenomai-- set up a real time task which reads bytes from the rtser0 device. 
 > When data is received, trigger a semaphore/condition variable to the above thread that one byte is ready for processing.
 > 
 > What this basically means is that I would have an rt task like the following in the serial port reader code where the task has been pre-initialized and started. 
 >  
 > void read_task_proc(void *arg)
 > {
 > 	while (1)
 >         {
 > 		int read = rt_dev_read(read_fd, inbyte, 2250);
 > 		if (read <0) {
 > 			printf("error on rt_dev_read, code %s\n",
 > 			       strerror(-err));
 > 			break;
 > 		}
 >                 else
 >                 {
 >                           //data received, trigger  condition variable
 > 			  pthread_mutex_lock(&run_mutex);
 > 		          pthread_cond_signal(&run_cv);
 > 			  pthread_mutex_unlock(&run_mutex);
 > 
 > 		}
 > 
 > 	}
 > 
 > 
 > }
 > 
 > In my sensor  thread I would have the following:
 > 
 > void sensorthreadmainloop()
 > {
 >     while(1)
 >     {
 > 
 > 	
 > 		pthread_mutex_lock(&run_mutex);
 > 		pthread_cond_wait(&run_cv, &run_mutex);
 > 		pthread_mutex_unlock(&run_mutex);
 >                 //if data received
 > 		SENSORID=sensorpacket->processChar(ser->getreadbyte());
 > 		//and figure out a way to signal other important information such as timeouts	
 >                         // measure timestamp, process byte, checksum, etc, if timestamp is too
 >                         //great an error has occurred, etc.  If valid packet is received, send a
 >                         //condition variable signal to the main loop that a completed sensor packet is available
 >                         //break out of loop if the application requests thread termination
 >                         .
 >                         .
 >                         .
 >                         //
 >     }
 > }
 > If I use a condition variable from a continuously running RT_TASK that reads from the serial port to trigger processing, is that the right way to make this work? 
 > Can I mix pthreads, mutexes, and tasks together, or should every
 > thread my program has (and it reads 3 sensors using the above
 > methods) all use RT_TASKS and specially set up Mutexes/Condition
 > variables. 

Everything is possible, but let us keep something in mind: if you use
Xenomai it is because you are not satisfied with Linux natural
latency. You probably have some treatment to do upon reception of a
character on the serial line, some time of real-time control loop. If:
- you transfer control from the real time task receiving characters to a
  non real-time task to to the treatment;
- or you call some non real-time services from the task receiving
  characters; 
- or you have the real-time task receiving character wait for a non
  real-time task;
the real-time task receiving characters from the serial line will depend
on Linux latencies. In other words, you loose any interest in using
Xenomai.

-- 


					    Gilles.

