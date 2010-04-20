From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <g2tdd8925a51004192146m3dc41c1la59720974282b961@domain.hid>
References: <20100419190151.56913gdansdxkhvk@domain.hid>
	<1271697374.16659.156.camel@domain.hid>
	<g2tdd8925a51004192146m3dc41c1la59720974282b961@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Apr 2010 10:22:55 +0200
Message-ID: <1271751775.8407.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT_QUEUE problem in Sender/Receiver order
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Josh Bowman <jbowman@domain.hid>
Cc: xenomai@xenomai.org, Michel He <michel.he@domain.hid>

On Tue, 2010-04-20 at 00:46 -0400, Josh Bowman wrote:
> Hi,
> 
> I'm reluctant to jump in here with my own notably limited psychic
> powers, but I did notice that the code given spawns the receiving
> tasks before it creates the queues that they receive from.  This would
> create a race condition (if a STD_PRIO task can preempt the task
> that's doing the initialization.)
> 

You are likely right, priority issues are usually involved in that
scenario, particularly since the initiator of all those creation calls
is the low-priority root thread.

> -Josh
> 
> On Mon, Apr 19, 2010 at 1:16 PM, Philippe Gerum <rpm@xenomai.org>
> wrote:
>         On Mon, 2010-04-19 at 19:01 +0200, Michel He wrote:
>         
>         >
>         >       err = rt_task_spawn(&test_task2_ptr, "Recep2",
>         STACK_SIZE, STD_PRIO,
>         > 0, &testtask2, NULL);
>         >       if (err) {
>         >               rt_printf("error rt_task_spawn 2\n");
>         >               return 0;
>         >       }
>         >       recvTask[nrecvhost]=&test_task2_ptr;
>         >
>         >       err =
>         >
>         rt_queue_create(&(recvCanal[nrecvhost]),"Recep2CANAL",MAX_MESSAGE_LENGTH,
>         > QUEUE_LIM, Q_FIFO);
>         >
>         >       if (err) {
>         >               rt_printf("error RT_canal_create 2 \n");
>         >               return 0;
>         >       }
>         >       nrecvhost++;
>         >
>         >
>         >       err = rt_task_spawn(&test_task3_ptr, "Recep3",
>         STACK_SIZE, STD_PRIO,
>         > 0, &testtask3, NULL);
>         >       if (err) {
>         >               rt_printf("error rt_task_spawn 3\n");
>         >               return 0;
>         >       }
>         >       recvTask[nrecvhost]=&test_task3_ptr;
>         >
>         >       err =
>         >
>         rt_queue_create(&(recvCanal[nrecvhost]),"Recep3CANAL",MAX_MESSAGE_LENGTH,
>         > QUEUE_LIM, Q_FIFO);
>         >
>         >       if (err) {
>         >               rt_printf("error RT_canal_create 2 \n");
>         >               return 0;
>         >
>         >       }
>         >       nrecvhost++;
>         >
>         >
>         >       err = rt_task_spawn(&test_task_ptr, "Sender",
>         STACK_SIZE, STD_PRIO,
>         > 0, &testtask, NULL);
>         >       if (err) {
>         >               rt_printf("error rt_task_spawn\n");
>         >               return 0;
>         >       }
>         >       recvTask[nrecvhost]=&test_task_ptr;
>         >       nrecvhost++;
>         >
>         >
>         >
>         > testtask2()
>         > {
>         > ...
>         >
>         rcbytes=RT_queue_read(&(recvCanal[0]),&rcvmsg,sizeof(rcvmsg),TM_INFINITE);
>         > }
>         >
>         >
>         > testtask3()
>         > {
>         > ...
>         >
>         rcbytes=RT_queue_read(&(recvCanal[1]),&rcvmsg,sizeof(rcvmsg),TM_INFINITE);
>         > }
>         >
>         
> 


-- 
Philippe.



