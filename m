Date: Wed, 2 Sep 2009 12:25:09 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
Message-ID: <Pine.LNX.4.64.0909021159100.22914@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Deprecated kernel system calls in xenomai-head and
 new application development paradigm
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


 	Hi,

  Well, recent changes marks kernel use of native/task.h as deprecated. 
I've read the FAQ, but still has questions. Suppose some kernel Xenomai RT 
driver need to be written. This driver is using pipes to exchange with 
non-rt userspace applications. The previous development model was simple :

............................. driver-module.c ...................

void process_task(void *)
{
  while (1) {
 	res = rt_pipe_read(...);
 	if (res > 0)
 		do_some_processing(...);
  }
}

int init_module()
{
  rt_pipe_create(...)
  rt_task_create(...);
  rt_task_start(...)
}

.............................

  Now as rt_task_create/rt_task_start are deprecated, can anybody 
briefly describe how such driver need to be developed ?

Thanks in advance.

P.S.	By the way - pipe.c example from Xenomai documentation still use
 	deprecated system calls from kernel space. Seems like this
 	confusing example need to be rewritten accordinly to new Xenomai
 	2.5/3.0 development paradigm.


 		Rus

