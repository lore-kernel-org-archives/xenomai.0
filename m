Subject: Re: [Xenomai-help] What returns rt_task_self in relation
	to	rt_task_create
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45643CC4.1000201@domain.hid>
References: <20403318.1164195534169.JavaMail.ngmail@domain.hid>
	<45643CC4.1000201@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 13:52:20 +0100
Message-Id: <1164199940.5006.270.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-11-22 at 13:04 +0100, Jan Kiszka wrote:
> M. Koehrer wrote:
> > Hi all,
> > 
> > I have a simple question concerning the Xenomai native API:
> > According to the API documentation, rt_task_self returns the 
> > address of the caller's task descriptor.
> > I have now written the following (simple application):
> > ---------- START ----------
> > #include <stdio.h>
> > #include <sys/mman.h>
> > #include <native/task.h>
> > 
> > RT_TASK task_desc;
> > 
> > void mytask(void *cookie)
> > {
> >     RT_TASK *tsk = rt_task_self();
> >     printf("rt_task_self  %p\n"
> >            "task_desc     %p\n", tsk, &task_desc);
> > }
> > 
> > int main(void)
> > {
> >     mlockall(MCL_CURRENT|MCL_FUTURE);
> > 
> >     rt_task_create(&task_desc, "mytaskname", 0, 80, T_JOINABLE);
> >     rt_task_start(&task_desc, &mytask, NULL);
> > 
> >     rt_task_join(&task_desc);
> > 
> >     return 0;
> > }
> > ------------ END -----------
> > 
> > I expect now that rt_task_self() returns exactly the address of the task_desc.
> > However, a different address is returned. 
> > The output of the application from above is:
> > rt_task_self  0x804a050
> > task_desc     0x8049878
> > 
> > How are those addresses related - how can I find out the descriptor address 
> > used for rt_task_create() at runtime?
> 
> The documentation is not precise enough here: what you obtain from
> rt_task_self is /some/ task descriptor for the currently running task,
> it is not a reference to the same piece of memory containing the task
> descriptor. Check the library implementation for further insights.
> 

A descriptor should always be seen as a reference to an object, not as
the object itself. Said differently, there is no such thing as a
main/unique/specific descriptor for any given object. The doc says
exactly that: you get a valid descriptor to the task by calling
rt_task_self(), but nothing says that this ought to be the unique way of
referencing it. It's merely a kind of pointer, although it's not
implemented as a C pointer. This is the reason why the storage address
of the descriptor itself has no value per se, and nothing should be
derived from it. This is what makes objects shareable betwen kernel and
user-space seamlessly from the user POV.

> > 
> > Background of the question:
> > I want to write an application that uses a couple of similar tasks.
> > I have to store some task-specific information (internal states...).
> > Now I am looking for a simple way to get this information at runtime from my task
> > by calling rt_task_self() (or something similar) to use this address to reach my
> > additional information.
> 
> If you are on NPTL glibc, set up a __thread variable for the per-thread
> information. It will always contain the thread-related data that you
> can, e.g., fill in during the thread routine's prologue.
> 
> Jan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



