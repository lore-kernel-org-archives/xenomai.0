Message-ID: <2ff1a98a0802140551ve405dd7v66419157978a8235@domain.hid>
Date: Thu, 14 Feb 2008 14:51:14 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47B44693.6070203@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <12460.62.39.72.60.1202995942.squirrel@domain.hid>
	<47B44693.6070203@domain.hid>
Subject: Re: [Xenomai-help] Problem of thread creation with Xenomai Posix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Feb 14, 2008 at 2:48 PM, Johan Borkhuis
<j.borkhuis@domain.hid> wrote:
> Fabien MAHOT wrote:
>  > Hi,
>  >
>  > I need your help to understand why my application doesn't work correctly.
>  >
>  > I use the Xenomai 2.3.4 kernel with its POSIX skin to develop a real time
>  > application. In this program, I create several threads thanks to a main
>  > thread which has the highest priority (SCHED_FIFO configuration). The aim
>  > is that the main thread stays in execution during the creation of all the
>  > other threads.
>  >
>  > However, in my program, when the main thread calls the posix function
>  > pthread_create to create a new thread, it's preempted by a thread created
>  > previously. In spite of the main thread has the highest priority.
>  >
>
> > I would like to know why I ve got this problem with Xenomai. If you ve got
>  > an idea, please , give me your opinion.
>  >
>  >
>  This is quite easy to explain: the task you create is a real time task.
>  This task will always run before your main task, which is a Linux task.
>
>  If you add a call to rt_task_shadow after the mlockall your main task
>  will also become a Xenomai task, and you will see the same behavior as
>  with Linux.

When using Xenomai posix skin, pthread_create creates real-time tasks
as well. And the main thread is automatically shadowed (by library
init code).

-- 
 Gilles Chanteperdrix

