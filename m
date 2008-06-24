Message-ID: <4860ED80.2030400@domain.hid>
Date: Tue, 24 Jun 2008 14:50:08 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <20080624123602.114820@domain.hid>
In-Reply-To: <20080624123602.114820@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error creating a task with rt_task_spawn
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org

Karl Reichert wrote:
> Hello,
> 
> I'm trying to create and start a new thread via rt_task_spawn() but I always get error -3. ("Unknown error: -3")
> 
> Any idea?

> #include "main.h"
> 
> #include <stdio.h>
> #include <signal.h>
> #include <native/task.h>
> #include <native/timer.h>
> #include <native/mutex.h>
> #include <sys/mman.h>
> 
> int i,j,x;
> RT_TASK *rx_tsk;

This is a (uninitialized) pointer ...
Maybe you wanted to type
RT_TASK rx_tsk;
?

> 
> int ret1;
> int ret2;
> 
> void rx_task(void *cookie);
> void cleanup(int dummy);
> 
> int main (int argc, char* argv[])
> {
> 	i = 0;
>    
>    if ( -1 == mlockall (MCL_CURRENT | MCL_FUTURE) ) {
>         perror("mlockall: ");
>         return -1;
>    }
> 
> 	ret1 = rt_task_spawn(rx_tsk, "rx_task", 0, 1, T_FPU|T_CPU(1), &rx_task, NULL);

Here you call rt_task_spawn with that pointer rx_tsk. You must provide a 
valid pointer, e.g. &rx_tsk and modify the definition of rx_tsk as above.

-- 
Sebastian

