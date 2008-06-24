Content-Type: text/plain; charset="us-ascii"
Date: Tue, 24 Jun 2008 15:00:59 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <4860ED80.2030400@domain.hid>
Message-ID: <20080624130059.114820@domain.hid>
MIME-Version: 1.0
References: <20080624123602.114820@domain.hid>
	<4860ED80.2030400@domain.hid>
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
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

> Karl Reichert wrote:
> > Hello,
> > 
> > I'm trying to create and start a new thread via rt_task_spawn() but I
> always get error -3. ("Unknown error: -3")
> > 
> > Any idea?
> 
> > #include "main.h"
> > 
> > #include <stdio.h>
> > #include <signal.h>
> > #include <native/task.h>
> > #include <native/timer.h>
> > #include <native/mutex.h>
> > #include <sys/mman.h>
> > 
> > int i,j,x;
> > RT_TASK *rx_tsk;
> 
> This is a (uninitialized) pointer ...
> Maybe you wanted to type
> RT_TASK rx_tsk;
> ?
> 
> > 
> > int ret1;
> > int ret2;
> > 
> > void rx_task(void *cookie);
> > void cleanup(int dummy);
> > 
> > int main (int argc, char* argv[])
> > {
> > 	i = 0;
> >    
> >    if ( -1 == mlockall (MCL_CURRENT | MCL_FUTURE) ) {
> >         perror("mlockall: ");
> >         return -1;
> >    }
> > 
> > 	ret1 = rt_task_spawn(rx_tsk, "rx_task", 0, 1, T_FPU|T_CPU(1), &rx_task,
> NULL);
> 
> Here you call rt_task_spawn with that pointer rx_tsk. You must provide a 
> valid pointer, e.g. &rx_tsk and modify the definition of rx_tsk as above.

Yes, you are right. My fault ...

But after modifying, when I run this program, the computer locks. I can move the mouse and even mouve the windows (Xfree), but I can neither close the window, click any buttons nor enter anything in the terminal-window.

Any ideas?

Thanks
Karl
-- 
von Karl Reichert


