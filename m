From: "Rodrigo Rosenfeld Rosas" <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] Help on debugger gdb
Date: Tue, 26 Sep 2006 09:02:06 -0300
References: <45188502.4060209@domain.hid> <1159261731.5084.46.camel@domain.hid>
	<4518F58A.5090900@domain.hid> <1159264954.5084.69.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <E1GSJFg-0007QT-OE@gna.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Thank you Philippe and Jan,

I would like further to suggest some improvements to this debugging process.

As Jan has said, I can also think of a scenario where a user will wish keep
other
programs running unaltered by the debugged program. Furthermore, I can even 
imagine other tasks inside the debugged program to keep running normally.

Suppose the framework I'm developing. If a user wants to test an own task,
but
would like not to stop the robot basic tasks, it would not be possible from
what I've
understood. If the user compiles the framework as a static library, it will
be the same
process. I did not developed a driver for my robot, which would provide
some ioctl
API for communicating to it. I did not also developed a separated server
program
for that. All robot control is developed inside the user-space library,
playing with
the parallel port pins and iopl()... I know it is not portable, but it is
simple and is
sufficient for my tests.

But if all tasks are frozen, the robot will have unexpected behaviour if a
user is
debugging communication with other robots, using rt-net, for instance.

Thank you for all the information regarding debuggers.

Regards,

Rodrigo.


Philippe Gerum <rpm@xenomai.org> wrote:
>
>On Tue, 2006-09-26 at 11:40 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>> > On Mon, 2006-09-25 at 22:40 -0300, Rodrigo Rosenfeld Rosas wrote:
>> >> Hi, it's me again, after a long while :)
>> >>
>> >> I'll present my Master thesis this Friday and I would like to comment 
>> >> about the debugger. Since I'm in hurry with a lot other issues, I do not 
>> >> have to time to test what I'm going to ask.
>> >>
>> >> I've never used a debugger with Xenomai (or RTAI). I mean, not GDB. I 
>> >> used other techniques to debug, such as logging, etc. My doubt is:
>> >>
>> >> Suppose I have a user-space program with 3 independent Xenomai RT-tasks. 
>> >> If I put a breakpoint in one of them, will the other two keep running? I 
>> >> guess yes, but I'm not sure and that is why I'm asking.
>> >>
>> > 
>> > Actually, they would not. The kernel would stop all of them as a
>> > consequence of ptracing, and Xenomai would switch them back to secondary
>> > mode if needed, to let them handle the new situation properly.
>> > 
>> >> Another thing. I think that the scheduler will keep counting the time 
>> >> when the debugger stopped the task. So, the next call to 
>> >> rt_task_wait_period() will return -ETIMEDOUT immediately, with the 
>> >> overruns set accordly, if this was the case, right?
>> >>
>> > 
>> > No, the outstanding RT timers are globally frozen whenever a ptraced
>> > user-space task is stopped by the debugger, exactely to prevent the case
>> > you described, so that you can step into your application without
>> > causing such annoying side-effect. Since we are breakpointing/stepping
>> > into the code, real-time accuracy doesn't matter anyway, so we act as if
>> > the timeline was being frozen each time the debugger holds the
>> > application. 
>> 
>> Timers are frozen, but internal timekeeping continues, e.g. in
>> xnpod_wait_thread_period (which is used by rt_task_wait_period). So the
>> overrun counter is in fact incremented and an error is returned after
>> the interruption.
>
>Yes, I was talking about the old behaviour we had of returning timeout
>conditions repeatedly for each missed release points before
>xnpod_wait_thread_period has been reworked to actually compute the
>missed periods.
>
>> 
>> That raises the question for me if we shouldn't allow this freeze also
>> per-process in the future to confine the effect only to those programs
>> actually being debugged. I can easily imagine scenarios where the
>> developer might be more happy to keep other, fairly independent parts of
>> the system alive while stepping through one application.
>> 
>
>Yes, but we will need the reworked timer infrastructure to do that
>properly.
>
>> Jan
>> 
>-- 
>Philippe.
>
>

		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 



