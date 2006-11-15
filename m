Message-ID: <455B3B6B.1030109@domain.hid>
Date: Wed, 15 Nov 2006 17:08:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_setname_np
References: <DD39B5C3F4963040ADC9768BE7E430CB0154F003@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154F003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Gilles Chanteperdrix wrote:
> 
> 
>>You are being dishonest: the function expects a pthread_t argument,
>>the only way to get a valid pthread_t value is to create a thread or
>>to call pthread_self().  
> 
> 
> No only a dumb newbie user of the Posix API with a background of
> VxWorks.
> If I want to create a task in VxWorks with e.g. int taskSpawn() I get
> explecitly back a task id, comparable to a pthread_t for POSIX API.
> Because it is a simple int (which is in fact not really true, because it
> is a pointer in the task control block casted into an int), I know as a
> dumb user that I cannot use it somehow before.
> 
> With pthreads I did the following:
> 
> pthread_t thread;
> pthread_attr_t attr;
> pthread_attr_init (&attr);
> pthread_attr_setname_np(&attr, "newname"); (-->
> pthread_set_name_np(thread, "newname");)
> pthread_create (&thread, &attr, func, arg);
> 
> 
> This did not compile, because only valid in kernel space, so I replaced
> pthread_attr_setname_np() with pthread_set_name_np() and let it run. Of
> course checking return values could have helped here.
> 
> I expected that pthread_t is a normal structure and would only be
> modified with pthread_set_name_np() aka the attribute structure with
> pthread_attr_setxxx(). I am simply not used to an API that doesn't
> provide the possibility to spawn a thread already with the correct name
> and rather forces the user to change the name after the thread is
> already running ...
> A collegue of mine stumbled over the exact same thing. A bit more
> "redundancy" in the documentation would probably have opened our eyes,
> although it seems according to Google that I am the first mentioning
> this problem.

If you feel like modifying the documentation, please send a patch.

> 
> 
>>>Btw. Is there a reason why the call to pthread_attr_setname_np() is
>>>limited to kernel space ?
>>
>>It is impossible to implement pthread_attr_setname_np in user-space.
>>I think I will remove this call, having different APIs in
>>kernel-space and user-space only adds confusion.  
> 
> 
> Just out of curiosity: what are the exact reasons ? I mean: couldn't you
> principially pass any information to the Xenomai subsystem at the time
> of a pthread_create() ??

The problem is that we would have to store this additional information
in the pthread_attr_t structure. And in order to allow users to include
and use the Xenomai API and the native pthread API at the same time,
Xenomai use the same definition for all the pthread_* types as the
native pthread API, and we do not know if the native API has room for an
additional string.

-- 
                                                 Gilles Chanteperdrix

