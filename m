Message-ID: <4BB38520.4020603@domain.hid>
Date: Wed, 31 Mar 2010 19:23:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] syscall restart issue with SIGINFO handlers
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Gilles,

here is a case so far uncaught by Xenomai syscall restart code:

#include <pthread.h>
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/mutex.h>

RT_MUTEX mutex;
pthread_t pthread;

void sighand1(int sig)
{
	printf("signal 1: %d\n", sig);
}

void sighand2(int sig, siginfo_t *si, void *context)
{
	printf("signal 2: %d\n", sig);
}

void thread(void *arg)
{
	int res1, res2;

	pthread = pthread_self();

	res1 = rt_mutex_acquire(&mutex, TM_INFINITE);

	res2 = rt_mutex_release(&mutex);

	printf("res = %d / %d\n", res1, res2);
}

int main()
{
	struct sigaction sa;
	RT_TASK task_main, task;

	mlockall(MCL_CURRENT|MCL_FUTURE);

	signal(SIGUSR1, sighand1);

	sigemptyset(&sa.sa_mask);
	sa.sa_sigaction = sighand2;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGUSR2, &sa, NULL);

	rt_task_shadow(&task_main, "main", 1, 0);

	rt_mutex_create(&mutex, "mutex");
	rt_mutex_acquire(&mutex, TM_INFINITE);

	rt_task_spawn(&task, "thread", 0, 2, 0, thread, 0);

	sleep(1);
	pthread_kill(pthread, SIGUSR1);

	sleep(1);
	pthread_kill(pthread, SIGUSR2);

	rt_mutex_release(&mutex);

	rt_task_delete(&task);

	return 0;
}


Sending SIGUSR2 will make the blocked thread see -EINTR as result of its
rt_mutex acquire. Some different path must be taken by libc when
delivering SA_SIGINFO signals and returning to the application. Can you
confirm this?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

