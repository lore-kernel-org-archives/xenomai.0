MIME-Version: 1.0
References: <cover.1625777265.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625777265.git.jan.kiszka@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 19 Jul 2021 12:08:11 +0200
Message-ID: <CAFLxGvw34vnYx57bP7cYv5HgRCbmPaGNBQzeQudyU-upq+u_-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add callback-like mechanism before/after ptrace
 stops
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
Cc: Xenomai <xenomai@xenomai.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>

On Thu, Jul 8, 2021 at 10:48 PM Jan Kiszka via Xenomai
<xenomai@xenomai.org> wrote:
> The model chosen for this is dedicating a real-time thread to this task.
> This has the advantage of isolating the thread a bit from the debugged
> contexts and also avoids having to introduce any kind of asynchronous
> signaling mechanism. The helper thread will register itself with the
> core and then run a loop, waiting for the next stop or resume event. At
> the point the helper receives such an event, all other real-time threads
> in the process have been stopped or not yet resumed so that the helper
> cannot interact with them nor should wait for resources they may have
> locked. The helper thread may also migrate to secondary mode before
> releasing control, usually only after/before all time-sensitive
> operations are executed.
>
> These patches have a very long (likely too long) internal history at
> Siemens, thus have shown to be useful at least for one of our use cases.

We have a similar but still rather different set of use cases.
A Xenomai 2 based system David and I working on carries a in house
patch to deliver
exceptions to userspace in the primary domain. The current patch implements
a signal alike interface. So userspace can register a hard real-time
handler for e.g. SIGFPE or SIGTRAP.
If a real-time task triggers an exception (e.g. division by zero,
hitting a break-point exception) this
exception is translated to a signal and delivered to userspace without switching
to the secondary domain.

The monitor thread approach should work too, I guess.
But the main difference is that the application I have in mind needs a
notification for exceptions,
plus machine state. This is why the signal model was chosen. Just like
on the Linux side
the real-time thread has access to mcontext to figure why the
exception happened, etc..

Let me outline two use cases.
1. FPU exception handling:
The application we work on is more a runtime than an application, it
runs programs that assume
specific behavior regarding integer and floating point operations.
These program have been developed for other operating systems and must
not break on
Linux/Xenomai.
For example they assume that a division by zero does not trap but results in 0.
So the runtime handles floating point exceptions, looks at the machine
state, decodes the current
operation and fixes the result.
Like it or not, we have to do this to keep binary compatibly.
Rebuilding these  programs
is not possible.

2. Break point handling:
The runtime allows instrumenting of programs it executes. A system
operator can mark code paths
to see how often they are executed. So the runtime installs a break
point instruction at the desired
place and handles the breakpoint exception in the primary domain where
just a counter
is incremented.
Although this slows down execution and hurts the system response time
it is still fast enough
to satisfy our real-time requirements.
On the other hand switching to the secondary domain is far too expensive.

Maybe we can combine both approaches? We'll happily port the current
patch to Xenomai 3.1
and give the monitor thread approach a try.

