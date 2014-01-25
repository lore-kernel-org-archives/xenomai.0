Message-ID: <52E3E71B.40501@xenomai.org>
Date: Sat, 25 Jan 2014 17:32:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtc7uTkGTX30oso0ciV4JisdTXSNL6YbWbmsnoD6C_r_Uw@mail.gmail.com>
 <52DFA12F.3000304@xenomai.org>
 <CAKKWdtehVfx_ahU-GKRgX3nnt1PLQqUjD8sWPsFFBydkAcKSPg@mail.gmail.com>
In-Reply-To: <CAKKWdtehVfx_ahU-GKRgX3nnt1PLQqUjD8sWPsFFBydkAcKSPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Computer froze by a loop
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 01/25/2014 08:53 AM, ali hagigat wrote:
> Regarding to examp9.c: The computer freezes, it means that no key
> works. I can not use <ctrl-C> either. The task2 is in Primary mode, I
> am sure. I have checked  /proc/sys/kernel/. sched_rt_period_us=1000000
> and sched_rt_runtime_us=950000.
> If task2 immigrates to Linux domain, the computer becomes responsive
> and the key-presses are seen. Besides while(1) is present after
> rt_task_inquire() which i guess makes task2 go to the primary domain.

And your guess is wrong, rt_task_inquire has the __xn_exec_any flag, so,
it will not migrate its caller. So, rt_task_inquire is executed with the
caller task running in secondary domain, since it comes after a call to
printf. I have tried your example, and I get the:

[sched_delayed] sched: RT throttling activated

Message on the kernel console, I can then interrupt the task with ctrl-C.

I enabled CONFIG_SMP in my kernel configuration and was able to
reproduce the behaviour you report. I then reduce your example to be as
simple as possible, up to:

#include <pthread.h>

void *burnit(void *cookie)
{
	while(1)
		;
	return cookie;
}

int main(void)
{
	pthread_attr_t tattr;
	struct sched_param sp;
	pthread_t tid;
	void *s;
	
	sp.sched_priority = 50;
	
	pthread_attr_init(&tattr);
	pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&tattr, SCHED_FIFO);
	pthread_attr_setschedparam(&tattr, &sp);
	
	pthread_create(&tid, &tattr, burnit, NULL);
	pthread_join(tid, &s);

	return 0;
}

And it causes a lockup (with CONFIG_SMP), on Linux 3.5.7, 3.8.13, and
3.10.18 (all without I-pipe patch). So, really, this is a Linux issue,
not a Xenomai issue.

Also, you have been told already, but since you seem to ignore it, I am
going to repeat: the xenomai mailing list is an old-fashioned mailing
list where we believe that "bottom-posting" results in more readable
archives than "top-posting", so, please stop top posting.

-- 
                                                                Gilles.

