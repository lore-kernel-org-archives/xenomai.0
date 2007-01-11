Message-ID: <45A656C6.6060406@domain.hid>
Date: Thu, 11 Jan 2007 16:24:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070703050002050305000405"
Subject: [Xenomai-core] Unwanted mode switch.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------070703050002050305000405
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


Hi,

in order to test the nocow patch, I wrote the attached test. Despite the
fact that there is no longer any page fault (I have nucleus debugging
on, so I would get a message if there was a fault), there is still an
unwanted mode switch at step 5. Any idea what could be the cause ?


-- 
                                                 Gilles Chanteperdrix

--------------070703050002050305000405
Content-Type: text/x-csrc;
 name="test_fork.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_fork.c"

#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <signal.h>
#include <string.h>
#include <sys/mman.h>
#include <execinfo.h>
#include <native/timer.h>
#include <native/task.h>

unsigned step;
void do_backtrace(void)
{
	static void *buffer[200];
	int levels = backtrace(buffer, sizeof(buffer)/sizeof(void *));
	backtrace_symbols_fd(buffer, levels, STDOUT_FILENO);
}
void mode_switch(int sig)
{
	printf("mode switch at step %d, test failed!\n", step);
	do_backtrace();
	exit(EXIT_FAILURE);
}

int main(void)
{
	RT_TASK task;
	RTIME time;
	pid_t pid;
	int rc;

	if ((SIG_ERR == signal(SIGXCPU, &mode_switch))) {
		perror("signal");
		exit(EXIT_FAILURE);
	}

	pid = fork();

	if (pid < 0) {
		perror("fork");
		exit(EXIT_FAILURE);
	}

	if (pid > 0) {
		int status;
		if (waitpid(pid, &status, 0) == -1) {
			perror("waitpid");
			exit(EXIT_FAILURE);
		}
		status = WEXITSTATUS(status);
		if (status == EXIT_SUCCESS)
			fprintf(stderr, "Test passed\n");
		_exit(status);
	}
	
	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
		perror("mlockall");
		exit(EXIT_FAILURE);
	}

	step = 1;
	if ((rc = rt_task_shadow(&task, "test_vm1", 1, 0))) {
		fprintf(stderr,
			"rt_task_shadow: %s\n", strerror(-rc));
		exit(EXIT_FAILURE);
	}

	step = 2;
	if ((rc = rt_task_set_mode(0, T_WARNSW, NULL))) {
		fprintf(stderr,
			"rt_task_set_mode_np: %s\n", strerror(-rc));
		exit(EXIT_FAILURE);
	}

	step = 3;
	time = rt_timer_read();

	step = 4;
	if ((rc = rt_task_set_mode(T_PRIMARY, 0, NULL))) {
		fprintf(stderr,
			"rt_task_set_mode_np: %s\n", strerror(-rc));
		exit(EXIT_FAILURE);
	}
	pid = fork();

	if (pid < 0) {
		perror("fork");
		exit(EXIT_FAILURE);
	}

	if (pid > 0) {
		int status;
		step = 5;

		time = rt_timer_read();

		if ((rc = rt_task_set_mode(T_PRIMARY, 0, NULL))) {
			fprintf(stderr,
				"rt_task_set_mode_np: %s\n", strerror(-rc));
			exit(EXIT_FAILURE);
		}

		if (waitpid(pid, &status, 0) == -1) {
			perror("waitpid");
			exit(EXIT_FAILURE);
		}
		_exit(WEXITSTATUS(status));
	}
	
	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
		perror("mlockall");
		exit(EXIT_FAILURE);
	}

	step = 6;
	if ((rc = rt_task_shadow(&task, "test_vm2", 1, 0))) {
		fprintf(stderr,
			"rt_task_shadow: %s\n", strerror(-rc));
		exit(EXIT_FAILURE);
	}

	step = 7;
	if ((rc = rt_task_set_mode(0, T_WARNSW, NULL))) {
		fprintf(stderr,
			"rt_task_set_mode_np: %s\n", strerror(-rc));
		exit(EXIT_FAILURE);
	}

	step = 8;
	time = rt_timer_read();
	
	if ((rc = rt_task_set_mode(T_PRIMARY, 0, NULL))) {
		fprintf(stderr,
			"rt_task_set_mode_np: %s\n", strerror(-rc));
		exit(EXIT_FAILURE);
	}

	exit(EXIT_SUCCESS);
}

--------------070703050002050305000405--

