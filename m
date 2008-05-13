Message-ID: <48297566.1010607@domain.hid>
Date: Tue, 13 May 2008 13:03:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid>
In-Reply-To: <0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt management under rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DOURNES Guillaume <Guillaume.DOURNES@lgm.fr>
Cc: xenomai@xenomai.org

[ Please don't reply on earlier postings when starting a new thread. ]

DOURNES Guillaume wrote:
> Hello,
> 
> I try to manage irq on my digital I/O board rtdm driver.
> So, I call rtdm_irq_request with RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE
> option to define my irq handler, in my rtdm open function.
> This irq handler works very good.
> So, I try to establish a callback system to inform my sofware when an
> valid interrupt is arrived.
> I don't know callback system, so i establish a rtdm semaphore.
> So, in my irq handler I call rtdm_sem_up, and I have an blocant ioctl
> where I call only rtdm_sem_down.
> 
> To test this method, I write a test code, where I create a rt task by
> calling rt_task_create(&Handler_IT_task, "Handler IT Task",0,50,0); and
> rt_task_start(&Handler_IT_task, &Handler_IT_task_proc, NULL);
> 
> And my task procedure is :
> 
> void Handler_IT_task_proc (void * arg)
> {
> 	int ret;
> 	while(1)
> 	{
> 		ret = rt_dev_ioctl(IO_Card_ID, DISCRETS_IOC_WAIT_IT, 0);
> 		if (!ret)
> 			printf("IT detected\n");
> 		else
> 			goto exit_Handler_IT_task;
> 		//rt_task_suspend(&Handler_IT_task);
> 	}
> exit_Handler_IT_task:
> 	printf("Exit Handler IT task\n");
> }
> 
> My problem is that on IT reception, my work station freeze. But, if I
> call a suspend task after my blocant ioctl (see comment), and I call an
> task resume by a gets in my main function, all my interrupts are founded
> correctly.
> 
> I try to change the rtdm semaphore by a rtdm event, but the results are
> the same.
> 
> So, why my sofware is frozen when the Handler task procedure keep the
> hand ? Can I establish a really callback function instead of a blocant
> ioctl ?

Use CONFIG_XENO_OPT_WATCHDOG to ensure that you don't see a runaway
thread here. Alternatively, you could break out of the loop after some
iterations to check if this is the reason for your "locked-up" system.

Note that, if we should help you beyond this, we will need the driver
source code as well. How should we know otherwise when your driver
returns 0 and how long it suspends the caller?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

