From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] Getting calling task id inside RTDM driver
Date: Fri, 14 Apr 2006 21:55:11 +0200
References: <443FB205.6010400@domain.hid>
In-Reply-To: <443FB205.6010400@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604142155.12772.Sebastian.Smolorz@domain.hid>
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

Am Freitag 14. April 2006 16:30 schrieb Sean McGranaghan:

> I am writing an RTDM driver that needs a simple task suspend/resume. I
> have a simple ioctl() that needs to initiate some io and then sleep
> until an interrupt occurs. I have been trying to use rt_task_suspend()
> and rt_task_resume().

Try to avoid using skin functions other than those of RTDM inside drivers. 
Your problem can be solved with a semaphore with an initial value of 0. A  
rtdm_sem_down will make your task sleep. Inside the interrupt handler a 
rtdm_sem_up will wake up your task (after the interrupt handler has exited).

Sebastian

