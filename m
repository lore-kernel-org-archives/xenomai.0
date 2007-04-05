Subject: Re: [Xenomai-help] Preemptive scheduling
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20070404151057.177770@domain.hid>
References: <20070328203115.190280@domain.hid>
	<17930.56329.893396.220621@domain.hid>
	<20070329031758.125210@domain.hid> <460B7CE0.60107@domain.hid>
	<20070403200539.126240@domain.hid> <1175631875.22950.72.camel@domain.hid>
	<20070403205554.107880@domain.hid> <1175674653.4666.9.camel@domain.hid>
	<20070404151057.177770@domain.hid>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 20:38:57 +0200
Message-Id: <1175798337.7594.56.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Jack Whorn <jackwhorn@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-04-04 at 17:10 +0200, Jack Whorn wrote:
> > Changeset r2092 introduced the sleeping scheduler lock for v2.3.x.
> 
> Hi Philippe,
> 
> I appreciate your help very much! I found and applied the diffs of changeset r2092.
>  It seems to work much better now: The system is able to access the hard disk, as I
>  see the LED blinking periodically. That`s great!
> 
> Still, I can`t use the keyboard to stop the application by pressing Strg-C.
> Also, the text cursor doesn`t blink, so the Linux system seems to be overloaded
>  (probably, it`s no longer scheduled).
> 
> So, the Linux-Kernel now seems to be able to run on behalf of a high-priority task.
>  Though, it is no longer scheduled as an idle task, which is ok as there is the highe
> r priority-task with the infinite loop. This way, everything acts as expected.
> 

What you see is your real-time task called "thread" running, nothing
else.

> Nevertheless, it would be interesting to run a linux shell concurrently. Can I adjust
>  linux priority during runtime (or: where do I have to adjust it in the sources)?
> 
> And btw, where can I look up the keyboard interrupt`s priority (is it kernel`s priority)?
> 

You may want to read these articles, explaining the basic concept of
primary and secondary domains as seen by the native API and all other
interfaces, and how this is implementing by the Adeos layer:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-rev-C.pdf
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf

In short, the infinite loop inside your application runs in primary
mode, which starves the regular Linux kernel from CPU and interrupts, so
that primary mode remains highly predictable time-wise. For that reason,
hitting ^C has no effect when running this loop (no kbd IRQ and no input
core polling for kbd event => no driver interaction => no termio
handling => no SIGINT ever emitted therefore received by your process).
All the CPU is eaten by your thread, and only real-time interrupts are
allowed to preempt it from time to time.
(Activating CONFIG_XENO_OPT_WATCHDOG would pull the break and stop this
loop after 4s btw).

You cannot adjust the kernel priority in the Xenomai scale yourself,
this would introduce unpredictable latencies. Xenomai does a similar
adjustment automatically when a real-time switches to secondary mode (an
explanation can be found in the cited docs), but this could be applied
to any random Linux task without wrecking the real-time behaviour, so
this has not been made possible.

To sum up, if you want regular I/O such as keyboard input to be
processed by Linux, you need to leave a bit of CPU time to the regular
kernel. This is why the infinite loop seems to lock up the box.

Rule of thumb: this is not a pure RTOS, but a combo merging a GPOS and a
RTOS sub-system to get the best of both worlds, so you need to make sure
that both can co-exist together - which does not prevent to one a higher
priority over the other - and leaving CPU time to the regular kernel to
process regular I/O through normal drivers is part of the requirements.
It is possible to develop real-time I/O drivers (RTDM is there for this
task), in this case, most of their code is controlled in primary mode by
Xenomai, and not by the vanilla Linux kernel.

> Thanks a lot,
> 
> Jack
> 
-- 
Philippe.



