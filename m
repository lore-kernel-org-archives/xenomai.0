MIME-Version: 1.0
From: AG M <agm6274@gmail.com>
Date: Tue, 14 Feb 2017 17:49:20 -0600
Message-ID: <CALD0yU4tbmu_XbmvBoSySn76g8Cq0LW3qO+u=iavp4qj8ouXCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Understanding Domain Switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have simple program (using POSIX skin) and I'm trying to figure out
when my program switches from primary (Xenomai) to secondary domain
(Linux)

**** Limited code. Will not compile ***
void warn_upon_switch(){

    printf("Switched to Secondary Mode \n");

}


void *threadFunc(void *arg)
{
    char *str;
    int i = 0;
    struct timespec delay, sleep;
    unsigned long over;
    int ret;

   #ifdef __XENO__
        ret = pthread_set_mode_np(0,  0x00040000);
        printf("Warn Bit Ret %d\n", ret);
   #endif /* __XENO__ */

    str=(char*)arg;
    sleep.tv_sec = 1;
    sleep.tv_nsec = 0;
    printf("Switch to secondary mode\n");

   //run this for some arbitrary time
    while(i < 100000 )
    {
        clock_nanosleep(CLOCK_REALTIME, 0, &sleep, NULL);
        //printf("threadFunc says: %s\n",str);
        ++i;
    }

    return NULL;
}

int main(void)
{
    signal(SIGXCPU, warn_upon_switch);
    pthread_t pth;
    double i = 0;
    int ret;
    pthread_attr_t tattr;
    struct sched_param sparam;
    sparam.sched_priority = 99;

    ret = pthread_attr_init(&tattr);
    //printf("Init Return Val %d\n", ret);

    ret = pthread_setschedparam(pth,SCHED_FIFO, &sparam);
    //printf("SetSchedParam Ret Value %d\n", ret);

    pthread_create(&pth,&tattr,threadFunc,"foo");

    //printf("main waiting for thread to terminate...\n");
     pthread_join(pth,NULL);

    return 0;
}

*****
 - How do I know if my program is running in primary or secondary
mode? I never get the SIGXCPU signal. Other signals like SIGINT work.
If I run the same example using the native skin, it works (using this:
http://svn.gna.org/svn/xenomai/trunk/examples/native/sigxcpu.c)

- I get the return value of ret pthread_setschedparam(pth,SCHED_FIFO,
&sparam); as 16 which is EBUSY. Any idea why? My goal is to run the
program in the highest priority if it transfers over to the secondary
domain.

- I'm also trying to figure out using /proc/xenomai/stat. This program
shows up as two processes and I see CSW and MSW have non zero values
and sometimes change. I know that it means a context switch but does
the mean its in the Linux domain?

- If the program can be seen in Linux (meaning it gets a PID through
the Linux kernel), does it mean its running in secondary mode?

I'm running Xenomai 2.6.3 and ipipe 3.
Any help is appreciated. Thanks!

- Ray

