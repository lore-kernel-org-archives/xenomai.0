Message-ID: <4D7A1FF0.6090106@domain.hid>
Date: Fri, 11 Mar 2011 14:13:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D79DD32.4050307@domain.hid> <4D79E28B.3090004@domain.hid>
	<4D79F0ED.6080101@domain.hid>
In-Reply-To: <4D79F0ED.6080101@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_delete trouble
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: johann.obermayr@domain.hid
Cc: xenomai@xenomai.org

Johann Obermayr wrote:
> We use xenomai 2.5.5.2 and linux kernel 2.6.32.15. gcc 4.3.3
> 
> Here you have some more details.
> a kernel module have a watchdog checker for some 'user-tasks'
> if a 'user-task' have a while loop, than the kernel module will suspend
> the user-task and call also the mayday function.
> 
> But on some other errorhandling, we have a high priortity watchdog task 
> control the 'user'-tasks.
> On error the watchdog task suspend all user-tasks. (this work correct)
> Than the watchdog-task switch off the user-task watchdog.
> Make errorhandling and some other function (dump user-task stack)
> Than the watchdog task will delete some user-task.
> But if a user-task is in a while loop, the system hangs.
> in user mode we have no mayday function.

>From my point of view, you should be using the watchdog provided by
Xenomai. Did you notice that in your application, you can register a
signal handler to handle the watchdog signal? This would allow you to
use the watchdog provided by Xenomai to handle tasks blocked in infinite
loops. Then use your watchdog to handle other cases.

See the example at examples/native/sigdebug.c

> it's look like, that when watchdog-task call rt_task_delete(user_task) , 
> the user_task continue running.
> Is this so ?

Yes, this is probably the reason. The thing is that the watchdog task
calling rt_task_delete calls pthread_cancel, which causes a switch to
secondary mode. What I do not understand, however, is that since you
have priority coupling enabled, it should work. So, I have to reproduce
this case to understand. But actually, now that I think about it,
Wolfgang signalled the same issue with pthread_cancel and the posix skin
a long time ago, I looked at it, and I seem to remember that after
investigation, it could not work.

-- 
					    Gilles.

