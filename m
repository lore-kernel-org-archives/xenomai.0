Subject: Re: [Xenomai-help] What returns rt_task_self in
	relation	to	rt_task_create
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45644D39.10007@domain.hid>
References: <20403318.1164195534169.JavaMail.ngmail@domain.hid>
	<45643CC4.1000201@domain.hid> <1164199940.5006.270.camel@domain.hid>
	<45644D39.10007@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 15:00:35 +0100
Message-Id: <1164204035.5006.305.camel@domain.hid>
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

On Wed, 2006-11-22 at 14:14 +0100, Jan Kiszka wrote:

[...]

> >>> How are those addresses related - how can I find out the descriptor address 
> >>> used for rt_task_create() at runtime?
> >> The documentation is not precise enough here: what you obtain from
> >> rt_task_self is /some/ task descriptor for the currently running task,
> >> it is not a reference to the same piece of memory containing the task
> >> descriptor. Check the library implementation for further insights.
> >>
> > 
> > A descriptor should always be seen as a reference to an object, not as
> > the object itself. Said differently, there is no such thing as a
> > main/unique/specific descriptor for any given object. The doc says
> > exactly that: you get a valid descriptor to the task by calling
> > rt_task_self(), but nothing says that this ought to be the unique way of
> > referencing it. 
> 
> The doc talks quite a lot about "_the_ task descriptor address" which
> /may/ suggest to the reader that there is only one address. That this
> cannot be the case becomes obvious when considering user/kernel or
> cross-process usage. Still, clarification at some point can help to
> avoid any future misinterpretation.
> 
> Suggestion (rt_task_self):
> 
> "Return the address of a descriptor for the current task.
> 

Agreed.

> Note: The returned descriptor address does not relate to the descriptor
> address passed to rt_task_create or similar services."
> 

Well, it actually does in intra-kernel calls, where rt_task_self()
returns the container object of the base nucleus thread present in the
RT_TASK struct the user passed us, even if nobody should rely on this
fact. I would try to clear any confusion like this:
"The address returned points at a descriptor identifying the calling
task, which might be different from the descriptor address passed to
rt_task_create()."

> Jan
> 
> 
> PS: Who's supposed to free the descriptor allocated by rt_task_self?
> Would some check for pthread_getspecific(__native_tskey) + free() on
> task self-destruction make sense? Will not catch all cases, I know.
> 

We could add that, and the same stuff upon return from the task body
inside the trampoline call, but the only way to solve this with no leak
would be to call the nucleus at each invocation, and not use any cached
descriptor here. Since TLS requires to be operated by the owning task,
there is no point in trying to have a deleted task clean those up
thoroughly.

-- 
Philippe.



