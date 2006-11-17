Message-ID: <455D962F.3070001@domain.hid>
Date: Fri, 17 Nov 2006 11:59:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <9656043.1163758677000.JavaMail.ngmail@domain.hid>
In-Reply-To: <9656043.1163758677000.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: What happens if task entry function returns?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

M. Koehrer wrote:
> Hi!
> 
> I am just playing around with Xenomai to understand it.
> And I have one question concerning the entry function that will be called from
> rt_task_start (Native API).
> What happens if this entry function reaches its end or a return within the function is
> called?
> 
> I have made a simple example that lead to strange effects.
> In my example (see complete C Code in attachement) I create to tasks
> that do the same.
> The entry functions look like:
> 
> void taska(void *cookie)
> {
>     RTIME delay;
>     int i;
>     printf("Hi, I am task A %s\n", (char*)cookie);
>     delay = 100000;
> 
>     for (i=0; i<200; i++)
>     {
>         rt_task_sleep(delay);
>     }
> 
>     printf("This is the end of A\n");
>     // rt_task_delete(0);
> }
> When I do not place the rt_task_delete(0) at the end of the function
> my second task will never reach the end with the second printf.
> Whenever I use rt_task_delete(0) at the end of the function it works perfectly.

Quite inconsistent, sounds like a bug. Does the second rt_task_join just
rush through and main terminates?

> 
> My question is now: What happens if the task's entry function returns?

pthread_exit() is invoked implicitly, which implies rt_task_delete(NULL).

> 
> Thanks for any feedback on that question.

Is this issue SMP-related? What happens if you force all your tasks to
the same CPU? Or if you run on a !CONFIG_SMP box?

Jan

