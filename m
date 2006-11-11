Subject: Re: [Xenomai-help] troubles deleting tasks
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1163165517.5765.132.camel@domain.hid>
References: <45547BD3.6070500@domain.hid> <1163165517.5765.132.camel@domain.hid>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 10:31:38 +0100
Message-Id: <1163237499.5765.204.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philipp Keller <philipp.keller@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-11-10 at 14:31 +0100, Philippe Gerum wrote:
> On Fri, 2006-11-10 at 14:17 +0100, Philipp Keller wrote:
> > Hello
> > 
> > We have troubles deleting the main task created with rt_task_shadow()
> > from user space.
> > In the course of initiating the program, we spawn two other threads from
> > the main task with rt_task_spawn().
> > When ending the application, both the spawned tasks can be deleted with
> > rt_task_delete(), but the main task returns with an unknown error code
> > when calling rt_task_delete().
>
> Knowing which error code would help.
> 

The following frag definitely works (i.e. the second printf() is not
issued because the current task has been deleted in the meantime), even
if using rt_task_self() for getting back the current task handle over
the main context, so there must be something else going on with your
application. Again, telling us the _exact_ error code value you get from
rt_task_delete() is the only way to start investigating the issue;
knowing that you apparently tested all the documented return codes in
your program does _not_ tell us which value is actually returned, and
therefore won't help much.

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>

RT_TASK task;

int main(int ac, char **av)
{
        mlockall(MCL_CURRENT|MCL_FUTURE);

        printf("rt_task_create=%d\n",
               rt_task_shadow(&task, "task", 50, 0));

        printf("rt_task_delete=%d\n",
                rt_task_delete(&task));

        return 0;
}


> > We believe to have released all recources before deleting, closing all
> > sockets and file handlers.
> > The trouble is that we cannot initiate rt can socket communication again
> > after failing to delete the main thread.
> > Doeas anyone have an idea what the probelm may be here?
> > 
> > Thanks for any hint
> > Philipp
> > 
> >  
> > -- 
> > Philipp Keller
> > Software Development
> > 
> > Neuronics AG
> > Technoparkstrasse 1
> > 8005 Zuerich / Switzerland
> > Tel +41 44 445 16 40
> > Fax +41 44 445 16 44
> > www.neuronics.ch
-- 
Philippe.



