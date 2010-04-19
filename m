From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100419190151.56913gdansdxkhvk@domain.hid>
References: <20100419190151.56913gdansdxkhvk@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Apr 2010 19:16:14 +0200
Message-ID: <1271697374.16659.156.camel@domain.hid>
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
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-04-19 at 19:01 +0200, Michel He wrote:
> hello everyone,
> 
>     I find out a problem (it seems already mentionned before but I  
> can't find the link to the forum and the post).

Ok. In the same vein, it turns out that you might be right, but I could
not find the link to the post that says so.

>  It deals with the  
> message passing, eg. when we change the order of task execution,  
> something can get wrong. Notice that codes below, if we launch the  
> exection of Recep2,Recep3,Sender, Recep2 won't get the right message.  
> But if we change the order to : Sender,Recep2,Recep3, everything is  
> back to OK. So any explanation ?

Any explanation from your end about what you would consider as a correct
result from that code, or should we resort to our well-known psychic
power to find it?

> 
> 
> 	err = rt_task_spawn(&test_task2_ptr, "Recep2", STACK_SIZE, STD_PRIO,  
> 0, &testtask2, NULL);
> 	if (err) {
> 		rt_printf("error rt_task_spawn 2\n");
> 		return 0;
> 	}
> 	recvTask[nrecvhost]=&test_task2_ptr;
> 
> 	err =  
> rt_queue_create(&(recvCanal[nrecvhost]),"Recep2CANAL",MAX_MESSAGE_LENGTH,  
> QUEUE_LIM, Q_FIFO);
> 
> 	if (err) {
> 		rt_printf("error RT_canal_create 2 \n");
> 		return 0;
> 	}
> 	nrecvhost++;
> 
> 
> 	err = rt_task_spawn(&test_task3_ptr, "Recep3", STACK_SIZE, STD_PRIO,  
> 0, &testtask3, NULL);
> 	if (err) {
> 		rt_printf("error rt_task_spawn 3\n");
> 		return 0;
> 	}
> 	recvTask[nrecvhost]=&test_task3_ptr;
> 
> 	err =  
> rt_queue_create(&(recvCanal[nrecvhost]),"Recep3CANAL",MAX_MESSAGE_LENGTH,  
> QUEUE_LIM, Q_FIFO);
> 
> 	if (err) {
> 		rt_printf("error RT_canal_create 2 \n");
> 		return 0;
> 
> 	}
> 	nrecvhost++;
> 
> 
> 	err = rt_task_spawn(&test_task_ptr, "Sender", STACK_SIZE, STD_PRIO,  
> 0, &testtask, NULL);
> 	if (err) {
> 		rt_printf("error rt_task_spawn\n");
> 		return 0;
> 	}
> 	recvTask[nrecvhost]=&test_task_ptr;
> 	nrecvhost++;
> 
> 
> 
> testtask2()
> {
> ...
> rcbytes=RT_queue_read(&(recvCanal[0]),&rcvmsg,sizeof(rcvmsg),TM_INFINITE);
> }
> 
> 
> testtask3()
> {
> ...
> rcbytes=RT_queue_read(&(recvCanal[1]),&rcvmsg,sizeof(rcvmsg),TM_INFINITE);
> }
> 
> 
> thank you
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



