Message-ID: <52D85E3A.4060501@xenomai.org>
Date: Thu, 16 Jan 2014 23:33:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <180542a9.1c6fc.1439a711789.Coremail.ericvic@163.com>
In-Reply-To: <180542a9.1c6fc.1439a711789.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai-2.6.3 with freescale imx6 kernel threads
	binding cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/16/2014 10:45 AM, 嵌入式工程师 wrote:
> 
> 
> Just the wrong message，below is my question。
> 
> 
> I use xenomai-2.6.3 with freescale imx6 kernel-3.0.35 threads binding cpu。
> rt_task_create(&t1, "task1", 4096, 88, T_FPU|T_CPU(1));
> But will randomly select binding cpu, not what I want cpu1,what is wrong？
> thanks!

Hi,

I have been trying to reproduce this issue with the program which 
follows, and was unable to do it. Could you try to run this program on 
your system? Or post a program, reduced to its simplest possible form, 
demonstrating the issue you observe?

Regards.

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <sched.h>
#include <unistd.h>

#include <native/task.h>

void body(void *cookie)
{
	long target_cpu = (long)cookie;
	long real_cpu = sched_getcpu();
	
	if (real_cpu < 0) {
		perror("sched_getcpu");
		exit(EXIT_FAILURE);
	}
	
	if (real_cpu != target_cpu) {
		fprintf(stderr, "Real cpu is %ld instead of %ld\n", 
			real_cpu, target_cpu);
		exit(EXIT_FAILURE);
	}
}

int main(void)
{
	int nrcpus = sysconf(_SC_NPROCESSORS_ONLN);
	double divider = 1 / sqrt(RAND_MAX);
	unsigned i = 0;

	if (nrcpus < 0) {
		perror("sysconf(_SC_NPROCESSORS_ONLN)");
		return EXIT_FAILURE;
	}

	srandom(time(NULL));

	for(;;) {
		char name[80];
		long target_cpu;
		cpu_set_t cpu_set;
		RT_TASK task;
		long mycpu;
		int err;
		++i;

		target_cpu = (int)(random() * divider) % nrcpus;
		mycpu = (int)(random() * divider) % nrcpus;

		CPU_ZERO(&cpu_set);
		CPU_SET(mycpu, &cpu_set);
		
		err = sched_setaffinity(0, sizeof(cpu_set), &cpu_set);
		if (err < 0) {
			perror("sched_setaffinity");
			return EXIT_FAILURE;
		}
		
		fprintf(stderr, "%09d: mine: %ld, target: %ld\n", 
			i, mycpu, target_cpu);

		snprintf(name, sizeof(name), "task%d", i);
		err = rt_task_create(&task, name, 65536, 88, 
				T_FPU | T_CPU(target_cpu) | T_JOINABLE);
		if (err < 0) {
			fprintf(stderr, "rt_task_create: %d, %d\n", err, i);
			return EXIT_FAILURE;
		}

		err = rt_task_start(&task, body, (void *)target_cpu);
		if (err < 0) {
			fprintf(stderr, "rt_task_start: %d\n", err);
			return EXIT_FAILURE;
		}
		
		err = rt_task_join(&task);
		if (err < 0) {
			fprintf(stderr, "rt_task_join: %d\n", err);
			return EXIT_FAILURE;
		}
	}
}

-- 
                                                                Gilles.

