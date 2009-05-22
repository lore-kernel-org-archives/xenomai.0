Message-ID: <4A169F11.9000702@domain.hid>
Date: Fri, 22 May 2009 14:48:17 +0200
From: Adrien LECOINTRE <adrien20@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Square wave jitter reduce with cpu load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I wrote a simple program toggling a pin of the parallel port every 20 
us. I observe with a scope a jitter of 4 us on my square wave. Then I 
added a background cpu load task and I expected to observe a bigger 
jitter but in fact the jitter becomes inferior than 1 us.
Do you have any explanation of this phenomena ? Do you think that I 
missed something in my kernel configuration ?

Thanks and sorry for my english.

int main(int argc, char *argv[]) {

    struct sched_param param;
    param.sched_priority = 99;
    if(sched_setscheduler(0, SCHED_FIFO, &param) == -1) {
            perror("main: sched_setscheduler failed");
            exit(-1);
    }

    mlockall(MCL_CURRENT | MCL_FUTURE);
    iopl(3);

    if (argc>1 && strcmp(argv[1],"square")==0)
        rt_task_spawn(&square_task, "square", STACK_SIZE, 90, T_JOINABLE | T_SUSP, &square, NULL);
    if (argc>2 && strcmp(argv[2],"cpu")==0)
        rt_task_spawn(&load_task, "cpu_load", STACK_SIZE, 80, T_JOINABLE | T_SUSP, &cpu_load, NULL);
    rt_task_resume(&square_task);
    rt_task_join(&square_task);
    rt_task_join(&load_task);

    return 0;
}


//                    --s-ms-us-ns
RTIME square_period_ns =     20000llu;

//        --s-ms-us-ns
RTIME cpu = 5000000000llu;

void square(void *cookie) {
    rt_task_resume(&load_task);
    unsigned long overrun;
    rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(square_period_ns));

    int i;
    for (i=0;i<NB_LOOP;i++)
    {
        outb_p(0xFF, PORT);
        rt_task_wait_period(&overrun);
        outb_p(0x00, PORT);
        rt_task_wait_period(&overrun);
    }
    rt_task_suspend(&load_task);
    rt_task_delete(&load_task);
}

void cpu_load(void *cookie)
{
    while(1)
        rt_timer_spin(cpu);
}



