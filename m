MIME-Version: 1.0
References: <CAFLxGvw7QBucCM47XXq2RJe1YtQ_wuGVrNg8ZPkUSmXYB04HHg@mail.gmail.com>
 <5059c077-395b-6d84-18e5-618de941c64f@siemens.com>
In-Reply-To: <5059c077-395b-6d84-18e5-618de941c64f@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 16 Jul 2019 09:58:46 +0200
Message-ID: <CAFLxGvxnQY2k4hoBsuiU3Y7AUdMWgJSmBZrb7qgqSbfmvihcxg@mail.gmail.com>
Subject: Re: rt_mutex_acquire() does not return EINTR upon rt_task_unblock()
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On Tue, Jul 16, 2019 at 2:46 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 15.07.19 23:30, Richard Weinberger via Xenomai wrote:
> > Hi!
> >
> > Sorry for asking so many questions on RT_MUTEX.
> >
> > Docs on rt_mutex_acquire variants state:
> > -EINTR is returned if rt_task_unblock() was called for the current task.
> >
> > This does not seems to be the case, pthread_mutex_lock() in lib/cobalt/mutex.c
> > does:
> >         do
> >                 ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
> >         while (ret == -EINTR);
> >
> > So, upon rt_task_unblock() the while loop does one more iteration but
> > blocks again
> > and the function will never return with -EINTR.
>
> Apparently, we lost that property when porting alchemy over the cobalt core. I'd
> first like to understand if that was accidental or intentional - Philippe?
>
> >
> > I guess the recommenced approach is posting a signal to a task before calling
> > rt_task_unblock()? Then the task can exit in a more or less controlled way.
> >
>
> Signals are hairy and non-RT. If such a workaround fits depends on your use
> case. Maybe you can describe that in more details.

For my use case it is okay that signals are non-RT.
Please let me explain a little more.

The application I' working on utilizes Xenomai 2 and is being ported
to Xenomai 3.
It is a single executable with many RT-Tasks. Some of these Tasks are
controlled by
user-input. Hence, from time to time bad things such as lockups will happen.
Due to the current design and timing constraints it is not allowed to
simply restart
the process to get back in a well defined state.
Therefore the application itself has mechanisms to destroy/unblock misbehaving
threads and restarts them. Same for RT_MUTEX.
This involves mayday calls, signals, rt_task_unblock(), etc...

I'm, currently reviewing these mechanisms to figure how the same functionality
can be achieved using Xenomai 3.
So far it seems to work but I still need to sort out undefined
behavior and other
corner cases.

-- 
Thanks,
//richard

