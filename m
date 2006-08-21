Subject: Re: [Xenomai-help] primary mode versus secondary mode
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <75975c320608211321u5b2d9e45nfb078e9ed4d8b617@domain.hid>
References: <75975c320608211235l79dfb17ft54df1018e7f597ff@domain.hid>
	<75975c320608211321u5b2d9e45nfb078e9ed4d8b617@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 22:42:39 +0200
Message-Id: <1156192960.4321.70.camel@domain.hid>
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
To: Paul Ianna <paulianna2002@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-21 at 16:21 -0400, Paul Ianna wrote:
> Hi All,
> 
> I have read (at least some of) the Xenomai docs and am a little
> unclear on the real distinction between primary and secondary mode.
> 
> I have seen in the native API that I can receive a signal if a task
> has "migrated to the Linux domain".
> 
> Does secondary mode mean that I am no longer a real-time task?
> 

Not exactely; it means that your real-time task is entering an execution
mode controlled by the regular Linux scheduler, therefore leaving the
Xenomai one. This means that predictability regarding latencies is
limited by what the vanilla Linux kernel can achieve, in terms of
determinism (i.e. not much by our standards). Your task will switch back
to strict real-time mode automatically when issuing a Xenomai syscall
that requires it (e.g. all blocking Xenomai syscall do).

> How do I avoid dropping from primary mode to secondary mode?
> 

- Avoid using plain Linux signals to send asynchronous notifications to
your RT tasks
- Avoid calling any code that could directly or indirectly issue a
regular Linux syscall (e.g. anything from the glibc that might call back
the kernel to perform the operation, like acquiring/releasing a
contended mutex, extending the data segment [malloc -> brk]  etc.)

Aside of this, you can be informed of any mode transition from primary
to secondary mode using the rt_task_setmode() call, arming the T_WARNSW
bit for the current task. This will send your task a SIGXCPU signal each
time it crosses the boundary. Have a look at
ksrc/skins/native/snippets/sigxcpu.c, it's a simple illustration of this
service.

Also have a look at /proc/xenomai/stats when your application runs, the
MSW field (i.e. Mode SWitches) counts the number of transitions for each
Xenomai thread. This value should not increase over time, at least for
latency critical threads.

> Thanks in advance,
> Paul Ianna
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



