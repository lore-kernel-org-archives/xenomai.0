Message-ID: <6ee4c8380604181253t235363a9v79d91b57bea4575a@domain.hid>
Date: Tue, 18 Apr 2006 15:53:19 -0400
From: "Brian L." <bluczkie@domain.hid>
Sender: zorander@domain.hid
Subject: Re: [Xenomai-help] General question on Native Skin tasks
In-Reply-To: <4443992C.5000808@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>
	<4443992C.5000808@domain.hid>
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

Ok; What xenomai priority in the 1-99 scheme corresponds to the
priority of normal user-level posix threads?

The application I'm building has realtime and non-realtime components
which share some native-skin objects. I am constructing my
time-critical and non-time-critical threads using rt_task_create. I
would like almost all of them to behave exactly as ordinary
non-xenomai posix threads do with regard to priority and starvation.

The example was contrived to support my question. In practice, I do
call mlockall. Also, my development machine has no swap space, so
mlockall probably shouldn't have an effect.

What does this watchdog do and where is it documented? I'm surprised I
haven't heard it mentioned before, since it seems rather important.

So far, I've not intended to introduce any "real-time" features; What
I'm doing is very vanilla stuff that I'd normally do with pthreads.

Brian


On 4/17/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Brian L. wrote:
> > If I create a native-skin RT_TASK from userspace with no flags, i.e.
> >
> > void task(void*)
> > {
> >     for (;;) ;
> > }
> > int main()
> > {
> >    RT_TASK t;
> >    rt_task_create(&t, 0, 3, 0);
> >    rt_task_start(&t,task,0);
> >    (do something which blocks)
> > }
>
> mlockall left out for simplicity? Or is it also missing on your real
> test? In the latter case, occasional application crashes are "normal"
> (as described below).
>
> Philippe, you suggested some code for detecting this. We should really,
> really add this soon (maybe to the exception path)!
>
> >
> > Should that task starve all other tasks? In what ways is it different
> > behaviorally from an ordinary posix thread? I ask because I have a
> > thread that might be spinning and a frozen system (back in the rtlinux
> > days, spinning in the real-time domain was a surefire way to freeze
> > without any other sign of trouble). If it is the case that this task
> > outweighs an ordinary linux thread/task, how can I make it the same?
>
> A task that has high priority than other system tasks has to outweigh
> them. This has nothing to to with POSIX (standard Linux included!),
> RTLinux, Xenomai, or whatever. But Xenomai has a simple watchdog to
> recover from run-away RT threads.
>
> >
> > Also,  I haven't completely tracked this down yet, but xenomai seems
> > to be page-faulting in a loop and exploding rather spectacularly in a
> > native-skin multithreaded program that doesn't do anything outside of
> > relatively ordinary queue/mutex/task stuff. I'm upgrading to trunk to
> > see if it goes away.
> >
> > Short of a serial cable, is there a way to capture Oops/Panic text as
> > it flies by?
>
> linux/Documentation/networking/netconsole.txt is another option.
>
> Jan
>
>
>
>

