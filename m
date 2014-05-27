MIME-Version: 1.0
In-Reply-To: <5383406C.4070902@xenomai.org>
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>
 <5382E8B1.8070402@xenomai.org>
 <CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>
 <5383406C.4070902@xenomai.org>
Date: Tue, 27 May 2014 08:05:06 -0400
Message-ID: <CAO0fa7YavfJxxLW6h3Wm8CRmS2+yb9Uhv5RDfsv04+pcpvorFg@mail.gmail.com>
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

Philippe: There is no change.

The "Thread Exited" messages come almost immediately. I put the sleep(3) in
there to be sure.. the order is definitely New Thread (x2), Thread Exited
(x2) - 3 second pause - hello world.
The sleep also influences the thread exit.. Without the sleep, only the
first thread created exits before it is started... unless you single step;
in that case, the first thread created exits when you "next" over the
creation of the second thread, then the second thread created exits when
you "next" over the next line. (the printf, here.)

I'm pretty sure I'm seeing threads exiting before they are even started..
Kinda like something in rt_task_create is accidentally starting the thread
without even knowing which function to execute on the thread.

PS: thanks for putting my reply on the list; I must have hit "reply"
instead of "reply all"
