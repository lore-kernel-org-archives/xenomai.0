Message-ID: <48FCF9B7.9000201@domain.hid>
Date: Mon, 20 Oct 2008 23:35:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48FCDC52.1070507@domain.hid>
	<48FCE40C.1080100@domain.hid>	<48FCEB70.7030808@domain.hid>
	<48FCEC25.2040200@domain.hid>	<48FCED48.5050608@domain.hid>
	<48FCF14C.8050103@domain.hid> <48FCF2E2.8050809@domain.hid>
	<48FCF4FB.1040104@domain.hid> <48FCF74E.1090102@domain.hid>
	<48FCF86F.3030007@domain.hid> <48FCF8D4.6030507@domain.hid>
	<48FCF94C.3000206@domain.hid>
In-Reply-To: <48FCF94C.3000206@domain.hid>
Content-Type: multipart/mixed; boundary="------------060903070808040802000205"
Subject: Re: [Xenomai-core] Warning when compiling trunk.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is a multi-part message in MIME format.
--------------060903070808040802000205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Well I am busy with the ARM FCSE now. Do you want my test case ?
> 
> Yes, hoping that it triggers on x86 as well. And is toolchain independent.



-- 
					    Gilles.

--------------060903070808040802000205
Content-Type: text/x-csrc;
 name="test_sigshadow.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_sigshadow.c"

#include <stdio.h>

#include <sys/mman.h>
#include <pthread.h>

#include <native/task.h>

void relaxed_thread(void *cookie)
{
	rt_task_set_mode(T_PRIMARY, 0, NULL);
	for (;;)
		;
}

int main(void)
{
	struct sched_param p;
	RT_TASK tid;

	mlockall(MCL_CURRENT | MCL_FUTURE);
	
	p.sched_priority = 99;
	pthread_setschedparam(pthread_self(), SCHED_FIFO, &p);

	rt_task_spawn(&tid, "relax", 65536, 12, 0, relaxed_thread, NULL);
	sleep(1);

	rt_task_suspend(&tid);
	sleep(1);

	exit(EXIT_SUCCESS);
}

--------------060903070808040802000205--

