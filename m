Message-ID: <2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>
Date: Mon, 19 May 2008 14:32:52 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Mon, May 19, 2008 at 2:14 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Hello,
>
> I ve a problem with my software application. I use Linux kernel 2.6.23
> patched Xenomai 2.4.2. My hardware is an ETX module with AMD Geode
> Processor.
>
> I wrote a test program to explain my problem. This crashes my system and I
> must reboot it. I think there is a bug when a thread calls Linux write
> function and when in the same time, a signal is catched to indicate a
> time-out end.
>
> My test program :
> Two threads are created :
> TimeOut thread : with the higher priority, creates dynamically TimeOut and
> waits theirs ends. This thread uses Display function (with Linux write
> function) to display debug traces.
> Display thread : uses Display function in a loop.
>
>
> /***********************************************************************************/
>
> #include <sys/mman.h>
> #include <pthread.h>
> #include <unistd.h>
> #include <sys/time.h>
> #include <string.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdbool.h>
> #include <stdarg.h>
> #include <time.h>
> #include <math.h>
> #include <signal.h>
> #include <semaphore.h>
> #include <errno.h>
>
> #define STACKSIZE 350
>
> // stack
> static int Stack[STACKSIZE];
> static unsigned short Write_ptr = 0;
> static unsigned short Read_ptr = 0;
>
> // Display
> pthread_mutex_t lockDisplay;
> unsigned char bufferDisplay[2048];
>
> // Timer
> struct stTimeOut {
>       timer_t timer_h;
>       struct sigaction    sa;
>       struct sigevent     sig_spec;
>       struct itimerspec   tmr_setting;
>       int number;
> }*timeOut0_ptr, *timeOut1_ptr, *timeOut2_ptr;
>
> // Thread start
> pthread_cond_t  start_signal;
> pthread_mutex_t main_start_lock;
> pthread_cond_t  EndTimeOut_signal;
> pthread_mutex_t TimeOut_lock;
>
> /************************ Stack functions *************************/
>
> int StackCreation(void)
> {
>        Write_ptr = 0;
>        Read_ptr  = 0;
>        return 0;
> }
>
> void StackWrite(int number)
> {
>        if (Write_ptr >= STACKSIZE)
>        {
>                Write_ptr = 0;
>        }
>        Stack[Write_ptr++] = number;
> }

Note that this function is not atomic. You should probably add a mutex.

>
> int StackRead(void)
> {
>        int number;
>        if (Read_ptr >= STACKSIZE)
>        {
>                Read_ptr = 0;
>        }
>        number = Stack[Read_ptr++];
>        return number;
> }
>
> unsigned short GetWritePtr(void)
> {
>        return Write_ptr;
> }
>
> unsigned short GetReadPtr(void)
> {
>        return Read_ptr;
> }
>
>
> /************************ Functions ******************************/
> void display(char * chaine,...)
> {
>        pthread_mutex_lock(&lockDisplay);
>        va_list ArgDisplay;
>        va_start(ArgDisplay, chaine);
>        vsprintf((char *)bufferDisplay,chaine,ArgDisplay);
>        write(2, (char*)bufferDisplay, strlen((char *)bufferDisplay));
>        pthread_mutex_unlock(&lockDisplay);
> }

There is no point in doing this. Really, using fprintf(stderr) makes
no difference. If you are looking for a display function that does not
make you leave the primary mode, you should use the rt_printf function
declared in the rtdk.h

>
> int func(volatile int* i)
> {
>        return (*i)++;
> }
>
> void DeleteTimer(timer_t timer)
> {
>        if (timer!=NULL)
>        {
>                timer_delete(timer);
>        }
> }
>
> void EndTimeOut (int signo,siginfo_t *info,void*context)
> {
>        volatile int i, result = 0;
>        DeleteTimer(((struct stTimeOut*)(info->si_value.sival_ptr))->timer_h);
>
>        StackWrite(((struct stTimeOut*)(info->si_value.sival_ptr))->number);

I am not sure info->si_value.sival_ptr is what you think it is. This
is probably a bug in Xenomai.

>
>        pthread_mutex_lock(&TimeOut_lock);
>        pthread_cond_broadcast(&EndTimeOut_signal);
>        pthread_mutex_unlock(&TimeOut_lock);
> }
>
> void StartTimeOut (int nb_Sec, int nb_nSec, struct stTimeOut* timeOut)
> {
>        (timeOut->sa).sa_flags = SA_SIGINFO;
>        (timeOut->sa).sa_sigaction = EndTimeOut;
>
>        if(sigaction(SIGRTMIN, &(timeOut->sa), NULL)==-1)
>        {
>                display("sigaction error - errno : %d  -> %s\n",errno,
> strerror(errno));
>        }
>
>        (timeOut->sig_spec).sigev_notify = SIGEV_SIGNAL;
>        (timeOut->sig_spec).sigev_signo = SIGRTMIN;
>        (timeOut->sig_spec).sigev_value.sival_ptr = timeOut;
>
>        if (timer_create(CLOCK_REALTIME, &(timeOut->sig_spec),
> &(timeOut->timer_h)) == -1)
>        {
>                display("timer_create error - errno : %d  -> %s\n",errno,
> strerror(errno));
>        }
>
>        (timeOut->tmr_setting).it_value.tv_sec = nb_Sec;
>        (timeOut->tmr_setting).it_value.tv_nsec = nb_nSec;
>        (timeOut->tmr_setting).it_interval.tv_sec = 0;
>        (timeOut->tmr_setting).it_interval.tv_nsec = 0;
>
>        if (timer_settime((timeOut->timer_h), 0,
> &(timeOut->tmr_setting),NULL) == -1)
>        {
>           display("timer_settime error - errno : %d  -> %s\n",errno,
> strerror(errno));
>        }
>
> }
>
> /************************** Threads ********************************/
> void* threadTimeOut(void * arg) {
>        int i=0;
>        int j, k, NbTimeOut, numTimeOut;
>
>        timeOut0_ptr = timeOut1_ptr = timeOut2_ptr = NULL;
>
>        display("TimeOut thread\n");
>        pthread_mutex_lock(&main_start_lock);
>        pthread_cond_wait(&start_signal, &main_start_lock);
>        pthread_mutex_unlock(&main_start_lock);

This is bad, pthread_cond_wait may experience spurious wakeups
(notably when receiving a signal). So, you MUST check a variable
external to the condition variable.

>        display("TimeOut thread\n");
>
>        while (i < 100)
>        {
>                // Malloc and start of time out
>                for (j=0 ; j < 3; j++)
>                {
>                        switch(j)
>                        {
>                        case 0 : if (timeOut0_ptr == NULL)
>                                 {
>                                        timeOut0_ptr=(struct
> stTimeOut*)malloc(sizeof(struct stTimeOut));
>                                        if (timeOut0_ptr == NULL) exit(1);
>                                                timeOut0_ptr->number = i;
>                                                i++;
>                                                display("Start of time out %d - 5ms\n",
> timeOut0_ptr->number);
>                                                StartTimeOut(0,500000000,timeOut0_ptr);
>                                  }
>                                  break;
>                        case 1 : if (timeOut1_ptr == NULL)
>                                 {
>                                        timeOut1_ptr=(struct
> stTimeOut*)malloc(sizeof(struct stTimeOut));
>                                        if (timeOut1_ptr == NULL) exit(1);
>                                        timeOut1_ptr->number = i;
>                                        i++;
>                                        display("Start of time out %d - 5ms\n",
> timeOut1_ptr->number);
>                                        StartTimeOut(0,500000000,timeOut1_ptr);
>                                  }
>                                  break;
>                        case 2 : if (timeOut2_ptr == NULL)
>                                 {
>                                        timeOut2_ptr=(struct
> stTimeOut*)malloc(sizeof(struct stTimeOut));
>                                        if (timeOut2_ptr == NULL) exit(1);
>                                                timeOut2_ptr->number = i;
>                                                i++;
>                                                display("Start of time out %d - 5ms\n",
> timeOut2_ptr->number);
>                                                StartTimeOut(0,500000000,timeOut2_ptr);
>                                  }
>                                   break;
>                        }
>          }
>          // Waiting of first time out end
>          pthread_mutex_lock(&TimeOut_lock);
>          pthread_cond_wait(&EndTimeOut_signal, &TimeOut_lock);
>          pthread_mutex_unlock(&TimeOut_lock);

Ditto.

>
>          // Reading of time out numbers and free space
>          NbTimeOut = GetWritePtr()- GetReadPtr();
>          display("Number of time out ends : %d\n", NbTimeOut);
>          for (j=0; j < NbTimeOut; j++)
>          {
>               numTimeOut = StackRead();
>               display("TimeOut%d ends\n", numTimeOut);
>               for (k=0; k < 3; k++)
>               {
>                   switch(k)
>                   {
>                   case 0 : if (timeOut0_ptr != NULL)
>                            {
>                               if (timeOut0_ptr->number == numTimeOut)
>                               {
>                                    free(timeOut0_ptr);
>                                    timeOut0_ptr = NULL;
>                               }
>                            }
>                            break;
>                   case 1 : if (timeOut1_ptr != NULL)
>                            {
>                               if (timeOut1_ptr->number == numTimeOut)
>                               {
>                                    free(timeOut1_ptr);
>                                    timeOut1_ptr = NULL;
>                               }
>                            }
>                            break;
>                   case 2 : if (timeOut2_ptr != NULL)
>                            {
>                               if (timeOut2_ptr->number == numTimeOut)
>                               {
>                                    free(timeOut2_ptr);
>                                    timeOut2_ptr = NULL;
>                               }
>                            }
>                            break;
>                   }
>               }
>          }
>    }
>
>    while(1)
>    {
>        sleep(10);
>    }
>        return NULL;
> }
>
> void* threadDisplay(void * arg) {
>        volatile int i=0;
>        volatile int result;
>        display ("Display thread\n");
>        pthread_mutex_lock(&main_start_lock);
>        pthread_cond_wait(&start_signal, &main_start_lock);
>        pthread_mutex_unlock(&main_start_lock);

Same comment.

>        display ("Display thread\n");
>
>        while (i <= 300000) {
>                result = func(&i);
>                display("Display thread :%d \r",result);
>        }
>        display ("End of display thread\n");
>        return NULL;
> }
>
> /***********************************************************************/
> void cleanup_upon_sig(int sig __attribute__((unused)))
> {
>        DeleteTimer(timeOut0_ptr->timer_h);
>        DeleteTimer(timeOut1_ptr->timer_h);
>        DeleteTimer(timeOut2_ptr->timer_h);
>        exit(0);
> }
>
> int main(int argc, char** argv) {
>        pthread_attr_t attr;
>        pthread_mutexattr_t attr_proto;
>        pthread_t p1;
>        pthread_t p2;
>        struct sched_param sch;
>
>        // Stack creation
>        StackCreation();
>
>        signal(SIGINT, cleanup_upon_sig);
>        signal(SIGTERM, cleanup_upon_sig);
>
>        mlockall(MCL_CURRENT|MCL_FUTURE);
>
>        // mutex initialisation
>        pthread_cond_init(&start_signal, NULL);
>        pthread_mutex_init(&main_start_lock, NULL);
>        pthread_cond_init(&EndTimeOut_signal, NULL);
>        pthread_mutex_init(&TimeOut_lock, NULL);
>        pthread_mutexattr_init(&attr_proto);
>        pthread_mutexattr_setprotocol(&attr_proto,PTHREAD_PRIO_INHERIT);
>        pthread_mutex_init(&lockDisplay, &attr_proto);
>
>        pthread_attr_init(&attr);
>        pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
>        pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
>
>        // TimeOut thread creation
>        sch.sched_priority = 80;
>        pthread_attr_setschedparam(&attr, &sch);
>        pthread_create(&p1, &attr, threadTimeOut, NULL);
>
>        // Display thread creation
>        sch.sched_priority = 70;
>        pthread_attr_setschedparam(&attr, &sch);
>        pthread_create(&p2, &attr, threadDisplay, NULL);
>
>        pthread_attr_destroy(&attr);
>
>        display ("Main condition broadcast\n");
>        // Start of all threads
>        pthread_mutex_lock(&main_start_lock);
>        pthread_cond_broadcast(&start_signal);
>        pthread_mutex_unlock(&main_start_lock);
>
>        while (1) {
>                sleep(5);
>        }
>
>        return 0;
> }
>
>
> /***********************************************************************************/
>
> OK, so when I run this program, the system crashes :
> - Result on screen :
>
> TimeOut thread
> Display thread
> Main condition broadcast
> TimeOut thread
> Start of time out 0 - 5ms
> Display thread
> Start of time out 1 - 5ms
> Start of time out 2 - 5ms
> Number of time out ends : 1
> TimeOut0 ends
> Start of time out 3 - 5ms
> Number of time out ends : 3
> TimeOut1 ends
> TimeOut2 ends
> TimeOut3 ends
> Start of time out 4 - 5ms
> Start of time out 5 - 5ms
> Start of time out 6 - 5ms
> Number of time out ends : 1
> Start of time out 7 - 5ms
> Display thread :22635           <- Crash of the system and I must reboot it

This is abnormal. You should get at least a segmentation fault. Are
you running your program under X-window? If yes, could you try and run
it in text mode, so that you will be able to see if you have a kernel
oops?

-- 
 Gilles

