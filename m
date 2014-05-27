MIME-Version: 1.0
In-Reply-To: <CAO0fa7YavfJxxLW6h3Wm8CRmS2+yb9Uhv5RDfsv04+pcpvorFg@mail.gmail.com>
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>
 <5382E8B1.8070402@xenomai.org>
 <CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>
 <5383406C.4070902@xenomai.org>
 <CAO0fa7YavfJxxLW6h3Wm8CRmS2+yb9Uhv5RDfsv04+pcpvorFg@mail.gmail.com>
Date: Tue, 27 May 2014 18:21:23 -0400
Message-ID: <CAO0fa7byLgJQ2_sLDtJLmjsf=oh2NF7k37qnWWxmwhZW6N1ksw@mail.gmail.com>
From: Drew <pythondrew@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

rt_task_create does not return an error.

Looking through src/skins/native/task.c, I see that rt_task_create actually
does start another thread.. rt_task_trampoline. So, I'm thinking possibly
this is the thread that gdb is telling me has exited, not my thread?

rt_task_start does return an error... -3.. which is "no such process" (I
think..) that would be consistent with my thread exiting prematurely.

It looks like rt_task_trampoline is supposed to hang around until
rt_task_start is executed, (the do while loop) but perhaps that loop exits
with an error other than EINTR? It seems possible that do while could exit
and still have a null entry pointer..

I'm guessing that trampoline is named that way because you bounce from that
task into the real task at the entry(cookie) line..
