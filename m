From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <2a9546e00706212247y667294d9u7d1d0a596f6b3a4a@domain.hid>
References: <2a9546e00706212247y667294d9u7d1d0a596f6b3a4a@domain.hid>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 11:09:34 +0200
Message-Id: <1182503374.13115.31.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] why use xenomai over linux
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: sanjeev sharma <sanjeevsharmaengg@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2007-06-22 at 11:17 +0530, sanjeev sharma wrote:
> hi ,
>  
> we have Xenomai realtime process with priority 99, and alarm is  fired
> every 2ms, in this Xenomai process we write to the pipe once alarm is
> fired.
> on the Linux domian we have a process which opens the same Xenomai
> pipe and reads the pipe, there are counters variables in Xenomai and
> Linux domain, we are passing the count value which gets incremented
> after each alarm, and we are checking difference of the counts in the
> Linux process once we read the data from pipe, 
> if the difference is greater than 1, we say Linux has lost the data,
> it failed to read the pipe. 
>  
> this we ran for overnightand did not fail. its good.
> even chekced with both process being Xenomai realtime and its gives
> the same result for overnight. 
>  
>  
> please clerify this doubt, as Linux process can handle only for 10ms

This assumption is terminally flawed.

>  how is it able to read data even for 2ms .
>  
> when we run for 500us time, write operation fails as it runs out of
> internal buffer of the pipe, is it because the pipe is not read from
> linux process. in case if we increase the buffer length it will
> generate theerror on writing after more delayed time, what could be
> the reason for this, we are balnk here, any pointers please.
>  

You must be kidding, right?

> one more question, 
>  
> are we comparing apple to apple here as Xenomai is a realtime process
> it will able to write even at 500us time. I think to compare I should
> make two linux process one on everytimer interrupt should write to
> pipe and another linux process should read and then I should compare
> this with above one making it apple to apple.
>  
> may be this will prove why use Xenomai over Linux,

Yeah, after all these years, this crucial issue is still tormenting me
too.

>  we are in the process of giving this data to the client to use
> Xenomai, please clarify.


This list is meant to help Xenomai users, not as a channel for cheap
pre-sale support.

>  
> we are using Montavista Linux .
> please comment on my undertsanding.
>  

Nope, I think you would not like it. And please, stop sending me private
copies of unanswered mails you previously sent to the mailing list. If
nobody did care to answer them already, it's either because nobody had
any interesting information to share, or nobody found anything
interesting in your mail; pick the explanation that fits.

> below is the code for xenomai and Linux process.
>  

If you really want to get serious about testing predictability when it
comes to interrupt and scheduling latencies,
try /usr/xenomai/share/xenomai/testsuite/{latency, cyclictest}. Both of
them have been specifically designed to illustrate the issue, and those
are even free.

>  
>  Xenomai process firing alarm and writing to pipe.
> 
> /************************************************************
> 
> * This program illustrate How to trigger an Alarm in Xenomai*
> 
> * user space program afetr a interval of 100 ms and pass data 
> 
> * to linux domain through pipe. *
> 
> ************************************************************/
> 
> /* Include Files */
> 
> #include <stdio.h>
> 
> #include <native/task.h>
> 
> #include <sys/mman.h>
> 
> #include <native/pipe.h>
> 
> #include <unistd.h>
> 
> #include <native/alarm.h>
> 
> #include <native/timer.h>
> 
> /* Global variables */
> 
> RT_TASK task; /* Task Descriptor */
> 
> RT_PIPE rt_pipe; /* Pipe Descriptor */
> 
> RT_ALARM alarm_desc;
> 
> #define ALARM_VALUE 4 /*Alarm value given in ticks */
> 
> /*200 tick=100 ms if period = 500000*/
> 
>  
> 
> #define ALARM_INTERVAL 4 /* Period in ticks */
> 
> /*200 tick=100 ms if period = 500000*/
> 
> /* Real Time task's Function body */
> 
> void task_body (void *cookie)
> 
> {
> 
> int err,i;
> 
> unsigned long int xenomai_counter =0;
> 
> printf("Creating the RT Pipe\n");
> 
> err = rt_pipe_create(&rt_pipe, "Xenomai_pipe",4,0); /* Creating a pipe
> with name as pipe, minor number as 4*/
> 
> if (err !=0)
> 
> printf("Error in creating pipe\n");
> 
> else
> 
> printf("pipe created \n");
> 
> while(1)
> 
> {
> 
> /* Wait for the next alarm to trigger. */
> 
> err = rt_alarm_wait (&alarm_desc);
> 
> if (err != 0)
> 
> {
> 
> printf ("Rt_alarm_wait return with error and return value is=%d\n",
> 
> err);
> 
> }
> 
> /*Writing data on the pipe*/
> 
> xenomai_counter++;
> 
> err = rt_pipe_write(&rt_pipe, &xenomai_counter,
> sizeof(xenomai_counter), P_NORMAL);
> 
> if (err < 0)
> 
> {
> 
> printf("Error in writing = %d\n",err);
> 
> exit(0);
> 
> }
> 
> }
> 
> rt_task_sleep(250); 
> 
> err = rt_pipe_delete(&rt_pipe); /* Delete the pipe descriptor */
> 
> if (err != 0 )
> 
> printf("Error in deleting the pipe\n");
> 
> else
> 
> printf("Successful in deleting the pipe\n");
> 
> exit(0);
> 
> }
> 
> int main (int argc, char **argv)
> 
> {
> 
> int err;
> 
> mlockall(MCL_CURRENT | MCL_FUTURE); /* Locking the current pages for
> the realtime task from swapping */
> 
> /* Create an Alarm... */
> 
> err = rt_alarm_create (&alarm_desc, "Xenomai_Alarm");
> 
> if (err != 0)
> 
> {
> 
> printf ("Error encounter while created Alarm and retrun value is =%d
> \n",
> 
> err);
> 
> }
> 
> /*start an Alarm */
> 
> err = rt_alarm_start (&alarm_desc, ALARM_VALUE, ALARM_INTERVAL);
> 
> if (err != 0)
> 
> {
> 
> printf
> 
> ("Problem encounter while Starting an Alarm and retrun value is =%d
> \n",
> 
> err);
> 
> }
> 
>  
> 
> /* Creating Task with name mytask, stack size will be allocated by
> Kernel as by passing 0, priority as 1*/
> 
> err = rt_task_create(&task,"Xenomai_task",0,99,T_FPU); 
> 
> if (err)
> 
> {
> 
> fprintf(stderr,"failed to create task, code %d\n",err);
> 
> return 0;
> 
> }
> 
> /* Starting the task execution */
> 
> err = rt_task_start(&task,&task_body,NULL);
> 
> if (err)
> 
> {
> 
> fprintf(stderr,"failed to start task, code %d\n",err);
> 
> return 0;
> 
> }
> 
> pause(); /* This function should be ther to make the parent to be in
> existence this can be achived by 
> 
> making task as joinable and waiting for that to complete */
> 
> // return 0;
> 
> }
> 
> 
>  
> Linux process reading from pipe.
>  
>  
>  
> /************************************************************
> 
> * This program illustrate the linux process communication **
> 
> * with Xenomai through reading on pipe **
> 
> ************************************************************/
> 
> #include <stdio.h>
> 
> #include <unistd.h>
> 
> #include <sys/types.h>
> 
> #include <sys/stat.h>
> 
> #include <fcntl.h>
> 
>  
> 
> int main()
> 
> {
> 
> int ret;
> 
> int fd,i;
> 
> unsigned long int Xenomai_counter;
> 
> unsigned long int Linux_counter=0;
> 
> unsigned long int Xenomai_linux_diff; 
> 
> printf("Opening the pipe\n"); 
> 
> fd = open("/dev/rtp4",O_RDWR); /* openning the pipe device file rtp4
> as xenomai task creates pipe 
> 
> with minor 4 */
> 
> if (fd < 0)
> 
> {
> 
> printf("Error in opening file descriptor = %d\n",fd);
> 
> exit(0);
> 
> }
> 
> while(1)
> 
> { 
> 
> /*read from pipe*/
> 
> ret = read(fd, &Xenomai_counter, (sizeof(Xenomai_counter)+1));
> 
> if (ret > 0)
> 
> printf("The data bytes read from pipe are =%d\n and the data is = %ld
> \n",ret,Xenomai_counter);
> 
> Xenomai_linux_diff=Xenomai_counter-Linux_counter;
> 
>  
> 
> if(Xenomai_linux_diff>1)
> 
> {
> 
> printf("Interrupt is missed------->>> TEST FAILED\n");
> 
> break;
> 
> }
> 
> else
> 
> {
> 
> printf("TEST PASSED->>>\n");
> 
> }
> 
>  
> 
> Linux_counter++; 
> 
> }
> 
> printf("FAILED FAILED FAILED FAILED\n");
> 
> close(fd);
> 
> exit(0);
> 
>  
> 
>  
> 
> } 
> 
>  
> 
> Reading pipe from Xenomai context:
> 
>  
> 
> * This program illustrate the linux process communication **
> 
> * with Xenomai through reading on pipe **
> 
> ************************************************************/
> 
> #include <stdio.h>
> 
> #include <sys/types.h>
> 
> #include <native/task.h>
> 
> #include <sys/mman.h>
> 
> #include <native/pipe.h>
> 
> #include <unistd.h>
> 
> #include <native/alarm.h>
> 
> #include <native/timer.h>
> 
> #include <sys/stat.h>
> 
> #include <fcntl.h>
> 
> /* Global variables */
> 
> RT_TASK task; /* Task Descriptor */
> 
> /* Real Time task's Function body */
> 
> void task_body (void *cookie)
> 
> {
> 
> int ret;
> 
> int fd,i;
> 
> unsigned long int Xenomai_counter;
> 
> unsigned long int Linux_counter=0;
> 
> unsigned long int Xenomai_linux_diff; 
> 
> printf("inside rt task\n");
> 
> printf("Opening the pipe\n"); 
> 
> fd = open("/dev/rtp4",O_RDWR); /* openning the pipe device file rtp4
> as xenomai task creates pipe 
> 
> with minor 4 */
> 
> if (fd < 0)
> 
> {
> 
> printf("Error in opening file descriptor = %d\n",fd);
> 
> exit(0);
> 
> }
> 
> while(1)
> 
> { 
> 
> /*read from pipe*/
> 
> ret = read(fd, &Xenomai_counter, (sizeof(Xenomai_counter)+1));
> 
> if((Xenomai_counter%10000) ==0)
> 
> printf("\n Xenomai_counter value =%ld\n",Xenomai_counter); 
> 
> Xenomai_linux_diff= Xenomai_counter-Linux_counter;
> 
>  
> 
> if(Xenomai_linux_diff>1)
> 
> {
> 
> printf("\nInterrupt is missed------->>> TEST FAILED\n");
> 
> printf("\n Exiting\n"); 
> 
> break;
> 
> }
> 
> Linux_counter++; 
> 
> }
> 
> printf("FAILED FAILED FAILED FAILED\n");
> 
> close(fd);
> 
>  
> 
> }
> 
> int main (int argc, char **argv)
> 
> {
> 
> int err;
> 
> mlockall(MCL_CURRENT | MCL_FUTURE); /* Locking the current pages for
> the realtime task from swapping */
> 
> /* Creating Task with name mytask, stack size will be allocated by
> Kernel as by passing 0, priority as 1*/
> 
> err = rt_task_create(&task,"Xenomai_Linux_task",0,99,T_FPU); 
> 
> if (err)
> 
> {
> 
> fprintf(stderr,"failed to create task, code %d\n",err);
> 
> return 0;
> 
> }
> 
> printf("rt task created\n");
> 
> /* Starting the task execution */
> 
> err = rt_task_start(&task,&task_body,NULL);
> 
> if (err)
> 
> {
> 
> fprintf(stderr,"failed to start task, code %d\n",err);
> 
> return 0;
> 
> }
> 
> pause(); /* This function should be ther to make the parent to be in
> existence this can be achived by 
> 
> making task as joinable and waiting for that to complete */
> 
> // return 0;
> 
> }
> 
>  
> 
> Thanks and Regards
> 
> san
> 
>  
> 
> 
>  
>  
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



