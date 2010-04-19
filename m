Message-ID: <20100419190151.56913gdansdxkhvk@domain.hid>
Date: Mon, 19 Apr 2010 19:01:51 +0200
From: Michel He <michel.he@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] RT_QUEUE problem in Sender/Receiver order
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

hello everyone,

    I find out a problem (it seems already mentionned before but I  
can't find the link to the forum and the post). It deals with the  
message passing, eg. when we change the order of task execution,  
something can get wrong. Notice that codes below, if we launch the  
exection of Recep2,Recep3,Sender, Recep2 won't get the right message.  
But if we change the order to : Sender,Recep2,Recep3, everything is  
back to OK. So any explanation ?


	err = rt_task_spawn(&test_task2_ptr, "Recep2", STACK_SIZE, STD_PRIO,  
0, &testtask2, NULL);
	if (err) {
		rt_printf("error rt_task_spawn 2\n");
		return 0;
	}
	recvTask[nrecvhost]=&test_task2_ptr;

	err =  
rt_queue_create(&(recvCanal[nrecvhost]),"Recep2CANAL",MAX_MESSAGE_LENGTH,  
QUEUE_LIM, Q_FIFO);

	if (err) {
		rt_printf("error RT_canal_create 2 \n");
		return 0;
	}
	nrecvhost++;


	err = rt_task_spawn(&test_task3_ptr, "Recep3", STACK_SIZE, STD_PRIO,  
0, &testtask3, NULL);
	if (err) {
		rt_printf("error rt_task_spawn 3\n");
		return 0;
	}
	recvTask[nrecvhost]=&test_task3_ptr;

	err =  
rt_queue_create(&(recvCanal[nrecvhost]),"Recep3CANAL",MAX_MESSAGE_LENGTH,  
QUEUE_LIM, Q_FIFO);

	if (err) {
		rt_printf("error RT_canal_create 2 \n");
		return 0;

	}
	nrecvhost++;


	err = rt_task_spawn(&test_task_ptr, "Sender", STACK_SIZE, STD_PRIO,  
0, &testtask, NULL);
	if (err) {
		rt_printf("error rt_task_spawn\n");
		return 0;
	}
	recvTask[nrecvhost]=&test_task_ptr;
	nrecvhost++;



testtask2()
{
...
rcbytes=RT_queue_read(&(recvCanal[0]),&rcvmsg,sizeof(rcvmsg),TM_INFINITE);
}


testtask3()
{
...
rcbytes=RT_queue_read(&(recvCanal[1]),&rcvmsg,sizeof(rcvmsg),TM_INFINITE);
}


thank you



