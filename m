From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <760425846A1BC44B8BD24361EF2E3451010D9A3F@square.bfh.ch>
References: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>
	<1184746976.6562.62.camel@domain.hid>
	<760425846A1BC44B8BD24361EF2E3451010D9A3F@square.bfh.ch>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 12:47:34 +0200
Message-Id: <1184755654.13258.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Writing from user space direct to IO
	Ports	without mode switches
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
To: Renner Johannes <rennj1@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-07-18 at 12:12 +0200, Renner Johannes wrote:
> Thanks for the information
> 
> I am using kernel 2.6.20 with xenomai 2.3.1. as you may see in the
> Attatched kernel.config i have TSC enabled with CPU:Core2 HPET,Speaker
> support,... etc disabled. Further I attachted my simplified RT task.
> 
> >> I have read that some Xenomai RT testing with the Parallel port at 
> >> frequencies above 200khz showed excellent results. Which functions
> are 
> >> used for such precise timings and are they only available in kernel 
> >> space?
> >native skin: rt_timer_tsc(), posix skin: clock_gettime().
> >Both are usable in kernel and user-space contexts. To have direct
> access to the x86 TSC from user-space, you need to make sure your kernel
> is compiled 
> >for a CPU type providing TSC support (i.e. anything beyond 486 would
> do). User-space should be built with the --enable-x86-tsc option too,
> but this is 
> >the default setting if you don't pass any opposite option to the
> "configure" script.
> 
> Unfortunately I wanted to ask for the IO funktions or methods you are
> using - the outb function makes timing imprecise at higher frequencies.
> I searched in the API dokumentation for functions to write to IO ports
> in a primary mode - user process, but didn't find any IO related
> functions. 
> How do you write to IO's within a xenomai RT task- is it possible to map
> them in user space?
> 

No. But outb()/inb() are available provided you are granted the right
I/O privilege level using iopl(), which your code does right, but
unfortunately, a bit too much.

Excepts from your code:

  while(!end){
    //switch to primary mode
    ret = rt_task_set_mode(0, T_PRIMARY, NULL);

Damnit. I knew this particular interface was going to be misused most of
the time. In short: do ____NOT_____ switch modes manually, this is
useless because Xenomai syscalls do it for you, and even sub-optimal
because the kernel knows better when it needs it and saves you a syscall
when required. The T_PRIMARY bit has been solely provided for internal
Xenomai purposes (some Xenomai libs have very special requirements in
very rare cases). rt_task_wait_period() will switch to primary mode if
needed, and always leave you in primary upon return.

    ret = rt_task_wait_period(&overrun);

//io output
     if(!iopl(3)) //ask for access rights
     
Why this? This line does cause a mode switch, since you issue a Linux
syscall here. IOPL needs to be granted to a task once, so you ought to
move this out of the loop, at the beginning of the routine for instance.
In the same vein, I see a fflush() in the tight loop here, so maybe they
were some fprintfs. If so, that's wrong, since they would cause Linux
syscalls to be issued, or at the very least, flushing non-empty buffers
from the stream would cause the syscall eventually.

{
	outb(val,base);//output to port
	val=~val;
     }
    fflush(NULL);
 }

There is also a useless and wrong call to rt_task_set_periodic() in the
main code, which looks like a left-over.

-- 
Philippe.



