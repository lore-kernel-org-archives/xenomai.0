From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C841BEF.50708@domain.hid>
References: <4C841BEF.50708@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 06 Sep 2010 06:56:43 +0200
Message-ID: <1283749003.1701.45.camel@domain.hid>
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

On Sun, 2010-09-05 at 15:38 -0700, Bob Feretich wrote:
> I am confused about the operation of the Native rt_event_bind() 
> function and I have not found any example of its use.
> 
> The documentation states...
> int rt_event_bind (RT_EVENT * event, const char * name, RTIME timeout)
> Parameters:
> ...
> event The address of an event flag group descriptor retrieved by the 
> operation. Contents of
> this memory is undefined upon failure.
> ...
> 
> Is the user-space task supposed to provide memory for the RT_EVENT, ...
> example:
> RT_EVENT event_structure;
> ...
> rt_event_bind (&event_structure,...)

This way.

> 
> Or, does the user-space program just provide a pointer variable to 
> retain the event structure provided to it by the function?
> example:
> RT_EVENT *event_pointer;
> ...
> rt_event_bind (event_pointer,...)
> 
> Neither seems to work correctly, the former only allocates a word of memory.
> printf("sizeof(event_structure)=%d", sizeof(event_structure) );
> Prints 4. This seems too small.
> 

It is correct; the only thing you should care about is the return code.
To keep the API consistent between kernel and user-space usages, both
require the address of a RT_EVENT event struct to be given, but this
struct is defined differently. In the user-space case, RT_EVENT is a
placeholder containing a handle to the actual struct in kernel space
(that handle is not a pointer, so you should not infer anything from its
value).

> The latter fails with an error code -14 (EFAULT).
> 
> Regards,
> Bob Feretich
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



