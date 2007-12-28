Message-ID: <2ff1a98a0712280630t7d524928r2f66355fd0731d67@domain.hid>
Date: Fri, 28 Dec 2007 15:30:43 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <8b3b30860712271756n526daf67yc8e5be203ae5421d@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8b3b30860712271756n526daf67yc8e5be203ae5421d@domain.hid>
Subject: Re: [Xenomai-help] update from fusion 0.9.1 to xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Racconico Lambrati <racconico.lambrati@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Dec 28, 2007 2:56 AM, Racconico Lambrati
<racconico.lambrati@domain.hid> wrote:
>
>
> 2007/12/27, Philippe Gerum <rpm@xenomai.org>:
> > Racconico Lambrati wrote:
> > >
> > > How can I run it in kernel space?
> > > The application is designed to be little and stable, and with fusion
> > > 0.9.1 run without problem
> > >
> >
> > If your application based on 0.9.1 used to run in user-space, then it
> > must have been based on the UVM support. This support has been dismissed
> > since Xenomai v2.3-rc1, because it was a temporary hack allowing
> > user-space development until all skins have a real user-space interface,
> > which is now the case.
>
> murphy's law  could be applied here! I use uvm
>
> > The services you mention are now only available from the kernel-based
> > interface, provided by the xeno_vxworks.ko module, because they do not
> > make sense from a userland perspective.
>
> then is it possible to create a kernel-based application with vxworks skins?
> How can i do it?
> I use "$(xeno-config --uvm-ldflags) -lvxworks -lrtai -lm" as LDFLAGS option.
>
> > Userland applications based on the VxWorks API
> > (/usr/xenomai/lib/libvxworks.so) should not need them at all. If for
> > some reason they do, then you should consider splitting the application
> > in two parts, one kernel-based, the other one running in userland. The
> > point is that dealing with interrupts should most often remain a kernel
> > business, and this obviously also applies to interposing on the tick
> timer.
>
> I've alredy done, using rt_pipe to make a communication line to a non-RT
> application and my RT application.
>
> > If your application was not based on the UVM, then it must have been
> > running embodied into a kernel module, in which case the issue is
> > already solved.
>
> This is not my case
>
> > Rehashing what Gilles already told you: until you actually explain _why_
> > you need such services, nobody will be able to suggest any solution to
> > your problem, I'm afraid.
>
> The application use intLock and intUnlock first of all to handle a CAN
> device.

This would better be done in a driver, in kernel-space. Or if you want
to continue to handle the CAN device in user-space, you will have to
replace intLock/intUnlock with a mutex.

> I use it also to handle a timers array. when I delete a timers from an array
> I disable the interrupt to avoid some race condition's problem (maybe a
> timer that is going to be delete wake up during it's deleting routine).

I am not sure I understand what you mean. If you are doing your own
timer handling, you should probably use vxworks watchdogs instead.
Xenomai timers are handled in a linked list by default, but you can
choose other data structures if you have to handle a lot of timers.
If by timers array, you mean an array of vxworks watchdogs, you do not
have to worry about locking, this is already done by xenomai vxworks
services. If what you want to protect is concurrent access to the
array, then you can use a mutex.

>
> I use SysClkConnect to hang the clock to a function that send the Give
> signal to a semaphore every 'n' cycle.

You can use a watchdog for that too.

>
> the semaphore is used to give the start to a function that handle the most
> important duty of the system, then when it term it cycle, it send the Give
> signal to a second semaphore that will launch a second task that manage the
> lesser important things.
>
> This is an overview of my software. there aren't many other thing, only the
> processing of the data received from CAN device, that is a lot of code but
> it don't need the realtime services. this code is executed in the first task
>
> I hope you understand my needs (my English is not so good).

Do not worry, english is not my mother tongue, so, even if you make
mistakes, I do not see them.

-- 
                                               Gilles Chanteperdrix

