MIME-Version: 1.0
In-Reply-To: <51319FEB.9050701@xenomai.org>
References: <CAJjOJyZWM-73DoTOAT4Xoiw3dk-yUw7Gu4ZOU9D9_b4qe5N-QQ@mail.gmail.com>
	<51319119.9020000@xenomai.org>
	<CAJjOJyaCg0A_wYzew=monnfvjmCWGvc8Y4APXG5fFoarGH9SRw@mail.gmail.com>
	<51319FEB.9050701@xenomai.org>
Date: Sat, 2 Mar 2013 18:53:09 -0800
Message-ID: <CAJjOJyYkOmXyyrXCvQ+EHrW9qs98TdFw4SPV+1d9_ozMVM2xBg@mail.gmail.com>
From: Jonathan Wallace <jonmon6691@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Problem Handling GPIO interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Mar 1, 2013 at 10:44 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 03/02/2013 07:38 AM, Jonathan Wallace wrote:
>
>> On Fri, Mar 1, 2013 at 9:41 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org
>> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>>> On 03/02/2013 05:47 AM, Jonathan Wallace wrote:
>>>
>>>> Hi all,
>>>>
>>>> I'm trying to get a small variation of the usr_irq.c example working,
>>>> but rt_intr_wait keeps returning -38 without blocking and perror
>>>> prints success. If I don't let it print anything (so it will run
>>>
>>>
>>> Sorry for the empty reply. The native skin does not use errno, so,
>>> perror will not print anything, rt_intr_wait return value has to be
>>> considered the error itself.
>>>
>>> -38 is -ENOSYS, meaning that the kernel does not implement the function.
>>>
>>> Indeed, handling interrupts in user-space is deprecated, for this
>>> reason, support is disabled by default in Xenomai kernel.
>>>
>>> In order to add support for the rt_intr_* services, you have to enable
>>> CONFIG_XENO_OPT_NATIVE_INTR
>>> in the kernel configuration.
>>>
>>>
>>>> faster) it seg faults after about 4 or 5 seconds, calling rt_intr_wait
>>>> in an infinite loop during that time.
>>>>
>>>> I'm also having an issue where if I run the program from an SSH
>>>> session, rt_task_create returns EPERM, but will return a success if I
>>>> run the program from the serial console. I can only assume there's
>>>> some difference in the shell processes at the kernel level, but if
>>>> there's a way to get around this, I would love to know too.
>>>
>>>
>>> I do not know if this is related, but Xenomai services are by default
>>> only available to the "root" user, so, if you are not loging with ssh as
>>> root user, what you observe is normal. If not, then what you observe is
>>> a new bug. Maybe ssh restrict some capabilities even when logging at root?
>>>
>>>
>>>
>>>>
>>>> A little background about the IRQ, because I could have this all wrong
>>>> too... I exported a gpio pin and echoed "falling" into the edge file
>>>> in sysfs. This added an entry in /procs/interrupts "205: 42
>>>> GPIO gpiolib" The number 42, increments every time I press my
>>>> button to cause an physical interrupt on the pin so I know its at
>>>> least working up to that point. I used this number 205 as the argument
>>>> to rt_intr_create, but I'm not sure that was the right thing to do.
>>>
>>>
>>> This should probably work. You may have to run rt_intr_enable after
>>> rt_intr_create though.
>>>
>>> --
>>>
>>> Gilles.
>>
>> Oh, the API documentation doesn't list ENOSYS as a possible return value
>> for rt_intr_wait, is there a Xenomai version of errno that I should use
>> for the definitions of the error codes or are they just part of the
>> standard headers?
>
>
> ENOSYS is defined of errno.h, the error are not returned through the
> "errno" variable by native skin services, but directly as negative
> values. ENOSYS is a "generic" return value, meaning that a service is
> not implemented by the kernel, and generally means that you have to
> enable some option in the kernel configuration to enable the service.
> Maybe we can document this in TROUBLESHOOTING.
>
>>
>> Either way I'd rather run this in kernel space I thought I'd just
>> implement it the easy way if possible to make sure things were working
>> on the Xenomai side of things.
>
>
> You can try to implement this in user-space. Chances are, however, that
> handling interrupts in user-space is in fact harder than handling them
> in kernel-space.
>
>>
>> For the SSH part, I was root in both terminals, I'll check the ssh group
>> permissions though. This is on a beaglebone btw.
>
>
> Maybe your rootfs has /etc/security/capabilities.conf or
> /etc/security/limits.conf ?
>
> (re-adding the list to cc).
>
> --
>                                                                 Gilles.

I've moved my test app over to a bare-bones module where I can printk
to see if its working, but I can't get it to compile using a simple
Makefile that works for cross-compiling modules that don't #include
Xenomai headers. It quits when it can't find native/task.h. So I ran
make with V=1 and it looks like -Iinclude/xenomai isn't added to the
(enormous) gcc command, which should put native/* in the search path.
I don't know what the "proper" way of adding this to the CFLAGS is so
I thought I'd look at some of the examples in the xenomai source...

I ended up modifying the makefile in
.../xenomai-2.6.2.1/examples/rtdm/driver-api to try and make it
compile just the rtdm examples for my board but the preprocesser isn't
finding the Xenomai headers either and has a few other errors. I ran
this one with V=1 also and it looks like some of the "-I" paths,
including .../include/xenomai, are missing the XENO_DESTDIR prefix so
its looking in my native machine's /lib/modules path instead of the
target's, I don't know how to fix this one either. I can send one or
both of these makefiles if it would help, but if there was an example
with a makefile built for cross-compiling modules, that would make my
life a lot easier.

As far as the SSH permissions issue, I checked the files under
/etc/security and there aren't any policies configured, ssh has a very
minimal config (dropbear server). Let me know if there's anything else
you want me to check, I don't know if there is a bugreporting site,
but I'd be happy to write up a small report on it if you think its
something worth looking into.

-Jon

