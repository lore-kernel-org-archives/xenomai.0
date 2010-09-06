From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C84A77A.6080904@domain.hid>
References: <4C841BEF.50708@domain.hid>
	<1283749003.1701.45.camel@domain.hid>
	<4C84A77A.6080904@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 06 Sep 2010 11:33:57 +0200
Message-ID: <1283765637.1701.220.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Native rt_event_bind() question.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-09-06 at 01:34 -0700, Bob Feretich wrote:
> OK, I've implemented rt_event_bind() the way you indicated and I get a 
> good return code.
> 
> But, now after several minutes of good operation, a rt_event_wait() in a 
> tight loop produces a return code of  -14 (EFAULT).
> 
> rt_event_wait (&event_structure,...)
> 
> According to the documentation, rt_event_wait() doesn't produce that 
> error code. This was my original error and it is what made me explore 
> the user-task representation of the RT_EVENT structure.
> What is the return code trying to tell me?
> 
> I'm guessing a kernel copy of the RT_EVENT is being trashed. The below 
> question assumes this is correct.
> I have two tasks involved. A rt-kernel-task that created and signals the 
> event; and a rt-user-task that binds, waits upon, and clears the event.
> Is there one instance of the RT_EVENT that is accessed by both tasks, or 
> does each task have their own instance?
> If there is only one instance, then I can monitor for corruption in the 
> kernel task. If there are two instances, then how do I monitor the user 
> tasks instance?

There is a single instance in kernel space, hence the handle from
user-space to reach it. This said, the only way your code can get
-EFAULT is by passing a wrong address for the event or return mask, or
maybe due to a stack overflow. A kernel data corruption would likely not
lead to -EFAULT. The issue is more likely in your application.

> 
> Regards,
> Bob Feretich
> 
> On 9/5/2010 9:56 PM, Philippe Gerum wrote:
> > On Sun, 2010-09-05 at 15:38 -0700, Bob Feretich wrote:
> >> I am confused about the operation of the Native rt_event_bind()
> >> function and I have not found any example of its use.
> >>
> >> The documentation states...
> >> int rt_event_bind (RT_EVENT * event, const char * name, RTIME timeout)
> >> Parameters:
> >> ...
> >> event The address of an event flag group descriptor retrieved by the
> >> operation. Contents of
> >> this memory is undefined upon failure.
> >> ...
> >>
> >> Is the user-space task supposed to provide memory for the RT_EVENT, ...
> >> example:
> >> RT_EVENT event_structure;
> >> ...
> >> rt_event_bind (&event_structure,...)
> > This way.
> >
> >> Or, does the user-space program just provide a pointer variable to
> >> retain the event structure provided to it by the function?
> >> example:
> >> RT_EVENT *event_pointer;
> >> ...
> >> rt_event_bind (event_pointer,...)
> >>
> >> Neither seems to work correctly, the former only allocates a word of memory.
> >> printf("sizeof(event_structure)=%d", sizeof(event_structure) );
> >> Prints 4. This seems too small.
> >>
> > It is correct; the only thing you should care about is the return code.
> > To keep the API consistent between kernel and user-space usages, both
> > require the address of a RT_EVENT event struct to be given, but this
> > struct is defined differently. In the user-space case, RT_EVENT is a
> > placeholder containing a handle to the actual struct in kernel space
> > (that handle is not a pointer, so you should not infer anything from its
> > value).
> >
> >> The latter fails with an error code -14 (EFAULT).
> >>
> >> Regards,
> >> Bob Feretich
> >>
> >>
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



