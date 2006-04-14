From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17471.42250.270559.782396@domain.hid>
Date: Fri, 14 Apr 2006 15:35:06 +0200
Subject: Re: [Xenomai-core] T_FPU without effect
In-Reply-To: <443F5DD7.40306@domain.hid>
References: <443F5DD7.40306@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Hi,
 > 
 > after receiving SIGXCPU for unexpected context switches in a larger
 > application, I found out that the T_FPU bit does not seem to be
 > recognised on x86 during native task creation. Here is a simple test
 > case, watch out for /proc/xenomai/faults after program start and 5 s later:
 > 
 > #include <native/task.h>
 > #include <sys/mman.h>
 > 
 > float x;
 > 
 > void task_func(void *p)
 > {
 >     rt_task_sleep(5000000000LL);
 >     x = 3.14 + (int)p;
 > }
 > 
 > main()
 > {
 >     RT_TASK task;
 > 
 >     mlockall(MCL_CURRENT|MCL_FUTURE);
 > 
 >     rt_task_spawn(&task, NULL, 0, 40, T_FPU | T_JOINABLE, task_func, 0);
 >     rt_task_join(&task);
 > 
 >     return 0;
 > }
 > 
 > 
 > Any immediate ideas?

User-space threads always have the FPU bit anyway. When a user-space
thread in primary mode uses FPU for the first time on x86, the FPU
hardware is initialized in the fault handler, this is the expected
behaviour. This allow the nucleus to not switch FPU context for
user-space threads that never use the FPU.

In case of an abnormal FPU fault, the message "invalid use of FPU" is
printed on console.

-- 


					    Gilles Chanteperdrix.

